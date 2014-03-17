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

INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('4x4','description de la catégorie 4x4','B','false'),
		('Pic-up','description d''un pic-up','B','false'),
		('Camion','Transport de marchandise','C','false'),
		('Bus','Transport de personne supérieur à 9 places ','E','false'),
		('Vehicule simple','tout type de véhicule simple a 4 roues','B','false');
GO