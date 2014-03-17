------------------------------------------------------------
-- Fichier     : fixInfraction.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixInfraction	
GO

CREATE PROCEDURE dbo.fixInfraction
	@matricule				nvarchar(50), -- FK
	@nom 					nvarchar(50), -- nullable
	@montant 				money -- nullable
AS
	BEGIN TRANSACTION fixInfraction
	BEGIN TRY
		COMMIT TRANSACTION fixInfraction
		PRINT('fixInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixInfraction: ERROR');
		ROLLBACK TRANSACTION fixInfraction
		RETURN -1;
	END CATCH
GO