------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables Catalogue et Liste Noire.
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
('1990-10-26','Baker','Maïssa'),
('1990-07-05','Shu','Jing');