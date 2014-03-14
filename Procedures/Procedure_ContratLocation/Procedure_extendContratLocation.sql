------------------------------------------------------------
-- Fichier     : Procedure_extendContratLocation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Etend un contrat de location. Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendContratLocation
GO

CREATE PROCEDURE dbo.extendContratLocation
	@id						int,
	@extension 				int
AS
	BEGIN TRANSACTION extendContratLocation
	BEGIN TRY
		DECLARE @res int;
		
		IF ( (SELECT date_fin_effective FROM ContratLocation WHERE id = @id) IS NOT NULL)
		BEGIN
			PRINT('extendContratLocation: ERROR, impossible à étendre, date de fin réelle insérée');
			ROLLBACK TRANSACTION extendContratLocation
			RETURN -1;
		END
		
		EXEC @res = dbo.canExtendContratLocation
			@id_contrat_location = @id,
			@nb_jours = @extension
			
		IF ( @res = 1)
		BEGIN
			EXEC dbo.updateContratLocation
				@id = @id,
				@date_fin_effective = null,
				@extension = @extension
			PRINT('ContratLocation étendu');
			COMMIT TRANSACTION extendContratLocation
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('extendContratLocation: ERROR, introuvable');
			ROLLBACK TRANSACTION extendContratLocation
			RETURN -1;
		END
	END TRY	
	BEGIN CATCH
		PRINT('extendContratLocation: ERROR');
		ROLLBACK TRANSACTION extendContratLocation
		RETURN -1;
	END CATCH
GO