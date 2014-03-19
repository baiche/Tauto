------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeTypeAbonnement
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de TypeAbonnement
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.makeTypeAbonnement
	@nom 				nvarchar(50), -- PK
	@prix 				money,
	@nb_max_vehicules 	int, -- nullable
	@km					int -- nullable
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeTypeAbonnement
			@nom = 'monTypeAbonnement',
			@prix = 50,
			@nb_max_vehicules = 2,
			@km = 20;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement' AND
			prix = 50 AND
			nb_max_vehicules = 2 AND
			km = 20
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
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement2',
			@prix = 50,
			@nb_max_vehicules = NULL,
			@km = 20;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement2' AND
			prix = 50 AND
			nb_max_vehicules = 1 AND
			km = 20
		) = 1)
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
	EXEC dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement3',
			@prix = 50,
			@nb_max_vehicules = 2,
			@km = NULL;
			
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement3' AND
			prix = 50 AND
			nb_max_vehicules = 2 AND
			km = 1000
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
	EXEC dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement4',
			@prix = 10,
			@nb_max_vehicules = 5,
			@km = 50;
	EXEC dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement4',
			@prix = 50,
			@nb_max_vehicules = 2,
			@km = 20;
			
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement4' AND
			prix = 10 AND
			nb_max_vehicules = 5 AND
			km = 50
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