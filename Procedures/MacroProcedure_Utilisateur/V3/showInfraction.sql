------------------------------------------------------------
-- Fichier     : showInfraction.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.showInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.showInfraction	
GO

CREATE PROCEDURE dbo.showInfraction
	@matricule				nvarchar(50), -- FK
AS
	BEGIN TRANSACTION showInfraction
	BEGIN TRY
		COMMIT TRANSACTION showInfraction
		PRINT('showInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('showInfraction: ERROR');
		ROLLBACK TRANSACTION showInfraction
		RETURN -1;
	END CATCH
GO