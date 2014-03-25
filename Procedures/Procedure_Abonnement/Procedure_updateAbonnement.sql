------------------------------------------------------------
-- Fichier     : Procedure_updateAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Neti Mohamed
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un abonnement, les valeurs que l'on ne souhaite pas changer peuvent être nulle
--				 Renvoie 1 en cas de succès, erreur autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateAbonnement
GO

CREATE PROCEDURE dbo.updateAbonnement
	@id 							int,
	@date_debut 					date,
	@duree 							int, -- nullable
	@renouvellement_auto			bit -- nullable
AS
 	BEGIN
		UPDATE Abonnement
		SET date_debut = @date_debut
		WHERE id = @id;
	END
	
	IF ( @duree IS NOT NULL)
	BEGIN
		UPDATE Abonnement
		SET duree = @duree
		WHERE id = @id;
	END

	IF ( @renouvellement_auto IS NOT NULL)
	BEGIN
		UPDATE Abonnement
		SET renouvellement_auto = @renouvellement_auto
		WHERE id = @id;
	END

	RETURN 1;
GO
