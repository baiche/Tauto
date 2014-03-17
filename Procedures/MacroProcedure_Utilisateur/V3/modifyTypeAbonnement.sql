------------------------------------------------------------
-- Fichier     : modifyTypeAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyTypeAbonnement	
GO

CREATE PROCEDURE dbo.modifyTypeAbonnement
	@nom 				nvarchar(50), -- PK, peut être modifié !
	@prix 				money, -- nullable
	@nb_max_vehicules 	int, -- nullable
	@km					int	 -- nullable
AS
	BEGIN TRANSACTION modifyTypeAbonnement
	BEGIN TRY
		COMMIT TRANSACTION modifyTypeAbonnement
		PRINT('modifyTypeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyTypeAbonnement: ERROR');
		ROLLBACK TRANSACTION modifyTypeAbonnement
		RETURN -1;
	END CATCH
GO