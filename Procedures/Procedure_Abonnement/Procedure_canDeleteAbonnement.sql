------------------------------------------------------------
-- Fichier     : Procedure_canDeleteAbonnement
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : I
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.canDeleteAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.canDeleteAbonnement
GO


CREATE PROCEDURE dbo.canDeleteAbonnement
	@id_contrat_location	int
AS
	BEGIN TRY
		RETURN SELECT a_supprimer FROM Abonnement
		WHERE id = @id_contrat_location
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
GO