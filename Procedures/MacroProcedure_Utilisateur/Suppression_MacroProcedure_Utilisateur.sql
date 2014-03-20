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