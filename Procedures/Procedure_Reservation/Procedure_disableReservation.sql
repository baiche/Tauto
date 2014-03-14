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

IF OBJECT_ID ('dbo.disableReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableReservation
GO

CREATE PROCEDURE dbo.disableReservation
	@id	 					int
AS
	UPDATE Reservation
	SET a_supprimer='true'
	WHERE id = @id;

GO
