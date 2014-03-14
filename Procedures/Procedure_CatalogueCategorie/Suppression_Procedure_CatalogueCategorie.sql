------------------------------------------------------------
-- Fichier     : Suppression_Procedure_CatalogueCategorie
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedure concernant la
--				liaison entre les catalogues et les 
--				categories de la base.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addCategorieToCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addCategorieToCatalogue;
GO

IF OBJECT_ID ('dbo.removeCategorieFromCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeCategorieFromCatalogue;
GO