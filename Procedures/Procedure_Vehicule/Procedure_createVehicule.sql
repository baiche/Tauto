------------------------------------------------------------
-- Fichier     : Procedure_createVehicule
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Baiche Mourad ( ajout de la colone a_supprimer )
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE TAuto.createVehicule
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
		type_carburant_modele,
		a_supprimer
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
		@type_carburant_modele,
		'false'
	);

GO
