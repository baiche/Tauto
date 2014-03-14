------------------------------------------------------------
-- Fichier     : Procedure_cancelReservation
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;
GO

CREATE PROCEDURE dbo.cancelReservation
	@id	 					int
AS
	UPDATE Reservation
	SET annule='true'
	WHERE id = @id;

GO
