------------------------------------------------------------
-- Fichier     : Procedure_canDeleteAbonnement
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : modifier le type d'abonnement d'un abonnement, returne 1 ou erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateTypeAbonnementForAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateTypeAbonnementForAbonnement
GO


CREATE PROCEDURE dbo.updateTypeAbonnementForAbonnement
	@id 							int,
	@nom_typeabonnement 				nvarchar(50)
AS
		UPDATE Abonnement
		SET nom_typeabonnement = @nom_typeabonnement
		WHERE id = @id;

	RETURN 1;
GO
