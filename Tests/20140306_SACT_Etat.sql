------------------------------------------------------------
-- Fichier     : 20140228_SACT_Etat.sql
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Etat.
------------------------------------------------------------


USE Tauto_IBDR;

------------------------------
--INITIALISATIONS FOR All TESTS
------------------------------
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
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
INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation) VALUES
		('1885896wx', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 		

--Test A.1
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'0100');
	PRINT('------------------------------Test A.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

--Test A.2
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 -1,0,'0100');
	PRINT('------------------------------Test A.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test A.3
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 NULL,0,'0100');
	PRINT('------------------------------Test A.3 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test A.4
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 0,'0100');
	IF (SELECT km FROM Etat WHERE date_creation='25-11-2060' 
							  AND id_location=(SELECT id 
											   FROM Location 
											   WHERE matricule_vehicule='1885896wx')) = 0
		PRINT('------------------------------Test A.4 OK');
	ELSE
		PRINT('------------------------------Test A.4 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test B.1
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,'0100');
	PRINT('------------------------------Test B.1 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test B.2
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,NULL,'0100');
	PRINT('------------------------------Test B.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test C.1
BEGIN TRY
INSERT INTO Etat(id_location,km,degat,fiche) VALUES
			((SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'0100');
	IF (SELECT km FROM Etat WHERE date_creation='25-11-2060' 
							  AND id_location=(SELECT id 
											   FROM Location 
											   WHERE matricule_vehicule='1885896wx')) = NULL
		PRINT('------------------------------Test C.1 NOT OK');
	ELSE
		PRINT('------------------------------Test C.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test C.2
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			(NULL, 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'0100');
	PRINT('------------------------------Test C.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test D.1
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 -11,
			 10,0,'0100');
	PRINT('------------------------------Test D.1 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test D.2
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060',NULL,10,0,'0100');
	PRINT('------------------------------Test D.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
--Test D.3
BEGIN TRY
INSERT INTO Etat(date_creation,km,degat,fiche) VALUES
			('25-11-2060',10,0,'0100');
	PRINT('------------------------------Test D.3 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.3 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test E.1
----------Part 1
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'');
	PRINT('------------------------------Test E.1 NOT OK.1');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.1');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

----------Part 2		  
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,' ');
	PRINT('------------------------------Test E.1 NOT OK.2');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.2');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

----------Part 3
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'m@Fiche');
	PRINT('------------------------------Test E.1 NOT OK.3');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.3');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test E.2

BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,NULL);
	PRINT('------------------------------Test E.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');


--Test F.1
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'0100'),
			 ('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 11,1,'0200');
	PRINT('------------------------------Test E.1 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK');
END CATCH

DELETE FROM Etat WHERE date_creation='25-11-2060' 
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
				  
--Test F.2
BEGIN TRY
INSERT INTO Etat(date_creation,id_location,km,degat,fiche) VALUES
			('25-11-2060', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 10,0,'0100'),
			 ('25-11-2061', 
			 (SELECT id FROM Location WHERE matricule_vehicule='1885896wx'),
			 11,1,'0200');
	PRINT('------------------------------Test F.2 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.2 NOT OK');
END CATCH

DELETE FROM Etat WHERE (date_creation='25-11-2060' OR date_creation='25-11-2061')
				  AND id_location=(SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

------------------------------
--CLEAN FOR ALL TESTS
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';