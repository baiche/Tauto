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
	BEGIN TRY
		if ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
		BEGIN
			UPDATE ContratLocation
			SET
				date_fin_effective = @date_fin_effective,
				extension = @extension
			WHERE id = @id;
			PRINT('ContratLocation mis à jour');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('updateContratLocation: ERROR, introuvable');
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('updateContratLocation: ERROR');
		RETURN -1;
	END CATCH
GO