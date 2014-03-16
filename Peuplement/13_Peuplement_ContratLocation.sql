------------------------------------------------------------
-- Fichier     : 19_Peuplement_ContratLocation.sql
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
('20140108 00:00:00', '20140306 00:00:00', '20140326 00:00:00', 0, 1),--1
('20140208 00:00:00', '20140306 00:00:00', '20140326 00:00:00', 20, 1),--2
('2014-03-07T09:00:00', '2014-04-01T19:00:00', null, 0, 2),--3
('20140213 00:00:00', '20140309 00:00:00', '20140310 00:00:00', 3, 2),--4
('20140304 00:00:00', '20140310 00:00:00', null, 4, 3),--5
('20140213 00:00:00', '20141229 00:00:00', null, 0, 3);--6
