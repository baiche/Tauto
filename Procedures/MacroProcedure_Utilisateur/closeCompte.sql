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
	BEGIN TRY
		
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
		ROLLBACK TRANSACTION closeCompte
		RETURN -1;
	END CATCH
GO