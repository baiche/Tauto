------------------------------------------------------------
-- Fichier     : closeTypeAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeTypeAbonnement	
GO

CREATE PROCEDURE dbo.closeTypeAbonnement
	@nom 				nvarchar(50), -- PK
AS
	BEGIN TRANSACTION closeTypeAbonnement
	BEGIN TRY
		COMMIT TRANSACTION closeTypeAbonnement
		PRINT('closeTypeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeTypeAbonnement: ERROR');
		ROLLBACK TRANSACTION closeTypeAbonnement
		RETURN -1;
	END CATCH
GO