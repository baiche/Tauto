------------------------------------------------------------
-- Fichier     : 20_Peuplement_LocationEtat.sql
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