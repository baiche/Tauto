-----------------------------------------------------------
-- Fichier     : 28_Peuplement_CompteAbonneConducteur.sql
-- Date        : 26/02/2014
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table de jointure entre conducteur et compteAbonne (particulier et entreprise).
--
------------------------------------------------------------

USE TAuto_IBDR;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('PIndustrie', 'PIndustrie', '2014-02-17', 'Francais', '200000002'),
	('TASociety', 'TASociety', '2014-02-24', 'Francais', '123456789'),
	('TASociety', 'TASociety', '2014-02-24', 'Francais', '987654321'),
	('TASociety', 'TASociety', '2014-02-24', 'Anglais', '100000001')
;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'Anglais', '100000001'),
	('Lecoconier', 'David', '1990-02-02', 'Francais', '987654321'),
	('De Finance', 'Boris', '1990-09-08', 'Francais', '123456789'),
	('Ouir', 'Seyyid', '1986-05-25', 'Francais', '200000002'),
	('Baiche', 'Mourad', '1989-04-25', 'Francais', '200000002'),
	('Deluze', 'Alexis', '1974-02-12', 'Francais', '987654321'),
	('Mottier', 'Allan', '1989-03-23', 'Anglais', '100000001')
;

GO







