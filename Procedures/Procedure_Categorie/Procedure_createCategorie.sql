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

IF OBJECT_ID ('dbo.createCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCategorie
GO


CREATE PROCEDURE dbo.createCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS
<<<<<<< HEAD

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
=======
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
>>>>>>> 40b334c4f066b4dcc2ed0e9590974cd10a6cf120
	
	BEGIN CATCH
		return -1	;
	END CATCH

GO
