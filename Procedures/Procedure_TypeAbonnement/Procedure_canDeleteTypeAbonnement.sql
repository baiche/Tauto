------------------------------------------------------------
-- Fichier     : Procedure_canDeleteAbonnement
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique si un type abonnement peut être supprimé.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.canDeleteTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.canDeleteTypeAbonnement
GO


CREATE PROCEDURE dbo.canDeleteTypeAbonnement
	@nom_type_abonnement	varchar(50)
AS
	BEGIN TRY
		RETURN SELECT a_supprimer FROM TypeAbonnement
		WHERE nom = @nom_type_abonnement
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.canDeleteTypeAbonnement',10,1)
	END CATCH
GO