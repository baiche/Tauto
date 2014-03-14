------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Categorie
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedure concernant les
--				categories
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCategorie
GO

IF OBJECT_ID ('dbo.deleteCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteCategorie
GO

IF OBJECT_ID ('dbo.disableCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableCategorie
GO

IF OBJECT_ID ('dbo.updateCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateCategorie
GO