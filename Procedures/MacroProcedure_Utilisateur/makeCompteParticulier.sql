------------------------------------------------------------
-- Fichier     : makeCompteParticulier.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajout d'un particulier dans la base
--				si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCompteParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteParticulier	
GO

CREATE PROCEDURE dbo.makeCompteParticulier
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50)
AS
	BEGIN TRANSACTION makeCompteParticulier
	
	BEGIN TRY
	
		
		--On s'assure que  les champs ne sont pas NULL 
		IF (@nom IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le nom doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@prenom IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le prenom doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@date_naissance IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: La date_naissance doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@iban IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le numero IBAN doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@courriel IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le courriel doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@telephone IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le numero de telephone doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		--On veut s'assurer que l'on peut ajouter le CompteAbonne
		--Gestion de la liste noire
		DECLARE @isInListeNoire		INT
		BEGIN TRY
			EXEC @isInListeNoire = dbo.isInListeNoire @nom,@prenom,@date_naissance;
			IF(@isInListeNoire = 1)
			BEGIN
				PRINT('makeCompteParticulier: La personne est sur liste noire');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
			END
		END TRY
		BEGIN CATCH
			PRINT('makeCompteParticulier: ERROR');
			DECLARE @msg varchar(4000)
			SET @msg = ERROR_MESSAGE()
			PRINT(@msg)
			ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END CATCH

		--Je n'ai pas à gérer le cas ou a_supprimer est vrai car cela veut dire que le 
		-- compte_abonne est sur liste noire
		
		--Si la personne n'existe pas déjà
		IF((
			SELECT COUNT(*) 
			FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 0)
			BEGIN 
				--ajout du compte abonne
				EXEC dbo.createParticulier @nom, @prenom, @date_naissance, @iban ,@courriel, @telephone
				--ajout dans la table particulier
				--INSERT INTO Particulier (nom_compte, prenom_compte, date_naissance_compte)
				--VALUES (@nom,@prenom,@date_naissance)
				COMMIT TRANSACTION makeCompteParticulier
				PRINT('makeCompteParticulier OK');
				RETURN 1;
			END
			
		ELSE
		BEGIN
		-- Si la personne existe déjà
			--On regarde si le compte est actif
			IF((
				SELECT actif 
				FROM CompteAbonne
				WHERE nom = @nom
				AND prenom = @prenom
				AND date_naissance = @date_naissance) =  1
			)
			-- s'il l'est on le signale
			BEGIN 
				PRINT 'makeCompteParticulier : Le compte existe déjà'
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1;
			END
			ELSE
			-- s'il ne l'est pas on le rend actif
			BEGIN
				UPDATE CompteAbonne
				SET actif = 1
				WHERE nom = @nom
				AND prenom = @prenom
				AND date_naissance = @date_naissance
				COMMIT TRANSACTION makeCompteParticulier
				PRINT('makeCompteParticulier OK');
				RETURN 1 	
			END
		END
	END TRY
	BEGIN CATCH
		PRINT 'makeCompteParticulier : Exception recue'
		DECLARE @msg varchar(4000)
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION makeCompteParticulier
		RETURN -1;
	END CATCH
GO