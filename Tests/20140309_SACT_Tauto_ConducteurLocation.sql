------------------------------------------------------------
-- Fichier     : 20140309_SACT_Tauto_ConducteurLocation.sql
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table ConducteurLocation.
------------------------------------------------------------


USE Tauto_IBDR;

-- preparation :

DELETE FROM ConducteurLocation

DELETE FROM Conducteur;
DELETE FROM Permis;

DELETE FROM Location
DELETE FROM ContratLocation
DELETE FROM Abonnement
DELETE FROM TypeAbonnement
DELETE FROM Particulier
DELETE FROM CompteAbonne
DELETE FROM Vehicule
DELETE FROM Modele

-- preparation : 3 conducteurs

INSERT INTO Permis(numero)
VALUES ('0000000001'),
       ('0000000002'),
       ('0000000003');

INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis)
VALUES ('123456789', 'Francais', 'de Finance', 'Boris', '0000000001'),
       ('987654321', 'Francais', 'le Coco', 'David', '0000000002'),
       ('100000001', 'Anglais', 'Amitousa', 'Jean Luc', '0000000003');

-- preparation : 2 locations

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres)
VALUES ('Peugeot', '406', 'Essence', 2006, 45, 0, 5);

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele)
VALUES ('0775896we', '14000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence'),
       ('0999996aa', '65000', 'Gris', 'Disponible', 'VF3 8C4HXF 11800000', 'Peugeot', '406', 5, 'Essence');

INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2014-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

DECLARE @IdAbonnement int;
SET @IdAbonnement = SCOPE_IDENTITY();

INSERT INTO ContratLocation(date_debut, date_fin, extension, id_abonnement)
VALUES ('20140303 08:00:00', '20140314 18:00:00', 0, @IdAbonnement);

DECLARE @IdContratLocation int;
SET @IdContratLocation = SCOPE_IDENTITY();

INSERT INTO Location(matricule_vehicule, id_contratLocation)
VALUES ('0775896we', @IdContratLocation); 

DECLARE @IdLocation1 int;
SET @IdLocation1 = SCOPE_IDENTITY();

INSERT INTO Location(matricule_vehicule, id_contratLocation)
VALUES ('0999996aa', @IdContratLocation); 

DECLARE @IdLocation2 int;
SET @IdLocation2 = SCOPE_IDENTITY();


--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 1

	   AND

      (SELECT id_location
	   FROM ConducteurLocation) = @IdLocation1

	   AND

	  (SELECT piece_identite_conducteur
	   FROM ConducteurLocation) = '123456789'
	   
	   AND

	  (SELECT nationalite_conducteur
	   FROM ConducteurLocation) = 'Francais'

		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 


--Test A.2
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais'),
		(@IdLocation1, '100000001', 'Anglais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation1) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais') = 1
	   
	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais') = 1

		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 


--Test A.3
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais'),
		(@IdLocation2, '123456789', 'Francais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais') = 2
	   

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation1) = 1

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation2) = 1


		PRINT('------------------------------Test A.3 OK')
	ELSE
		PRINT('------------------------------Test A.3 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 NOT OK')
END CATCH 


--Test A.4
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais'),
		(@IdLocation1, '987654321', 'Francais'),
		(@IdLocation1, '100000001', 'Anglais'),
		(@IdLocation2, '100000001', 'Anglais'),
		(@IdLocation2, '987654321', 'Francais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 5

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation1) = 3

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation2) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais') = 1

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '987654321' AND nationalite_conducteur = 'Francais') = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais') = 2

		PRINT('------------------------------Test A.4 OK')
	ELSE
		PRINT('------------------------------Test A.4 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais');
	
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais');
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(NULL, '123456789', 'Francais');
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


--Test C.2
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, NULL, NULL);
	
	-- verification
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 
