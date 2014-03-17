------------------------------------------------------------
-- Fichier     : Suppression_Procedure_CategorieModele
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedure concernant la
--				liaison entre les categories et les modeles
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addModeleToCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addModeleToCategorie
GO

IF OBJECT_ID ('dbo.deleteModeleFromCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteModeleFromCategorie
GO