------------------------------------------------------------
-- Fichier     : ScriptPeuplementAlexis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage de la table SousPermis
--               avec 12 entrées
------------------------------------------------------------

USE TAuto_IBDR;
GO

PRINT '> Ajout des sous permis '
INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES 
	('B', '0000000001', '2001-01-01', DEFAULT, 0),
	('D', '0000000001', '2001-01-02', DEFAULT, 0),
	('A1', '0000000001', '2001-01-03', DEFAULT, 0),
	('A2', '0000000002', '2002-02-01', DEFAULT, 0),
	('B', '0000000002', '2002-02-02', DEFAULT, 0),
	('D', '0000000002', '2002-02-03', DEFAULT, 0),
	('D', '0000000003', '2001-01-11', DEFAULT, 0),
	('A2', '0000000003', '2001-01-12', DEFAULT, 0),
	('B', '0000000003', '2001-01-13', DEFAULT, 0),
	('D', '0000000004', '2002-02-11', DEFAULT, 0),
	('E', '0000000004', '2002-02-12', DEFAULT, 0),
	('F', '0000000004', '2002-02-13', DEFAULT, 0)
GO

-- 2