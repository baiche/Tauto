------------------------------------------------------------
-- Fichier     : Procedure_endContratLocation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met fin à un contrat de location si ce dernier 
--				 existe. Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;


IF OBJECT_ID ('dbo.endContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.endContratLocation
	
GO
CREATE PROCEDURE dbo.endContratLocation
	@id						int
AS
	BEGIN TRANSACTION endContratLocation
	BEGIN TRY
		DECLARE @LOCATION_T TABLE (
			id 					int,
			matricule_vehicule 	nvarchar(50),
			km					int
		)
		DECLARE @kmTot int, @kmLoc int, @kmVehicule int, @matricule nvarchar(50), @idContrat int;
		
		if ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
		BEGIN
		
			UPDATE ContratLocation
			SET
				date_fin_effective = GETDATE()
			WHERE id = @id;
			
			INSERT INTO @LOCATION_T(id, matricule_vehicule, km)
				(SELECT id, matricule_vehicule, km
				FROM Location
				WHERE id_contratLocation = @id);
				
			DECLARE contratLoc CURSOR
				FOR SELECT * FROM @LOCATION_T
				
			OPEN contratLoc
			FETCH NEXT FROM contratLoc INTO @idContrat, @matricule, @kmLoc;
				
			WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN TRY
					SET @kmTot = 0;
					SELECT @kmVehicule = kilometrage FROM Vehicule WHERE matricule = @matricule;
					SET @kmTot = @kmVehicule + @kmLoc;
					
					UPDATE Vehicule 
					SET
						kilometrage = @kmTot
					WHERE matricule = @matricule;
				END TRY
				BEGIN CATCH
					PRINT('ContratLocation: ERROR, vehicule ' + @matricule + ' pas mis à jour');
				END CATCH
				FETCH NEXT FROM contratLoc INTO @idContrat, @matricule, @kmLoc;
			END
				
			CLOSE contratLoc;
			DEALLOCATE contratLoc;
			
			PRINT('ContratLocation terminé');
			COMMIT TRANSACTION endContratLocation
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('endContratLocation: ERROR, impossible à terminer car le tuple n''a pas été trouvé');
			ROLLBACK TRANSACTION endContratLocation
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('endContratLocation: ERROR');
		ROLLBACK TRANSACTION endContratLocation
		RETURN -1;
	END CATCH
GO