 ------------------------------------------------------------
-- Fichier     : 24_Peuplement_ReservationVehicule.sql
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance, Seyyid Ouir
-- Commentaire : Liaison des reservations aux vehicules 
-- concernés
                 
------------------------------------------------------------

USE TAuto_IBDR;
GO

DECLARE @idReservation int;

-- reservations annulees -----------------------------------
/*
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2013-05-02T08:00:00' AND date_fin = '2013-05-31T18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wi'), -- '206',5,'Diesel'
	(@idReservation, '0775896wu'), -- '206',5,'Diesel'
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2013-06-15T10:00:00' AND date_fin = '2013-06-25T18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2013-07-01T09:00:00' AND date_fin = '2013-07-15T17:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-01-14T08:00:00' AND date_fin = '2014-01-21T08:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wu'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-01-21T08:00:00' AND date_fin = '2014-01-23T12:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
	
*/
--------------------

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-04-06T13:00:00' AND date_fin = '2014-04-10T18:00:00'; -- 6

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'), -- '206',5,'Diesel'
	(@idReservation, '0775896wi'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-04-28T08:00:00' AND date_fin = '2014-05-05T17:00:00'; -- 7

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'); -- '406',5,'Essence'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-04-07T10:00:00' AND date_fin = '2014-04-24T18:00:00'; -- 8

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'), -- '406',5,'Essence'
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-05-06T10:00:00' AND date_fin = '2014-05-08T18:00:00'; -- 9

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-06-01T09:00:00' AND date_fin = '2014-06-13T17:00:00'; -- 10, annulee

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-07-11T09:00:00' AND date_fin = '2014-09-22T17:00:00'; -- 11

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wi'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-11-05T08:00:00' AND date_fin = '2014-11-05T16:00:00'; -- 12

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'

	
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '2014-03-05T08:00:00' AND date_fin = '2014-03-06T16:00:00'; -- 13

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'
