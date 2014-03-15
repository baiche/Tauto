------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Location
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				listes noires
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createLocation
GO

IF OBJECT_ID ('dbo.deleteLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteLocation
GO