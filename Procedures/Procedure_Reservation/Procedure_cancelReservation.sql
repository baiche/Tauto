------------------------------------------------------------
-- Fichier     : Procedure_annulerReservation
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : Baiche ( modification du nom de la fonction  ) 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.annulerReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.annulerReservation
GO

CREATE PROCEDURE dbo.annulerReservation
	@id	 					int
AS
	UPDATE Reservation
	SET annule='true'
	WHERE id = @id;

GO
