------------------------------------------------------------
-- Fichier     : cancelReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.cancelReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.cancelReservation	
GO

CREATE PROCEDURE dbo.cancelReservation
	@id_reservation 		int -- PK
AS
	BEGIN TRANSACTION cancelReservation
	BEGIN TRY
	
	IF (SELECT COUNT(*) FROM Reservation r WHERE r.id=@id_reservation)=0
		BEGIN
			PRINT('cette reservation n''existe pas! ')
			return -1;
		END  
	ELSE
		EXEC cancelReservation @id_reservation;
		DELETE FROM ReservationVehicule WHERE id_reservation=@id_reservation;
		
		COMMIT TRANSACTION cancelReservation
		PRINT('cancelReservation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('cancelReservation: ERROR');
		ROLLBACK TRANSACTION cancelReservation
		RETURN -1;
	END CATCH
GO