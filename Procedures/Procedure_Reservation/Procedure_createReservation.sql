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

GO
CREATE PROCEDURE TAuto.createReservation
	@id	 					int,
	@date_creation			date,
	@date_debut				datetime,
	@date_fin				datetime,
	@annule					bit,
	@matricule_vehicule		nvarchar(50),
	@id_abonnement			int
AS
	INSERT INTO Reservation(
		id,
		date_creation,
		date_debut,
		date_fin,
		annule,
		matricule_vehicule,
		id_abonnement
	)
	VALUES (
		@id,
		@date_creation,
		@date_debut,
		@date_fin,
		@annule,
		@matricule_vehicule,
		@id_abonnement
	);

GO
