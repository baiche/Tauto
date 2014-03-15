------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Permis
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createPermis
GO

IF OBJECT_ID ('dbo.deletePermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deletePermis
GO

IF OBJECT_ID ('dbo.updatePermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updatePermis
GO