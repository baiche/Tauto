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
	('0000000001', DEFAULT, DEFAULT),
	('0000000002', DEFAULT, DEFAULT),
	('0000000003', DEFAULT, DEFAULT),
	('0000000004', DEFAULT, DEFAULT)
GO
