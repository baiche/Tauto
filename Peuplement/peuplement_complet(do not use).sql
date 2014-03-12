------------------------------------------------------------
-- Fichier     : peuplement_complet.sql
-- Date        : 28/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Ensemble du peuplement en un script
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO TypePermis(nom) VALUES 
	('A1'),
	('A2'),
	('B'),
	('C'),
	('D'),
	('E'),
	('F')
GO

INSERT INTO TypeCarburant(nom) VALUES ('Essence'), ('Diesel');

INSERT INTO TypeAbonnement
	(nom, prix, nb_max_vehicules)
VALUES
	('or', 15, 100),
	('argent', 10, 50),
	('bronze', 8, 20),
	('10vehicules', 5, 10),
	('5vehicules', 3, 5),
	('2vehicules', 2, 2),
	('1vehicules', 1, 1);

INSERT INTO Nationalite(nom) VALUES ('Francais'), ('Anglais');

INSERT INTO CouleurVehicule(nom) VALUES ('Bleu'), ('Blanc'), ('Rouge');

INSERT INTO StatutVehicule(nom) VALUES ('Disponible'), ('Louee'), ('En panne');

INSERT INTO Permis(numero, valide, points_estimes) VALUES 
	('0000000001', 'true', 5),
	('0000000002', 'true', DEFAULT),
	('0000000003', 'true', DEFAULT),
	('0000000004', 'true', DEFAULT)
GO

INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES 
	('B', '0000000001', '2001-01-01', '9999-12-31', 0),
	('D', '0000000001', '2001-01-02', '9999-12-31', 0),
	('A1', '0000000001', '2001-01-03', '9999-12-31', 0),
	('A2', '0000000002', '2002-02-01', '9999-12-31', 0),
	('B', '0000000002', '2002-02-02', '9999-12-31', 0),
	('D', '0000000002', '2002-02-03', '9999-12-31', 0),
	('D', '0000000003', '2001-01-11', '9999-12-31', 0),
	('A2', '0000000003', '2001-01-12', '9999-12-31', 0),
	('B', '0000000003', '2001-01-13', '9999-12-31', 0),
	('D', '0000000004', '2002-02-11', '9999-12-31', 0),
	('E', '0000000004', '2002-02-12', '9999-12-31', 0),
	('F', '0000000004', '2002-02-13', '9999-12-31', 0)
GO

INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES 
	('123456789', 'Francais', 'de Finance', 'Boris', '0000000001'),
	('987654321', 'Francais', 'le Coco', 'David', '0000000002'),
	('100000001', 'Anglais', 'Amitousa', 'Jean Luc', '0000000003'),
	('200000002', 'Francais', 'Marshall', 'Michel', '0000000004')
GO

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'true', 
 'false', 'LU28 0019 4006 4475 0000', 'jean-luc.amitousa-mankoy@hotmail.fr', '0656470693'),
('Lecoconier', 'David', '1990-02-02', 'true', 
 'false', 'MK072 5012 0000 0589 84', 'david.lecoconier@gmail.Com', '06050403021'),
('De Finance', 'Boris', '1990-09-08', 'true', 
 'false', 'PL60 1020 1026 0000', 'boris.de.finance@gmail.com', '060102030405'),
('Ouir', 'Seyyid', '1986-05-25', 'true', 
 'false', 'DE89 3704 0044 0532', 'seyyid.ouir@gmail.com', '0601030507'),
('Baiche', 'Mourad', '1989-04-25', 'true', 
 'false', 'GR16 0110 1250 0000 0001', 'mourad.baiche@gmail.com', '0706050403'),
('Deluze', 'Alexis', '1974-02-12', 'true', 
 'false', 'FR14 2004 1010 0505', 'alexis.deluze@gmail.com', '070102030405'),
('Mottier', 'Allan', '1989-03-23', 'true', 
 'false', 'HR12 1001 0051 863', 'allan.mottier@gmail.com', '0701030507'),
