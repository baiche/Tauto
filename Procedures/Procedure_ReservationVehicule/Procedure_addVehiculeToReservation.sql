------------------------------------------------------------
-- Fichier     : Procedure_addVehiculeToReservation
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addVehiculeToReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addVehiculeToReservation
GO

CREATE PROCEDURE dbo.addVehiculeToReservation
	@id_reservation				INT,
	@matricule_vehicule			VARCHAR(50)
AS
	INSERT INTO ReservationVehicule
	(	id_reservation,
		matricule_vehicule
	)
	VALUES (
		@id_reservation,
		@matricule_vehicule
	);

GO
