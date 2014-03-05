------------------------------------------------------------
-- Fichier     : 11_Peuplement_Entreprise.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage de la table Entreprise
------------------------------------------------------------

USE TAuto_IBDR

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('PIndustrie', 'PIndustrie', '2014-02-17', 'true', 
 'false', 'LU2800194006447512001234567', 'pindustrie@hotmail.fr', '0656470693'),
('TASociety', 'TASociety', '2014-02-24', 'true', 
 'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');

INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
('73282932014785', 'Pokemon Industrie','PIndustrie','PIndustrie','2014-02-17'),
('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
