------------------------------------------------------------
-- Fichier     : fixVehicule.sql
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

IF OBJECT_ID ('dbo.fixVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.isDisponible1;
	PRINT('PROCEDURE dbo.fixVehicule supprimée');
GO


CREATE PROCEDURE dbo.fixVehicule
	@matricule 	nvarchar(50)
AS
	BEGIN TRANSACTION fixVehicule
	BEGIN TRY

		-- in progress ...

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