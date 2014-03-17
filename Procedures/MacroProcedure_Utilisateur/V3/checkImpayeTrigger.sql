------------------------------------------------------------
-- Fichier     : checkImpayeTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.checkImpayeTrigger', 'P') IS NOT NULL
	DROP PROCEDURE dbo.checkImpayeTrigger	
GO

CREATE PROCEDURE dbo.checkImpayeTrigger
AS
	BEGIN TRANSACTION checkImpayeTrigger
	BEGIN TRY
		COMMIT TRANSACTION checkImpayeTrigger
		PRINT('checkImpayeTrigger OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('checkImpayeTrigger: ERROR');
		ROLLBACK TRANSACTION checkImpayeTrigger
		RETURN -1;
	END CATCH
GO