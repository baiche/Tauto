-----------------------------------------------------------
-- Fichier     : 17_Peuplement_Categorie.sql
-- Date        : 18/02/2014
-- Auteur      : Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table Categorie
--
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('4x4','description de la catégorie 4x4','B'),
		('Pic-up','description d''un pic-up','B'),
		('Camion','Transport de marchandise','C'),
		('Bus','Transport de personne supérieur à 9 places ','E'),
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
GO