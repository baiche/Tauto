------------------------------------------------------------
-- Fichier     : makeVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
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