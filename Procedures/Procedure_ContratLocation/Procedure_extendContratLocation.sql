------------------------------------------------------------
-- Fichier     : Procedure_extendContratLocation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Etend un contrat de location. Renvoie 1 en cas de succès, -1 aurtement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendContratLocation

GO
CREATE PROCEDURE dbo.extendContratLocation
	@id						int,
	@date_fin_effective 	datetime,
	@extension 				int
AS
	BEGIN TRANSACTION extendContratLocation
	BEGIN TRY
		if ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
		BEGIN
			UPDATE ContratLocation
			SET
				extension = @extension
			WHERE id = @id;
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