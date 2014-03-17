------------------------------------------------------------
-- Fichier     : Procedure_disableCategorie
-- Date        : 04/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : Baiche Mourad
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.disableCategorie
	@nom					nvarchar(50)
AS
	UPDATE Categorie
	SET a_supprimer='true'
	WHERE nom = @nom;
	
GO
