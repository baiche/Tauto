------------------------------------------------------------
-- Fichier     : Suppression_Procedure_ConducteurLocation
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant la liaison
--				 entre les conducteurs et les locations.			
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addConducteurToLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addConducteurToLocation
GO

IF OBJECT_ID ('dbo.removeConducteurFromLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromLocation
GO