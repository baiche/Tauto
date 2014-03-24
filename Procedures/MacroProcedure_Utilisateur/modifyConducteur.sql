------------------------------------------------------------
-- Fichier     : modifyConducteur.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : modifie le conducteur ou supprime un permis. 
--				 Les arguments sont optionnels. Le nom du type 
--				 de permis est à recherché dans l'ensemble des sous-permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyConducteur	
GO

CREATE PROCEDURE dbo.modifyConducteur
	--Conducteur
	@piece_identite 	nvarchar(50), -- PK
	@nationalite 		nvarchar(50), -- PK
	@nom 				nvarchar(50), -- NOT NULL
	@prenom 			nvarchar(50), -- NOT NULL
	--Permis
	@valide 			bit,		  -- DEFAULT 'true'
	@points_estimes 	tinyint, 	  -- NOT NULL 	DEFAULT 12
	--SousPermis
	@nom_typepermis		nvarchar(10), -- PK
	@date_obtention 	date,     	  -- NOT NULL
	@date_expiration 	date,         -- NOT NULL
	@periode_probatoire tinyint   	  -- NOT NULL 	DEFAULT 3
AS
	BEGIN TRANSACTION modifyConducteur
	BEGIN TRY
	
		DECLARE @asConducteur	 	int,
				@asSousPermis		int,
				@numPemis			nvarchar(50);
	
		--Si les information concernant le conducteur pas renseigner, on sort
		IF(@piece_identite IS NULL OR @nationalite IS NULL)
		BEGIN
			PRINT('modifyConducteur: ERROR Les informations concernant le conducteur son incomplet');
			ROLLBACK TRANSACTION modifyConducteur
			RETURN -1;
		END
		
		--on verifie que le conducteur existe
		SET @asConducteur = (SELECT COUNT(*) FROM  Conducteur 
											 WHERE piece_identite = @piece_identite
											 AND   nationalite = @nationalite);
		--on verifie que le conducteur existe, a defaut on sort
		IF(@asConducteur = 0)
		BEGIN
			PRINT('modifyConducteur: ERROR conducteur correspondant est introuvable');
			ROLLBACK TRANSACTION modifyConducteur
			RETURN -1;
		END
		
		--On recupere le numero de permis du conducteur
		SET @numPemis = (SELECT id_permis FROM Conducteur
										  WHERE piece_identite = @piece_identite
										  AND   nationalite = @nationalite);
		
		--Si le nom est renseigner, on met a jour le nom du conducteur
		IF(@nom IS NOT NULL)
		BEGIN
			UPDATE Conducteur
			SET nom = @nom
			WHERE piece_identite = @piece_identite
			AND   nationalite = @nationalite;
		END
		
		--Si le prenom est renseigner, on met a jour le prenom du conducteur
		IF(@nom IS NOT NULL)
		BEGIN
			UPDATE Conducteur
			SET prenom = @prenom
			WHERE piece_identite = @piece_identite
			AND   nationalite = @nationalite;
		END
		
		--Si la validité du permis est renseigner, on met a jour la validité du permis du conducteur
		IF(@valide IS NOT NULL)
		BEGIN
			UPDATE Permis
			SET valide = @valide
			WHERE numero = @numPemis;
		END

		--Si l'estimation de point du permis est renseigner, on met a jour l'estimation de point du permis du conducteur
		IF(@valide IS NOT NULL)
		BEGIN
			UPDATE Permis
			SET points_estimes = @points_estimes
			WHERE numero = @numPemis;
		END
		
		--Si le nom du sous permis est renseigner
		IF(@nom_typepermis IS NOT NULL)
		BEGIN
			--on verifie que le sous permis inquer existe ou pas
			SET @asSousPermis = (SELECT COUNT(*) FROM  SousPermis
												 WHERE nom_typepermis = @nom_typepermis
												 AND   numero_permis = @numPemis);
												 
			--si le sous permis n'existe pas deja, on le cré
			IF(@asSousPermis = 0)
			BEGIN
				--on verifie que la date d'obte,tion et d'expiration sont renseigner, a defaut on sort
				IF(@date_obtention IS NULL OR @date_expiration IS NULL)
				BEGIN
					PRINT('modifyConducteur: ERROR veuillez indiquer la date d''obtention et la date d''expiration');
					ROLLBACK TRANSACTION modifyConducteur
					RETURN -1;
				END
				--verification de la coherence de la date_expiration et date_obtention
				IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
				BEGIN
					PRINT('modifyConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
					ROLLBACK TRANSACTION modifyConducteur
					RETURN -1;
				END
				--on insert le sous permis correspondant 
				INSERT INTO SousPermis (nom_typepermis,numero_permis,date_obtention,date_expiration)
								VALUES (@nom_typepermis,@numPemis,@date_obtention,@date_expiration);
				--si la periode probatoir est renseigner, on met a jour la valeur correspondante
				IF(@periode_probatoire IS NOT NULL)
				BEGIN
					UPDATE SousPermis --ATTENTION verifier la valeur de periode_probatoir
					SET periode_probatoire = @periode_probatoire
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END	
			END
			----si le sous permis existe deja, on le modifie
			ELSE
			BEGIN
				--si la date d'obtention du sous permis est renseigner
				IF(@date_obtention IS NOT NULL)
				BEGIN
					--verification de la coherence de la date_obtention
					IF(@date_obtention > GETDATE())
					BEGIN
						PRINT('modifyConducteur: ERROR problème avec la date d''obtention du sous permis');
						ROLLBACK TRANSACTION modifyConducteur
						RETURN -1;
					END
					--on met a jour la date d'obtention du sous permis
					UPDATE SousPermis 
					SET date_obtention = @date_obtention
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END
				--si la date d'expiration du sous permis est renseigner
				IF(@date_expiration IS NOT NULL)
				BEGIN
					--verification de la coherence de la date_expiration
					IF(@date_expiration < GETDATE())
					BEGIN
						PRINT('modifyConducteur: ERROR problème avec la date d''expiration du sous permis');
						ROLLBACK TRANSACTION modifyConducteur
						RETURN -1;
					END
					--on met a jour la date d'expiration du sous permis
					UPDATE SousPermis 
					SET date_expiration = @date_expiration
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END
				--si la periode probatoir est renseigner, on met a jour la valeur correspondante
				IF(@periode_probatoire IS NOT NULL)
				BEGIN
					UPDATE SousPermis --ATTENTION verifier la valeur de periode_probatoir
					SET periode_probatoire = @periode_probatoire
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END
				--verification de la coherence de la date_expiration et date_obtention si les 2 renseigner
				IF(@date_obtention IS NOT NULL AND @date_expiration IS NOT NULL)
				BEGIN
					IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
					BEGIN
						PRINT('modifyConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
						ROLLBACK TRANSACTION modifyConducteur
						RETURN -1;
					END
				END
			END
		END
		--Le nom du sous permis n'est pas renseigner
		ELSE
		BEGIN
			PRINT('modifyConducteur: INFORMATION le nom du sous permis n''a pas été renseigner, impossible d''effectuer des operation sur ce dernier');
		END
		COMMIT TRANSACTION modifyConducteur
		PRINT('modifyConducteur OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyConducteur: ERROR');
		ROLLBACK TRANSACTION modifyConducteur
		RETURN -1;
	END CATCH
GO