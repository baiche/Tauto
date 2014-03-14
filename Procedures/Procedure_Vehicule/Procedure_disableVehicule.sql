------------------------------------------------------------
-- Fichier     : Procedure_disableVehicule
-- Date        : 04/04/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.disableVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableVehicule
GO

CREATE PROCEDURE dbo.disableVehicule
	@matricule 				nvarchar(50)
AS
	UPDATE Vehicule
	SET a_supprimer='true'
	WHERE 	matricule = @matricule;

GO