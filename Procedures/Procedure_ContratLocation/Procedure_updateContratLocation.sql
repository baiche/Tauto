------------------------------------------------------------
-- Fichier     : Procedure_updateContratLocation
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
		date_fin_effective = @date_fin_effective,
		extension = @extension
	WHERE id = @id;

GO