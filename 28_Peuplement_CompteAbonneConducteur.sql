-----------------------------------------------------------
-- Fichier     : ScriptPeuplementCategorieModele.sql
-- Date        : 26/02/2014
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script de remplissage de la table de jointure antre conducteur et compteAbonne (particulier et entreprise).
--
------------------------------------------------------------

USE TAuto_IBDR;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('PIndustrie', 'PIndustrie', '2014-02-17','200000002', 'Francais'),
	('TASociety', 'TASociety', '2014-02-24','123456789', 'Francais'),
	('TASociety', 'TASociety', '2014-02-24','987654321', 'Francais'),
	('TASociety', 'TASociety', '2014-02-24','100000001', 'Anglais')
;

GO
INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
	('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', '100000001', 'Anglais'),
	('Lecoconier', 'David', '1990-02-02', '987654321', 'Francais'),
	('De Finance', 'Boris', '1990-09-08', '123456789', 'Francais'),
	('Ouir', 'Seyyid', '1986-05-25', '200000002', 'Francais'),
	('Baiche', 'Mourad', '1989-04-25', '200000002', 'Francais'),
	('Deluze', 'Alexis', '1974-02-12', '987654321', 'Francais'),
	('Mottier', 'Allan', '1989-03-23', '100000001', 'Anglais')
;

GO







