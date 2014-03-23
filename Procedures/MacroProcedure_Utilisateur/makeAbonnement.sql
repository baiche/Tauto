------------------------------------------------------------
-- Fichier     : makeAbonnement.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un abonnement correspondant à un 
--				compte abonne et à un type d'abonnement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeAbonnement	
GO

CREATE PROCEDURE dbo.makeAbonnement
	@date_debut 						date,
	@duree 								int,
	@renouvellement_auto 				bit,
	@nom_typeabonnement 				nvarchar(50), -- FK
	@nom_compteabonne 					nvarchar(50), -- FK
	@prenom_compteabonne 				nvarchar(50), -- FK
	@date_naissance_compteabonne 		date 		  -- FK
	
AS
	BEGIN TRANSACTION makeAbonnement
	BEGIN TRY
	
		DECLARE @asCompteAbonne	 	int,
				@asTypeAbonnement	int,
				@idAbonnement		int,
				@returnPS			int;

		IF(@nom_compteabonne = NULL)
		BEGIN
			PRINT('makeAbonnement: le nom doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@prenom_compteabonne = NULL)
		BEGIN
			PRINT('makeAbonnement: le prenom doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@date_naissance_compteabonne = NULL)
		BEGIN
			PRINT('makeAbonnement: la date de naissance doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		SET @asCompteAbonne = (SELECT COUNT(*) FROM CompteAbonne 
										WHERE nom = @nom_compteabonne 
										AND   prenom = @prenom_compteabonne
										AND   date_naissance = @date_naissance_compteabonne);
										
		IF ( @asCompteAbonne = 0)
		BEGIN
			PRINT('makeAbonnement: pas de compte abonne correspondant');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@nom_typeabonnement = NULL)
		BEGIN
			PRINT('makeAbonnement: la type de l''abonnement doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		SET @asTypeAbonnement = (SELECT COUNT(*) FROM TypeAbonnement 
										WHERE nom = @nom_typeabonnement);
										
		IF ( @asTypeAbonnement = 0)
		BEGIN
			PRINT('makeAbonnement: pas de type abonnement correspondant');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		INSERT INTO Abonnement(
			nom_typeabonnement,
			nom_compteabonne,
			prenom_compteabonne,
			date_naissance_compteabonne
		)
		VALUES (
			@nom_typeabonnement,
			@nom_compteabonne,
			@prenom_compteabonne,
			@date_naissance_compteabonne
		);
		
		IF(@@ERROR <> 0)
		BEGIN
			PRINT('makeAbonnement: Error');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		SET @idAbonnement = SCOPE_IDENTITY();
		
		IF(@date_debut IS NOT NULL AND GETDATE ( ) > @date_debut)
		BEGIN
			PRINT('makeAbonnement: Veuillez saisire une date de debut présente ou future');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@duree IS NOT NULL AND @duree < 1 )
		BEGIN
			PRINT('makeAbonnement: La durée saisie n''es pas bonne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END

		EXEC dbo.updateAbonnement @idAbonnement, @date_debut, @duree, @renouvellement_auto = @returnPS OUTPUT;
		
		IF(@returnPS <> 1)
		BEGIN
			PRINT('makeAbonnement: Error');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		
/*
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
	
		EXEC dbo.makeAbonnement @nom, @prenom, @date_naissance,@date_debut,@duree,@renouvellement_auto, @nom_typeabonnement
*/			
		
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