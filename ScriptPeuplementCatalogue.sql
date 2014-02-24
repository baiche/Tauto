------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables :
--				-Catalogue 
--				-Liste Noire
--				-Facturation
--				-Etat
--				-ContratLocation
--				-Location
------------------------------------------------------------

USE TAuto_IBDR

---------------------------------------------
--Catalogue                                 -
---------------------------------------------

INSERT INTO Catalogue(nom,date_debut,date_fin)
VALUES('printemps 2014','2014-03-20', '2014-06-20'),
('été 2014','2014-06-21', '2014-09-22'),
('automne 2014','2014-09-23', '2014-12-20'),
('hiver 2014','2014-12-21', '2015-03-19'),
('Haut de gamme','0001-01-01', '9999-12-31'),
('Flotte','0001-01-01', '9999-12-31');