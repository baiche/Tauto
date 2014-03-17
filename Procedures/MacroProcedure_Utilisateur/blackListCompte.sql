------------------------------------------------------------
-- Fichier     : blackListCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.blackListCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.blackListCompte	
GO

CREATE PROCEDURE dbo.blackListCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
AS
	BEGIN TRANSACTION blackListCompte
	BEGIN TRY
		COMMIT TRANSACTION blackListCompte
		PRINT('blackListCompte OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('blackListCompte: ERROR');
		ROLLBACK TRANSACTION blackListCompte
		RETURN -1;
	END CATCH
GO