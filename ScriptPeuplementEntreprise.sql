------------------------------------------------------------
-- Fichier     : ScriptPeuplementEntreprise
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Remplissage de la table Entreprise
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('PIndustrie', 'PIndustrie', '1980-02-17', 'true', 
 'false', 'AD12 0001 2030 2003 5910 0100', 'pindustrie@hotmail.fr', '0656470693'),
('TASociety', 'TASociety', '1980-02-24', 'true', 
 'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');

INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
('732 829 320', 'Pokemon Industrie','PIndustrie','PIndustrie','1980-02-17'),
('843 930 431', 'TASociety','TASociety','TASociety','1980-02-24');
