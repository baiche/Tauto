------------------------------------------------------------
-- Fichier     : makeCompteEntreprise.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCompteEntreprise', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteEntreprise	
GO

CREATE PROCEDURE dbo.makeCompteEntreprise
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50),
	@siret 				nvarchar(50),
	@nom_entreprise		nvarchar(50)
AS
	BEGIN TRANSACTION makeCompteEntreprise
	
		--On s'assure que  les champs ne sont pas NULL 
	IF (@nom IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le nom doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	IF (@prenom IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le prenom doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	IF (@date_naissance IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: La date_naissance doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	IF (@iban IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le numero IBAN doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	IF (@courriel IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le courriel doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	IF (@telephone IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le numero de telephone doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	IF (@siret IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le numero de siret doit etre renseigne');
			ROLLBACK TRANSACTION makeCompteParticulier
			RETURN -1
	END
	
	
	IF (@nom_entreprise IS NULL)
	BEGIN
			PRINT('makeCompteEntreprise: Le nom de l''entreprise doit etre renseigne');
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
			PRINT('makeCompteEntreprise: La personne est sur liste noire');
			ROLLBACK TRANSACTION makeCompteEntreprise
			RETURN -1
		END
	END TRY
	BEGIN CATCH
		PRINT('makeCompteEntreprise: ERROR');
		DECLARE @msg varchar(4000)
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION makeCompteEntreprise
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
			EXEC dbo.createEntreprise @nom, @prenom, @date_naissance, @iban, @courriel, @telephone, @siret, @nom_entreprise;
		END
	ELSE
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
			PRINT 'makeCompteEntreprise : Le compte existe déjà'
			ROLLBACK TRANSACTION makeCompteEntreprise
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
			COMMIT TRANSACTION makeCompteEntreprise
			PRINT('makeCompteEntreprise OK');
			RETURN 1 	
		END	
	
	BEGIN TRY
		COMMIT TRANSACTION makeCompteEntreprise
		PRINT('makeCompteEntreprise OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeCompteEntreprise: ERROR');
		DECLARE @msg varchar(4000)
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION makeCompteEntreprise
		RETURN -1;
	END CATCH
GO