------------------------------------------------------------
-- Fichier     : Procedure_deleteContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime un contrat de location. Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteContratLocation
	
GO
CREATE PROCEDURE dbo.deleteContratLocation
	@id						int
AS
	BEGIN TRANSACTION deleteContratLocation
	BEGIN TRY
		DECLARE @Output TABLE (
			id INT
		);
		
		DECLARE @LOCATION_T TABLE(
			id int
		);
		DECLARE @idLoc int, @res int;
		
		IF (
			(SELECT date_fin_effective FROM ContratLocation WHERE id = @id)
			IS NULL
		)
		BEGIN
			PRINT('deleteContratLocation: ERROR, non terminé');
			ROLLBACK TRANSACTION deleteContratLocation
			RETURN -1;
		END
		
		INSERT INTO @LOCATION_T(id)
			(SELECT id
			FROM Location
			WHERE id_contratLocation = @id);
		
		DECLARE contratLoc CURSOR
			FOR SELECT * FROM @LOCATION_T
		
		OPEN contratLoc
		FETCH NEXT FROM contratLoc INTO @idLoc;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC @res = dbo.deleteLocation @idLoc;
			IF (@res = 0) -- C'est ok
			BEGIN
				PRINT('ContratLocation: Location ' + @idLoc + ' supprimé');
			END
			ELSE -- Sinon on annule tout
			BEGIN
				PRINT('ContratLocation: Location ' + @idLoc + ' impossible à supprimer');
				ROLLBACK TRANSACTION deleteContratLocation;
				RETURN -1;
			END
			FETCH NEXT FROM contratLoc INTO @idLoc;
		END
		
		CLOSE contratLoc;
		DEALLOCATE contratLoc; 
		
		DELETE ContratLocation
		OUTPUT DELETED.id INTO @Output
		WHERE id = @id;
		
		IF ( (SELECT COUNT(*) FROM @Output) = 1)
		BEGIN
			PRINT('ContratLocation supprimé');
			COMMIT TRANSACTION deleteContratLocation
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('deleteContratLocation: ERROR, pas supprimé');
			ROLLBACK TRANSACTION deleteContratLocation
			RETURN -1;
		END
	END TRY	
	BEGIN CATCH
		PRINT('deleteContratLocation: ERROR');
		ROLLBACK TRANSACTION deleteContratLocation
		RETURN -1;
	END CATCH
GO