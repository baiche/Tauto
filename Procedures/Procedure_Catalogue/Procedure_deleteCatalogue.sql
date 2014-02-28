------------------------------------------------------------
-- Fichier     : Procedure_deleteCatalogue
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
CREATE PROCEDURE TAuto.deleteCatalogue
	@nom 					nvarchar(50)
AS
	DELETE FROM Catalogue
	WHERE 	nom = @nom;
GO
