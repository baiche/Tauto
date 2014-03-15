------------------------------------------------------------
-- Fichier     : findOtherVehiculeWithElevation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.findOtherVehiculeWithElevation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.findOtherVehiculeWithElevation	
GO

CREATE PROCEDURE dbo.findOtherVehiculeWithElevation
	@matricule 			nvarchar(50), -- PK
	@date_fin			date
AS
	BEGIN TRY
		PRINT('findOtherVehiculeWithElevation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('findOtherVehiculeWithElevation: ERROR');
		RETURN -1;
	END CATCH
GO