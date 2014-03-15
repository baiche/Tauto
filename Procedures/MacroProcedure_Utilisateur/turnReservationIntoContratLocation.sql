------------------------------------------------------------
-- Fichier     : turnReservationIntoContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.turnReservationIntoContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.turnReservationIntoContratLocation	
GO

CREATE PROCEDURE dbo.turnReservationIntoContratLocation
	@id_reservation 		int
AS
	BEGIN TRANSACTION turnReservationIntoContratLocation
	BEGIN TRY
		COMMIT TRANSACTION turnReservationIntoContratLocation
		PRINT('turnReservationIntoContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('turnReservationIntoContratLocation: ERROR');
		ROLLBACK TRANSACTION turnReservationIntoContratLocation
		RETURN -1;
	END CATCH
GO