('Neti', 'Mohamed', '1988-03-25', 'true', 
 'false', 'AD12 0001 2030 2003', 'mohamed.neti@gmail.com', '0607080904');
 
 INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
 ('Amitousa Mankoy', 'Jean-Luc', '1990-07-18'),
 ('Lecoconier', 'David', '1990-02-02'),
 ('De Finance', 'Boris', '1990-09-08'),
 ('Ouir', 'Seyyid', '1986-05-25'),
 ('Baiche', 'Mourad', '1989-04-25'),
 ('Deluze', 'Alexis', '1974-02-12'),
 ('Mottier', 'Allan', '1989-03-23'),
 ('Neti', 'Mohamed', '1988-03-25');
 
 INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('PIndustrie', 'PIndustrie', '2014-02-17', 'true', 
 'false', 'AD12 0001 2030 2003 5910 0100', 'pindustrie@hotmail.fr', '0656470693'),
('TASociety', 'TASociety', '2014-02-24', 'true', 
 'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');

INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
('732 829 320', 'Pokemon Industrie','PIndustrie','PIndustrie','2014-02-17'),
('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');

INSERT INTO Catalogue(nom,date_debut,date_fin)
VALUES('printemps 2014','2014-03-20', '2014-06-20'),
('été 2014','2014-06-21', '2014-09-22'),
('automne 2014','2014-09-23', '2014-12-20'),
('hiver 2014','2014-12-21', '2015-03-19'),
('Haut de gamme','0001-01-01', '9999-12-31'),
('Flotte','0001-01-01', '9999-12-31');

INSERT INTO ListeNoire(date_naissance,nom,prenom)
VALUES('1990-09-08','de Finance de Clairbois','Boris'),
('1990-09-08','Nithoo','Ritchie'),
('1989-02-02','Lecoconnier','David'),
('1991-03-23','Mottier','Allan'),
('1991-09-08','Tran','Marie-Diana'),
('1990-09-08','Marchal','Vincent'),
('1990-02-13','Fabry','Jules'),
('1989-05-07','Knoertzer','Michel'),
('1990-09-08','Baiche','Mourad'),
('1990-04-28','Diallo','Abdoul'),
('1992-09-17','Boulila','Louiza'),
('1988-11-21','Tariqui','Ibtissam'),
('1990-10-26','Baker','Maïssa'),
('1990-07-05','Shu','Jing');

-- peugeot 206
INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3),
		('Peugeot','206','Diesel',2003,45,0,5),
		('Peugeot','206','Essence',2003,39,0,3),
		('Peugeot','206','Essence',2003,45,0,5);

		
-- peugeot 207
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','207','Diesel',2010,50,0,5),
		('Peugeot','207','Essence',2013,50,0,5);

-- peugeot 307
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','307','Diesel',2010,50,0,5),
		('Peugeot','307','Essence',2013,50,0,5);
-- peugeot 406
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','406','Diesel',2004,45,0,5),
		('Peugeot','406','Essence',2006,45,0,5);


-- peugeot 607
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','607','Diesel',2013,55,0,5),
		('Peugeot','607','Essence',2012,55,0,5);


-- BMW Serie 5 F10
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('BMW','5 F10 M5','Diesel',2013,65,0,5),
		('BMW','5 F10 M5','Essence',2012,65,0,5);


-- Camions
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Man','TGS','Diesel',2013,265,0,2),
		('Man','TGS','Essence',2013,265,0,2),
		('Toyota','DYNA 6-105 DROPSIDES','Diesel',2013,265,0,2),
		('Toyota','DYNA 6-105 DROPSIDES','Essence',2013,265,0,2),
		('Izuzu','P35.Y07','Diesel',2013,265,0,2),
		('Mercedes-Benz','Actros','Diesel',2013,265,0,2),
		('Izuzu','P35.Y07','Essence',2013,265,0,2),
		('Mercedes-Benz','Actros','Essence',2013,265,0,2);

-- AutoBus
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Man','Lion''s Regio','Diesel',2013,265,0,6),
		('VanHool','AGG300','Diesel',2013,265,0,6),
		('Mercedes-Benz','CITARO','Diesel',2013,265,0,6);

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele)VALUES
		('0775896wx','18000','Bleu','En panne','VF3 8C4HXF 81100000','Peugeot','406',5,'Diesel'), 
		('0775896we','14000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','406',5,'Essence'),
		('0775896wr','25000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','406',5,'Diesel'),
		('0775896wt','35000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel'), 
		('0775896wy','30000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',3,'Essence'), 
		('0775896wu','60000','Bleu','Perdue','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel'), 
		('0775896wi','120000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel')   		
