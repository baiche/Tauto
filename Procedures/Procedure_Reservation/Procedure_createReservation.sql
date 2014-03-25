------------------------------------------------------------
-- Fichier     : Procedure_createReservation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Baiche Mourad
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createReservation
GO

CREATE PROCEDURE dbo.createReservation
	@date_debut				datetime,
	@date_fin				datetime,
	@id_abonnement			int
AS
	INSERT INTO Reservation(
		date_creation,
		date_debut,
		date_fin,
		annule,
		id_abonnement
	)
	VALUES (
		GETDATE(),
		@date_debut,
		@date_fin,
		'false',
		@id_abonnement
	);

GO
