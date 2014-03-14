------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_deleteContratLocation
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de suppression d'un contrat de location
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.deleteContratLocation 
			@id = 1
			
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id = 1
		) = 0)
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
	EXEC @ReturnValue =  dbo.deleteContratLocation 
			@id = 3
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id = 3
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
