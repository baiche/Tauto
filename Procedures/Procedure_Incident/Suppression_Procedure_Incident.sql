------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Incident
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				incidents
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createIncident', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createIncident
GO