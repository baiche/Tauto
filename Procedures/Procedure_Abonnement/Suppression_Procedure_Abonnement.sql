------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Abonnement
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les abonnements de la base.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createAbonnement
GO

IF OBJECT_ID ('dbo.deleteAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteAbonnement	
GO

IF OBJECT_ID ('dbo.updateAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateAbonnement
GO

IF OBJECT_ID ('dbo.disableAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableAbonnement
GO

IF OBJECT_ID ('dbo.updateTypeAbonnementForAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateTypeAbonnementForAbonnement
GO

