------------------------------------------------------------
-- Fichier     : ScriptPeuplementLocation
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Remplissage de la table Location
------------------------------------------------------------

USE TAuto_IBDR

--Une location en cours

INSERT INTO Abonnement(date_debut,duree,renouvellement_auto,nom_typeabonnement,nom_compteabonne,
					   prenom_compteabonne,date_naissance_compteabonne) VALUES
('2014-02-01','60','false','5vehicules','Ouir', 'Seyyid', '1986-05-25');

INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
('2014-02-23','2014-03-23',NULL,NULL,1);

INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation) VALUES
('0775896wx',NULL,NULL,NULL,1);

INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
('2014-02-23',18000,'true','false','TheFicheId');

UPDATE Location
SET date_etat_avant='2014-02-23'
WHERE id=1


--Une location en retard
