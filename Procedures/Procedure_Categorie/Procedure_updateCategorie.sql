------------------------------------------------------------
-- Fichier     : Procedure_updateCategorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Baiche Mourad ( ajout d'un try catch et du return true | false
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.updateCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS
BEGIN TRY
	UPDATE Categorie
	SET description = @description, nom_typepermis = @nom_typepermis
	WHERE nom = @nom;
	return 'true';
END TRY 

BEGIN CATCH
	return 'false';
END CATCH
GO
