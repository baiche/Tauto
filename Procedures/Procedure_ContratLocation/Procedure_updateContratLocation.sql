------------------------------------------------------------
-- Fichier     : Procedure_updateContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un contrat de location. Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateContratLocation
GO

CREATE PROCEDURE dbo.updateContratLocation
	@id						int,
	@date_fin_effective 	datetime,
	@extension 				int
AS
	/*BEGIN TRANSACTION updateContratLocation
	BEGIN TRY		
		IF ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
		BEGIN*/
			IF (@date_fin_effective IS NOT NULL)
			BEGIN
				IF ( (SELECT date_debut FROM ContratLocation WHERE id = @id) > @date_fin_effective)
				BEGIN
					/*PRINT('updateContratLocation: ERROR, date de fin réelle inférieure à la date de début');
					ROLLBACK TRANSACTION updateContratLocation
					RETURN -1;*/
					RAISERROR('Modification de des dates impossibles, debut > fin', 10, 1);
				END
				UPDATE ContratLocation
				SET
					date_fin_effective = @date_fin_effective
				WHERE id = @id;
			END
			
			IF (@extension IS NOT NULL)
			BEGIN
				UPDATE ContratLocation
				SET
					extension = @extension
				WHERE id = @id;
			END
			
			RETURN 1;
			/*PRINT('ContratLocation mis à jour');
			COMMIT TRANSACTION updateContratLocation
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('updateContratLocation: ERROR, introuvable');
			ROLLBACK TRANSACTION updateContratLocation
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('updateContratLocation: ERROR');
		ROLLBACK TRANSACTION updateContratLocation
		RETURN -1;
	END CATCH*/
GO