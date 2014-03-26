------------------------------------------------------------
-- Fichier     : Procedure_removeVehiculeFromReservation
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.removeVehiculeFromReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeVehiculeFromReservation
GO

CREATE PROCEDURE dbo.removeVehiculeFromReservation
	@id_reservation				INT,
	@matricule_vehicule			VARCHAR(50)
AS
DELETE FROM ReservationVehicule

WHERE 
	id_reservation=@id_reservation AND
	matricule_vehicule= @matricule_vehicule;

GO