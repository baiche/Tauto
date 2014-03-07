------------------------------------------------------------
-- Fichier     : Procedure_deleteCatalogue
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteCatalogue', 'P') IS NOT NULL
DROP PROCEDURE dbo.deleteCatalogue;
GO

CREATE PROCEDURE dbo.deleteCatalogue
	@nom 					nvarchar(50)
AS
	BEGIN TRY
		DELETE FROM Catalogue
		WHERE 	nom = @nom;
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
GO
