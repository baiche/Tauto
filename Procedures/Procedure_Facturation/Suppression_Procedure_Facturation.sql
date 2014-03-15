------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Facturation
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				facturations
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createFacturation;
GO

IF OBJECT_ID ('dbo.printFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.printFacturation;
GO

IF OBJECT_ID ('dbo.updateFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateFacturation;
GO