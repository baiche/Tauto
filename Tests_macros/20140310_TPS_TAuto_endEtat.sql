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
	
	IF (  (SELECT COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T10:00:00' AND
			km_apres = 15000 AND
			fiche_apres = 'fichetest1' AND
			degat = 'false'
		) = 1)
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
		
	DECLARE @nbEtat int, @nbVeh int;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres IS NOT NULL AND
			km_apres = 130000 AND
			fiche_apres = 'fichetest2' AND
			degat = 'false';
	SELECT @nbVeh = COUNT(*) FROM Vehicule WHERE matricule = '0775896wi' AND statut LIKE 'Disponible';
	IF ( @nbEtat = 1 AND @nbVeh = 1 )
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
-- Insertion en mettant une date de fin < date de début
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

	/*IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple inséré');
	END*/

	IF (  (SELECT COUNT (*) FROM Etat WHERE
			id = 9 AND
			date_avant = GETDATE()
		) = 1)
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
-- Insertion en mettant une date de fin < date du jour
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 7,
		@matricule = '0775896wy',
		@date_avant = NULL,
		@km_avant = NULL,
		@fiche_avant = 'fichetest4';
			
	IF (  (SELECT COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			km_avant = 30000
		) = 1)
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