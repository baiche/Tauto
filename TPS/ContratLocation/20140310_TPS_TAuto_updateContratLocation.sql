------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_updateContratLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de mise à jour de contrat de location
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.updateContratLocation
		@id	= 5,
		@date_fin_effective	= '2014-03-10T00:00:00',
		@extension = null
			
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - Tuple modifié');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non modifié');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id	= 5 AND
			date_fin_effective	= '2014-03-10T00:00:00' AND
			extension = 4
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
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.updateContratLocation 
		@id	= 6,
		@date_fin_effective	= '2013-02-25T00:00:00',
		@extension = 25
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non modifié');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple modifié');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id	= 6 AND
			date_fin_effective	= '2013-02-25T00:00:00' AND
			extension = 25
		) = 0)
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
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.updateContratLocation 
		@id	= 6,
		@date_fin_effective	= null,
		@extension = 10
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple modifié');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non modifié');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id	= 6 AND
			date_fin_effective IS NULL AND
			extension = 10
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
