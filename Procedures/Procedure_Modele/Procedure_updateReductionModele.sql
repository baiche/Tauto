------------------------------------------------------------
-- Fichier     : Procedure_updateReductionModele
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateReductionModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateReductionModele
GO

-- Cette procedure permet de modifier le pourcentage de reduction du prix du modele

CREATE PROCEDURE dbo.updateReductionModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@reduction 				tinyint,
	@portieres 				tinyint
AS
	UPDATE Modele
	SET reduction = @reduction
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;
		
GO