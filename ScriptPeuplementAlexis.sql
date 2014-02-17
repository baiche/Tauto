------------------------------------------------------------
-- Fichier     : ScriptPeuplementAlexis
-- Date        : 17/02/2014
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Remplissage des tables TypePermis, Permis,
-- SousPermis, Conducteur
------------------------------------------------------------

USE IBDR;
GO

PRINT '> Ajout des types de permis '
INSERT INTO TypePermis(nom) VALUES 
	('A1'),
	('A2'),
	('B'),
	('C'),
	('D'),
	('E'),
	('F')
GO

PRINT '> Ajout des sous permis '
INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES 
	('B', '0000000001', '2001-01-01', DEFAULT, 0),
	('D', '0000000001', '2001-01-02', DEFAULT, 0),
	('A1', '0000000001', '2001-01-03', DEFAULT, 0),
	('A2', '0000000002', '2002-02-01', DEFAULT, 0),
	('B', '0000000002', '2002-02-02', DEFAULT, 0),
	('D', '0000000002', '2002-02-03', DEFAULT, 0)
GO

PRINT '> Ajout des permis '
INSERT INTO Permis(numero, valide, points_estime) VALUES 
	('0000000001', 'true', 5),
	('0000000002', 'true', DEFAULT)
GO

PRINT '> Ajout des conducteurs '
INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES 
	('123456789', 'Française', 'de Finance', 'Boris', '0000000001'),
	('987654321', 'Française', 'le Coco', 'David', '0000000002')
GO
