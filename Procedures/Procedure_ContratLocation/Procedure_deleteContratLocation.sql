------------------------------------------------------------
-- Fichier     : Procedure_deleteContratLocation
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
CREATE PROCEDURE dbo.deleteContratLocation
	@id						int
AS
	DELETE FROM ContratLocation
	WHERE id = @id;
GO