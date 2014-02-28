------------------------------------------------------------
-- Fichier     : Procedure_SousPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

-- Insertion d'un nouveu sous permis

CREATE PROCEDURE dbo.createSousPermis
	@nom_typepermis			nvarchar(50),
	@numero_permis 			nvarchar(50),
	@date_obtention 		date,
	@date_expiration		date,
	@periode_probatoire		tinyint
AS
	INSERT INTO SousPermis(
		nom_typepermis, 
		numero_permis, 
		date_obtention,
		date_expiration,
		periode_probatoire,
		actif
	)
	VALUES (
		@nom_typepermis,
		@numero_permis,
		@date_obtention,
		@date_expiration,
		@periode_probatoire,
		DEFAULT
	);
GO

-- Désactive le sous permis (pas de supression)

CREATE PROCEDURE dbo.deleteSousPermis
	@nom_typepermis			nvarchar(50),
	@numero_permis 			nvarchar(50),
AS
	UPDATE SousPermis
	SET actif = 'false'
	WHERE nom_typepermis = @nom_typepermis AND numero_permis = @numero_permis;
GO