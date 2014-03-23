------------------------------------------------------------
-- Fichier     : makeVehicule.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajout d'un vehicule dans la base de donnée / Alexis : désolé j'ai fait cette procédure mais y'a eu un conflit dans l'excel de la répartition des taches ...
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeVehicule	
GO

CREATE PROCEDURE dbo.makeVehicule
	@marque_modele 			nvarchar(50), -- FK
	@serie 					nvarchar(50), -- FK
	@type_carburant 		nvarchar(50), -- FK
	@portieres 				tinyint,  -- FK
	@matricule 				nvarchar(50), --PK
	@kilometrage 			int,
	@couleur 				nvarchar(50),
	@num_serie				nvarchar(50),
	@nom_categorie			nvarchar(50)
AS
	BEGIN TRANSACTION makeVehicule
	
	BEGIN TRY
	
				IF (SELECT count(*) FROM CategorieModele cm WHERE cm.nom_categorie=@nom_categorie AND cm.marque_modele=@marque_modele AND cm.portieres_modele=@portieres AND cm.serie_modele = @serie
				  AND cm.type_carburant_modele=@type_carburant )= 0
				  BEGIN
					PRINT ('Cette modele n''existe pas dans cette categorie ')
					return -1 ;
				  END
				  
				ELSE 
				EXEC createVehicule @matricule ,@kilometrage,@couleur,'Disponible',@num_serie,@marque_modele,@serie,@portieres,@type_carburant ;
	
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