------------------------------------------------------------
-- Fichier     : closeVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeVehicule	
GO

CREATE PROCEDURE dbo.closeVehicule
	@matricule			nvarchar(50) -- PK
AS
	BEGIN TRANSACTION closeVehicule
	BEGIN TRY
		COMMIT TRANSACTION closeVehicule
		PRINT('closeVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeVehicule: ERROR');
		ROLLBACK TRANSACTION closeVehicule
		RETURN -1;
	END CATCH
GO