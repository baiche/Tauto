------------------------------------------------------------
-- Fichier     : makeTypeAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeTypeAbonnement	
GO

CREATE PROCEDURE dbo.makeTypeAbonnement
	@nom 				nvarchar(50), -- PK
	@prix 				money,
	@nb_max_vehicules 	int, -- nullable
	@km					int -- nullable
AS
	BEGIN TRANSACTION makeTypeAbonnement
	BEGIN TRY
		COMMIT TRANSACTION makeTypeAbonnement
		PRINT('makeTypeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeTypeAbonnement: ERROR');
		ROLLBACK TRANSACTION makeTypeAbonnement
		RETURN -1;
	END CATCH
GO