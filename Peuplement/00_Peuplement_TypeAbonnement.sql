------------------------------------------------------------
-- Fichier     : 00_Peuplement_Permis.sql
-- Date        : 05/03/2014
-- Version     : 2.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage de la table TypeAbonnement
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO TypeAbonnement
	(nom, prix, nb_max_vehicules, km)
VALUES
	('or', 15, 100, DEFAULT),
	('argent', 10, 50, DEFAULT),
	('bronze', 8, 20, DEFAULT),
	('10vehicules', 5, 10, DEFAULT),
	('5vehicules', 3, 5, 800),
	('2vehicules', 2, 2, 700),
	('1vehicules', 1, 1, 500);
