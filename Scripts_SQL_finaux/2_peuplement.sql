------------------------------------------------------------
-- Fichier     : 2_peuplement
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script sql peuplant la base pour les tests.
-- Attention le peuplement peut contenir des erreurs dans
-- l'etat de la base. 
------------------------------------------------------------

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

SET NOCOUNT ON;

------------------------------------------------------------
-- Fichier     : 00_Peuplement_Permis.sql
-- Date        : 05/03/2014
-- Version     : 2.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage de la table TypeAbonnement
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO TypeAbonnement
	(nom, prix, nb_max_vehicules, km)
VALUES
	('or', 15, 100, DEFAULT),
	('argent', 10, 50, DEFAULT),
	('bronze', 8, 20, DEFAULT),
	('10vehicules', 5, 10, DEFAULT),
	('5vehicules', 3, 5, 800),
	('2vehicules', 2, 2, 700),
	('1vehicules', 1, 1, 500);
GO

------------------------------------------------------------
-- Fichier     : 01_Peuplement_Permis.sql
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Permis
--               avec 4 entrées
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO Permis(numero, valide, points_estimes) VALUES 
	('0000000001', DEFAULT, DEFAULT),
	('0000000002', DEFAULT, DEFAULT),
	('0000000003', DEFAULT, DEFAULT),
	('0000000004', DEFAULT, DEFAULT)
GO

------------------------------------------------------------
-- Fichier     : 02_Peuplement_SousPermis.sql
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table SousPermis
--               avec 12 entrées
------------------------------------------------------------

USE TAuto_IBDR;

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

------------------------------------------------------------
-- Fichier     : 03_Peuplement_Conducteur.sql
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Conducteur
--               avec 4 entrées
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES 
	('123456789', 'Francais', 'de Finance', 'Boris', '0000000001'),
	('987654321', 'Francais', 'le Coco', 'David', '0000000002'),
	('100000001', 'Anglais', 'Amitousa', 'Jean Luc', '0000000003'),
	('200000002', 'Francais', 'Marshall', 'Michel', '0000000004'),
	('330000033', 'Francais', 'Ouir', 'Seyyid', NULL)
GO

------------------------------------------------------------
-- Fichier     : 04_Peuplement_Particulier.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Particulier
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'true', 
 'false', 'LU2800194006447500001234567', 'jean-luc.amitousa-mankoy@hotmail.fr', '0656470693'),
('Lecoconier','David', '1990-02-02', 'true', 
 'false', 'LU2800194006447500001234567', 'david.lecoconier@gmail.com', '0605040302'),
('De Finance', 'Boris', '1990-09-08', 'true', 
 'false', 'LU2800194006447500001234567', 'boris.de.finance@gmail.com', '0601020304'),
 ('Ouir', 'Seyyid', '1986-05-25', 'true', 
 'false', 'LU2800194006447500001234567', 'seyyid.ouir@gmail.com', '0601030507'),
('Baiche', 'Mourad', '1989-04-25', 'true', 
 'false', 'LU2800194006447500001234567', 'mourad.baiche@gmail.com', '0706050403'),
('Deluze', 'Alexis', '1974-02-12', 'true', 
 'false', 'LU2800194006447500001234567', 'alexis.deluze@gmail.com', '0701020304'),
('Mottier', 'Allan', '1989-03-23', 'true', 
 'false', 'LU2800194006447500001234567', 'allan.mottier@gmail.com', '0701030507'),