GO

INSERT INTO Abonnement
	(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES
	('2013-01-12', 22, 0, '1vehicules',  'Deluze',     'Alexis',     '1974-02-12'), -- id = 1
	('2013-05-01', 90, 0, 'bronze',      'TASociety',  'TASociety',  '2014-02-24'), -- id = 2
	('2013-11-01', 30, 0, 'or',          'PIndustrie', 'PIndustrie', '2014-02-17'), -- id = 3
	('2013-12-24', 30, 1, '2vehicules',  'De Finance', 'Boris',      '1990-09-08'), -- id = 4
	('2014-01-01', 10, 0, '5vehicules',  'Lecoconier', 'David',      '1990-02-02'), -- id = 5
	('2014-01-03', 60, 0, '1vehicules',  'Baiche',     'Mourad',     '1989-04-25'), -- id = 6
	('2014-01-12', 50, 0, '1vehicules',  'Ouir',       'Seyyid',     '1986-05-25'), -- id = 7
	('2014-02-01', 60, 0, 'or',          'PIndustrie', 'PIndustrie', '2014-02-17'), -- id = 8
	('2014-02-07', 30, 1, '1vehicules',  'Mottier',    'Allan',      '1989-03-23'), -- id = 9
	('2014-02-15', 30, 1, 'argent',      'TASociety',  'TASociety',  '2014-02-24'), -- id = 10
	('2014-02-19', 30, 0, '2vehicules',  'Lecoconier', 'David',      '1990-02-02'), -- id = 11
	('2014-02-22',  5, 0, '5vehicules',  'Neti',       'Mohamed',    '1988-03-25'), -- id = 12
	('2014-12-22', 15, 0, '10vehicules', 'Deluze',     'Alexis',     '1974-02-12'); -- id = 13
	
INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('4x4','description de la catégorie 4x4','B'),
		('Pic-up','description d''un pic-up','B'),
		('Camion','Transport de marchandise','C'),
		('Bus','Transport de personne > 9 places ','E'),
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
GO

INSERT INTO Facturation(date_creation,date_reception,montant)--voir numero_location
VALUES('2014-01-07', '2014-01-12',175.25),--1
('2014-02-08','2014-02-12',55.25),--2
('2013-03-27','2014-03-28',15.35),--3
('2014-02-13','2014-03-12',155.29),--4
('2014-03-04','2014-03-15',175.23),--5
('2012-12-28','2013-01-14',175.24);--6	

INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)
VALUES('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,1),--1
('20140208 00:00:00','20140306 00:00:00','20140326 00:00:00',20,1),--2
('20140327 00:00:00','20140308 00:00:00','20140309 00:00:00',0,2),--3
('20140213 00:00:00','20140309 00:00:00','20140310 00:00:00',3,2),--4
('20140304 00:00:00','20140310 00:00:00','20140312 00:00:00',4,3),--5
('20140213 00:00:00','20121229 00:00:00','20130110 00:00:00',0,3);--6

------------------------------------------------
--Location                                     -
------------------------------------------------
INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation)
VALUES('0775896wx',1,NULL,NULL,1),--1
('0775896we',2,NULL,NULL,2),--2
('0775896wr',3,NULL,NULL,3),--3
('0775896wt',4,NULL,NULL,4),--4
('0775896wy',5,NULL,NULL,5),--5
('0775896wi',6,NULL,NULL,6);--6

------------------------------------------------
--Etat                                         -
------------------------------------------------
INSERT INTO Etat(date_creation,id_location,km,degat,fiche)
VALUES('20140101 10:00:00',1,100,0,'0001'),--1av
('20140107 12:00:00',1,150,0,'0002'),--1ap
('20140208 10:00:00',2,151,1,'0003'),--2av
('20140210 12:00:00',2,300,1,'0004'),--2ap
('20130327 10:00:00',3,300,0,'0005'),--3av
('20130308 10:00:00',3,400,0,'0006'),--3ap
('20140213 10:00:00',4,400,1,'0007'),--4av
('20140309 09:53:22',4,600,0,'0008'),--4ap
('20140304 10:00:00',5,610,1,'0009'),--5av
('20140310 12:53:20',5,678,0,'0010'),--5ap
('20121228 10:00:00',6,679,0,'0011'),--6av
('20130110 12:00:00',6,1000,1,'0012');--6ap

