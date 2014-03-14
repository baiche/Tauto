------------------------------------------------------------
-- Fichier     : makeCompteParticulier.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCompteParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteParticulier	
GO

CREATE PROCEDURE dbo.makeCompteParticulier
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@date_naissance 	date,
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50),
AS
	BEGIN TRANSACTION makeCompteParticulier
	BEGIN TRY
		COMMIT TRANSACTION makeCompteParticulier
		PRINT('makeCompteParticulier OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeCompteParticulier: ERROR');
		ROLLBACK TRANSACTION makeCompteParticulier
		RETURN -1;
	END CATCH
GO