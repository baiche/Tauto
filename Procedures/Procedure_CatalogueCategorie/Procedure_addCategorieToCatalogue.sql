------------------------------------------------------------
-- Fichier     : Procedure_addCategorieToCatalogue
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addCategorieToCatalogue', 'P') IS NOT NULL
DROP PROCEDURE dbo.addCategorieToCatalogue;
GO

CREATE PROCEDURE dbo.addCategorieToCatalogue
	@nom_catalogue 					nvarchar(50),
	@nom_categorie 					nvarchar(50)
AS
	INSERT INTO CatalogueCategorie(
		nom_catalogue,
		nom_categorie
	)
	VALUES (
		@nom_catalogue,
		@nom_categorie
	)
GO
