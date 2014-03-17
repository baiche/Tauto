------------------------------------------------------------
-- Fichier     : modifyCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Methode modifant les champs d'un compte
-- autre que ceux permettant de l'identifier
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyCompte	
GO

CREATE PROCEDURE dbo.modifyCompte
	@nom 					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date, -- PK
	@iban 					nvarchar(50), -- nullable
	@courriel 				nvarchar(50), -- nullable
	@telephone 				nvarchar(50), -- nullable
	@siret 					char(14),	  -- nullable
	@nom_entreprise					nvarchar(50), -- nullable
	@greyList				bit, 		  -- nullable
	@renouvellement_auto	bit 		  -- nullable
AS
	BEGIN TRANSACTION modifyCompte
	BEGIN TRY
		
		IF (@iban <> NULL)
			UPDATE CompteAbonne
			SET iban = @iban
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		IF (@nom <> NULL)
			UPDATE CompteAbonne
			SET courriel = @courriel
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		IF (@telephone <> NULL)
			UPDATE CompteAbonne
			SET telephone = @telephone
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		IF (@siret <> NULL)
			UPDATE Entreprise
			SET siret = @siret
			WHERE nom_compte = @nom
			AND	prenom_compte = @prenom
			AND date_naissance_compte = @date_naissance
		
		IF (@date_naissance <> NULL)
			UPDATE Entreprise
			SET nom = @nom_entreprise
			WHERE nom_compte = @nom
			AND	prenom_compte = @prenom
			AND date_naissance_compte = @date_naissance
		
		IF (@greylist <> NULL)
			UPDATE CompteAbonne
			SET liste_grise = @greyList
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		COMMIT TRANSACTION modifyCompte
		PRINT('modifyCompte OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyCompte: ERROR');
		ROLLBACK TRANSACTION modifyCompte
		RETURN -1;
	END CATCH
GO