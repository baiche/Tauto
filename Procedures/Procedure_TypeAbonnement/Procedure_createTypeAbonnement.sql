------------------------------------------------------------
-- Fichier     : Procedure_createTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createTypeAbonnement
GO

-- Insertion d'un nouveu type d'abonnement

CREATE PROCEDURE dbo.createTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int
AS
	INSERT INTO TypeAbonnement(
		nom, 
		prix, 
		nb_max_vehicules
	)
	VALUES (
		@nom,
		@prix,
		@nb_max_vehicules
	);
GO
