------------------------------------------------------------
-- Fichier     : checkReservationTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.checkReservationTrigger', 'P') IS NOT NULL
	DROP PROCEDURE dbo.checkReservationTrigger	
GO

CREATE PROCEDURE dbo.checkReservationTrigger
AS
	BEGIN TRANSACTION checkReservationTrigger
	BEGIN TRY
		COMMIT TRANSACTION checkReservationTrigger
		PRINT('checkReservationTrigger OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('checkReservationTrigger: ERROR');
		ROLLBACK TRANSACTION checkReservationTrigger
		RETURN -1;
	END CATCH
GO