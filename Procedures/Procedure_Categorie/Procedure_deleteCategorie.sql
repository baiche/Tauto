------------------------------------------------------------
-- Fichier     : Procedure_deleteCategorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteCategorie
GO

CREATE PROCEDURE dbo.deleteCategorie
	@nom					nvarchar(50)
AS
	DELETE FROM Categorie
	WHERE nom = @nom;
GO
