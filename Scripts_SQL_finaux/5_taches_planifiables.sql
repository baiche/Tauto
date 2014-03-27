------------------------------------------------------------
-- Fichier     : 5_taches_planifiables
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script d'ajout des taches planifié dans la
-- base. Ces procedures sont appelé a intervalle reguliers.
-- Par le task scheduler de windows.
------------------------------------------------------------

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

------------------------------------------------------------
-- Fichier     : checkImpayeTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.checkImpayeTriggerRec') IS NOT NULL
	DROP PROCEDURE dbo.checkImpayeTriggerRec	
GO

CREATE PROCEDURE dbo.checkImpayeTriggerRec
AS
	DECLARE @idFac int;
	DECLARE @niveau int;
	DECLARE @courriel nvarchar(50);
	DECLARE @nom nvarchar(50);
	DECLARE @prenom nvarchar(50);
	DECLARE @date_naissance date;
	DECLARE @date_ datetime;
	DECLARE @a_supprimer bit;
			
	DECLARE Impaye_cursor CURSOR
		FOR SELECT * FROM RelanceDecouvert;
	OPEN Impaye_cursor;
	FETCH NEXT FROM Impaye_cursor
		INTO @date_, @nom, @prenom, @date_naissance, @niveau, @a_supprimer; 
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @a_supprimer = 'false'
		BEGIN
			IF @niveau < 5
			BEGIN
				SELECT @courriel = courriel FROM CompteAbonne WHERE nom = @nom AND prenom = @prenom AND date_naissance = @date_naissance;
				EXEC dbo.updateNiveauRelanceDecouvert
					@nom, @prenom, @date_naissance, @date_;
				PRINT 'Niveau de relance incremente pour ' + @nom + N' ' + @prenom;
				PRINT 'Message envoye a l''adresse ' + @courriel + ', niveau ' + CAST(@niveau AS nvarchar(2));
			END
			ELSE
			BEGIN
				PRINT N'Niveau 5 atteint, ' + @nom + N' ' + @prenom + N' mis en liste grise';
				EXEC dbo.greyListCompteAbonne
					@nom, @prenom, @date_naissance;
				EXEC dbo.disableRelanceDecouvert
					@nom, @prenom, @date_naissance, @date_;
			END
		END
		PRINT '';
		FETCH NEXT FROM Impaye_cursor
			INTO @date_, @nom, @prenom, @date_naissance, @niveau, @a_supprimer; 
	END
	
	CLOSE Impaye_cursor;
	DEALLOCATE Impaye_cursor;
GO

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
		
		DELETE FROM Categorie
		WHERE a_supprimer = 'true'
			
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
			
		DELETE FROM Vehicule	
		WHERE a_supprimer = 'true'

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
			
			
		DELETE FROM Modele
		WHERE a_supprimer = 'true'
			
		--SUPPRESSION des RESERVATIONS
			
			--1 - suppression de ReservationVehicule
			
			--2 - suppression de Reservation
			
		DELETE FROM Reservation
		WHERE a_supprimer = 'true'
			
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
				
		DELETE FROM Abonnement
		WHERE a_supprimer = 'true'
		
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
			
		DELETE FROM TypeAbonnement
		WHERE a_supprimer = 'true'	
					
		--SUPPRESSION des COMPTEABONNES
		
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
			
			--6 - suppression de CompteAbonne
			
		DELETE FROM CompteAbonne
		WHERE a_supprimer = 'true'
			
		--SUPPRESSION de RelanceDecouvert
			
			--1 - suppression de RelanceDecouvert
			
		DELETE FROM RelanceDecouvert
		WHERE a_supprimer = 'true'
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