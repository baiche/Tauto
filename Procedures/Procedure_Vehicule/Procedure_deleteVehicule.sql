------------------------------------------------------------
-- Fichier     : Procedure_deleteVehicule
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE TAuto.deleteVehicule
	@matricule 					nvarchar(50)
AS
	DELETE FROM Vehicule
	WHERE 	matricule = @matricule;
GO
