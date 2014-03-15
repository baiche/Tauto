 ------------------------------------------------------------
-- Fichier     : 24_Peuplement_ReservationVehicule.sql
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
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
WHERE date_debut = '20130502 08:00:00' AND date_fin = '20130531 18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wi'), -- '206',5,'Diesel'
	(@idReservation, '0775896wu'), -- '206',5,'Diesel'
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20130615 10:00:00' AND date_fin = '20130625 18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20130701 09:00:00' AND date_fin = '20130715 17:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'
	

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140114 08:00:00' AND date_fin = '20140121 08:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wu'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140121 08:00:00' AND date_fin = '20140123 12:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
	
*/
--------------------

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140325 08:00:00' AND date_fin = '20140404 17:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'); -- '406',5,'Essence'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140406 13:00:00' AND date_fin = '20140410 18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'), -- '206',5,'Diesel'
	(@idReservation, '0775896wi'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140407 10:00:00' AND date_fin = '20140424 18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896we'), -- '406',5,'Essence'
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140506 10:00:00' AND date_fin = '20140508 18:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wt'); -- '206',5,'Diesel'

/*
SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140601 09:00:00' AND date_fin = '20140613 17:00:00'; -- annulee

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wy'); -- '206',3,'Essence'
*/

SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20140711 09:00:00' AND date_fin = '20140922 17:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wi'); -- '206',5,'Diesel'


SELECT @idReservation = id FROM Reservation
WHERE date_debut = '20141105 08:00:00' AND date_fin = '20141105 16:00:00';

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
	(@idReservation, '0775896wr'); -- '406',5,'Diesel'
