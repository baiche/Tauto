 ------------------------------------------------------------
-- Fichier     : ScriptPeuplementAbonnement
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Remplissage des tables Abonnement, TypeAbonnement
                 
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

INSERT INTO Abonnement
	(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES
	('2014-02-19', 10, false, 'argent', 'Lecoconier', 'David', '1990-02-02'),
	('2014-01-01', 30, false, '2vehicules', 'Lecoconier', 'David', '1990-02-02'),
	('2014-01-12', 50, false, '1vehicules', 'Ouir', 'Seyyid', '1986-05-25'),
	('2013-12-24', 30, true, 'or', 'De Finance', 'Boris', '1990-09-08'),
	('2014-01-03', 60, false, 'argent', 'Baiche', 'Mourad', '1989-04-25'),
	('2014-02-07', 30, true, 'or', 'Mottier', 'Allan', '1989-03-23'),
	('2014-01-12', 15, false, '10vehicules', 'Deluze', 'Alexis', '1974-02-12'),
	('2013-11-17', 22, false, 'bronze', 'Deluze', 'Alexis', '1974-02-12'),
	('2014-02-22', 5, false, '5vehicules', 'Neti', 'Mohamed', '1988-03-25');