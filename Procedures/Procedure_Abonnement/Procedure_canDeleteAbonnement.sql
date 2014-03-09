------------------------------------------------------------
-- Fichier     : Procedure_canDeleteAbonnement
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Affiche la facture d'un contrat_location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.canDeleteAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.canDeleteAbonnement
GO


CREATE PROCEDURE dbo.canDeleteAbonnement
	@id_contrat_location	int
AS