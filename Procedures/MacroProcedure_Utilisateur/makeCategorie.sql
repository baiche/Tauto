------------------------------------------------------------
-- Fichier     : makeCategorie.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCategorie	
GO

CREATE PROCEDURE dbo.makeCategorie
	@nom_catalogue			nvarchar(50), -- FK
	@nom					nvarchar(50), -- PK
	@description 			nvarchar(50),
	@nom_typepermis			nvarchar(10)
AS
	BEGIN TRANSACTION makeCategorie
	BEGIN TRY
		COMMIT TRANSACTION makeCategorie
		PRINT('makeCategorie OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeCategorie: ERROR');
		ROLLBACK TRANSACTION makeCategorie
		RETURN -1;
	END CATCH
GO