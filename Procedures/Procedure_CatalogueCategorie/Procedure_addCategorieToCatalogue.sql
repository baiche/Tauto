------------------------------------------------------------
-- Fichier     : Procedure_addCategorieToCatalogue
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Procedure ajoutant une catagorie à un catalogue
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addCategorieToCatalogue', 'P') IS NOT NULL
DROP PROCEDURE dbo.addCategorieToCatalogue;
GO

CREATE PROCEDURE dbo.addCategorieToCatalogue
	@nom_catalogue 					nvarchar(50),
	@nom_categorie 					nvarchar(50)
AS
	BEGIN TRY
		INSERT INTO CatalogueCategorie(
			nom_catalogue,
			nom_categorie
		)
		VALUES (
			@nom_catalogue,
			@nom_categorie
		)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
	 
GO
