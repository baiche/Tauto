------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables :
--				-ContratLocation
------------------------------------------------------------

USE TAuto_IBDR

------------------------------------------------
--ContratLocation
------------------------------------------------
INSERT INTO ContratLocation(id,date_debut,date_fin,date_fin_effective,extension,id_abonnement)
VALUES(null,'2014-01-08','2014-03-06','2014-03-26','2014-03-26',0,'a voir'),--1
(null,'2014-02-08','2014-03-06','2014-03-26','2014-03-26',20,'a voir'),--2
(null,'2014-03-27','2014-03-08','2014-03-09','2014-03-09',0,'a voir'),--3
(null,'2014-02-13','2014-03-09','2014-03-10','2014-03-10',3,'a voir'),--4
(null,'2014-03-04','2014-03-10','2014-03-12','2014-03-10',4,'a voir'),--5
(null,'2014-02-13','2012-12-29','2013-01-10','2013-01-10',0,'a voir');--6



