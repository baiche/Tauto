------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Modele
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				modeles
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createModele
GO

IF OBJECT_ID ('dbo.deleteModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteModele
GO

IF OBJECT_ID ('dbo.disableModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableModele
GO

IF OBJECT_ID ('dbo.updatePrixModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updatePrixModele
GO

IF OBJECT_ID ('dbo.updateReductionModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateReductionModele
GO