('Neti', 'Mohamed', '1988-03-26', 'true', 
 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
 
 INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
 ('Amitousa Mankoy', 'Jean-Luc', '1990-07-18'),
 ('Lecoconier', 'David', '1990-02-02'),
 ('De Finance', 'Boris', '1990-09-08'),
 ('Ouir', 'Seyyid', '1986-05-25'),
 ('Baiche', 'Mourad', '1989-04-25'),
 ('Deluze', 'Alexis', '1974-02-12'),
 ('Mottier', 'Allan', '1989-03-23'),
 ('Neti', 'Mohamed', '1988-03-26');
 
 ------------------------------------------------------------
-- Fichier     : 05_Peuplement_Entreprise.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Entreprise
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('PIndustrie', 'PIndustrie', '2014-02-17', 'true', 
 'false', 'LU2800194006447512001234567', 'pindustrie@hotmail.fr', '0656470693'),
('TASociety', 'TASociety', '2014-02-24', 'true', 
 'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');

INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
('73282932014785', 'Pokemon Industrie','PIndustrie','PIndustrie','2014-02-17'),
('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');

------------------------------------------------------------
-- Fichier     : 06_Peuplement_Catalogue.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Catalogue 
------------------------------------------------------------

USE TAuto_IBDR

---------------------------------------------
--Catalogue                                 -
---------------------------------------------

INSERT INTO Catalogue(nom,date_debut,date_fin)
VALUES('printemps 2014','2014-03-20', '2014-06-20'),
('ete 2014','2014-06-21', '2014-09-22'),
('automne 2014','2014-09-23', '2014-12-20'),
('hiver 2014','2014-12-21', '2015-03-19'),
('Haut de gamme','0001-01-01', '9999-12-31'),
('Flotte','0001-01-01', '9999-12-31');

------------------------------------------------------------
-- Fichier     : 07_Peuplement_ListeNoire.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Liste Noire
------------------------------------------------------------

USE TAuto_IBDR

------------------------------------------------
--Liste Noire                                  -
------------------------------------------------

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
('1990-10-26','Baker','Maissa'),
('1990-07-05','Shu','Jing');

-----------------------------------------------------------
-- Fichier     : 08_Peuplement_Modele.sql
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
GO		

-----------------------------------------------------------
-- Fichier     : 09_Peuplement_Vehicule.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table Vehicule
--
------------------------------------------------------------

USE TAuto_IBDR


INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('0775896wx','18000','Bleu','En panne','VF3 8C4HXF 81100000','Peugeot','406',5,'Diesel','false'), 
		('0775896we','14000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','406',5,'Essence','false'),
		('0775896wr','25000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','406',5,'Diesel','false'),
		('0775896wt','35000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false'), 
		('0775896wy','30000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',3,'Essence','false'), 
		('0775896wu','60000','Bleu','Perdue','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false'), 
		('0775896wi','120000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false'),	
		-- ajouts pour la recherche : BMW Noires
		('1775896wx','18000','Noir','En panne','ABS X0988 150','BMW','5 F10 M5',5,'Diesel','false'), 
		('1775896we','14000','Noir','Disponible','ABS X0988 151','BMW','5 F10 M5',5,'Diesel','false'),
		('1775896wr','25000','Noir','Disponible','ABS X0988 152','BMW','5 F10 M5',5,'Diesel','false'),
		('1775896wt','35000','Noir','Disponible','ABS X0988 153','BMW','5 F10 M5',5,'Diesel','false'), 
		('1775896wy','30000','Noir','Disponible','ABS X0988 154','BMW','5 F10 M5',5,'Essence','false'), 
		('1775896wu','60000','Noir','Perdue','ABS X0988 155','BMW','5 F10 M5',5,'Essence','false'), 
		('1775896wi','120000','Noir','Disponible','ABS X0988 156','BMW','5 F10 M5',5,'Essence','false'),
		--ajouts pour le test de fixFacturation
		('2775896wi','120000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false');   	
GO

 ------------------------------------------------------------
-- Fichier     : 10_Peuplement_Abonnement.sql
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : 
                 
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO Abonnement
	(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES
	('2013-12-22', 15, 0, '10vehicules', 'Deluze',     'Alexis',     '1974-02-12'), -- 1
	('2013-05-01', 90, 0, 'bronze',      'TASociety',  'TASociety',  '2014-02-24'), -- 2
	('2013-10-01', 60, 0, 'or',          'PIndustrie', 'PIndustrie', '2014-02-17'), -- 3
	('2013-12-24', 30, 1, '2vehicules',  'De Finance', 'Boris',      '1990-09-08'), -- 4
	('2014-01-01', 10, 0, '5vehicules',  'Lecoconier', 'David',      '1990-02-02'), -- 5
	('2014-02-03', 60, 0, '1vehicules',  'Baiche',     'Mourad',     '1989-04-25'), -- 6
	('2014-02-19', 30, 0, '2vehicules',  'Lecoconier', 'David',      '1990-02-02'), -- 7
	('2014-02-22',  5, 0, '5vehicules',  'Neti',       'Mohamed',    '1988-03-26'), -- 8
	('2014-02-24', 50, 0, '1vehicules',  'Ouir',       'Seyyid',     '1986-05-25'), -- 9
	('2014-03-03', 40, 0, '1vehicules',  'Deluze',     'Alexis',     '1974-02-12'), -- 10
	('2014-03-07', 30, 1, '1vehicules',  'Mottier',    'Allan',      '1989-03-23'), -- 11
	('2014-03-10', 30, 1, 'or',          'PIndustrie', 'PIndustrie', '2014-02-17'), -- 12
	('2014-03-15', 30, 1, 'argent',      'TASociety',  'TASociety',  '2014-02-24'); -- 13
GO

-----------------------------------------------------------
-- Fichier     : 11_Peuplement_Categorie.sql
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

------------------------------------------------------------
-- Fichier     : 12_Peuplement_Facturation.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Facturation
------------------------------------------------------------

USE TAuto_IBDR

------------------------------------------------
--Facturation                                  -
------------------------------------------------
INSERT INTO Facturation(date_creation,date_reception,montant)--voir numero_location
VALUES('2014-01-07', '2014-01-12',175.25),--1
('2014-02-08','2014-02-12',55.25),--2
('2013-03-27','2014-03-28',15.35),--3
('2014-02-13','2014-03-12',155.29),--4
('2014-03-04','2014-03-15',175.23),--5
('2012-12-28','2013-01-14',175.24),--6
--ajout pour fixFacturation
('2014-03-21',NULL,150.00);--7

------------------------------------------------------------
-- Fichier     : 13_Peuplement_ContratLocation.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-ContratLocation
------------------------------------------------------------

USE TAuto_IBDR

------------------------------------------------
--ContratLocation
------------------------------------------------
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
('2014-01-08T00:00:00', '2014-03-06T00:00:00', '2014-03-26T00:00:00', 0, 1),--1
('2014-02-08T00:00:00', '2014-03-06T00:00:00', '2014-03-26T00:00:00', 20, 1),--2
('2014-03-07T09:00:00', '2014-04-01T19:00:00', null, 0, 2),--3
('2014-02-13T00:00:00', '2014-03-09T00:00:00', '2014-03-10T00:00:00', 3, 2),--4
('2014-03-04T00:00:00', '2014-03-10T00:00:00', null, 4, 3),--5
('2014-02-13T00:00:00', '2014-12-29T00:00:00', null, 0, 3),--6
('2014-03-10T10:00:00', '2014-03-15T10:00:00', null, 0, 10),--7
('2014-03-16T10:00:00', '2014-03-25T10:00:00', null, 0, 13),--8
--ajout pour fixFacturation
('2014-03-10T10:00:00', '2014-03-20T10:00:00', '2014-03-20T10:00:00', 0, 13);--9

------------------------------------------------------------
-- Fichier     : 14_Peuplement_LocationEtat.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Location
------------------------------------------------------------

USE TAuto_IBDR

------------------------------------------------
--Etat                                         -
------------------------------------------------
INSERT INTO Etat(date_avant,km_avant,fiche_avant,date_apres,km_apres,fiche_apres)
VALUES
('20140101 10:00:00', 100, '0001','20140107 12:00:00',150,'0002' ),--1
('20140208 10:00:00',151,'0003','20140210 12:00:00',300,'0004'),--2
('2013-03-07T08:00:00',300,'0005','20130328 10:00:00',400,'0006'),--3 
('20140213 10:00:00',400,'0007','20140309 09:53:22',600,'0008'),--4
('20140304 10:00:00',610,'0009','20140310 12:53:20',678,'0010'),--5 
('20121228 10:00:00',679,'0011','20130110 12:00:00',1000,'0012'),--6

-- Test de endEtat
('2014-03-16T10:00:00', 14000, '0012', NULL, NULL, ''),--7
('2014-03-16T10:00:00', 120000, '0013', NULL, NULL, ''),--8 
('2014-03-16T10:00:00', 30000, '0014', NULL, NULL, ''),--9
('2014-03-16T10:00:00', 25000, '0015', NULL, NULL, ''),--10
('2014-03-16T10:00:00', 35000, '0016', NULL, NULL, '');--11

------------------------------------------------
--Location                                     -
------------------------------------------------
INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation)
VALUES('0775896wx',1,1,1),--1
('0775896we',2,2,2),--2
('0775896wr',3,3,3),--3
('0775896wt',4,4,4),--4
('0775896wy',5,5,5),--5
('0775896wi',6,6,6),--6

-- Test de makeEtat ?et makeFacturation?
('0775896we', NULL, NULL, 7),--7
('0775896wr', NULL, NULL, 7),--8
('0775896wt', NULL, NULL, 7),--9
('0775896wy', NULL, NULL, 7),--10

-- Test de endEtat
('0775896we', NULL, 7, 8),--11
('0775896wi', NULL, 8, 8),--12
('0775896wy', NULL, 9, 8),--13 - incident non pénalisable
('0775896wr', NULL, 10, 8),--14 - incident pénalisable
('0775896wt', NULL, 11, 8),--15 - 100€ d'amende

--Test de fixFacturation
('2775896wi', 7, NULL, 9);--16

 ------------------------------------------------------------
-- Fichier     : 15_Peuplement_Retard.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Retard
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--Retard
------------------------------------------------

INSERT INTO Retard(date, id_location, regle, niveau)
VALUES ('20140304 00:00:00',5,0,1),--5
('20140310 00:00:00',5,1,2),--5
('20121231 00:00:00',5,0,3);--6


 ------------------------------------------------------------
-- Fichier     : 16_Peuplement_Reservation.sql
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables Reservation
                 
------------------------------------------------------------

USE TAuto_IBDR
GO

-- preparation :

DECLARE @idAbonnementTA int, @PIndustrie int, @idAbonnementBoris int, @idAbonnementAlexis int;

SELECT @idAbonnementBoris = id
FROM Abonnement
WHERE nom_compteabonne = 'De Finance'; -- renouvellement auto

SELECT @idAbonnementAlexis = id
FROM Abonnement
WHERE nom_compteabonne = 'Deluze' AND date_debut = '2014-03-03'; -- pas de renouvellement auto

SELECT @PIndustrie = id
FROM Abonnement
WHERE nom_compteabonne = 'PIndustrie' AND date_debut = '2014-03-10'; -- renouvellement auto

SELECT @idAbonnementTA = id
FROM Abonnement
WHERE nom_compteabonne = 'TASociety' AND date_debut = '2014-03-15'; -- renouvellement auto

-- peuplement :

INSERT INTO Reservation
	(date_creation, date_debut, date_fin, annule, id_abonnement)
VALUES
	('2013-05-01', '2013-05-02T08:00:00', '2013-05-31T18:00:00', 1, @idAbonnementTA), -- 1
	('2013-06-10', '2013-06-15T10:00:00', '2013-06-25T18:00:00', 1, @idAbonnementTA), -- 2
	('2013-06-22', '2013-07-01T09:00:00', '2013-07-15T17:00:00', 1, @idAbonnementTA), -- 3
	
	('2014-01-13', '2014-01-14T08:00:00', '2014-01-21T08:00:00', 1, @idAbonnementBoris), -- 4
	('2014-01-20', '2014-01-21T08:00:00', '2014-01-23T12:00:00', 1, @idAbonnementBoris), -- 5
	
	('2014-02-03', '2014-04-06T13:00:00', '2014-04-10T18:00:00', 0, @idAbonnementBoris), -- 6
	('2014-02-24', '2014-04-28T08:00:00', '2014-05-05T17:00:00', 0, @idAbonnementBoris), -- 7
	
	('2014-03-01', '2014-04-07T10:00:00', '2014-04-24T18:00:00', 0, @PIndustrie), -- 8
	('2014-03-06', '2014-05-06T10:00:00', '2014-05-08T18:00:00', 0, @PIndustrie), -- 9
	('2014-03-08', '2014-06-01T09:00:00', '2014-06-13T17:00:00', 1, @PIndustrie), -- 10
	('2014-03-08', '2014-07-11T09:00:00', '2014-09-22T17:00:00', 0, @PIndustrie), -- 11
	('2014-03-01', '2014-11-05T08:00:00', '2014-11-05T16:00:00', 0, @PIndustrie), -- 12
	
	--('2014-03-04', '2014-03-05T08:00:00', '2014-03-06T16:00:00', 0, @idAbonnementAlexis), -- 13
	
	('2014-03-08', '2014-12-01T09:00:00', '2014-12-22T17:00:00', 0, @PIndustrie), -- 14
	('2014-03-10', '2014-11-05T08:00:00', '2014-12-05T16:00:00', 0, @idAbonnementAlexis), -- 15
	('2014-02-24', '2014-11-28T08:00:00', '2014-12-05T17:00:00', 0, @idAbonnementBoris); -- 16
	
	-- In progress
	
------------------------------------------------------------
-- Fichier     : 17_Peuplement_Incident.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Incident
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--Incident
------------------------------------------------

INSERT INTO Incident(date, id_location, description, penalisable)
VALUES ('20140304 00:00:00',5,'crevaison',0),--5
('2014-03-10T00:00:00',5,'injure au vendeur',1),--5
('2012-12-31T00:00:00',5,'crevaison',0),--6
('2014-03-25T08:58:45', 13, 'crevaison', 0),
('2014-03-21T14:42:23', 14, 'injure', 1);

------------------------------------------------------------
-- Fichier     : 18_Peuplement_Infraction.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Infraction
------------------------------------------------------------

USE TAuto_IBDR

-------------------------------------------------
--Infraction                                    -
-------------------------------------------------
INSERT INTO Infraction(date, id_location, nom, montant, description, regle)
VALUES
('2014-01-08T00:01:00',1,'Depassement de la vitesse autorisee', 135,'Depassement de plus de 50 km/h a Paris',0),--1
('2014-02-14T00:01:00',2,'Brule un stop', 233,'Au rond point de Nanterre à 14 h 30',1),--2
('2014-02-28T00:01:00',2,'Depassement de la vitesse autorisee', 135,'Depassement de plus de 20 km/h a Marseille',0),--2
('2014-03-20T21:00:00',15,'Exces de vitesse',100,'Depassement de 40km/h de la vitesse maximale autorisee',0); -- 15


-----------------------------------------------------------
-- Fichier     : 19_Peuplement_CategorieModel.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table de jointure entre categorie et modele
--
------------------------------------------------------------

USE TAuto_IBDR;

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

------------------------------------------------------------
-- Fichier     : 20_Peuplement_RelanceDecouvert.sql
-- Date        : 26/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-RelanceDecouvert
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--RelanceDecouvert
------------------------------------------------

INSERT INTO RelanceDecouvert(date, nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne,niveau)
VALUES ('20140226 10:00:00','PIndustrie','PIndustrie','2014-02-17',2),
('20140226 11:00:00','Lecoconier', 'David', '1990-02-02',1),
('20140226 12:00:00','De Finance', 'Boris', '1990-09-08',0);

 ------------------------------------------------------------
-- Fichier     : 21_Peuplement_CatalogueCategorie.sql
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

-----------------------------------------------------------
-- Fichier     : 22_Peuplement_CompteAbonneConducteur.sql
-- Date        : 26/02/2014
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table de jointure entre conducteur et compteAbonne (particulier et entreprise).
--
------------------------------------------------------------

USE TAuto_IBDR;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('PIndustrie', 'PIndustrie', '2014-02-17', 'Francais', '200000002'),
	('TASociety', 'TASociety', '2014-02-24', 'Francais', '123456789'),
	('TASociety', 'TASociety', '2014-02-24', 'Francais', '987654321'),
	('TASociety', 'TASociety', '2014-02-24', 'Anglais', '100000001')
;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'Anglais', '100000001'),
	('Lecoconier', 'David', '1990-02-02', 'Francais', '987654321'),
	('De Finance', 'Boris', '1990-09-08', 'Francais', '123456789'),
	('Ouir', 'Seyyid', '1986-05-25', 'Francais', '200000002'),
	('Baiche', 'Mourad', '1989-04-25', 'Francais', '200000002'),
	('Deluze', 'Alexis', '1974-02-12', 'Francais', '987654321'),
	('Deluze', 'Alexis', '1974-02-12', 'Francais', '123456789'),
	('Mottier', 'Allan', '1989-03-23', 'Anglais', '100000001');

