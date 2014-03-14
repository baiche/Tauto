------------------------------------------------------------
-- Fichier     : Procedure_createAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un abonnement.
--				Renvoie l'id de l'abonnemement ou -1 en cas d'erreur 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createAbonnement

GO
CREATE PROCEDURE dbo.createAbonnement
	@date_debut 					date,
	@duree 							int,
	@renouvellement_auto 			bit,
	@nom_typeabonnement 			nvarchar(50),
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne 			nvarchar(50),
	@date_naissance_compteabonne 	date
AS
	BEGIN TRY
		IF (@date_debut < GETDATE())
		BEGIN
			PRINT('createAbonnement: Date de début inférieure à la date d''aujourd''hui');
			RETURN -1;
		END
		IF ( (SELECT actif FROM CompteAbonne
			WHERE nom = @nom_compteabonne AND
				  prenom = @prenom_compteabonne AND
				  date_naissance = @date_naissance_compteabonne
			  ) = 'true'
			)
		BEGIN
			INSERT INTO Abonnement(
				date_debut,
				duree,
				renouvellement_auto,
				nom_typeabonnement,
				nom_compteabonne,
				prenom_compteabonne,
				date_naissance_compteabonne
			)
			VALUES (
				@date_debut,
				@duree,
				@renouvellement_auto,
				@nom_typeabonnement,
				@nom_compteabonne,
				@prenom_compteabonne,
				@date_naissance_compteabonne
			)
			PRINT('createAbonnement créé');
			RETURN SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			PRINT('createAbonnement: compte abonné inactif');
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('createAbonnement: ERROR');
		RETURN -1;
	END CATCH
GO
