------------------------------------------------------------
-- Fichier     : closeCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCompte	
GO

CREATE PROCEDURE dbo.closeCompte
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@date_naissance 	date
AS
	BEGIN TRANSACTION closeCompte
	BEGIN TRY
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