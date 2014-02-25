------------------------------------------------------------
-- Fichier     : Procedure_RelanceDecouvert
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

-- Cette procedure permet de creer une nouvelle relance de decouvert

CREATE PROCEDURE dbo.createRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date,
	@niveau 						tinyint
AS
	INSERT INTO RelanceDecouvert(
		date,
		nom_compteabonne,
		prenom_compteabonne,
		date_naissance_compteabonne,
		niveau 
	)
	VALUES (
		DEFAULT,
		@nom_compteabonne,
		@prenom_compteabonne,
		@date_naissance_compteabonne,
		@niveau
	);
	
GO

-- Cette procedure permet d'incrémenter le niveau d'une relance de decouvert

CREATE PROCEDURE dbo.updateNiveauRelanceDecouvert
	@id		int
AS
	UPDATE RelanceDecouvert
	SET niveau = niveau+1, date = GETDATE()
	WHERE id = @id;

GO

-- Cette procedure permet de supprimer une relance de decouvert

CREATE PROCEDURE dbo.deleteRelanceDecouvert
	@id		int
AS
	DELETE FROM RelanceDecouvert
	WHERE id = @id;
GO