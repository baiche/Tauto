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

GO
CREATE PROCEDURE TAuto.deleteReservation
	@id 					int
AS
	DELETE FROM Reservation
	WHERE 	id = @id;
GO