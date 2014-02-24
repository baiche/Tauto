------------------------------------------------------------
-- Fichier     : Procedure_Catalogue
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
CREATE PROCEDURE TAuto.deleteCatalogue
	@nom 					nvarchar(50)
AS
	DELETE FROM Catalogue
	WHERE 	nom = @nom;
GO
