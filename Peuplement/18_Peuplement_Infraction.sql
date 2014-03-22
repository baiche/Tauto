------------------------------------------------------------
-- Fichier     : 24_Peuplement_Infraction.sql
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