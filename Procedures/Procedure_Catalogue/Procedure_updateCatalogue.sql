------------------------------------------------------------
-- Fichier     : Procedure_updateCatalogue
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateCatalogue', 'P') IS NOT NULL
DROP PROCEDURE dbo.updateCatalogue;
GO

CREATE PROCEDURE dbo.updateCatalogue
	@nom 					nvarchar(50),
	@date_debut 			date,
	@date_fin				date
AS
	BEGIN TRY
		UPDATE Catalogue
		SET nom = @nom,
			date_debut = @date_debut,
			date_fin = @date_fin	
		WHERE 	nom = @nom;
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
GO
