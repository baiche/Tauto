------------------------------------------------------------
-- Fichier     : Procedure_updatePrixModele
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

-- Cette procedure permet de modifier le prix d'un modele

CREATE PROCEDURE dbo.updatePrixModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@prix 					money,
	@portieres 				tinyint
AS
	UPDATE Modele
	SET prix = @prix
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;

GO