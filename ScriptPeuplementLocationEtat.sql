------------------------------------------------------------
-- Fichier     : ScriptPeuplementLocation
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Remplissage de la table Location
------------------------------------------------------------

USE TAuto_IBDR

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
--INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation)
--VALUES('0775896wx',1,'20140107 10:00:00','20140107 12:00:00',1),--1
--('0775896we',2,'20140208 10:00:00','20140210 12:00:00',2),--2
--('0775896wr',3,'20130327 10:00:00','20130308 10:00:00',3),--3
--('0775896wt',4,'20140213 10:00:00','20140309 09:53:22',4),--4
--('0775896wy',5,'20140304 10:00:00','20140310 12:53:20',5),--5
--('0775896wi',6,'20121228 10:00:00','20130110 12:00:00',6);--6

UPDATE Location
    SET date_etat_avant = CASE id
        WHEN 1 THEN '20140107 10:00:00'
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

--Une location en cours

--INSERT INTO Abonnement(date_debut,duree,renouvellement_auto,nom_typeabonnement,nom_compteabonne,
--					   prenom_compteabonne,date_naissance_compteabonne) VALUES
--('2014-02-01','60','false','5vehicules','Ouir', 'Seyyid', '1986-05-25');

--INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
--('2014-02-23','2014-03-23',NULL,NULL,1);

--INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation) VALUES
--('0775896wx',NULL,NULL,NULL,1);

--INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
--('2014-02-23',18000,'true','false','TheFicheId');

--UPDATE Location
--SET date_etat_avant='2014-02-23'
--WHERE id=1


--Une location en retard
