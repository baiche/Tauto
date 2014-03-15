------------------------------------------------------------
-- Fichier     : makeModele.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeModele	
GO

CREATE PROCEDURE dbo.makeModele
	@nom_catalogue			nvarchar(50), -- FK
	@nom_categorie			nvarchar(50), -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint  -- PK
	@annee 					int,
	@prix 					money,
	@reduction 				tinyint	-- nullable
AS
	BEGIN TRANSACTION makeModele
	BEGIN TRY
		COMMIT TRANSACTION makeModele
		PRINT('makeModele OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeModele: ERROR');
		ROLLBACK TRANSACTION makeModele
		RETURN -1;
	END CATCH
GO