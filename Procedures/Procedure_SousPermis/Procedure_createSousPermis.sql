------------------------------------------------------------
-- Fichier     : Procedure_createSousPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Insertion d'un nouveu sous permis
------------------------------------------------------------

USE TAuto_IBDR
GO


IF OBJECT_ID ('dbo.createSousPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createSousPermis
GO

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
		periode_probatoire
		--actif
	)
	VALUES (
		@nom_typepermis,
		@numero_permis,
		@date_obtention,
		@date_expiration,
		@periode_probatoire
		--DEFAULT
	);
GO
