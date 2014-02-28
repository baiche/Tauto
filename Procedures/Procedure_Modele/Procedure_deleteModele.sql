------------------------------------------------------------
-- Fichier     : Procedure_deleteModele
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO

-- Cette procedure rend le modele inactif sans reellement le delete pour eviter la perte d'information

CREATE PROCEDURE dbo.deleteModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@portieres 				tinyint
AS
	UPDATE Modele
	SET actif = 'false'
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;
GO