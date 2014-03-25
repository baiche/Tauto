------------------------------------------------------------
-- Fichier     : declareConducteur.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Déclare un conducteur à un compte abonné. Crée le conducteur
--			 	 avec son permis et le lie au compte abonné s’il n’existe pas,
--				 ou vérifie s’il possède le permis (l’ajoute à défaut), et vérifie 
--				 s’il est lié au compte abonné (le lie à default).
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.declareConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.declareConducteur	
GO

CREATE PROCEDURE dbo.declareConducteur
	@nom 				nvarchar(50), -- PK nom de l'abonné
	@prenom 			nvarchar(50), -- PK prénom de l'abonné
	@date_naissance 	date, 		  -- PK date de naissance de l'abonné
	@nom_conducteur		nvarchar(50), -- nom du conducteur
	@prenom_conducteur	nvarchar(50), -- prénom du conducteur
	@piece_identite 	nvarchar(50), -- PK piece d'identite du conducteur
	@nationalite 		nvarchar(50), -- PK nationalité du conducteur
	@numero_permis		nvarchar(50), -- nullable numero de permis
	@nom_typepermis 	nvarchar(10), -- nullable nom du sous permis (A1,A2,B...)
	@date_obtention 	date,		  -- nullable, si null ne pas prendre en compte la suite des arguments : date d'obtention du sous permis
	@periode_probatoire tinyint,      -- nullable, csq sur le nombre de points de base : peride probatoir du sous permis
	@date_expiration 	date,         -- nullable, null signifiant pas de limite : date d'expiration du sous permis
	@valide				bit,		  -- boolean pour la validité du permis
	@points_estimes		tinyint		  -- estimation du nombre de point du permis
