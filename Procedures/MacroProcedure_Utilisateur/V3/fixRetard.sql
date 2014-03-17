------------------------------------------------------------
-- Fichier     : fixRetard.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixRetard', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixRetard	
GO

CREATE PROCEDURE dbo.fixRetard
	@matricule				nvarchar(50), -- FK, l'un des deux paramètres est obligatoire
	@idLocation				int -- FK, l'un des deux paramètres est obligatoire
AS
	BEGIN TRANSACTION fixRetard
	BEGIN TRY
		COMMIT TRANSACTION fixRetard
		PRINT('fixRetard OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixRetard: ERROR');
		ROLLBACK TRANSACTION fixRetard
		RETURN -1;
	END CATCH
GO