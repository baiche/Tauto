------------------------------------------------------------
-- Fichier     : Procedure_disableModele
-- Date        : 04/04/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.disableModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableModele
GO

-- Cette procedure permet de desactiver un modele

CREATE PROCEDURE dbo.disableModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@portieres 				tinyint
AS
	UPDATE Modele
	SET a_supprimer='true'
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;

GO