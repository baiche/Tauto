------------------------------------------------------------
-- Fichier     : Procedure_disableAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Désactive un abonnement. Renvoie 1 en cas de succès, erreur autrement.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.disableAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableAbonnement

GO
CREATE PROCEDURE dbo.disableAbonnement
	@id 							int
AS
	UPDATE Abonnement
	SET a_supprimer = 'true'
	WHERE id = @id;

	RETURN 1;
GO
			