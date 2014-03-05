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

GO
CREATE PROCEDURE TAuto.disableVehicule
	@matricule 				nvarchar(50)
AS
	UPDATE Vehicule
	SET a_supprimer='true'
	WHERE 	matricule = @matricule;

GO