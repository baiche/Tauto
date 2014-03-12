 ------------------------------------------------------------
-- Fichier     : 27_Peuplement_CatalogueCategorie.sql
-- Date        : 26/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table "CatalogueCategorie"
                 
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO CatalogueCategorie
	(nom_catalogue, nom_categorie)
VALUES
	('Flotte', 'Vehicule simple'),
	('Flotte', 'Camion'),
	
	('Haut de gamme', '4x4'),
	('Haut de gamme', 'Pic-up'),
	
	('printemps 2014', 'Vehicule simple'),
	('printemps 2014', 'Camion'),
	('printemps 2014', '4x4'),
	
	('ete 2014', 'Vehicule simple'),
	('ete 2014', 'Camion'),
	('ete 2014', '4x4'),
	('ete 2014', 'Bus'),

	('automne 2014', 'Vehicule simple'),
	('automne 2014', 'Camion'),
	('automne 2014', '4x4'),
	('automne 2014', 'Bus'),
	('automne 2014', 'Pic-up');

GO