------------------------------------------------
--Location                                     -
------------------------------------------------

UPDATE Location
    SET date_etat_avant = CASE id
        WHEN 1 THEN '20140101 10:00:00'
        WHEN 2 THEN '20140208 10:00:00'
        WHEN 3 THEN '20130327 10:00:00'
        WHEN 4 THEN '20140213 10:00:00'
        WHEN 5 THEN '20140304 10:00:00'
        WHEN 6 THEN '20121228 10:00:00'
    END
WHERE id IN (1,2,3,4,5,6)


UPDATE Location
    SET date_etat_apres = CASE id
        WHEN 1 THEN '20140107 12:00:00'
        WHEN 2 THEN '20140210 12:00:00'
        WHEN 3 THEN '20130308 10:00:00'
        WHEN 4 THEN '20140309 09:53:22'
        WHEN 5 THEN '20140310 12:53:20'
        WHEN 6 THEN '20130110 12:00:00'
    END
WHERE id IN (1,2,3,4,5,6)

INSERT INTO Retard(date, id_location, regle, niveau)
VALUES ('20140304 00:00:00',5,0,1),--5
('20140310 00:00:00',5,1,2),--5
('20121231 00:00:00',5,0,3);--6

INSERT INTO Reservation
	(date_creation, date_debut, date_fin, annule, matricule_vehicule, id_abonnement)
VALUES

	-- Abonnement('2013-01-12', 22, false, '1vehicules', 'Deluze', 'Alexis', '1974-02-12'), -- id = 1
	('2013-01-13', '20130114 08:00:00', '20130121 08:00:00', 0, '0775896wu', 1),
	('2013-01-20', '20130121 08:00:00', '20130123 12:00:00', 0, '0775896wy', 1),

	-- Abonnement('2013-05-01', 90, false, 'bronze', 'TASociety', 'TASociety', '1980-02-24'); -- id = 2
	('2013-05-01', '20130502 08:00:00', '20130531 18:00:00', 0, '0775896wi', 2),
	('2013-05-01', '20130502 08:00:00', '20130531 18:00:00', 0, '0775896wu', 2),
	('2013-05-01', '20130502 08:00:00', '20130501 18:00:00', 0, '0775896wy', 2),
	
	('2013-06-10', '20130615 10:00:00', '20130625 18:00:00', 0, '0775896wt', 2),
	('2013-06-22', '20130701 09:00:00', '20130715 17:00:00', 0, '0775896wr', 2),

	-- Abonnement('2013-11-01', 30, false, 'or', 'PIndustrie', 'PIndustrie', '1980-02-17'), -- id = 3
	('2013-11-01', '20131104 10:00:00', '20131108 18:00:00', 0, '0775896wx', 3),
	('2013-11-01', '20131104 10:00:00', '20131108 18:00:00', 0, '0775896we', 3),
	
	('2013-11-01', '20131105 08:00:00', '20131105 16:00:00', 0, '0775896wr', 3),
	
	('2013-11-06', '20131106 10:00:00', '20131108 18:00:00', 0, '0775896wt', 3),
	('2013-11-08', '20131111 09:00:00', '20131122 17:00:00', 0, '0775896wx', 3),

	-- Abonnement('2013-12-24', 30, true, '2vehicules', 'De Finance', 'Boris', '1990-09-08'), -- id = 4
	('2013-12-24', '20131224 08:00:00', '20131226 17:00:00', 0, '0775896we', 4),
	('2014-01-03', '20130106 13:00:00', '20130110 18:00:00', 0, '0775896wt', 4),
	('2014-01-03', '20130106 13:00:00', '20130110 18:00:00', 0, '0775896wi', 4);
	
INSERT INTO Incident(date, id_location, description, penalisable)
VALUES ('20140304 00:00:00',5,'crevaison',0),--5
('20140310 00:00:00',5,'injure au vendeur',1),--5
('20121231 00:00:00',5,'crevaison',0);--6

INSERT INTO Infraction(date, id_location, nom, montant, description, regle)
VALUES('20140108 00:00:00',1,'Dépassement de la vitesse autorisée', 135,'Dépassement de plus de 50 km/h a Paris',0),--1
('20140214 00:00:00',2,'Brule un stop', 233,'Au rond point de Nanterre à 14 h 30',1),--2
('20140228 00:00:00',2,'Dépassement de la vitesse autorisée', 135,'Dépassement de plus de 20 km/h a Marseille',0);--2

