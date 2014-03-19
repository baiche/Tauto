 ------------------------------------------------------------
-- Fichier     : 16_Peuplement_Abonnement.sql
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : 
                 
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO Abonnement
	(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES
	('2013-12-22', 15, 0, '10vehicules', 'Deluze',     'Alexis',     '1974-02-12'), -- 1
	('2013-05-01', 90, 0, 'bronze',      'TASociety',  'TASociety',  '2014-02-24'), -- 2
	('2013-10-01', 60, 0, 'or',          'PIndustrie', 'PIndustrie', '2014-02-17'), -- 3
	('2013-12-24', 30, 1, '2vehicules',  'De Finance', 'Boris',      '1990-09-08'), -- 4
	('2014-01-01', 10, 0, '5vehicules',  'Lecoconier', 'David',      '1990-02-02'), -- 5
	('2014-02-03', 60, 0, '1vehicules',  'Baiche',     'Mourad',     '1989-04-25'), -- 6
	('2014-02-19', 30, 0, '2vehicules',  'Lecoconier', 'David',      '1990-02-02'), -- 7
	('2014-02-22',  5, 0, '5vehicules',  'Neti',       'Mohamed',    '1988-03-26'), -- 8
	('2014-02-24', 50, 0, '1vehicules',  'Ouir',       'Seyyid',     '1986-05-25'), -- 9
	('2014-03-03', 40, 0, '1vehicules',  'Deluze',     'Alexis',     '1974-02-12'), -- 10
	('2014-03-07', 30, 1, '1vehicules',  'Mottier',    'Allan',      '1989-03-23'), -- 11
	('2014-03-10', 30, 1, 'or',          'PIndustrie', 'PIndustrie', '2014-02-17'), -- 12
	('2014-03-15', 30, 1, 'argent',      'TASociety',  'TASociety',  '2014-02-24'); -- 13
