------------------------------------------------------------
-- Fichier     : Procedure_createAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un abonnement et renvoie l'id de cet abonnement, -1 en cas d'erreur
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
	BEGIN TRANSACTION create_Abonnement
		BEGIN TRY
			DECLARE @COMPTEABONNE_T TABLE(
				nom 				nvarchar(50),
				prenom				nvarchar(50), 
				date_naissance		date, 
				actif				bit, 
				liste_grise			bit
			)
			DECLARE @actif_curseur 			bit,
					@liste_grise_curseur 	bit;
				
			INSERT INTO @COMPTEABONNE_T(actif, liste_grise)
				(SELECT actif, liste_grise
					FROM CompteAbonne
					WHERE nom = @nom_compteabonne
					AND prenom = @prenom_compteabonne
					AND date_naissance = @date_naissance_compteabonne
				);
				
			IF ( (SELECT COUNT(*) FROM @COMPTEABONNE_T) = 0 )
			BEGIN
				--Print('createAbonnement: aucun compte_abonnement correspondant');
				--RETURN -1;
				RAISERROR ('createAbonnement: aucun compte_abonnement correspondant', 10, -1); 
			END
			
			DECLARE compteAbonnement_curseur CURSOR
				FOR SELECT * FROM @COMPTEABONNE_T
				OPEN compteAbonnement_curseur
				FETCH NEXT FROM compteAbonnement_curseur
				INTO @actif_curseur, @liste_grise_curseur;
				
			CLOSE compteAbonnement_curseur;
			DEALLOCATE compteAbonnement_curseur;
		
			IF ( @actif_curseur = 'false')	
			BEGIN
				--Print('createAbonnement: compte_abonnement correspondant non actif');
				--RETURN -1;
				RAISERROR ('createAbonnement: compte_abonnement correspondant non actif', 10, -1);
			END
		
			IF ( @liste_grise_curseur = 'true')	
			BEGIN
				Print('createAbonnement: ATTENTION, compte_abonnement correspondant est sur liste grise');
			END
		
			IF ( GETDATE() > @date_debut ) 
			BEGIN
				--Print('createAbonnement: Date de début de l\'abonnement inférieur à celle d\'aujourd\'hui');
				--RETURN -1;
				RAISERROR ('createAbonnement: Date de début de l abonnement inférieur à celle d aujourd hui', 10, -1);
			END
		
			IF ( @duree < 1 ) --a retirer et à tester en CHECK ds Generation
			BEGIN
				--Print('createAbonnement: Durée de l\'abonnement trop petite');
				--RETURN -1;
				RAISERROR ('createAbonnement: Durée de l abonnement trop petite', 10, -1);
			END
		
			DECLARE @TYPEABONNEMENT_T TABLE(
				nom 				nvarchar(50))
			
			INSERT INTO @TYPEABONNEMENT_T(nom)
				(SELECT nom
				FROM TypeAbonnement
				WHERE nom = @nom_typeabonnement);
			
			IF ( (SELECT COUNT(*) FROM @TYPEABONNEMENT_T) = 0 )
			BEGIN
				--Print('createAbonnement: aucun type_abonnement correspondant');
				--RETURN -1;
				RAISERROR ('createAbonnement: aucun type_abonnement correspondant', 10, -1);
			END

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
			);
			PRINT('createAbonnement créé ' + CAST(SCOPE_IDENTITY() AS CHAR(5)) );
			RETURN SCOPE_IDENTITY();
		END TRY
		BEGIN CATCH
			PRINT('createAbonnement: ERROR');
			ROLLBACK TRANSACTION create_location;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION create_Abonnement;
GO
