 ------------------------------------------------------------
-- Fichier     : ScriptPeuplementTypeAbonnement
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
                 
------------------------------------------------------------

USE TAuto_IBDR

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
