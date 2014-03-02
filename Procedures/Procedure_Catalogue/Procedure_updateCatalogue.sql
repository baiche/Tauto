------------------------------------------------------------
-- Fichier     : Procedure_updateCatalogue
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
CREATE PROCEDURE TAuto.updateCatalogue
	@nom 					nvarchar(50),
	@date_debut 			date,
	@date_fin				date
AS
	UPDATE Catalogue
	SET nom = @nom,
		date_debut = @date_debut,
		date_fin = @date_fin	
	WHERE 	nom = @nom;

GO