------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Reservation
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				Reservations
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.cancelReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.cancelReservation
GO

IF OBJECT_ID ('dbo.createReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createReservation
GO

IF OBJECT_ID ('dbo.deleteReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteReservation
GO

IF OBJECT_ID ('dbo.disableReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableReservation
GO

IF OBJECT_ID ('dbo.updateReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateReservation
GO