AS
	BEGIN TRANSACTION declareConducteur
	BEGIN TRY
		DECLARE @asCompteAbonne		int,
				@asConducteur	 	int,
				@asPermis			int,
				@asSousPermis		int;
		
		--Si les information concernant le compte de l'abonne pas renseigner, on sort
		IF(@nom IS NULL OR @prenom IS NULL OR @date_naissance IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le compte abonne son incomplet');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		--Si les information concernant le conducteur pas renseigner, on sort
		IF(@piece_identite IS NULL OR @nationalite IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le conducteur son incomplet');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		--on verifie que le compte abonne au quel on veut ajouter le conducteur existe
		SET @asCompteAbonne = (SELECT COUNT(*) FROM CompteAbonne 
										WHERE nom = @nom
										AND   prenom = @prenom
										AND   date_naissance = @date_naissance);
		
		--on verifie que le conducteur qu'on veut ajouter existe
		SET @asConducteur = (SELECT COUNT(*) FROM Conducteur 
										WHERE piece_identite = @piece_identite
										AND   nationalite = @nationalite);
										
		--on verifie que le compte abonne au quel on veut ajouter le conducteur existe, a defaut on sort
		IF(@asCompteAbonne = 0)
		BEGIN
			PRINT('declareConducteur: ERROR compte abonné correspondant est introuvable');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		--SI le conducteur qu'on veut ajouter existe
		IF ( @asConducteur = 1 )
		BEGIN
			--si ne numero de permis est renseigné, on verifie que c le meme que celui du conducteur, a defaut on sort
			if( @numero_permis IS NOT NULL AND ((SELECT id_permis FROM Conducteur WHERE piece_identite = @piece_identite
																			   AND   nationalite = @nationalite) <> @numero_permis))
			BEGIN
				PRINT('declareConducteur: ERROR le numéro de permis du conducteur n''est pas bon');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			
			SET @numero_permis = (SELECT id_permis FROM Conducteur WHERE piece_identite = @piece_identite AND   nationalite = @nationalite);
			--si le conducteur n'as pas le sous permis renseignern, on lui ajoute le sous permis correspondant
			if( @nom_typepermis IS NOT NULL AND (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = @nom_typepermis
																			  AND   numero_permis = @numero_permis)=0)
			BEGIN
				--la date d'obtention et la date d'expiration du sous permis doivent etre indique, a defaut on sort
				IF(@date_obtention IS NULL OR @date_expiration IS NULL)
				BEGIN
					PRINT('declareConducteur: ERROR veuillez indiquer la date d''obtention et la date d''expiration');
					ROLLBACK TRANSACTION declareConducteur
					RETURN -1;
				END
				--verification de la coherence de la date_expiration et date_obtention
				IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
				BEGIN
					PRINT('declareConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
					ROLLBACK TRANSACTION declareConducteur
					RETURN -1;
				END
				--on insert le sous permis correspondant 
				INSERT INTO SousPermis (nom_typepermis,numero_permis,date_obtention,date_expiration)
								VALUES (@nom_typepermis,@numero_permis,@date_obtention,@date_expiration);
				--si la periode probatoir est renseigner, on met a jour la valeur correspondante
				IF(@periode_probatoire IS NOT NULL)
				BEGIN
					UPDATE SousPermis --ATTENTION verifier la valeur de periode_probatoir
					SET periode_probatoire = @periode_probatoire
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numero_permis;
				END
			END
			--verifie que le conducteur correspondant n'est pas deja ratache au compte abonne,a defaut on le ratache
			IF( (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = @nom
															 AND	prenom_compteabonne = @prenom
															 AND	date_naissance_compteabonne = @date_naissance
															 AND	piece_identite_conducteur = @piece_identite
															 AND	nationalite_conducteur = @nationalite) = 0)
			BEGIN	
				EXECUTE dbo.addConducteurToCompteAbonne @nom,@prenom,@date_naissance,@piece_identite,@nationalite;
			END	
		END
		--cas ou le conducteur n'existe pas
		ELSE
		BEGIN
			--le numero de permis et le nom du sous permis doivent etre renseginer, a defaut on sort
			IF(@numero_permis IS NULL OR @nom_typepermis IS NULL)
			BEGIN
				PRINT('declareConducteur: ERROR Veuillez renseignerginer le numéro de permis et le nom du type de permis');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			--la date_expiration et la date_obtention du sous permis doivent etre renseginer, a defaut on sort
			IF(@date_obtention IS NULL OR @date_expiration IS NULL)
			BEGIN
				PRINT('declareConducteur: ERROR Veuillez renseigner la date d''obtention et la date d''expiration du type de permis');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			--verification de la coherence de la date_expiration et date_obtention
			IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
			BEGIN
				PRINT('declareConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			--le nom et le prenom du conducteur doivent renseginer, a defaut on sort
			IF(@nom_conducteur IS NULL OR @prenom_conducteur IS NULL)
			BEGIN
				PRINT('declareConducteur: ERROR Veuillez renseigner le nom et le prénom du conducteur');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
		
		
			--creation du permis 
			INSERT INTO Permis (numero)VALUES (@numero_permis);
			--si le boolean valide du permis est renseginer, on met la valeur correspondante a jour
			IF(@valide IS NOT NULL)
			BEGIN
				UPDATE Permis
				SET valide = @valide
				WHERE numero = @numero_permis;
			END
			--si l'estimation de point du permis est renseginer, on met la valeur correspondante a jour
			IF(@points_estimes IS NOT NULL)
			BEGIN
				UPDATE Permis
				SET points_estimes = @points_estimes
				WHERE numero = @numero_permis;
			END
			--creation sous_permis
			INSERT INTO SousPermis (nom_typepermis,numero_permis,date_obtention,date_expiration)
								VALUES (@nom_typepermis,@numero_permis,@date_obtention,@date_expiration);
			--si la periode probatoir du sous permis est renseginer, on met la valeur correspondante a jour
			IF(@periode_probatoire IS NOT NULL)
			BEGIN
				UPDATE SousPermis
				SET periode_probatoire = @periode_probatoire
				WHERE nom_typepermis = @nom_typepermis
				AND numero_permis = @numero_permis;
			END
			--creation du conducteur 
			EXECUTE dbo.createConducteur @piece_identite,@nationalite,@nom_conducteur,@prenom_conducteur,@numero_permis;
			--liaison conducteur et compte abonne
			EXECUTE dbo.addConducteurToCompteAbonne @nom,@prenom,@date_naissance,@piece_identite,@nationalite;

		END
		COMMIT TRANSACTION declareConducteur
		PRINT('declareConducteur OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('declareConducteur: ERROR');
		ROLLBACK TRANSACTION declareConducteur
		RETURN -1;
	END CATCH
GO