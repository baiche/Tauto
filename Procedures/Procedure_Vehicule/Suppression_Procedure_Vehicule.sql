------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Vehicule
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les 
--				vehicules
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createVehicule
GO

IF OBJECT_ID ('dbo.deleteVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteVehicule
GO

IF OBJECT_ID ('dbo.disableVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableVehicule
GO

IF OBJECT_ID ('dbo.setKilometrageVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.setKilometrageVehicule
GO

IF OBJECT_ID ('dbo.setStatutVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.setStatutVehicule
GO

IF OBJECT_ID ('dbo.updateVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateVehicule
GO
