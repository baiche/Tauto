------------------------------------------------------------
-- Fichier     : Procedure_canExtendContratLocation
-- Date        : 08/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : indique si nous pouvons étendre la durée du 
--				 contratLocation pour n jours.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeFile;
GO

CREATE PROCEDURE dbo.closeFile
	@FS int, -- File system object reference
	@FileID int -- File id reference
AS
	BEGIN
		SET NOCOUNT ON

		DECLARE @OLEResult int

		-- Close file
		EXECUTE @OLEResult = sp_OADestroy @FileID
		EXECUTE @OLEResult = sp_OADestroy @FS

	END
GO