GO

 ------------------------------------------------------------
-- Fichier     : 23_Peuplement_ConducteurLocation.sql
-- Date        : 26/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table "ConducteurLocation"
                 
------------------------------------------------------------

USE TAuto_IBDR;

GO
INSERT INTO ConducteurLocation
	(id_location, piece_identite_conducteur, nationalite_conducteur)
VALUES
	(1, '987654321', 'Francais'),
	(2, '987654321', 'Francais'),
	(3, '100000001', 'Anglais'),
	(4, '200000002', 'Francais'),
	(5, '987654321', 'Francais'),
	(6, '123456789', 'Francais');
GO

 ------------------------------------------------------------
-- Fichier     : 24_Peuplement_ReservationVehicule.sql
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance, Seyyid Ouir
-- Commentaire : Liaison des reservations aux vehicules 
-- concernés
                 
------------------------------------------------------------

USE TAuto_IBDR;
GO

DECLARE @idReservation int;

-- reservations annulees -----------------------------------
/*
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2013-05-02T08:00:00' AND date_fin = '2013-05-31T18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wi'), -- '206',5,'Diesel'
	(@idReservation, '0775896wu'), -- '206',5,'Diesel'
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2013-06-15T10:00:00' AND date_fin = '2013-06-25T18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2013-07-01T09:00:00' AND date_fin = '2013-07-15T17:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-01-14T08:00:00' AND date_fin = '2014-01-21T08:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wu'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-01-21T08:00:00' AND date_fin = '2014-01-23T12:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
	
*/
--------------------

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-04-06T13:00:00' AND date_fin = '2014-04-10T18:00:00'; -- 6

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'), -- '206',5,'Diesel'
	(@idReservation, '0775896wi'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-04-28T08:00:00' AND date_fin = '2014-05-05T17:00:00'; -- 7

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'); -- '406',5,'Essence'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-04-07T10:00:00' AND date_fin = '2014-04-24T18:00:00'; -- 8

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'), -- '406',5,'Essence'
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-05-06T10:00:00' AND date_fin = '2014-05-08T18:00:00'; -- 9

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-06-01T09:00:00' AND date_fin = '2014-06-13T17:00:00'; -- 10, annulee

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-07-11T09:00:00' AND date_fin = '2014-09-22T17:00:00'; -- 11

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wi'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-11-05T08:00:00' AND date_fin = '2014-11-05T16:00:00'; -- 12

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'

/*	
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-03-05T08:00:00' AND date_fin = '2014-03-06T16:00:00'; -- 13

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'
*/
	
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-12-01T09:00:00' AND date_fin = '2014-12-22T17:00:00'; -- 14

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'

	
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-11-05T08:00:00' AND date_fin = '2014-12-05T16:00:00'; -- 15

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'

	
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-11-28T08:00:00' AND date_fin = '2014-12-05T17:00:00'; -- 16

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'); -- '406',5,'Essence'












