USE TAuto_IBDR

-----------------------------------------------------------
-- Fichier     : ScriptPeuplementCategorieModele.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script de remplissage de la table de jointre entre categorie et model
--
------------------------------------------------------------


-- Ajout des modele pour la categorie Vehicule simple
GO
INSERT CategorieModele(marque_modele,serie_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Essence',5,'Vehicule Simple'),
		('Peugeot','206','Diesel',3,'Vehicule Simple'),
		('Peugeot','207','Diesel',5,'Vehicule Simple')
GO


-- Ajout des modele pour la categorie Camion
GO
INSERT CategorieModele(marque_modele,serie_modele,portieres_modele,nom_categorie) VALUES
		('Man','TGS','Essence',2,'Camion'),
		('Toyota','DYNA 6-105 DROPSIDES','Diesel',2,'Camion'),
		('Izuzu','P35.Y07','Diesel',2,'Camion'),
		('Mercedes-Benz','Actros','Diesel',2,'Camion')
GO


-- Ajout des modele pour la categorie Bus
GO
INSERT CategorieModele(marque_modele,serie_modele,portieres_modele,nom_categorie) VALUES
		('Man','Lion''s Regio','Diesel',6,'Bus'),
		('VanHool','AGG300','Diesel',6,'Bus'),
		('Mercedes-Benz','CITARO','Diesel',4,'Bus')
GO

