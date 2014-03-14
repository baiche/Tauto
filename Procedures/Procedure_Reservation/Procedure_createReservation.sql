------------------------------------------------------------
-- Fichier     : Procedure_createReservation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createReservation
GO

CREATE PROCEDURE dbo.createReservation
	@id	 					int,
	@date_creation			date,
	@date_debut				datetime,
	@date_fin				datetime,
	@annule					bit,
	@id_abonnement			int
AS
	INSERT INTO Reservation(
		id,
		date_creation,
		date_debut,
		date_fin,
		annule,
		id_abonnement
	)
	VALUES (
		@id,
		@date_creation,
		@date_debut,
		@date_fin,
		@annule,
		@id_abonnement
	);

GO
