------------------------------------------------------------
-- Fichier     : Procedure_disableTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Désactive un TypeAbonnement. Renvoie 1 en cas de succès, erreur autrement.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.disableTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableTypeAbonnement

GO
CREATE PROCEDURE dbo.disableTypeAbonnement
	@nom 							nvarchar(50)
AS
	UPDATE TypeAbonnement
	SET a_supprimer = 'true'
	WHERE nom = @nom;

	RETURN 1;
GO
			
			