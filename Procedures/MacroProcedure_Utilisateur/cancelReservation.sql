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
	@matricule		VARCHAR(50), -- PK
	@date_debut		datetime,
	@date_fin		datetime
AS
	BEGIN TRANSACTION cancelReservation
	BEGIN TRY

	IF (SELECT COUNT(*) FROM ReservationVehicule  WHERE matricule_vehicule=@matricule)=0
		BEGIN
			PRINT('cette reservation n''existe pas! ')
			return -1;
		END  
	ELSE

	DECLARE @res INT;
		SET @res = (SELECT  id_reservation  FROM ReservationVehicule WHERE matricule_vehicule=@matricule);
		
		EXEC annulerReservation @res;
	
		DELETE FROM ReservationVehicule WHERE matricule_vehicule=@matricule;

	
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