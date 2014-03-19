------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeCatalogue
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de catalogue
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.makeCatalogue
	@nom 					nvarchar(50), -- PK
	@date_debut 			date, -- nullable, la date par défaut est la date du jour
	@date_fin		 		date  -- vérifier debut <= fin
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCatalogue 
			@nom = 'monCatalogue',
			@date_debut = '2014-03-15',
			@date_fin = '2014-03-17'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM Catalogue WHERE
			nom = 'monCatalogue' AND
			date_debut = '2014-03-15' AND
			date_fin = '2014-03-17'
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
	PRINT('------------------------------Test 1 NOT -- OK');
END CATCH
GO

--Test 2
-- Insertion en mettant la date de debut à nulle.
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.makeCatalogue 
			@nom = 'monCatalogue2',
			@date_debut = NULL,
			@date_fin = '2014-06-17'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM Catalogue WHERE
			nom = 'monCatalogue2' AND date_debut = CONVERT(date, GETDATE()) AND date_fin = '2014-06-17')
		= 1)
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
	EXEC dbo.addConducteurToLocation 
			@nom = 'monCatalogue3',
			@date_debut = '2014-03-15T00:00:00',
			@date_fin = '2014-02-17T00:00:00';
			
	PRINT('------------------------------Test 3 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 OK');
END CATCH
GO

--Test 4
-- Insertion en mettant une date de fin < date du jour
BEGIN TRY
	EXEC dbo.addConducteurToLocation 
			@nom = 'monCatalogue4',
			@date_debut = NULL,
			@date_fin = '2013-06-17T00:00:00';

	PRINT('------------------------------Test 4 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 OK');
END CATCH
GO