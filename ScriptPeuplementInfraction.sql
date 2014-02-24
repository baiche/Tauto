------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables :
--				-Infraction
------------------------------------------------------------

USE TAuto_IBDR

-------------------------------------------------
--Infraction                                    -
-------------------------------------------------
INSERT INTO Infraction(date, id_location, nom, montant, description, regle)
VALUES('2014-01-08',1,'Dépassement de la vitesse autorisée', '€135','Dépassement de plus de 50 km/h a Paris',0),--1
('2014-02-14',2,'Brule un stop', '€233','Au rond point de Nanterre à 14 h 30',1),--2
('2014-02-28',2,'Dépassement de la vitesse autorisée', '€135','Dépassement de plus de 20 km/h a Marseille',0);--2
