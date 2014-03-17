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

IF OBJECT_ID ('dbo.openFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.openFile;
GO
	sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO

CREATE PROCEDURE dbo.openFile
	@FileName nvarchar(250), -- Name of the file to create
	@FS int OUTPUT, -- File system object reference
	@FileID int OUTPUT -- File id reference
AS
	BEGIN

	
		SET NOCOUNT ON

		DECLARE @OLEResult int

		-- Create scripting object
		EXECUTE @OLEResult = sp_OACreate 'Scripting.FileSystemObject', @FS OUT 
		
		IF @OLEResult <> 0 RETURN -1

			
		--Ouvre le fichier (2 = ForWriting, 8 = ForAppending)
		EXECUTE @OLEResult = sp_OAMethod @FS, 'OpenTextFile', @FileID OUT, @FileName, 2, 1
		PRINT('on est dans openFile '+CAST(@OLEResult as varchar(10)));
		PRINT(@OLEResult);
		IF @OLEResult <> 0 
			RETURN -1
			
		PRINT('openFile fini OK');	
	END
GO

