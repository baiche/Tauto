------------------------------------------------------------
-- Fichier     : Suppression_Procedure_CategorieModele
-- Date        : 20/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les MacroProcedures
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.associateConducteurToLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.associateConducteurToLocation	
GO

IF OBJECT_ID ('dbo.blackListCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.blackListCompte	
GO

IF OBJECT_ID ('dbo.cancelReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.cancelReservation	
GO

IF OBJECT_ID ('dbo.closeCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCompte	
GO

IF OBJECT_ID ('dbo.declareConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.declareConducteur	
GO

IF OBJECT_ID ('dbo.modifyConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyConducteur	
GO

IF OBJECT_ID ('dbo.makeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeAbonnement	
GO

IF OBJECT_ID ('dbo.makeCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCatalogue	
GO

IF OBJECT_ID ('dbo.makeCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCategorie	
GO

IF OBJECT_ID ('dbo.makeCompteEntreprise', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteEntreprise	
GO

IF OBJECT_ID ('dbo.makeCompteParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteParticulier	
GO

IF OBJECT_ID ('dbo.makeModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeModele	
GO

IF OBJECT_ID ('dbo.makeReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeReservation	
GO

IF OBJECT_ID ('dbo.makeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeVehicule	
GO

IF OBJECT_ID ('dbo.modifyCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyCompte	
GO

IF OBJECT_ID ('dbo.modifyConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyConducteur	
GO

IF OBJECT_ID ('dbo.searchVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.searchVehicule
GO

IF OBJECT_ID ('dbo.turnReservationIntoContratLocat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.turnReservationIntoContratLocat	
GO
