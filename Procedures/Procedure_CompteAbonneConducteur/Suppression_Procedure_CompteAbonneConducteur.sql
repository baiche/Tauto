------------------------------------------------------------
-- Fichier     : Suppression_Procedure_CompteAbonneConducteur
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les liaison 
--				entre compte abonne et conducteur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addConducteurToCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addConducteurToCompteAbonne
GO

IF OBJECT_ID ('dbo.removeConducteurFromCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromCompteAbonne
GO

