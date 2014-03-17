------------------------------------------------------------
-- Fichier     : extendContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendContratLocation	
GO

CREATE PROCEDURE dbo.extendContratLocation
	@idContratLocation	int, -- PK
	@extension			int,
AS
	BEGIN TRANSACTION extendContratLocation
	BEGIN TRY
		COMMIT TRANSACTION extendContratLocation
		PRINT('extendContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('extendContratLocation: ERROR');
		ROLLBACK TRANSACTION extendContratLocation
		RETURN -1;
	END CATCH
GO