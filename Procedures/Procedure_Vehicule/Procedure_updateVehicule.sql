------------------------------------------------------------
-- Fichier     : Procedure_updateVehicule
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : baiche mourad
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateVehicule
GO

CREATE PROCEDURE dbo.updateVehicule
	@matricule 				nvarchar(50),
	@kilometrage 			int,
	@couleur				nvarchar(50),
	@statut					nvarchar(50),
	@num_serie				nvarchar(50),
	@marque_modele			nvarchar(50),
	@serie_modele			nvarchar(50),
	@portieres_modele		tinyint,
	@type_carburant_modele	nvarchar(50)
AS
	UPDATE Vehicule
	SET kilometrage = @kilometrage,
		couleur = @couleur,	
		statut = @statut,
		num_serie = @num_serie,
		marque_modele = @marque_modele,
		serie_modele = @serie_modele,
		portieres_modele = @portieres_modele,
		type_carburant_modele = @type_carburant_modele
	WHERE 	matricule = @matricule;

GO