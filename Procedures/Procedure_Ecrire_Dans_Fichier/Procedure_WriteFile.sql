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

IF OBJECT_ID ('dbo.writeFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.writeFile;
GO

CREATE PROCEDURE dbo.writeFile
	@FileID int, -- File id reference
	@Text nvarchar(4000), -- Text to write
	@NewLine int = 1
AS
	BEGIN
		SET NOCOUNT ON

		DECLARE @OLEResult int

		-- Write the text in the file
		IF @NewLine = 1
		BEGIN
			EXECUTE @OLEResult = sp_OAMethod @FileID, 'WriteLine', Null, @Text
		END
		ELSE
		BEGIN
			EXECUTE @OLEResult = sp_OAMethod @FileID, 'Write', Null, @Text
		END

		IF @OLEResult <> 0 RETURN -1

	END
GO
