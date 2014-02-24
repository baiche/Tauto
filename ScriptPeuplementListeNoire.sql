------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables :
--				-Liste Noire
------------------------------------------------------------

USE TAuto_IBDR

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