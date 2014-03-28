------------------------------------------------------------
-- Fichier     : fixVehicule.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie l'état du véhicule.
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.fixVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixVehicule;
GO


CREATE PROCEDURE dbo.fixVehicule
	@matricule		nvarchar(50),
	@statut_future	nvarchar(50)
AS
	BEGIN TRANSACTION fixVehicule
	BEGIN TRY
		DECLARE @Status_actuel nvarchar(50);

		IF(@matricule IS NULL)
		BEGIN
			PRINT('fixVehicule: ERROR Le matricule du vehicule n''est pas renseigne');
			ROLLBACK TRANSACTION fixVehicule
			RETURN -1;
		END
		
		IF not exists (SELECT 1 FROM Vehicule WHERE matricule = @matricule)	
		BEGIN
			PRINT('fixVehicule: ERROR Vehicule inexistant');
			ROLLBACK TRANSACTION fixVehicule
			RETURN -1
		END
		
		IF(@statut_future IS NULL)
		BEGIN
			PRINT('fixVehicule: ERROR Le status souhaite du vehicule n''est pas renseigne');
			ROLLBACK TRANSACTION fixVehicule
			RETURN -1;
		END
		
		IF @statut_future NOT IN ('Disponible', 'Louee', 'En panne', 'Perdue')
		BEGIN
			PRINT('fixVehicule: ERROR Status inconnu');
			ROLLBACK TRANSACTION fixVehicule
			RETURN -1
		END
		
		SELECT @Status_actuel = statut FROM Vehicule WHERE matricule = @matricule;
		
		IF @statut_future = @Status_actuel
		BEGIN
			PRINT('fixVehicule: ERROR Le vehicule a deja ce status !');
			ROLLBACK TRANSACTION fixVehicule
			RETURN -1
		END
		
		-- ('Louee' ou 'En panne' ou 'Perdue') -> 'Disponible'
		
		IF @statut_future = 'Disponible'
		BEGIN
			UPDATE Vehicule
			SET statut = 'Disponible'
			WHERE matricule = @matricule;
		END
		
		-- ('Disponible' ou 'Louee') -> ('En panne' ou 'Perdue')
		
		IF @statut_future IN ('En panne', 'Perdue') AND @Status_actuel IN ('Disponible', 'Louee')
		BEGIN
			DECLARE @ReturnValue int;
			
			EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation @matricule, 1, NULL;
			IF ( @ReturnValue = -1)
			BEGIN
				PRINT('fixVehicule: ERROR pas reussi a remplacer le vehicule pour les reservations concernees !');
				ROLLBACK TRANSACTION fixVehicule
				RETURN -1
			END
		
			UPDATE Vehicule
			SET statut = @statut_future
			WHERE matricule = @matricule;
		END
		
		-- verifier le update
		
		SELECT @Status_actuel = statut FROM Vehicule WHERE matricule = @matricule;
		
		IF @statut_future <> @Status_actuel
		BEGIN
			PRINT('fixVehicule: ERROR L''operation a echouee !');
			ROLLBACK TRANSACTION fixVehicule
			RETURN -1
		END

		COMMIT TRANSACTION fixVehicule
		PRINT('fixVehicule OK');
		RETURN 1;
		
	END TRY
	BEGIN CATCH
		PRINT('fixVehicule: ERROR');
		ROLLBACK TRANSACTION fixVehicule
		RETURN -1;
	END CATCH
GO