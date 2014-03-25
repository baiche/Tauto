------------------------------------------------------------
-- Fichier     : modifyAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie le renouvellement automatique de l'abonnement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyAbonnement	
GO

CREATE PROCEDURE dbo.modifyAbonnement
	@id 					int, -- PK
	@renouvellement_auto	bit
AS
	BEGIN TRANSACTION modifyAbonnement
	BEGIN TRY
		
		IF @renouvellement_auto IS NOT NULL AND @id IS NOT NULL
		BEGIN
			UPDATE Abonnement
			SET renouvellement_auto = @renouvellement_auto
			WHERE id = @id;
			COMMIT TRANSACTION modifyAbonnement
			PRINT('modifyAbonnement OK');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('renouvellement_auto ou id nul');
			ROLLBACK TRANSACTION modifyAbonnement
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('modifyAbonnement: ERROR');
		ROLLBACK TRANSACTION modifyAbonnement
		RETURN -1;
	END CATCH
GO