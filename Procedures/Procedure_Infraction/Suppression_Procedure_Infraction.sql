------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Facturation
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				infractions
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createInfraction
GO