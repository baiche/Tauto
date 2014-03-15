------------------------------------------------------------
-- Fichier     : modifyCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyCompte	
GO

CREATE PROCEDURE dbo.modifyCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50), -- nullable
	@courriel 			nvarchar(50), -- nullable
	@telephone 			nvarchar(50), -- nullable
	@siret 				char(14),	  -- nullable
	@nom 				nvarchar(50), -- nullable
	@greyList			bit 		  -- nullable
AS
	BEGIN TRANSACTION modifyCompte
	BEGIN TRY
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