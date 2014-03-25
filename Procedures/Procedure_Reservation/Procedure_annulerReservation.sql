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

IF OBJECT_ID ('dbo.cancelReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.cancelReservation
GO

CREATE PROCEDURE dbo.cancelReservation
	@id	 					int
AS
	UPDATE Reservation
	SET annule='true'
	WHERE id = @id;

GO
