------------------------------------------------------------
-- Fichier     : Procedure_updateAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateAbonnement
GO

CREATE PROCEDURE dbo.updateAbonnement
AS
GO