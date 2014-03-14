------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Conducteur
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				 conducteurs				
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createConducteur
GO

IF OBJECT_ID ('dbo.deleteConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteConducteur
GO

IF OBJECT_ID ('dbo.updateConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateConducteur
GO