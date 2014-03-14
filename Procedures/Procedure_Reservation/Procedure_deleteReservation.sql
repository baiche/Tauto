------------------------------------------------------------
-- Fichier     : Procedure_deleteReservation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteReservation
GO

CREATE PROCEDURE dbo.deleteReservation
	@id 					int
AS
	DELETE FROM Reservation
	WHERE 	id = @id;
GO