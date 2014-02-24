------------------------------------------------------------
-- Fichier     : Peuplement_Conducteur
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage de la table Conducteur
--               avec 4 entr�es
------------------------------------------------------------

USE TAuto_IBDR;
GO

PRINT '> Ajout des conducteurs '
INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES 
	('123456789', 'Fran�aise', 'de Finance', 'Boris', '0000000001'),
	('987654321', 'Fran�aise', 'le Coco', 'David', '0000000002'),
	('100000001', 'Anglaise', 'Amitoussa', 'Jean Luc', '0000000003'),
	('200000002', 'Fran�aise', 'Marshall', 'Michel', '0000000004')
GO

-- 4