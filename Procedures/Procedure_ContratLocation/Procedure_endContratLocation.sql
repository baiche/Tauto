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
		if ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
		BEGIN
			UPDATE ContratLocation
			SET
				date_fin_effective = GETDATE()
			WHERE id = @id;
			PRINT('ContratLocation terminé');
			COMMIT TRANSACTION endContratLocation
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('endContratLocation: ERROR, impossible à terminer car pas trouvé');
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