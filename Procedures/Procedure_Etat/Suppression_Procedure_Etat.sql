------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Etat
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les etats
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEtat
GO

IF OBJECT_ID ('dbo.updateEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateEtat
GO