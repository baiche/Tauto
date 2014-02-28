------------------------------------------------------------
-- Fichier     : Procedure_updateTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

-- Update le prix et le nombre max de véhicules

CREATE PROCEDURE dbo.updateTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int
AS
	UPDATE TypeAbonnement
	SET prix = @prix, nb_max_vehicules = @nb_max_vehicules
	WHERE nom = @nom;	
GO