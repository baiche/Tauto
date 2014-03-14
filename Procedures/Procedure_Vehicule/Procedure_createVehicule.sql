------------------------------------------------------------
-- Fichier     : Procedure_createVehicule
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createVehicule
GO

CREATE PROCEDURE dbo.createVehicule
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
	INSERT INTO Vehicule(
		matricule,
		kilometrage,
		couleur,
		statut,
		num_serie,
		marque_modele,
		serie_modele,
		portieres_modele,
		type_carburant_modele
	)
	VALUES (
		@matricule,
		@kilometrage,
		@couleur,
		@statut,
		@num_serie,
		@marque_modele,
		@serie_modele,
		@portieres_modele,
		@type_carburant_modele
	);

GO
