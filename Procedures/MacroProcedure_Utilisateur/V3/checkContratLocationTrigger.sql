------------------------------------------------------------
-- Fichier     : checkContratLocationTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.checkContratLocationTrigger', 'P') IS NOT NULL
	DROP PROCEDURE dbo.checkContratLocationTrigger	
GO

CREATE PROCEDURE dbo.checkContratLocationTrigger
AS
	BEGIN TRANSACTION checkContratLocationTrigger
	BEGIN TRY
		COMMIT TRANSACTION checkContratLocationTrigger
		PRINT('checkContratLocationTrigger OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('checkContratLocationTrigger: ERROR');
		ROLLBACK TRANSACTION checkContratLocationTrigger
		RETURN -1;
	END CATCH
GO