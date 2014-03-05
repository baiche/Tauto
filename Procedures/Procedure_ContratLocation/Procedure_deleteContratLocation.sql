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
AS
	DECLARE	@id						int
BEGIN
	DECLARE @Output TABLE (
		id INT
	);
	
	IF (
		(SELECT date_fin_effective FROM ContratLocation WHERE id = @id)
		IS NULL
	)
	BEGIN
		PRINT('ContratLocation: ERROR, non terminé');
		RETURN -1;
	END
	
	DELETE 
	OUTPUT DELETED.id INTO @Output
	FROM ContratLocation
	WHERE id = @id;
	
	IF ( (SELECT COUNT(*) FROM @Output) = 1)
	BEGIN
		PRINT('ContratLocation supprimé');
		RETURN 1;
	END
	ELSE
	BEGIN
		PRINT('ContratLocation: ERROR, pas supprimé');
		RETURN -1;
	END
END
GO