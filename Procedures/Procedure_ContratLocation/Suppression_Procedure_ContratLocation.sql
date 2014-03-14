------------------------------------------------------------
-- Fichier     : Suppression_Procedure_ContratLocation
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				contrats location			
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.canExtendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.canExtendContratLocation;
GO

IF OBJECT_ID ('dbo.removeConducteurFromLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromLocation
GO

IF OBJECT_ID ('dbo.createContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createContratLocation
GO

IF OBJECT_ID ('dbo.deleteContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteContratLocation
GO

IF OBJECT_ID ('dbo.endContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.endContratLocation	
GO

IF OBJECT_ID ('dbo.extendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendContratLocation
GO

IF OBJECT_ID ('dbo.printContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.printContratLocation
GO

IF OBJECT_ID ('dbo.updateContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateContratLocation
GO