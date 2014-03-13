------------------------------------------------------------
-- Fichier     : Procedure_createCategorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCategorie
GO


CREATE PROCEDURE dbo.createCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS
	INSERT INTO Categorie(
		nom, 
		description, 
		nom_typepermis
	)
	VALUES (
		@nom,
		@description,
		@nom_typepermis
	);
	
GO
