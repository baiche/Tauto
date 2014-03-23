------------------------------------------------------------
-- Fichier     : Suppression_Procedure_CompteAbonne
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				compte abonne
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.blackListCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.blackListCompteAbonne
GO

IF OBJECT_ID ('dbo.createParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createParticulier
GO

IF OBJECT_ID ('dbo.createEntreprise', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEntreprise
GO

IF OBJECT_ID ('dbo.deleteCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteCompteAbonne
GO

IF OBJECT_ID ('dbo.disableCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableCompteAbonne
GO

IF OBJECT_ID ('dbo.getCompteAbonneReservations', 'P') IS NOT NULL
	DROP PROCEDURE dbo.getCompteAbonneReservations
GO

IF OBJECT_ID ('dbo.greyListCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.greyListCompteAbonne
GO

IF OBJECT_ID ('dbo.updateCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateCompteAbonne
GO

