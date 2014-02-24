 ------------------------------------------------------------
-- Fichier     : ScriptPeuplementAbonnement
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
                 
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO Abonnement
	(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES

	('2014-01-01', 10, 0, '5vehicules', 'Lecoconier', 'David', '1990-02-02'), -- id = 1
	('2014-02-19', 30, 0, '2vehicules', 'Lecoconier', 'David', '1990-02-02'), -- id = 2
	
	('2014-01-12', 50, 0, '1vehicules', 'Ouir', 'Seyyid', '1986-05-25'), -- id = 3
	
	('2013-12-24', 30, 1, '2vehicules', 'De Finance', 'Boris', '1990-09-08'), -- id = 4
	
	('2014-01-03', 60, 0, '1vehicules', 'Baiche', 'Mourad', '1989-04-25'), -- id = 5
	
	('2014-02-07', 30, 1, '1vehicules', 'Mottier', 'Allan', '1989-03-23'), -- id = 6
	
	('2014-12-22', 15, 0, '10vehicules', 'Deluze', 'Alexis', '1974-02-12'), -- id = 7
	('2013-01-12', 22, 0, '1vehicules', 'Deluze', 'Alexis', '1974-02-12'), -- id = 8
	
	('2014-02-22', 5, 0, '5vehicules', 'Neti', 'Mohamed', '1988-03-25'), -- id = 9
	
	('2013-11-01', 30, 0, 'or', 'PIndustrie', 'PIndustrie', '1980-02-17'), -- id = 10
	('2014-02-01', 60, 0, 'or', 'PIndustrie', 'PIndustrie', '1980-02-17'), -- id = 11
	
	('2013-05-01', 90, 0, 'bronze', 'TASociety', 'TASociety', '1980-02-24'), -- id = 12
	('2014-02-15', 30, 1, 'argent', 'TASociety', 'TASociety', '1980-02-24'); -- id = 13

