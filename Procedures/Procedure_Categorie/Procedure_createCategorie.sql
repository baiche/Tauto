------------------------------------------------------------
-- Fichier     : Procedure_createCategorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Baiche Mourad ( ajout du champs a_supprimer ) 
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

	BEGIN TRY
		BEGIN
			INSERT INTO Categorie(
			nom, 
			description, 
			nom_typepermis,
			a_supprimer
			)
			VALUES (
			@nom,
			@description,
			@nom_typepermis,
			'false'
			);
		END
		
		return @nom;
		
	END TRY
	
	BEGIN CATCH
		return -1	;
	END CATCH

GO
