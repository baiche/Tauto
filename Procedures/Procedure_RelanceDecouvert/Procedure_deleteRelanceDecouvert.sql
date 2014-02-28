------------------------------------------------------------
-- Fichier     : Procedure_deleteRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO

-- Cette procedure permet de supprimer une relance de decouvert

CREATE PROCEDURE dbo.deleteRelanceDecouvert
	@id		int
AS
	DELETE FROM RelanceDecouvert
	WHERE id = @id;
GO