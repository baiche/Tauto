------------------------------------------------------------
-- Fichier     : Procedure_isDisponible1
-- Date        : 16/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique si un vehicule est disponible pour une reservation  
--               entre une date de début et une date de fin
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.isDisponible1', 'P') IS NOT NULL
	DROP PROCEDURE dbo.isDisponible1;
	PRINT('PROCEDURE dbo.isDisponible1 supprimée');
GO


CREATE PROCEDURE dbo.isDisponible1
	@matricule 	nvarchar(50),
	@dateDebut	datetime,
	@dateFin	datetime
AS
	BEGIN TRY
		DECLARE @VehiculeStatus nvarchar(50);
		
		SELECT @VehiculeStatus = statut FROM Vehicule WHERE matricule = @matricule;
		
		IF @VehiculeStatus = 'Perdue'
		BEGIN
			PRINT('-- ' + @matricule + ' Perdue');
			RETURN -1
		END
		
		IF @VehiculeStatus = 'En panne'
		BEGIN
			PRINT('-- ' + @matricule + ' En panne');
			RETURN -1
		END
		
		IF @VehiculeStatus = 'Louee'
		BEGIN
			DECLARE @DateFinLocation datetime;
			SELECT @DateFinLocation = cl.date_fin 
			FROM Location l
			INNER JOIN ContratLocation cl
			ON l.id_contratLocation = cl.id
			WHERE l.matricule_vehicule = @matricule AND cl.date_fin >= @dateDebut;
			
			IF (@DateFinLocation IS NOT NULL)	
			BEGIN
				PRINT('-- ' + @matricule + ' Louee jusqu au ' + CONVERT(varchar, @DateFinLocation, 121));
				RETURN -1
			END
		END
		
		DECLARE @ReturnValue int;
		EXEC @ReturnValue = dbo.notReservedVehicle1 
				@matricule,
				@dateDebut,
				@dateFin
		IF ( @ReturnValue = 1 )
		BEGIN
			PRINT('-- ' + @matricule + ' Disponible pour ces dates');
			RETURN 1;
		END
		
		ELSE
		BEGIN
			PRINT('-- ' + @matricule + ' Réservé pour ces dates');
			RETURN -1
		END
		
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la procedure dbo.isDisponible1',10,1)
	END CATCH
GO

PRINT('PROCEDURE dbo.isDisponible1 créée');
GO
