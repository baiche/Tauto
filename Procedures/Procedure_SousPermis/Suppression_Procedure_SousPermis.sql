------------------------------------------------------------
-- Fichier     : Suppression_Procedure_SousPermis
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				sous permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createSousPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createSousPermis
GO

IF OBJECT_ID ('dbo.deleteSousPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteSousPermis
GO
