------------------------------------------------------------
-- Fichier     : Procedure_createCatalogue
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCatalogue', 'P') IS NOT NULL
DROP PROCEDURE dbo.createCatalogue;
GO

CREATE PROCEDURE dbo.createCatalogue
	@nom 					nvarchar(50),
	@date_debut 			date,
	@date_fin				date
AS
	BEGIN TRY
		INSERT INTO Catalogue(
			nom,
			date_debut,
			date_fin
		)
		VALUES (
			@nom,
			@date_debut,
			@date_fin
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
GO
