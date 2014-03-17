------------------------------------------------------------
-- Fichier     : makeAbonnement.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeAbonnement	
GO

CREATE PROCEDURE dbo.makeAbonnement
	@nom 					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date, -- PK
	@date_debut 			date,
	@duree 					int,
	@renouvellement_auto 	bit,
	@nom_typeabonnement 	nvarchar(50) -- FK
AS
	BEGIN TRANSACTION makeAbonnement
	BEGIN TRY
		IF(@nom = NULL)
		BEGIN
			PRINT('makeAbonnement: le nom doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@prenom = NULL)
		BEGIN
			PRINT('makeAbonnement: le prenom doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@date_naissance = NULL)
		BEGIN
			PRINT('makeAbonnement: la date de naissance doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@date_debut = NULL)
		BEGIN
			PRINT('makeAbonnement: la date de debut doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@duree = NULL)
		BEGIN
			PRINT('makeAbonnement: la duree doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@renouvellement_auto = NULL)
		BEGIN
			PRINT('makeAbonnement: il faut préciser si l''abonnement est renouvelable automatiquement');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@nom_typeabonnement = NULL)
		BEGIN
			PRINT('makeAbonnement: la type de l''abonnement doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		EXEC dbo.makeAbonnement @nom, @prenom, @date_naissance,@date_debut,@duree,@renouvellement_auto, @nom_typeabonnement
		COMMIT TRANSACTION makeAbonnement
		PRINT('makeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeAbonnement: ERROR');
		ROLLBACK TRANSACTION makeAbonnement
		RETURN -1;
	END CATCH
GO