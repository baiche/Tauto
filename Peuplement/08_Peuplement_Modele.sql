-----------------------------------------------------------
-- Fichier     : 14_Peuplement_Modele.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table Modele
--
------------------------------------------------------------

USE TAuto_IBDR;

-- peugeot 206
INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','206','Diesel',2003,39,0,3,'false'),
		('Peugeot','206','Diesel',2003,45,0,5,'false'),
		('Peugeot','206','Essence',2003,39,0,3,'false'),
		('Peugeot','206','Essence',2003,45,0,5,'false');

		
-- peugeot 207
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2010,50,0,5,'false'),
		('Peugeot','207','Essence',2013,50,0,5,'false');

-- peugeot 307
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','307','Diesel',2010,50,0,5,'false'),
		('Peugeot','307','Essence',2013,50,0,5,'false');
-- peugeot 406
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false'),
		('Peugeot','406','Essence',2006,45,0,5,'false');


-- peugeot 607
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','607','Diesel',2013,55,0,5,'false'),
		('Peugeot','607','Essence',2012,55,0,5,'false');


-- BMW Serie 5 F10
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('BMW','5 F10 M5','Diesel',2013,65,0,5,'false'),
		('BMW','5 F10 M5','Essence',2012,65,0,5,'false');
		


-- Camions
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Man','TGS','Diesel',2013,265,0,2,'false'),
		('Man','TGS','Essence',2013,265,0,2,'false'),
		('Toyota','DYNA 6-105 DROPSIDES','Diesel',2013,265,0,2,'false'),
		('Toyota','DYNA 6-105 DROPSIDES','Essence',2013,265,0,2,'false'),
		('Izuzu','P35.Y07','Diesel',2013,265,0,2,'false'),
		('Mercedes-Benz','Actros','Diesel',2013,265,0,2,'false'),
		('Izuzu','P35.Y07','Essence',2013,265,0,2,'false'),
		('Mercedes-Benz','Actros','Essence',2013,265,0,2,'false');

-- AutoBus
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Man','Lion''s Regio','Diesel',2013,265,0,6,'false'),
		('VanHool','AGG300','Diesel',2013,265,0,6,'false'),
		('Mercedes-Benz','CITARO','Diesel',2013,265,0,6,'false');
