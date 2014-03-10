------------------------------------------------------------
-- Fichier     : Procedure_deleteLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------


USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.deleteLocation

	@id_location		int
		
AS	
	BEGIN TRANSACTION delete_location
		BEGIN TRY
		
			------------------------------------------------------------------
			-- ETAPE.01: Mise a jour du statut du vehicule.
			------------------------------------------------------------------
			
			UPDATE Vehicule
			SET statut='Disponible'
			FROM Location l 
			WHERE l.id=@id_location
			  AND matricule=l.matricule_vehicule
			
			
			
			------------------------------------------------------------------
			-- ETAPE.02: Destruction de l'etat associe a la location
			------------------------------------------------------------------
		
			DELETE e
			FROM Etat e, Location l
			WHERE l.id=@id_location 
			  AND e.id = l.id_etat
			  
			  
			  
			------------------------------------------------------------------
			-- ETAPE.03: Destruction de la facture associe a la location
			------------------------------------------------------------------
		
			DELETE e
			FROM Etat e, Location l
			WHERE l.id=@id_location 
			  AND e.id = l.id_etat
			  
			  
			  
			------------------------------------------------------------------
			-- ETAPE.04: Destruction des infractions/incidents/retards
			------------------------------------------------------------------
		
			DELETE
			FROM Infraction
			WHERE id_location=@id_location;
			  
			DELETE
			FROM Incident
			WHERE id_location=@id_location;
			
			DELETE 
			FROM Retard
			WHERE id_location=@id_location;
			  
			  
			  
			------------------------------------------------------------------
			-- ETAPE.05: Destruction de la location
			------------------------------------------------------------------
		
			DELETE l FROM Location l WHERE l.id=@id_location;
			
			
			
			RETURN 0;
			
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION delete_location;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION delete_location;
GO