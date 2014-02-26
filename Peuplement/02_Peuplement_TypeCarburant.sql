-----------------------------------------------------------
-- Fichier     : 02_Peuplement_TypeCarburant.sql
-- Date        : 24/02/2014
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de l'enumeration TypeCarburant.
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO TypeCarburant(nom) VALUES ('Essence'), ('Diesel');