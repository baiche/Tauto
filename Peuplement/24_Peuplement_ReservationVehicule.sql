 ------------------------------------------------------------
-- Fichier     : 24_Peuplement_ReservationVehicule.sql
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Liaison des reservations aux vehicules 
-- concernés
                 
------------------------------------------------------------

USE TAuto_IBDR;

INSERT INTO ReservationVehicule
	(id_reservation,matricule_vehicule)
VALUES
(1,'0775896wu'),
(2,'0775896wy'),
(3,'0775896wi'),
(4,'0775896wu'),
(5,'0775896wy'),
(6,'0775896wt'),
(7,'0775896wr'),
(8,'0775896wx'),
(9,'0775896we'),
(10,'0775896wr'),
(11,'0775896wt'),
(12,'0775896wx'),
(13,'0775896we'),
(14,'0775896wt'),
(15, '0775896wi');
