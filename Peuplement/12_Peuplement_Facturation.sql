------------------------------------------------------------
-- Fichier     : 18_Peuplement_Facturation.sql
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
('2012-12-28','2013-01-14',175.24);--6