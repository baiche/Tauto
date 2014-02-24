------------------------------------------------------------
-- Fichier     : Procedure_Categorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.createCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS
	INSERT INTO Categorie(
		nom, 
		description, 
		nom_typeperms
	)
	VALUES (
		@nom,
		@description,
		@nom_typepermis
	);
	
GO
CREATE PROCEDURE dbo.updateCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS
	UPDATE Categorie
	SET nom = @nom, description = @description, nom_typepermis = @nom_typepermis
	WHERE nom = @nom;
	
GO
CREATE PROCEDURE dbo.deleteCategorie
	@nom					nvarchar(50),
AS
	DELETE FROM Categorie
	WHERE nom = @nom;
GO