------------------------------------------------------------
-- Fichier     : makeCatalogue.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCatalogue	
GO

CREATE PROCEDURE dbo.makeCatalogue
	@nom 					nvarchar(50), -- PK
	@date_debut 			date, -- nullable, la date par défaut est la date du jour
	@date_fin		 		date  -- vérifier debut <= fin
AS
	BEGIN TRANSACTION makeCatalogue
	BEGIN TRY
		COMMIT TRANSACTION makeCatalogue
		PRINT('makeCatalogue OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeCatalogue: ERROR');
		ROLLBACK TRANSACTION makeCatalogue
		RETURN -1;
	END CATCH
GO