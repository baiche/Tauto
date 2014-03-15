------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Retard
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				retards
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createRetard', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createRetard
GO
