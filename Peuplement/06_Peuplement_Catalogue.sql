------------------------------------------------------------
-- Fichier     : 12_Peuplement_Catalogue.sql
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