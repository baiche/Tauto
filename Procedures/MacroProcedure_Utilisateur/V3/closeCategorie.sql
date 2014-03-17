------------------------------------------------------------
-- Fichier     : closeCategorie.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCategorie	
GO

CREATE PROCEDURE dbo.closeCategorie
	@nom 			nvarchar(50),
	@modeleToo		bit -- nullable, false par défaut
AS
	BEGIN TRANSACTION closeCategorie
	BEGIN TRY
		COMMIT TRANSACTION closeCategorie
		PRINT('closeCategorie OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeCategorie: ERROR');
		ROLLBACK TRANSACTION closeCategorie
		RETURN -1;
	END CATCH
GO