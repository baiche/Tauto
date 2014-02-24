------------------------------------------------------------
-- Fichier     : Procedure_ListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE TAuto.createListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	INSERT INTO ListeNoire(
		date_naissance,
		nom,
		prenom
	)
	VALUES (
		@date_naissance,
		@nom,
		@prenom
	);

GO
CREATE PROCEDURE TAuto.updateListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	UPDATE ListeNoire
	SET date_naissance = @date_naissance
		nom = @nom,
		prenom = @prenom
	WHERE 	date_naissance = @date_naissance
			nom = @nom,
			prenom = @prenom;

GO
CREATE PROCEDURE TAuto.deleteListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	DELETE FROM ListeNoire
	WHERE 	date_naissance = @date_naissance
			nom = @nom,
			prenom = @prenom;
GO
