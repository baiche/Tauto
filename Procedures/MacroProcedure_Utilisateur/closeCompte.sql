------------------------------------------------------------
-- Fichier     : closeCompte.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Fermeture d'un compte
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCompte	
GO

CREATE PROCEDURE dbo.closeCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
AS
	BEGIN TRANSACTION closeCompte
	DECLARE @msg varchar(4000)
	BEGIN TRY
		-- verification des arguments
		IF(@nom IS NULL)
		BEGIN
			PRINT('closeCompte: Le nom doit etre renseigne');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END
		
		IF(@prenom IS NULL)
		BEGIN
			PRINT('closeCompte: Le prenom doit etre renseigne');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END
		
		IF(@date_naissance IS NULL)
		BEGIN
			PRINT('closeCompte: La date_naissance doit etre renseignee');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END
	
		-- on regarde si le compte existe
		
		IF((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 0)
		BEGIN
			PRINT('closeCompte: Le compte n''existe pas');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END 
	
		-- on regarde si le compte n'est pas d�j� inactif
		IF((SELECT actif FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 'false')
		BEGIN
			PRINT('closeCompte: Le compte est deja inactif');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END 
		
		UPDATE CompteAbonne 
		SET actif = 'false'
		WHERE nom = @nom
		AND prenom = @prenom
		AND date_naissance = @date_naissance
		
		COMMIT TRANSACTION closeCompte
		PRINT('closeCompte OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeCompte: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeCompte
		RETURN -1;
	END CATCH
GO