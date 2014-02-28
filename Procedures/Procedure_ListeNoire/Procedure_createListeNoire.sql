------------------------------------------------------------
-- Fichier     : Procedure_createListeNoire
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
