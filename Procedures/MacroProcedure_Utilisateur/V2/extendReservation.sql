------------------------------------------------------------
-- Fichier     : extendReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Etend une réservation en lui associant un nouveau véhicule. Prend le premier disponible.
--				 Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendReservation	
GO

CREATE PROCEDURE dbo.extendReservation
	@id_reservation			int, -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	BEGIN TRANSACTION extendReservation
	BEGIN TRY
		DECLARE @matricule nvarchar(50), @date_d datetime, @date_f datetime, @res int, @continuer bit;
		DECLARE @Veh_T TABLE(
			matricule nvarchar(50)
		);
		
		IF @id_reservation IS NULL
		BEGIN
			RAISERROR('ID reservation nul', 10, -1);
			RETURN -1;
		END
		
		SELECT @date_d = date_debut, @date_f = date_fin FROM Reservation WHERE id = @id_reservation;
		
		SET @continuer = 'true';
		
		INSERT INTO @Veh_T(matricule)
			(SELECT matricule FROM Vehicule WHERE
					marque_modele = @marque
				AND serie_modele = @serie
				AND type_carburant_modele = @type_carburant
				AND portieres_modele = @portieres
				AND statut IN ('Louee', 'Disponible') );
		
		DECLARE veh_cursor CURSOR
			FOR SELECT * FROM @Veh_T;
		OPEN veh_cursor;
		
		FETCH NEXT FROM veh_cursor
			INTO @matricule;
			
		WHILE @@FETCH_STATUS = 0 AND @continuer = 'true'
		BEGIN
			SELECT @res = COUNT(r.id) FROM ReservationVehicule rv, Reservation r WHERE 
					rv.matricule_vehicule = @matricule
				AND r.id = rv.id_reservation
				AND (  ( @date_d < r.date_debut AND @date_f > r.date_debut )
					OR ( @date_d > r.date_debut AND @date_f < r.date_fin)
					OR ( @date_d < r.date_fin   AND @date_f > r.date_fin)
					)
			IF @res > 0
			BEGIN				
				FETCH NEXT FROM veh_cursor
					INTO @matricule;
			END
			ELSE
			BEGIN
				SET @continuer = 'false';
			END
		END
		
		CLOSE veh_cursor;
		DEALLOCATE veh_cursor;
		
		IF @continuer = 'false'
		BEGIN
			INSERT INTO ReservationVehicule(id_reservation, matricule_vehicule)
			VALUES (@id_reservation, @matricule);
			COMMIT TRANSACTION extendReservation
			PRINT('extendReservation OK');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('Pas d''extension possible avec le modele demande');
			RETURN -1;
		END
		
	END TRY
	BEGIN CATCH
		PRINT('extendReservation: ERROR');
		ROLLBACK TRANSACTION extendReservation
		RETURN -1;
	END CATCH
GO