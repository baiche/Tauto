------------------------------------------------------------
-- Fichier     : Procedure_updateNiveauRelanceDecouvert
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

-- Cette procedure permet d'incrémenter le niveau d'une relance de decouvert

CREATE PROCEDURE dbo.updateNiveauRelanceDecouvert
	@id		int
AS
	UPDATE RelanceDecouvert
	SET niveau = niveau+1, date = GETDATE()
	WHERE id = @id;

GO