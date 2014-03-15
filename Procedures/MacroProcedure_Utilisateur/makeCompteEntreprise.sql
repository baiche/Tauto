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
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@date_naissance 	date,
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50),
	@siret 				char(14),
	@nom 				nvarchar(50)
AS
	BEGIN TRANSACTION makeCompteEntreprise
	BEGIN TRY
		COMMIT TRANSACTION makeCompteEntreprise
		PRINT('makeCompteEntreprise OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeCompteEntreprise: ERROR');
		ROLLBACK TRANSACTION makeCompteEntreprise
		RETURN -1;
	END CATCH
GO