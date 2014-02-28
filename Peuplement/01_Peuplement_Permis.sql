------------------------------------------------------------
-- Fichier     : 07_Peuplement_Permis.sql
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Permis
--               avec 4 entr�es
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO Permis(numero, valide, points_estimes) VALUES 
	('0000000001', 'true', 5),
	('0000000002', 'true', DEFAULT),
	('0000000003', 'true', DEFAULT),
	('0000000004', 'true', DEFAULT)
GO

-- 3