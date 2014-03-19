------------------------------------------------------------
-- Fichier     : turnReservationIntoContratLocat.sql
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

IF OBJECT_ID ('dbo.turnReservationIntoContratLocat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.turnReservationIntoContratLocat	
GO

CREATE PROCEDURE dbo.turnReservationIntoContratLocat
	@id_reservation 		int, -- PK
	@km_reservation			int -- nombre de kilomètres autorisés pendant la location
AS
	BEGIN TRANSACTION turnReservationIntoContratLocat
	BEGIN TRY
		DECLARE @id_abonnem int, @matricule_veh nvarchar(50), @date_d datetime, @date_f datetime, @id_contratLoc int, @annul bit,
				@vehiculeStatut nvarchar(50), @nomTitulaire nvarchar(50), @a_supprimer bit;
		DECLARE @ReservationVehicule_T TABLE (
			matricule_vehicule nvarchar(50)
		);
		DECLARE @Reservation_T TABLE (
			date_debut datetime,
			date_fin datetime, 
			annule bit,
			id_abonnement int,
			a_supprimer bit
		);
		DECLARE @Vehicule_T TABLE(
			matricule nvarchar(50),
			statut nvarchar(50)
		);
		
		INSERT INTO @ReservationVehicule_T(matricule_vehicule)
			(SELECT matricule_vehicule FROM ReservationVehicule WHERE id_reservation = @id_reservation);
			
		INSERT INTO @Reservation_T(date_debut, date_fin, annule, id_abonnement, a_supprimer)
			(SELECT date_debut, date_fin, annule, id_abonnement, a_supprimer FROM Reservation WHERE id = @id_reservation);
		
		DECLARE Reservation_T_cursor CURSOR
			FOR SELECT * FROM @Reservation_T
			
		OPEN Reservation_T_cursor
		FETCH NEXT FROM Reservation_T_cursor
			INTO @date_d, @date_f, @annul, @id_abonnem, @a_supprimer;
		CLOSE Reservation_T_cursor;
		DEALLOCATE Reservation_T_cursor;
			
		IF ( @annul = 'true' )
		BEGIN
			RAISERROR('Reservation annule', 10, -1);
			RETURN -1;
		END
			
		IF ( @a_supprimer = 'true' )
		BEGIN
			RAISERROR('Reservation supprimee', 10, -1);
			RETURN -1;
		END
			
		SELECT @nomTitulaire = nom_compteabonne FROM Abonnement WHERE id = @id_abonnem;
			
			
		PRINT('Contrat de location de ' + @nomTitulaire);
		
		
		IF ( SELECT COUNT (*) FROM @ReservationVehicule_T) > 0
		BEGIN
			EXEC @id_contratLoc = dbo.createContratLocation
				@date_debut = @date_d,
				@date_fin = @date_f,
				@id_abonnement = @id_abonnem;
			
			DECLARE ReserVehi_cursor CURSOR
				FOR SELECT * FROM @ReservationVehicule_T;
			OPEN ReserVehi_cursor;
			FETCH NEXT FROM ReserVehi_cursor
				INTO @matricule_veh;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @vehiculeStatut = statut FROM Vehicule WHERE matricule = @matricule_veh;				
				
				IF (@vehiculeStatut NOT LIKE 'Disponible')
					RAISERROR('Vehicule louee', 10, -1);
					
				EXEC dbo.createLocation 
					@matricule_vehicule = @matricule_veh,
					@id_contratLocation = @id_contratLoc,
					@km = @km_reservation;
				
				FETCH NEXT FROM ReserVehi_cursor
					INTO @matricule_veh;
			END
			
			CLOSE ReserVehi_cursor;
			DEALLOCATE ReserVehi_cursor;
		END
		
		UPDATE Reservation 
		SET a_supprimer = 'true'
		WHERE id = @id_reservation;
	
		COMMIT TRANSACTION turnReservationIntoContratLocat
		PRINT('turnReservationIntoContratLocat OK');
		RETURN @id_contratLoc;
	END TRY
	BEGIN CATCH
		PRINT('turnReservationIntoContratLocat: ERROR');
		ROLLBACK TRANSACTION turnReservationIntoContratLocat
		RETURN -1;
	END CATCH
GO