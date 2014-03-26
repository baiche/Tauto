 ------------------------------------------------------------
-- Fichier     : 29_Peuplement_ConducteurLocation.sql
-- Date        : 26/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table "ConducteurLocation"
                 
------------------------------------------------------------

USE TAuto_IBDR;

GO
INSERT INTO ConducteurLocation
	(id_location, piece_identite_conducteur, nationalite_conducteur)
VALUES
	(1, '987654321', 'Francais'),
	(2, '987654321', 'Francais'),
	(3, '100000001', 'Anglais'),
	(4, '200000002', 'Francais'),
	(5, '987654321', 'Francais'),
	(6, '123456789', 'Francais');
GO