-- Ajout des modele pour la categorie Vehicule simple
INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Diesel',3,'Vehicule Simple'),
		('Peugeot','206','Diesel',5,'Vehicule Simple'),
		('Peugeot','206','Essence',3,'Vehicule Simple'),
		('Peugeot','206','Essence',5,'Vehicule Simple'),		
		('Peugeot','207','Diesel',5,'Vehicule Simple'),
		('Peugeot','207','Essence',5,'Vehicule Simple'),
		('Peugeot','307','Diesel',5,'Vehicule Simple'),
		('Peugeot','307','Essence',5,'Vehicule Simple'),
		('Peugeot','406','Diesel',5,'Vehicule Simple'),
		('Peugeot','406','Essence',5,'Vehicule Simple'),
		('Peugeot','607','Diesel',5,'Vehicule Simple'),
		('Peugeot','607','Essence',5,'Vehicule Simple'),
		('BMW','5 F10 M5','Diesel',5,'Vehicule Simple'),
		('BMW','5 F10 M5','Essence',5,'Vehicule Simple');


-- Ajout des modele pour la categorie Camion
INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Man','TGS','Essence',2,'Camion'),
		('Man','TGS','Diesel',2,'Camion'),
		('Toyota','DYNA 6-105 DROPSIDES','Essence',2,'Camion'),
		('Toyota','DYNA 6-105 DROPSIDES','Diesel',2,'Camion'),
		('Izuzu','P35.Y07','Essence',2,'Camion'),
		('Izuzu','P35.Y07','Diesel',2,'Camion'),
		('Mercedes-Benz','Actros','Essence',2,'Camion'),
		('Mercedes-Benz','Actros','Diesel',2,'Camion');

-- Ajout des modele pour la categorie Bus
INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Man','Lion''s Regio','Diesel',6,'Bus'),
		('VanHool','AGG300','Diesel',6,'Bus'),
		('Mercedes-Benz','CITARO','Diesel',6,'Bus');

INSERT INTO RelanceDecouvert(date, nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne,niveau)
VALUES ('20140226 10:00:00','PIndustrie','PIndustrie','2014-02-17',2),
('20140226 11:00:00','Lecoconier', 'David', '1990-02-02',1),
('20140226 12:00:00','De Finance', 'Boris', '1990-09-08',0);

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
	
	('été 2014', 'Vehicule simple'),
	('été 2014', 'Camion'),
	('été 2014', '4x4'),
	('été 2014', 'Bus'),

	('automne 2014', 'Vehicule simple'),
	('automne 2014', 'Camion'),
	('automne 2014', '4x4'),
	('automne 2014', 'Bus'),
	('automne 2014', 'Pic-up');

GO

INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('PIndustrie', 'PIndustrie', '2014-02-17','200000002', 'Francais'),
	('TASociety', 'TASociety', '2014-02-24','123456789', 'Francais'),
	('TASociety', 'TASociety', '2014-02-24','987654321', 'Francais'),
	('TASociety', 'TASociety', '2014-02-24','100000001', 'Anglais')
;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', '100000001', 'Anglais'),
	('Lecoconier', 'David', '1990-02-02', '987654321', 'Francais'),
	('De Finance', 'Boris', '1990-09-08', '123456789', 'Francais'),
	('Ouir', 'Seyyid', '1986-05-25', '200000002', 'Francais'),
	('Baiche', 'Mourad', '1989-04-25', '200000002', 'Francais'),
	('Deluze', 'Alexis', '1974-02-12', '987654321', 'Francais'),
	('Mottier', 'Allan', '1989-03-23', '100000001', 'Anglais')
;
GO

INSERT INTO ConducteurLocation
	(id_location, piece_identite_conducteur, nationalite_conducteur)
VALUES
	(1, '123456789', 'Francais'),
	(1, '987654321', 'Francais'),
	(2, '987654321', 'Francais'),
	(3, '100000001', 'Anglais'),
	(4, '200000002', 'Francais'),
	(5, '987654321', 'Francais'),
	(6, '123456789', 'Francais');