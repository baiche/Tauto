------------------------------------------------------------
-- Fichier     : Procedure_setKilometrageVehicule
-- Date        : 04/04/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.setKilometrageVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.setKilometrageVehicule
GO

CREATE PROCEDURE dbo.setKilometrageVehicule
	@matricule 				nvarchar(50),
	@kilometrage 			int
	
AS
	UPDATE Vehicule
	SET	kilometrage = @kilometrage
	WHERE 	matricule = @matricule;

GO