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

IF OBJECT_ID ('dbo.writeFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.writeFile;
GO

IF OBJECT_ID ('dbo.openFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.openFile;
GO

IF OBJECT_ID ('dbo.closeFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeFile;
GO

IF OBJECT_ID ('dbo.WriteStringToFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.WriteStringToFile;
GO