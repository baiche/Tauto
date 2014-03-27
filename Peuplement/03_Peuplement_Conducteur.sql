------------------------------------------------------------
-- Fichier     : 09_Peuplement_Conducteur.sql
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Conducteur
--               avec 4 entrées
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES 
	('123456789', 'Francais', 'de Finance', 'Boris', '0000000001'),
	('987654321', 'Francais', 'le Coco', 'David', '0000000002'),
	('100000001', 'Anglais', 'Amitousa', 'Jean Luc', '0000000003'),
	('200000002', 'Francais', 'Marshall', 'Michel', '0000000004'),
	('330000033', 'Francais', 'Ouir', 'Seyyid', NULL)
GO
