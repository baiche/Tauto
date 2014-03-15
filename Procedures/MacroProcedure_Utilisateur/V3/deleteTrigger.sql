------------------------------------------------------------
-- Fichier     : deleteTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteTrigger', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteTrigger	
GO

CREATE PROCEDURE dbo.deleteTrigger
AS
	BEGIN TRANSACTION deleteTrigger
	BEGIN TRY
		COMMIT TRANSACTION deleteTrigger
		PRINT('deleteTrigger OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('deleteTrigger: ERROR');
		ROLLBACK TRANSACTION deleteTrigger
		RETURN -1;
	END CATCH
GO