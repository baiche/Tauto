------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_extendContratLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'extension de contrat de location
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.extendContratLocation
		@id	= 3,
		@extension = 2
			
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - Tuple modifié');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non modifié');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id	= 3 AND
			extension = 2
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
	EXEC @ReturnValue = dbo.extendContratLocation 
		@id	= 4,
		@extension = 2
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non modifié');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple modifié');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id	= 4 AND
			extension = 2
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
