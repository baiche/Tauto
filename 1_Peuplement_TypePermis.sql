------------------------------------------------------------
-- Fichier     : ScriptPeuplementAlexis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage de la table TypePermis
--               avec 7 entrées
------------------------------------------------------------

USE TAuto_IBDR;
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

-- 1