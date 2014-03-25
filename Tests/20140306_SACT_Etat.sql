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

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

------------------------------
--INITIALISATIONS FOR All TESTS
------------------------------

INSERT INTO Catalogue(nom,date_debut,date_fin)
VALUES('Flotte','2014-01-01', '2014-06-01');

INSERT INTO Categorie(nom,description,nom_typepermis) 
VALUES('Vehicule simple','Tout type de vehicule simple a 4 roues','B');

INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie)
VALUES('Flotte', 'Vehicule simple');

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) 
VALUES('Peugeot','406','Diesel',2004,45,0,5);

INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) 
VALUES('Peugeot','406','Diesel',5,'Vehicule Simple');

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) 
VALUES('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) 
VALUES('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');

INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) 
VALUES('Dupont', 'Jacques', '1992-05-7');

INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules, km)
VALUES('10vehicules', 5, 10, DEFAULT);

INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) 
VALUES('2014-02-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
	
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) 
VALUES('2014-02-02 00:00:00',
	   '2014-02-12 00:00:00',
	   '2014-02-11 00:00:00',
	   0,
	   (SELECT id 
	    FROM Abonnement 
	    WHERE nom_compteabonne='Dupont' 
	      AND prenom_compteabonne='Jacques' 
	      AND date_naissance_compteabonne='1992-05-7'));

INSERT INTO Facturation(date_creation,date_reception,montant) 
VALUES('2014-02-11','2014-02-13',200);

INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation,km) 
VALUES('1885896wx', 
	   (SELECT id FROM Facturation WHERE date_creation='2014-02-11'),
	   NULL,
	   (SELECT id FROM ContratLocation WHERE date_debut='2014-02-02 00:00:00'),
	   0); 		

--Test A.1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 'true',
			 '0100');
	PRINT('------------------------------Test A.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK '+ERROR_MESSAGE());
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

--Test A.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 -1,
			 0,
			 '0100');
	PRINT('------------------------------Test A.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test A.3
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 NULL,
			 0,
			 '0100');
	PRINT('------------------------------Test A.3 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test A.4
BEGIN TRY
INSERT INTO Etat(date_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 0,
			 '0100');
	IF (SELECT km_avant FROM Etat WHERE date_avant='2014-02-02') = 0
		PRINT('------------------------------Test A.4 OK');
	ELSE
		PRINT('------------------------------Test A.4 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

--Test B.1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 '0100');
	PRINT('------------------------------Test B.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test B.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 NULL,
			 '0100');
	PRINT('------------------------------Test B.2 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test C.1
BEGIN TRY
INSERT INTO Etat(km_avant,degat,fiche_avant) VALUES
			(10,
			 0,
			 '0100');
	IF (SELECT COUNT(*) 
		FROM Etat 
		WHERE date_avant IS NULL 
		  AND km_avant=10) = 0
		PRINT('------------------------------Test C.1 OK');
	ELSE
		PRINT('------------------------------Test C.1 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK lalala');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test C.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			(NULL, 
			 10,
			 0,
			 '0100');
	PRINT('------------------------------Test C.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
			  
--Test E.1
----------Part 1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 '');
	PRINT('------------------------------Test E.1 NOT OK.1');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.1');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

----------Part 2		  
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 ' ');
	PRINT('------------------------------Test E.1 NOT OK.2');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.2');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

----------Part 3
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 'm@Fiche');
	PRINT('------------------------------Test E.1 NOT OK.3');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.3');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test E.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('25-11-2060', 
			 10,
			 0,
			 NULL);
	PRINT('------------------------------Test E.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';


--Test G.1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,km_apres,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 10,
			 0,
			 '0100');
	PRINT('------------------------------Test G.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.1 NOT OK ');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

--Test G.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,km_apres,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 -1,
			 0,
			 '0100');
	PRINT('------------------------------Test G.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test G.3
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,km_apres,degat,fiche_avant) VALUES
			('2014-02-02',
			 10,
			 NULL,
			 0,
			 '0100');
	PRINT('------------------------------Test G.3 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.3 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test G.4
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 '0100');
	IF (SELECT km_apres FROM Etat WHERE date_avant='2014-02-02') IS NULL
		PRINT('------------------------------Test G.4 OK');
	ELSE
		PRINT('------------------------------Test G.4 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.4 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

------------------------------
--CLEAN FOR ALL TESTS
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2014-02-11';
DELETE FROM ContratLocation WHERE date_debut='2014-02-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2014-02-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' 
						  AND prenom_compte='Jacques' 
						  AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' 
						   AND prenom='Jacques' 
						   AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM CatalogueCategorie WHERE nom_catalogue='Flotte';
DELETE FROM CategorieModele WHERE marque_modele='Peugeot' 
							  AND serie_modele='406' 
							  AND type_carburant_modele='Diesel';
DELETE FROM Categorie WHERE nom='Vehicule simple';
DELETE FROM Modele WHERE marque='Peugeot'
					 AND serie='406'
					 AND type_carburant='Diesel'
DELETE FROM Catalogue WHERE nom='Flotte';

SET NOCOUNT OFF