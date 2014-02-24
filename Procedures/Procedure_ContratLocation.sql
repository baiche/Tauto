------------------------------------------------------------
-- Fichier     : Procedure_ContratLocation
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
CREATE PROCEDURE dbo.updateContratLocation
	@id						int,
	@date_debut 			datetime,
	@date_fin 				datetime,
	@date_fin_effective 	datetime,
	@extension 				int,
	@id_abonnement 			int
AS
	UPDATE ContratLocation
	SET
		date_debut = @date_debut,
		date_fin = @date_fin,
		date_fin_effective = @date_fin_effective,
		extension = @extension,
		id_abonnement = @id_abonnement
	WHERE id = @id;

GO
CREATE PROCEDURE dbo.deleteContratLocation
	@id						int
AS
	DELETE FROM ContratLocation
	WHERE id = @id;
GO