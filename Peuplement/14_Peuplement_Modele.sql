USE TAuto_IBDR;

-----------------------------------------------------------
-- Fichier     : ScriptPeuplementModel.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script de remplissage de la table Modele
--
------------------------------------------------------------

-- peugeot 206
PRINT('Remplissage de la table Modele');
PRINT('==============================');

PRINT('
Ajout des Peugeot 206');
GO
INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3),
		('Peugeot','206','Diesel',2003,45,0,5),
		('Peugeot','206','Essence',2003,39,0,3),
		('Peugeot','206','Essence',2003,45,0,5)
GO
		
-- peugeot 207
PRINT('
Ajout des Peugeot 207');
GO
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','207','Diesel',2010,50,0,5),
		('Peugeot','207','Essence',2013,50,0,5)
GO

-- peugeot 307
PRINT('
Ajout des Peugeot 307');
GO
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','307','Diesel',2010,50,0,5),
		('Peugeot','307','Essence',2013,50,0,5)
GO

-- peugeot 406
PRINT('
Ajout des Peugeot 406');
GO
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','406','Diesel',2004,45,0,5),
		('Peugeot','406','Essence',2006,45,0,5)
GO


-- peugeot 607
PRINT('
Ajout des Peugeot 607');
GO
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','607','Diesel',2013,55,0,5),
		('Peugeot','607','Essence',2012,55,0,5)
GO


-- BMW Serie 5 F10
PRINT('
Ajout des BMW M5');
GO
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('BMW','5 F10 M5','Diesel',2013,65,0,5),
		('BMW','5 F10 M5','Essence',2012,65,0,5)
GO


-- Camions

GO
PRINT('
Ajout des Camions ');
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Man','TGS','Diesel',2013,265,0,2),
		('Man','TGS','Essence',2013,265,0,2),
		('Toyota','DYNA 6-105 DROPSIDES','Diesel',2013,265,0,2),
		('Toyota','DYNA 6-105 DROPSIDES','Essence',2013,265,0,2),
		('Izuzu','P35.Y07','Diesel',2013,265,0,2),
		('Mercedes-Benz','Actros','Diesel',2013,265,0,2),
		('Izuzu','P35.Y07','Essence',2013,265,0,2),
		('Mercedes-Benz','Actros','Essence',2013,265,0,2)	
GO

-- AutoBus
PRINT('
Ajout des Autobus');
GO

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Man','Lion''s Regio','Diesel',2013,265,0,6),
		('VanHool','AGG300','Diesel',2013,265,0,6),
		('Mercedes-Benz','CITARO','Diesel',2013,265,0,6)
GO
