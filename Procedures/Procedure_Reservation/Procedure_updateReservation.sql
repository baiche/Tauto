------------------------------------------------------------
-- Fichier     : Procedure_updateReservation
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
CREATE PROCEDURE TAuto.updateReservation
	@id	 					int,
	@date_creation			date,
	@date_debut				datetime,
	@date_fin				datetime,
	@annule					bit,
	@matricule_vehicule		nvarchar(50),
	@id_abonnement			int
AS
	UPDATE Reservation
	SET id = @id
		date_creation = @date_creation,
		date_debut = @date_debut,
		date_fin = @date_fin,
		annule = @annule,
		matricule_vehicule = @matricule_vehicule,
		id_abonnement = @id_abonnement
	WHERE 	id = @id;

GO