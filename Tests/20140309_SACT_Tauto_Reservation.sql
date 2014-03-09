------------------------------------------------------------
-- Fichier     : 20140309_SACT_Tauto_Reservation.sql
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Reservation.
------------------------------------------------------------


USE Tauto_IBDR;

-- preparation : un vehicule, un abonnement

DELETE FROM Abonnement
DELETE FROM TypeAbonnement
DELETE FROM Particulier
DELETE FROM CompteAbonne
DELETE FROM Vehicule
DELETE FROM Modele


INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres)
VALUES ('Peugeot', '406', 'Essence', 2006, 45, 0, 5);

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele)
VALUES ('0775896we', '14000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence');


INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2013-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

DECLARE @IdAbonnement int;
SET @IdAbonnement = SCOPE_IDENTITY();

--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('20130317 08:00:00', '20130324 08:00:00', '0775896we', @IdAbonnement);
	
	-- verification
    IF
      (SELECT date_creation
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = CONVERT (date, GETDATE())

	   AND

	  (SELECT annule
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = 'false'

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
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('2013-03-10', '20130317 08:00:00', '20130324 08:00:00', '0775896we', @IdAbonnement);
	
	-- verification
    IF
      (SELECT date_creation
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = '2013-03-10'
	   
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
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		(NULL, '20130317 08:00:00', '20130324 08:00:00', '0775896we', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 


--Test A.4
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('2013-03-10', '20130324 08:00:00', '0775896we', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 


--Test A.5
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, matricule_vehicule, id_abonnement)
	VALUES
		('2013-03-10', '20130317 08:00:00', '0775896we', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(id, date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		(11, '20130317 08:00:00', '20130324 08:00:00', '0775896we', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test B.2
BEGIN TRY
	-- preparation
	DELETE FROM Reservation
	INSERT INTO Reservation
		(date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('20130317 08:00:00', '20130324 08:00:00', '0775896we', @IdAbonnement);

	DECLARE @IdPredecesseur int;
	SET @IdPredecesseur = SCOPE_IDENTITY();

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', '0775896we', @IdAbonnement);
	
	-- verification
    IF SCOPE_IDENTITY() = @IdPredecesseur + 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', '0775896we', @IdAbonnement + 1);
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


--Test C.2
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, matricule_vehicule, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', 'xxxxxxxxx', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 


DELETE FROM Reservation
DELETE FROM Abonnement
DELETE FROM TypeAbonnement
DELETE FROM Particulier
DELETE FROM CompteAbonne
DELETE FROM Vehicule
DELETE FROM Modele
