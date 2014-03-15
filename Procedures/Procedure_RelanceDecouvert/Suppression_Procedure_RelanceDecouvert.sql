------------------------------------------------------------
-- Fichier     : Suppression_Procedure_RelanceDecouvert
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				relance decouverts
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createRelanceDecouvert
GO

IF OBJECT_ID ('dbo.deleteRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteRelanceDecouvert
GO

IF OBJECT_ID ('dbo.disableRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableRelanceDecouvert
GO

IF OBJECT_ID ('dbo.relanceRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.relanceRelanceDecouvert
GO

IF OBJECT_ID ('dbo.updateNiveauRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateNiveauRelanceDecouvert
GO

