------------------------------------------------------------
-- Fichier     : closeCatalogue.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCatalogue	
GO

CREATE PROCEDURE dbo.closeCatalogue
	@nom 			nvarchar(50),
	@categorieToo		bit -- nullable, false par défaut
AS
	BEGIN TRANSACTION closeCatalogue
	BEGIN TRY
		COMMIT TRANSACTION closeCatalogue
		PRINT('closeCatalogue OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeCatalogue: ERROR');
		ROLLBACK TRANSACTION closeCatalogue
		RETURN -1;
	END CATCH
GO