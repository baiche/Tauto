------------------------------------------------------------
-- Fichier     : Procedure_deleteModeleFromCategorie
-- Date        : 04/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteModeleFromCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteModeleFromCategorie
GO

-- Cette procedure permet d'ajouter un modele a une categorie

CREATE PROCEDURE dbo.deleteModeleFromCategorie
	@marque_modele 				nvarchar(50),
	@serie_modele					nvarchar(50),
	@type_carburant_modele 		nvarchar(50),
	@portieres_modele			tinyint,
	@nom_categorie				nvarchar(50)
	
AS
	DELETE FROM CategorieModele
	WHERE 
		marque_modele=@marque_modele AND
		serie_modele=@serie_modele AND
		type_carburant_modele = @type_carburant_modele AND
		portieres_modele= @portieres_modele AND
		nom_categorie= @nom_categorie;
	
GO
