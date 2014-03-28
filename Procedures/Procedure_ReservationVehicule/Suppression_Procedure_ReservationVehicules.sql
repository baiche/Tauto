------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Reservation
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				ReservationVehicules
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addVehiculeToReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addVehiculeToReservation
GO

IF OBJECT_ID ('dbo.removeVehiculeFromReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeVehiculeFromReservation
GO

