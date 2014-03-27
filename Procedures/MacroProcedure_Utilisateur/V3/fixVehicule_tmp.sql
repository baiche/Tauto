------------------------------------------------------------
-- Fichier     : fixVehicule_tmp.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie l'état du véhicule. 
--               On doit autoriser le passage de 'En panne' à 'Disponible'
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.fixVehicule_tmp', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixVehicule_tmp;
GO


CREATE PROCEDURE dbo.fixVehicule_tmp
	@matricule 	nvarchar(50)
AS
	BEGIN TRANSACTION fixVehicule_tmp
	BEGIN TRY

		IF(@matricule IS NULL)
		BEGIN
			PRINT('fixVehicule_tmp: ERROR Le matricule du vehicule n''est pas renseigne');
			ROLLBACK TRANSACTION fixVehicule_tmp
			RETURN -1;
		END
		
		IF not exists (SELECT 1 FROM Vehicule WHERE matricule = @matricule)	
		BEGIN
			PRINT('fixVehicule_tmp: ERROR Vehicule inexistant');
			ROLLBACK TRANSACTION fixVehicule_tmp
			RETURN -1
		END
		
		IF (SELECT statut FROM Vehicule WHERE matricule = @matricule) <> 'En panne'
		BEGIN
			PRINT('fixVehicule_tmp: ERROR Le status du vehicule n''est pas ''En panne'' !');
			ROLLBACK TRANSACTION fixVehicule_tmp
			RETURN -1
		END

		UPDATE Vehicule
		SET statut = 'Disponible'
		WHERE matricule = @matricule;

		COMMIT TRANSACTION fixVehicule
		PRINT('fixVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixVehicule_tmp: ERROR');
		ROLLBACK TRANSACTION fixVehicule_tmp
		RETURN -1;
	END CATCH
GO