------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeEtat
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de TypeAbonnement
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.makeEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_avant	 		datetime,
	@km_avant 			int,
	@fiche_avant		nvarchar(50)
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896we',
		@date_avant = '2014-03-10T10:00:00',
		@km_avant = NULL,
		@fiche_avant = 'fichetest1';
		
	/*IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END*/
	
	IF (  (SELECT COUNT (*) FROM Location WHERE
			id_contratLocation = 7 AND
			id_etat = @ReturnValue
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
-- Insertion en mettant la date de debut à nulle.
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wr',
		@date_avant = '2014-03-10T10:00:00',
		@km_avant = NULL,
		@fiche_avant = 'fichetest2';
		
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wr',
		@date_avant = '2014-03-10T10:00:00',
		@km_avant = NULL,
		@fiche_avant = 'fichetest2';
		

	PRINT('------------------------------Test 2 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 OK');
END CATCH
GO

--Test 3
-- Insertion en mettant une date de fin < date de début
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wt',
		@date_avant = NULL,
		@km_avant = 35000,
		@fiche_avant = 'fichetest3';

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
			date_avant = CONVERT(date, GETDATE())
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
	EXEC @ReturnValue = dbo.makeEtat
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