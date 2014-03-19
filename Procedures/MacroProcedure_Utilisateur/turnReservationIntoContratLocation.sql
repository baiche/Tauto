------------------------------------------------------------
-- Fichier     : turnReservationIntoContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Jean-Luc Amitousa Mankoy
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Transforme une réservation en location
--				 L'état des véhicules est vérifié (Disponible)
--				 Pas de vérification sur l'abbonnement, on le suppose valide
--				 Etat a_supprimer de la réservation vérifié
--				 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.turnReservationIntoContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.turnReservationIntoContratLocation	
GO

CREATE PROCEDURE dbo.turnReservationIntoContratLocation
	@id_reservation 		int, -- PK
	@km_reservation			int -- nombre de kilomètres autorisés pendant la location
AS
	BEGIN TRANSACTION turnReservationIntoContratLocation
	BEGIN TRY
		DECLARE @id_abonnem int, @matricule_veh nvarchar(50), @date_d datetime, @date_f datetime, @id_contratLoc int, @annul bit
				@vehiculeStatut nvarchar(50);
		DECLARE @ReservationVehicule_T TABLE (
			matricule_vehicule nvarchar(50)
		);
		DECLARE @Reservation_T TABLE (
			date_debut datetime,
			date_fin datetime, 
			annule,
		);
		DECLARE @Vehicule_T TABLE(
			statut nvarchar(50)
		);
		
		INSERT INTO @ReservationVehicule_T(matricule_vehicule)
			(SELECT matricule_vehicule FROM ReservationVehicule WHERE id_reservation = @id_reservation);
			
		INSERT INTO @Reservation_T(date_debut, date_fin datetime, annule)
			(SELECT date_debut, date_fin, annule FROM Reservation WHERE id = @id_reservation);
		
		DECLARE @Reservation_T_cursor CURSOR
			FOR SELECT * FROM @Reservation_T;
		OPEN @Reservation_T_cursor;
		FETCH NEXT FROM @Reservation_T_cursor
			INTO @date_d, @date_f, @annul;
		CLOSE @Reservation_T_cursor;
		DEALLOCATE @Reservation_T_cursor;
			
		IF ( @annul = 'true' )
			RAISERROR('Reservation annule', 10, -1);
		
		IF (COUNT (*) FROM @ReservationVehicule_T) > 0
		BEGIN
			EXEC @id_contratLoc = dbo.createContratLocation
				@date_debut = @date_d,
				@date_fin = @date_f,
				@id_abonnement = id_abonnem;
			
			DECLARE @ReserVehi_cursor CURSOR;
			OPEN @ReserVehi_cursor;
			FETCH NEXT FROM @ReserVehi_cursor
				INTO @matricule_vehicule;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				INSERT INTO @Vehicule_T(statut)
					(SELECT statut FROM Vehicule WHERE matricule = @matricule_vehicule);
				DECLARE @Vehicule_T_cursor CURSOR
					FOR SELECT * FROM @Vehicule_T;
				OPEN @Vehicule_T_cursor;
				FETCH NEXT FROM @Vehicule_T_cursor
					INTO @vehiculeStatut;
				CLOSE @Vehicule_T_cursor;
				DEALLOCATE @Vehicule_T_cursor;
				IF (@vehiculeStatut NOT LIKE 'Disponible')
					RAISERROR('Vehicule louee', 10, -1);
					
				EXEC dbo.createLocation 
					@matricule_vehicule = @matricule_veh,
					@id_contratLocation = @id_contratLoc,
					@km = @km_reservation;
				
				FETCH NEXT FROM @ReserVehi_cursor
					INTO @matricule_vehicule;
			END
			
			CLOSE @ReserVehi_cursor;
			DEALLOCATE @ReserVehi_cursor;
		END
		
		UPDATE Reservation 
		SET a_supprimer = 'true'
		WHERE id = @id_reservation;
		
		EXEC dbo.printContratLocation
			@id_contrat_location = @id_contratLoc;
	
		COMMIT TRANSACTION turnReservationIntoContratLocation
		PRINT('turnReservationIntoContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('turnReservationIntoContratLocation: ERROR');
		ROLLBACK TRANSACTION turnReservationIntoContratLocation
		RETURN -1;
	END CATCH
GO