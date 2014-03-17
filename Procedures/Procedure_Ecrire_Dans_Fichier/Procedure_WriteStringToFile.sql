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

IF OBJECT_ID ('dbo.WriteStringToFile', 'P') IS NOT NULL
	DROP PROCEDURE dbo.WriteStringToFile;
GO

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO

CREATE PROCEDURE dbo.WriteStringToFile
(@pv_path VARCHAR(100),
@pv_filename VARCHAR(100),
@pv_data VARCHAR(MAX),
@pi_result_code INT OUTPUT,
@pv_result_msg VARCHAR(2000) OUTPUT)
AS
BEGIN

SET NOCOUNT ON;

-- Declare variables
DECLARE @li_file_sytem_object INT;
DECLARE @li_result INT;
DECLARE @li_file_id INT;
DECLARE @lv_file_location VARCHAR(200);

-- Declare output variables
DECLARE @li_result_code INT;
DECLARE @lv_result_msg VARCHAR(MAX);

-- Initialise file path variable
SET @lv_file_location = @pv_path + '\' + @pv_filename;

-- Initialise output varaibles
SET @li_result_code = 0;
SET @lv_result_msg = NULL;

BEGIN TRY
-- Create a file system object
EXECUTE @li_result = sp_OACreate 'Scripting.FileSystemObject', @li_file_sytem_object OUT;

-- Check if the file system object was created
IF @li_result <> 0 
BEGIN
SET @li_result_code = -1;
SET @lv_result_msg = 'There was an error creating the Scripting.FileSystemObject.'; 
END;

-- Only proceed if the file system object was created successfully
IF @li_result = 0
BEGIN
-- Check if file exists
EXEC sp_OAMethod @li_file_sytem_object, 'FileExists', @li_result OUT, @lv_file_location; 
END;

-- Delete the file if it already exists
IF @li_result = 1
BEGIN
EXEC @li_result = sp_OAMethod @li_file_sytem_object, 'DeleteFile', NULL, @lv_file_location;
END;

-- Only proceed if there are no errors above
IF @li_result = 0
BEGIN
-- Open the file
EXECUTE @li_result = sp_OAMethod @li_file_sytem_object, 'OpenTextFile', @li_file_id OUT, @lv_file_location, 8, 1;

-- Return error if the file was not opened successfully
IF @li_result <> 0 
BEGIN
SET @li_result_code = -1;
SET @lv_result_msg = 'There was an error during opening the file location.';
END;
END;

-- Only proceed if the file was opened successfully
IF @li_result = 0 
BEGIN
-- Write data to file
EXECUTE @li_result = sp_OAMethod @li_file_id, 'WriteLine', NULL, @pv_data;

-- Return error if the data could not be written
IF @li_result <> 0 
BEGIN
SET @li_result_code = -1;
SET @lv_result_msg = 'There was an error during writing the data.';
END;
END;

-- Close the file no matter what happens above
EXEC @li_result = sp_OAMethod @li_file_id, 'Close';

-- Return error if the file could not be closed
IF @li_result <> 0 
BEGIN
SET @li_result_code = -1;
SET @lv_result_msg = 'There was an error closing the file.';
END;

-- Destory file object
EXEC @li_result = sp_OADestroy @li_file_id;

-- Destory file system object
EXEC @li_result = sp_OADestroy @li_file_sytem_object;
END TRY

-- Catch all exceptions here
BEGIN CATCH
SET @li_result_code = -1;
SET @lv_result_msg = ERROR_MESSAGE(); 
END CATCH;

-- Set output variables
SET @pi_result_code = @li_result_code;
SET @pv_result_msg = @lv_result_msg;

END
GO