------------------------------------------------------------
-- Fichier     : 00_Peuplement_Permis.sql
-- Date        : 05/03/2014
-- Version     : 2.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage de la table TypeAboonement
------------------------------------------------------------

INSERT INTO TypeAbonnement
	(nom, prix, nb_max_vehicules)
VALUES
	('or', 15, 100),
	('argent', 10, 50),
	('bronze', 8, 20),
	('10vehicules', 5, 10),
	('5vehicules', 3, 5),
	('2vehicules', 2, 2),
	('1vehicules', 1, 1);
