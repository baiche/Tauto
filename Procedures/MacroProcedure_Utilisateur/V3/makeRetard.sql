------------------------------------------------------------
-- Fichier     : makeRetard.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeRetard', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeRetard	
GO

CREATE PROCEDURE dbo.makeRetard
	@matricule				nvarchar(50), -- FK, l'un des deux paramètres est obligatoire
	@idLocation				int -- FK, l'un des deux paramètres est obligatoire
AS
	BEGIN TRANSACTION makeRetard
	BEGIN TRY
		COMMIT TRANSACTION makeRetard
		PRINT('makeRetard OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeRetard: ERROR');
		ROLLBACK TRANSACTION makeRetard
		RETURN -1;
	END CATCH
GO