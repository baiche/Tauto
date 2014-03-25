------------------------------------------------------------
-- Fichier     : extendContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendContratLocation	
GO

CREATE PROCEDURE dbo.extendContratLocation
	@idContratLocation	int, -- PK
	@extension			int
AS
	BEGIN TRANSACTION extendContratLocation
	BEGIN TRY
		DECLARE @date_f datetime, @date_f_ext datetime, @matricule nvarchar(50), @res int;
		DECLARE @Vehicule_T TABLE(
			matricule nvarchar(50)
		);
		
		IF @extension <= 0
		BEGIN
			RAISERROR('L''extension doit etre positive', 10, -1);
			RETURN -1;
		END
		
		SELECT @date_f = date_fin FROM ContratLocation WHERE id = @idContratLocation;
		SET @date_f_ext = DATEADD(day, @extension, @date_f);
		INSERT INTO @Vehicule_T (matricule)
			(SELECT matricule_vehicule FROM Location WHERE id_contratLocation = @idContratLocation);
		
		DECLARE veh_cursor CURSOR
			FOR SELECT * FROM @Vehicule_T;
		OPEN veh_cursor;
		FETCH NEXT FROM veh_cursor
			INTO @matricule;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (SELECT COUNT(r.id) FROM Reservation r, ReservationVehicule rv WHERE
					rv.matricule_vehicule = @matricule
				AND rv.id_reservation = r.id
				AND r.date_debut <= @date_f_ext) > 0
			BEGIN
				EXEC @res = dbo.findOtherVehicule
					@matricule = @matricule,
					@itMustBeDone = 'false',
					@date_fin = @date_f_ext;
				IF @res = -1
				BEGIN
					RAISERROR('Extension impossible, chevauchement sur une reservation', 10, -1);
					RETURN -1;
				END
			END
			FETCH NEXT FROM veh_cursor
				INTO @matricule;
		END
		
		CLOSE veh_cursor;
		DEALLOCATE veh_cursor;
		
		EXEC dbo.updateContratLocation
			@id = @idContratLocation,
			@date_fin_effective = NULL,
			@extension = @extension;
		
		COMMIT TRANSACTION extendContratLocation
		PRINT('extendContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('extendContratLocation: ERROR');
		ROLLBACK TRANSACTION extendContratLocation
		RETURN -1;
	END CATCH
GO