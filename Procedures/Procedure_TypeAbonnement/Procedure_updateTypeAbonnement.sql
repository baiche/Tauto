------------------------------------------------------------
-- Fichier     : Procedure_updateTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un TypeAbonnement, les valeurs que l'on ne souhaite pas changer peuvent être nulle
--				 Renvoie 1 en cas de succès , erreur autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateTypeAbonnement
GO

CREATE PROCEDURE dbo.updateTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int,
	@km						int
AS
	IF ( @prix IS NOT NULL)
	BEGIN
		UPDATE TypeAbonnement
		SET prix = @prix
		WHERE nom = @nom;
	END
	
	IF ( @nb_max_vehicules IS NOT NULL)
	BEGIN
		UPDATE TypeAbonnement
		SET nb_max_vehicules = @nb_max_vehicules
		WHERE nom = @nom;
	END
	
	IF ( @km IS NOT NULL)
	BEGIN
		UPDATE TypeAbonnement
		SET km = @km
		WHERE nom = @nom;
	END
	
	RETURN 1;
GO