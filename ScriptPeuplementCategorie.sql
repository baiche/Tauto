USE TAuto_IBDR


-----------------------------------------------------------
-- Fichier     : ScriptpeuplementCategorie.sql
-- Date        : 18/02/2014
-- Auteur      : Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script de remplissage de la table Categorie
--
------------------------------------------------------------

GO

INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('4x4','description de la catégorie 4x4','B'),
		('Pique-up','description d''un pique-up','B'),
		('Camion','Transport de marchandise','C'),
		('Bus','Transport de personne > 9 places ','E'),
		('Vehicule simple','tout type de véhicule simple a 4 roues','B')	
GO