------------------------------------------------------------
-- Fichier     : makeModele.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeModele	
GO

CREATE PROCEDURE dbo.makeModele
	@nom_catalogue			nvarchar(50), -- FK
	@nom_categorie			nvarchar(50), -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint,  -- PK
	@annee 					int,
	@prix 					money,
	@reduction 				tinyint	-- nullable
AS
	BEGIN TRANSACTION makeModele
	BEGIN TRY
	
	IF(SELECT count(*) FROM Catalogue c WHERE c.nom=@nom_catalogue)=0
			BEGIN 
			PRINT ('Le Catalogue n''existe pas ')
			return -1 ;
			END
		ELSE
		
		BEGIN
			IF(SELECT count(*) FROM CatalogueCategorie cc WHERE cc.nom_categorie=@nom_categorie AND cc.nom_catalogue=@nom_catalogue)=0
			BEGIN 
			PRINT ('Cette categorie n''existe pas dans ce catalogue ')
			return -1 ;
			END
		
			ELSE
				BEGIN
				EXEC createModele @marque,@serie,@type_carburant,@annee,@prix,@reduction,@portieres;
				EXEC addModeleToCategorie @marque,@serie,@type_carburant,@portieres,@nom_categorie;
				END
		END
			
	
		COMMIT TRANSACTION makeModele
		PRINT('makeModele OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeModele: ERROR');
		ROLLBACK TRANSACTION makeModele
		RETURN -1;
	END CATCH
GO