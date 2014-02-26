USE TAuto_IBDR;

-----------------------------------------------------------
-- Fichier     : ScriptPeuplementCategorieModele.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script de remplissage de la table de jointure entre categorie et modele
--
------------------------------------------------------------


-- Ajout des modele pour la categorie Vehicule simple
GO
INSERT INTO CategorieModele(marque_modele,serie_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Essence',5,'Vehicule Simple'),
		('Peugeot','206','Essence',3,'Vehicule Simple'),
		('Peugeot','206','Diesel',5,'Vehicule Simple'),
		('Peugeot','206','Diesel',3,'Vehicule Simple'),
		('Peugeot','207','Essence',5,'Vehicule Simple'),
		('Peugeot','207','Diesel',3,'Vehicule Simple'),
		('Peugeot','307','Diesel',5,'Vehicule Simple'),
		('Peugeot','307','Essence',5,'Vehicule Simple'),
		('Peugeot','406','Diesel',5,'Vehicule Simple'),
		('Peugeot','406','Essence',5,'Vehicule Simple'),
		('Peugeot','607','Diesel',5,'Vehicule Simple'),
		('Peugeot','607','Essence',5,'Vehicule Simple'),
		('BMW','5 F10 M5','Diesel',5,'Vehicule Simple'),
		('BMW','5 F10 M5','Essence',5,'Vehicule Simple')
GO


-- Ajout des modele pour la categorie Camion
GO
INSERT INTO CategorieModele(marque_modele,serie_modele,portieres_modele,nom_categorie) VALUES
		('Man','TGS','Essence',2,'Camion'),
		('Man','TGS','Diesel',2,'Camion'),
		('Toyota','DYNA 6-105 DROPSIDES','Essence',2,'Camion'),
		('Toyota','DYNA 6-105 DROPSIDES','Diesel',2,'Camion'),
		('Izuzu','P35.Y07','Essence',2,'Camion'),
		('Izuzu','P35.Y07','Diesel',2,'Camion'),
		('Mercedes-Benz','Actros','Essence',2,'Camion'),
		('Mercedes-Benz','Actros','Diesel',2,'Camion')
GO


-- Ajout des modele pour la categorie Bus
GO
INSERT INTO CategorieModele(marque_modele,serie_modele,portieres_modele,nom_categorie) VALUES
		('Man','Lion''s Regio','Diesel',6,'Bus'),
		('VanHool','AGG300','Diesel',6,'Bus'),
		('Mercedes-Benz','CITARO','Diesel',4,'Bus')
GO

