------------------------------------------------------------
-- Fichier     : 10_Peuplement_Particulier.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Particulier
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'true', 
 'false', 'LU28 0019 4006 4475 0000', 'jean-luc.amitousa-mankoy@hotmail.fr', '0656470693'),
('Lecoconier', 'David', '1990-02-02', 'true', 
 'false', 'MK072 5012 0000 0589 84', 'david.lecoconier@gmail.Com', '06050403021'),
('De Finance', 'Boris', '1990-09-08', 'true', 
 'false', 'PL60 1020 1026 0000', 'boris.de.finance@gmail.com', '060102030405'),
('Ouir', 'Seyyid', '1986-05-25', 'true', 
 'false', 'DE89 3704 0044 0532', 'seyyid.ouir@gmail.com', '0601030507'),
('Baiche', 'Mourad', '1989-04-25', 'true', 
 'false', 'GR16 0110 1250 0000 0001', 'mourad.baiche@gmail.com', '0706050403'),
('Deluze', 'Alexis', '1974-02-12', 'true', 
 'false', 'FR14 2004 1010 0505', 'alexis.deluze@gmail.com', '070102030405'),
('Mottier', 'Allan', '1989-03-23', 'true', 
 'false', 'HR12 1001 0051 863', 'allan.mottier@gmail.com', '0701030507'),
('Neti', 'Mohamed', '1988-03-25', 'true', 
 'false', 'AD12 0001 2030 2003', 'mohamed.neti@gmail.com', '0607080904');
 
 INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
 ('Amitousa Mankoy', 'Jean-Luc', '1990-07-18'),
 ('Lecoconier', 'David', '1990-02-02'),
 ('De Finance', 'Boris', '1990-09-08'),
 ('Ouir', 'Seyyid', '1986-05-25'),
 ('Baiche', 'Mourad', '1989-04-25'),
 ('Deluze', 'Alexis', '1974-02-12'),
 ('Mottier', 'Allan', '1989-03-23'),
 ('Neti', 'Mohamed', '1988-03-25');