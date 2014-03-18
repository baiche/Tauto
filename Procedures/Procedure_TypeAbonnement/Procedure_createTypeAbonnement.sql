------------------------------------------------------------
-- Fichier     : Procedure_createTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un typeAbonnement et renvoie 1 en cas de succès, ou une erreur autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createTypeAbonnement
GO

CREATE PROCEDURE dbo.createTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int,
	@km						int
AS
	INSERT INTO TypeAbonnement(
		nom, 
		prix, 
		nb_max_vehicules,
		km
	)
	VALUES (
		@nom,
		@prix,
		@nb_max_vehicules,
		@km
	);
	RETURN 1;
GO
