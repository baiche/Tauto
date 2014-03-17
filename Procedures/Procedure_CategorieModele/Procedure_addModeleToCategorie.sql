------------------------------------------------------------
-- Fichier     : Procedure_addModeleToCategorie
-- Date        : 04/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addModeleToCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addModeleToCategorie
GO

-- Cette procedure permet d'ajouter un modele a une categorie

CREATE PROCEDURE dbo.addModeleToCategorie
	@marque_modele 				nvarchar(50),
	@serie_modele					nvarchar(50),
	@type_carburant_modele 		nvarchar(50),
	@portieres_modele			tinyint,
	@nom_categorie				nvarchar(50)
	
AS
	INSERT INTO CategorieModele(
		marque_modele,
		serie_modele,
		type_carburant_modele,
		portieres_modele,
		nom_categorie
	)
	VALUES (
		@marque_modele,
		@serie_modele,
		@type_carburant_modele,
		@portieres_modele,
		@nom_categorie
	);
	
GO

