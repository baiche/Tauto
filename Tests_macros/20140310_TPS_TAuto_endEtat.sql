------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_endEtat
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de fin d'un état
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.endEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_apres	 		datetime, -- nullable
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat 				bit, -- nullable, mettre faux si rien n'est indiqué
	@vehicule_statut	nvarchar(50) -- nullable, met dispo par défaut
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896we',
		@date_apres = '2014-03-25T10:00:00',
		@km_apres = 15000,
		@fiche_apres = 'fichetest1',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T10:00:00' AND
			km_apres = 15000 AND
			fiche_apres = 'fichetest1' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 90.00 )
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- Test des valeurs nulles
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wi',
		@date_apres = NULL,
		@km_apres = 130000,
		@fiche_apres = 'fichetest2',
		@degat = NULL,
		@vehicule_statut = NULL;
		
	DECLARE @nbEtat int, @nbVeh int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres IS NOT NULL AND
			km_apres = 130000 AND
			fiche_apres = 'fichetest2' AND
			degat = 'false';
	SELECT @nbVeh = COUNT(*) FROM Vehicule WHERE matricule = '0775896wi' AND statut LIKE 'Disponible';
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	IF ( @nbEtat = 1 AND @nbVeh = 1 AND @factVal = 60.00 )
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO

--Test 3
-- Calcul de la facture de la location avec un incident non pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wy',
		@date_apres = '2014-03-25T12:00:00',
		@km_apres = 30075,
		@fiche_apres = 'fichetest3',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T12:00:00' AND
			km_apres = 30075 AND
			fiche_apres = 'fichetest3' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 90.00 )
	BEGIN
		PRINT('------------------------------Test 3 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 NOT - - OK');
END CATCH
GO

--Test 4
-- Calcul de la facture de la location avec un incident pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wr',
		@date_apres = '2014-03-25T12:00:00',
		@km_apres = 30075,
		@fiche_apres = 'fichetest4',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T12:00:00' AND
			km_apres = 30075 AND
			fiche_apres = 'fichetest4' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 140.00 )
	BEGIN
		PRINT('------------------------------Test 4 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 NOT - - OK');
END CATCH
GO

--Test 5
-- Calcul de la facture de la location avec une infraction de 100€ non regle
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wt',
		@date_apres = '2014-03-25T10:00:00',
		@km_apres = 35050,
		@fiche_apres = 'fichetest5',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T10:00:00' AND
			km_apres = 35050 AND
			fiche_apres = 'fichetest5' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 190.00 )
	BEGIN
		PRINT('------------------------------Test 5 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 NOT - - OK');
END CATCH
GO