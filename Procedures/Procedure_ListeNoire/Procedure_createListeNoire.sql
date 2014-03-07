------------------------------------------------------------
-- Fichier     : Procedure_createListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createListeNoire', 'P') IS NOT NULL
DROP PROCEDURE dbo.createListeNoire;
GO

CREATE PROCEDURE dbo.createListeNoire
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
