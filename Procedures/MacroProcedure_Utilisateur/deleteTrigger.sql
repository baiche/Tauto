------------------------------------------------------------
-- Fichier     : deleteTrigger.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : S'occupe de toute les suppressions
-- en attente de la base. Il est supposé que les fonctions
-- demandant la suppression d'un element de la base vérifient
-- que les données affectées ne sont plus nécessaire. 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteTrigger', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteTrigger	
GO

CREATE PROCEDURE dbo.deleteTrigger
AS
	BEGIN TRANSACTION deleteTrigger
	DECLARE @msg varchar(4000)
	BEGIN TRY
	
		--Debut du nettoyage de la base de donnees
		
		--SUPPRESSION des CATALOGUES
		
			--1 - suppression de CatalogueCategorie
			
			--2 - suppression de Catalogue
			
		DELETE FROM Catalogue
		WHERE a_supprimer = 'true'
			
		--SUPPRESSION des CATEGORIES
		
			--1 - suppression de CatalogueCategorie
			
			--2 - suppression de CategorieModele
			
			--3 - suppression de Categorie
			
		--SUPPRESSION des VEHICULES
			
			--1 - suppression de ReservationVehicule
			
			
			--2 - SUPPRESSION des LOCATIONS
				
				--2.1 suppression de Infraction
				
				--2.2 suppression de Incident
				
				--2.3 suppression de Retard
				
				--2.4 suppression de ConducteurLocation
				
				--2.5 suppression de Facturation
				
				--2.6 suppression de Etat
				
				--2.7 suppression de Location
				
			--3 - suppression de Vehicule 
				
				
		--SUPPRESSION des MODELES
		
			--1 - SUPPRESSION des VEHICULES
			
				--1.1 - suppression de ReservationVehicule
				
				
				--1.2 - SUPPRESSION des LOCATIONS
					
					--1.2.1 suppression de Infraction
					
					--1.2.2 suppression de Incident
					
					--1.2.3 suppression de Retard
					
					--1.2.4 suppression de ConducteurLocation
					
					--1.2.5 suppression de Facturation
					
					--1.2.6 suppression de Etat
					
					--1.2.7 suppression de Location
					
				--1.3 - suppression de Vehicule 
			
			--2 - suppression de Modele
			
		--SUPPRESSION des RESERVATIONS
			
			--1 - suppression de ReservationVehicule
			
			--2 - suppression de Reservation
			
		--SUPPRESSION des ABONNEMENTS
		
			--1 - SUPPRESSION des RESERVATIONS
			
				--1.1 - suppression de ReservationVehicule
				
				--1.2 - suppression de Reservation
			
			--2 - SUPPRESSION des CONTRATLOCATIONS
			
				--2.1 - SUPPRESSION des LOCATIONS
					
					--2.1.1 suppression de Infraction
					
					--2.1.2 suppression de Incident
					
					--2.1.3 suppression de Retard
					
					--2.1.4 suppression de ConducteurLocation
					
					--2.1.5 suppression de Facturation
					
					--2.1.6 suppression de Etat
					
					--2.1.7 suppression de Location
				
				--2.2 suppression de ContratLocation
				
		--SUPPRESSION des TYPEABONNEMENTS
		
			--1 - SUPPRESSION des ABONNEMENTS
		
				--1.1 - SUPPRESSION des RESERVATIONS
				
					--1.1.1 - suppression de ReservationVehicule
					
					--1.1.2 - suppression de Reservation
				
				--1.2 - SUPPRESSION des CONTRATLOCATIONS
				
					--1.2.1 - SUPPRESSION des LOCATIONS
						
						--1.2.1.1 suppression de Infraction
						
						--1.2.1.2 suppression de Incident
						
						--1.2.1.3 suppression de Retard
						
						--1.2.1.4 suppression de ConducteurLocation
						
						--1.2.1.5 suppression de Facturation
						
						--1.2.1.6 suppression de Etat
						
						--1.2.1.7 suppression de Location
					
					--1.2.2 suppression de ContratLocation
					
			--2 - suppression de TypeAbonnement
					
		--SUPPRESSION de CompteAbonne
		
			--1 - SUPPRESSION des ABONNEMENTS
		
				--1.1 - SUPPRESSION des RESERVATIONS
				
					--1.1.1 - suppression de ReservationVehicule
					
					--1.1.2 - suppression de Reservation
				
				--1.2 - SUPPRESSION des CONTRATLOCATIONS
				
					--1.2.1 - SUPPRESSION des LOCATIONS
						
						--1.2.1.1 suppression de Infraction
						
						--1.2.1.2 suppression de Incident
						
						--1.2.1.3 suppression de Retard
						
						--1.2.1.4 suppression de ConducteurLocation
						
						--1.2.1.5 suppression de Facturation
						
						--1.2.1.6 suppression de Etat
						
						--1.2.1.7 suppression de Location
					
					--1.2.2 suppression de ContratLocation
					
			--2 - suppression de Particulier
			
			--3 - suppression de Entreprise
			
			--4 - suppression de CompteAbonneConducteur
			
			--5 - suppression de RelanceDecouvert
			
		--SUPPRESSION de RelanceDecouvert
			
			--1 - suppression de RelanceDecouvert
	
		--Fin du nettoyage de la base de donnees	
			
		COMMIT TRANSACTION deleteTrigger
		PRINT('deleteTrigger OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('deleteTrigger: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION deleteTrigger
		RETURN -1;
	END CATCH
GO