------------------------------------------------------------
-- Fichier     : Procedure_notReservedVehicle1
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique si un vehicule n'est pas déjà réservé 
--               entre une date de début et une date de fin
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.notReservedVehicle1', 'P') IS NOT NULL
	DROP PROCEDURE dbo.notReservedVehicle1;
	PRINT('PROCEDURE dbo.notReservedVehicle1 supprimée');
GO


CREATE PROCEDURE dbo.notReservedVehicle1
	@matricule 	nvarchar(50),
	@dateDebut	datetime,
	@dateFin	datetime
AS
	BEGIN TRY
		IF exists
			(SELECT 1
			FROM ReservationVehicule rv
			INNER JOIN Reservation r
			ON rv.id_reservation = r.id
			WHERE 
					rv.matricule_vehicule = @matricule
					AND 
					(r.date_debut between @dateDebut AND @dateFin
						OR r.date_fin between @dateDebut AND @dateFin
						OR (r.date_debut <= @dateDebut AND r.date_fin >= @dateFin)
					)
			)	
		BEGIN
			RETURN -1
		END
		
		ELSE
		BEGIN
			RETURN 1
		END
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la procedure dbo.notReservedVehicle1',10,1)
	END CATCH
GO

PRINT('PROCEDURE dbo.notReservedVehicle1 créée');
GO
