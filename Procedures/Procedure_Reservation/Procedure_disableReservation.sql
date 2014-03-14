------------------------------------------------------------
-- Fichier     : Procedure_disableReservation
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

CREATE PROCEDURE dbo.disableReservation
	@id	 					int
AS
	UPDATE Reservation
	SET a_spprimer='true'
	WHERE id = @id;

GO
