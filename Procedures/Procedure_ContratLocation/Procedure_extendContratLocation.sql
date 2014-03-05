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
AS
	DECLARE	@id						int,
	DECLARE	@date_fin_effective 	datetime,
	DECLARE	@extension 				int
BEGIN
	if ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
	BEGIN
		UPDATE ContratLocation
		SET
			extension = @extension
		WHERE id = @id;
		PRINT('ContratLocation étendu');
		RETURN 1;
	END
	ELSE
	BEGIN
		PRINT('ContratLocation: ERROR, introuvable');
		RETURN -1;
	END
	
END
GO