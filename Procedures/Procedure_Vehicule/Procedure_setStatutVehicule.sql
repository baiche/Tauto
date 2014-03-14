------------------------------------------------------------
-- Fichier     : Procedure_setStatutVehicule
-- Date        : 04/04/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------


USE TAuto_IBDR;

IF OBJECT_ID ('dbo.setStatutVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.setStatutVehicule
GO

CREATE PROCEDURE dbo.setStatutVehicule
	@matricule 				nvarchar(50),
	@statut					nvarchar(50)
	
AS
	UPDATE Vehicule
	SET statut = @statut

	WHERE 	matricule = @matricule;

GO