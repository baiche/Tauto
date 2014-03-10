------------------------------------------------------------
-- Fichier     : 20140310_SACT_Tauto_ReservationVehicule.sql
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table ReservationVehicule.
------------------------------------------------------------


USE Tauto_IBDR;

-- preparation :

DELETE FROM ReservationVehicule

DELETE FROM Vehicule
DELETE FROM Modele

DELETE FROM Reservation
DELETE FROM Abonnement
DELETE FROM TypeAbonnement
DELETE FROM Particulier
DELETE FROM CompteAbonne

DECLARE @IdAbonnement int, @IdReservation1 int, @IdReservation2 int;

-- preparation : 3 Vehicules

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres)
VALUES ('Peugeot', '406', 'Essence', 2006, 45, 0, 5);

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele)
VALUES ('0775896we', '14000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence'),
       ('0115896wx', '18000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence'),
       ('0445896wr', '25000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence');

-- preparation : 2 Reservations

INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2013-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

SET @IdAbonnement = SCOPE_IDENTITY();

INSERT INTO Reservation (date_debut, date_fin, id_abonnement)
VALUES ('20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);

SET @IdReservation1 = SCOPE_IDENTITY();

INSERT INTO Reservation (date_debut, date_fin, id_abonnement)
VALUES ('20130319 08:00:00', '20130321 17:00:00', @IdAbonnement);

SET @IdReservation2 = SCOPE_IDENTITY();

--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 1

	   AND

      (SELECT id_reservation
	   FROM ReservationVehicule) = @IdReservation1

	   AND

	  (SELECT matricule_vehicule
	   FROM ReservationVehicule) = '0775896we'

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
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we'),
		(@IdReservation1, '0115896wx');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation1) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0775896we') = 1
	   
	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0115896wx') = 1

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
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we'),
		(@IdReservation2, '0775896we');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0775896we') = 2
	   

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation1) = 1

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation2) = 1


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
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we'),
		(@IdReservation1, '0115896wx'),
		(@IdReservation1, '0445896wr'),
		(@IdReservation2, '0445896wr'),
		(@IdReservation2, '0115896wx');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 5

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation1) = 3

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation2) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0775896we') = 1

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0115896wx') = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0445896wr') = 2

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
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we');
	
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we');
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(NULL, '0775896we');
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


--Test C.2
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation2 + 5, '0775896we');
	
	-- verification
	PRINT('------------------------------Test C.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 


--Test C.3
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, NULL);
	
	-- verification
	PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH 


--Test C.4
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0999999xx');
	
	-- verification
	PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 
