------------------------------------------------------------
-- Fichier     : 20140304_SACT_Location.sql
-- Date        : 04/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Location.
------------------------------------------------------------

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

------------------------------
--INITIALISATIONS FOR Test A.1
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test A.1
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) 
	VALUES
		('1885896aa', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test A.1 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 OK');
END CATCH 

------------------------------
--CLEAN FOR Test A.1
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896aa';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';
 
 
 
 
 
 
------------------------------
--INITIALISATIONS FOR Test A.2
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);

------------------------------
--REALIZATION OF Test A.2
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		(NULL, 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test A.2 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK');
END CATCH 

------------------------------
--CLEAN FOR Test A.2
------------------------------
DELETE FROM Location WHERE id_facturation=(SELECT id FROM Facturation WHERE date_creation='2060-12-09');
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';






------------------------------
--INITIALISATIONS FOR Test B.1
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test B.1
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 -1,
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test B.1 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK');
END CATCH 

------------------------------
--CLEAN FOR Test B.1
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';





------------------------------
--INITIALISATIONS FOR Test B.2
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test B.2
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 NULL,
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test B.2 OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK');
END CATCH 

------------------------------
--CLEAN FOR Test B.2
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';





------------------------------
--INITIALISATIONS FOR Test C.1
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test C.1
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 -1); 
		 
	PRINT('------------------------------Test C.1 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK');
END CATCH 

------------------------------
--CLEAN FOR Test C.1
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';





------------------------------
--INITIALISATIONS FOR Test C.2
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7')); 
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test C.2
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 NULL); 
		 
	PRINT('------------------------------Test C.2 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK');
END CATCH 

------------------------------
--CLEAN FOR Test C.2
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';

SET NOCOUNT OFF