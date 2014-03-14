------------------------------------------------------------
-- Fichier     : Procedure_updateCategorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateCategorie
GO

CREATE PROCEDURE dbo.updateCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS
	UPDATE Categorie
	SET description = @description, nom_typepermis = @nom_typepermis
	WHERE nom = @nom;
	
GO
