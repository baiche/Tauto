------------------------------------------------------------
-- Fichier     : Procedure_removeCategorieFromCatalogue
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Procedure permettant de supprimer une 
--				 categorie d'un catalogue.	
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.removeCategorieFromCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeCategorieFromCatalogue;
GO

CREATE PROCEDURE dbo.removeCategorieFromCatalogue
	@nom_catalogue 					nvarchar(50),
	@nom_categorie 					nvarchar(50)
AS
	BEGIN TRY
		DELETE FROM CatalogueCategorie
		WHERE nom_catalogue = @nom_catalogue
		AND nom_categorie = @nom_categorie
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.removeCategorieFromCatalogue',10,1)
	END CATCH
GO
