------------------------------------------------------------
-- Fichier     : Suppression_Procedure_TypeAbonnement
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				types d'abonnements
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.canDeleteTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.canDeleteTypeAbonnement
GO

IF OBJECT_ID ('dbo.createTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createTypeAbonnement
GO

IF OBJECT_ID ('dbo.deleteTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteTypeAbonnement
GO

IF OBJECT_ID ('dbo.updateTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateTypeAbonnement
GO
