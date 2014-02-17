------------------------------------------------------------
-- Fichier     : ScriptPeuplementJeanLuc
-- Date        : 17/02/2014
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Remplissage des tables Compte Abonné, Location
------------------------------------------------------------

USE IBDR

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'true', 
	   'false', 'LU28 0019 4006 4475 0000', 'jean-luc.amitousa-mankoy@hotmail.fr', '0656470693');