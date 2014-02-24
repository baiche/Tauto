------------------------------------------------------------
-- Fichier     : Procedure_TypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

-- Insertion d'un nouveu type d'abonnement

CREATE PROCEDURE TAuto.createTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int
AS
	INSERT INTO TypeAbonnement(
		nom, 
		prix, 
		nb_max_vehicules,
		actif
	)
	VALUES (
		@nom,
		@prix,
		@nb_max_vehicules,
		DEFAULT
	);
GO

-- Update le prix et le nombre max de véhicules

CREATE PROCEDURE TAuto.updateTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int
AS
	UPDATE TypeAbonnement
	SET prix = @prix, nb_max_vehicules = @nb_max_vehicules
	WHERE nom = @nom;	
GO

-- Désactive le type d'abonnement (pas de supression)

CREATE PROCEDURE TAuto.deleteTypeAbonnement
	@nom					nvarchar(50),
AS
	UPDATE TypeAbonnement
	SET actif = 'false'
	WHERE nom = @nom;	
GO