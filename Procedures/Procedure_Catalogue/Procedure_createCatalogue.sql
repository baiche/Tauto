------------------------------------------------------------
-- Fichier     : Procedure_createCatalogue
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
CREATE PROCEDURE TAuto.createCatalogue
	@nom 					nvarchar(50),
	@date_debut 			date,
	@date_fin				date
AS
	INSERT INTO Catalogue(
		nom,
		date_debut,
		date_fin
	)
	VALUES (
		@nom,
		@date_debut,
		@date_fin
	);

GO
