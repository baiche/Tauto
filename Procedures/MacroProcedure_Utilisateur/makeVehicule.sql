------------------------------------------------------------
-- Fichier     : makeVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeVehicule	
GO

CREATE PROCEDURE dbo.makeVehicule
	@nom_catalogue			nvarchar(50), -- FK
	@nom_categorie			nvarchar(50), -- FK
	@marque 				nvarchar(50), -- FK
	@serie 					nvarchar(50), -- FK
	@type_carburant 		nvarchar(50), -- FK
	@portieres 				tinyint,  -- FK
	@matricule 				nvarchar(50), --PK
	@kilometrage 			int,
	@couleur 				nvarchar(50),
	@num_serie				nvarchar(50)
AS
	BEGIN TRANSACTION makeVehicule
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
				IF (SELECT count(*) FROM CategorieModele cm WHERE cm.nom_categorie=@nom_categorie AND cm.marque_modele=@marque AND cm.portieres_modele=@portieres AND cm.serie_modele = @serie
				  AND cm.type_carburant_modele=@type_carburant )= 0
				  BEGIN
					PRINT ('Cette modele n''existe pas dans cette categorie ')
					return -1 ;
				  END
				  
				ELSE 
				EXEC createVehicule @matricule ,@kilometrage,@couleur,'Disponible',@num_serie,@marque,@serie,@portieres,@type_carburant ;
				   
			END
	
	END
	
		COMMIT TRANSACTION makeVehicule
		PRINT('makeVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeVehicule: ERROR');
		ROLLBACK TRANSACTION makeVehicule
		RETURN -1;
	END CATCH
GO