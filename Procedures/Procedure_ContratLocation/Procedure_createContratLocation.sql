------------------------------------------------------------
-- Fichier     : Procedure_createContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.createContratLocation
	@date_debut 			datetime,
	@date_fin 				datetime,
	@date_fin_effective 	datetime,
	@extension 				int,
	@id_abonnement 			int
AS
	INSERT INTO ContratLocation (
		date_debut,
		date_fin,
		date_fin_effective,
		extension,
		id_abonnement
	)
	VALUES (
		@date_debut,
		@date_fin,
		@date_fin_effective,
		@extension,
		@id_abonnement
	);

GO
