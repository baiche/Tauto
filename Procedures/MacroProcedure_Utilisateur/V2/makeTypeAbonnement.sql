------------------------------------------------------------
-- Fichier     : makeTypeAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un type d'abonnement, remplace les champs nuls par les valeurs par défaut.
--				 Renvoie 1 en cas de succès, -1 autrement
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
		IF @nb_max_vehicules IS NULL
			SET @nb_max_vehicules = 1;
		IF @km IS NULL
			SET @km = 1000;
			
		EXEC dbo.createTypeAbonnement
			@nom = @nom,
			@prix = @prix,
			@nb_max_vehicules = @nb_max_vehicules,
			@km = @km;
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