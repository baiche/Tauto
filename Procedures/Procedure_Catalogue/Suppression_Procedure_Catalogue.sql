------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Catalogue
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedure concernant les 
--				catalogues de la base.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCatalogue;
GO

IF OBJECT_ID ('dbo.deleteCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteCatalogue;
GO

IF OBJECT_ID ('dbo.updateCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateCatalogue;
GO