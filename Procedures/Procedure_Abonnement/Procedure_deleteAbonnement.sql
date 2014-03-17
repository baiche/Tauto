------------------------------------------------------------
-- Fichier     : Procedure_deleteAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime un abonnement. Renvoie 1 en cas de succès, erreur autrement.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteAbonnement

GO
CREATE PROCEDURE dbo.deleteAbonnement
	@id 				int
AS
	DELETE FROM Infraction
		WHERE id_location IN ( SELECT id FROM Location
									WHERE id_contratLocation IN (SELECT id FROM ContratLocation
																	WHERE id_abonnement=@id));
																				
	DELETE FROM Incident
		WHERE id_location IN ( SELECT id FROM Location
									WHERE id_contratLocation IN (SELECT id FROM ContratLocation
																	WHERE id_abonnement=@id));
																				
	DELETE FROM Retard
		WHERE id_location IN ( SELECT id FROM Location
									WHERE id_contratLocation IN (SELECT id FROM ContratLocation
																	WHERE id_abonnement=@id));
								
	DELETE FROM ConducteurLocation
		WHERE id_location IN (SELECT id FROM Location
									WHERE id_contratLocation IN (SELECT id FROM ContratLocation
																	WHERE id_abonnement=@id));
			
	DELETE FROM Location
		WHERE id_contratLocation IN (SELECT id FROM ContratLocation
										WHERE id_abonnement=@id);																						
															
	DELETE FROM ContratLocation
		WHERE id_abonnement=@id;
				
	DELETE FROM ReservationVehicule
		WHERE id_reservation IN (SELECT id FROM Reservation 
									WHERE id_abonnement = @id);
														
	DELETE FROM Reservation
		WHERE id_abonnement=@id;
				
	DELETE FROM Abonnement
		WHERE id=@id;
		
	RETURN 1;
GO
			