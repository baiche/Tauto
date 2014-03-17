------------------------------------------------------------
-- Fichier     : makeCatalogue.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Jean-Luc Amitousa Mankoy
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCatalogue	
GO

CREATE PROCEDURE dbo.makeCatalogue
	@nom 					nvarchar(50), -- PK
	@date_debut 			date, -- nullable, la date par défaut est la date du jour
	@date_fin		 		date  -- vérifier debut <= fin
AS
	BEGIN TRANSACTION makeCatalogue
	BEGIN TRY
		IF ( (SELECT COUNT(*) FROM Catalogue WHERE nom = @nom) = 1)
		BEGIN
			PRINT('makeCatalogue: nom pris');
			RETURN -1;
		END
		
		IF ( @date_debut IS NULL)
		BEGIN
			SET @date_debut = GETDATE();
		END
		
		IF (@date_debut < @date_fin)
		BEGIN
			EXEC dbo.createCatalogue @nom, @date_debut, @date_fin;
			COMMIT TRANSACTION makeCatalogue
			PRINT('makeCatalogue OK');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('makeCatalogue: ERROR, date de fin anterieure');
			ROLLBACK TRANSACTION makeCatalogue
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('makeCatalogue: ERROR');
		ROLLBACK TRANSACTION makeCatalogue
		RETURN -1;
	END CATCH
GO