------------------------------------------------------------
-- Fichier     : searchVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.searchVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.searchVehicule	
GO

CREATE PROCEDURE dbo.searchVehicule
	@nom_categorie			nvarchar(50), -- nullable
	@marque 				nvarchar(50), -- nullable
	@serie 					nvarchar(50), -- nullable
	@type_carburant 		nvarchar(50), -- nullable
	@portieres 				tinyint, -- nullable
	@prix_max 				money, -- nullable
	@prix_min 				money, -- nullable
	@date_debut 			date, -- nullable
	@date_fin 				date, -- nullable
AS
	BEGIN TRANSACTION searchVehicule
	BEGIN TRY
		COMMIT TRANSACTION searchVehicule
		PRINT('searchVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('searchVehicule: ERROR');
		ROLLBACK TRANSACTION searchVehicule
		RETURN -1;
	END CATCH
GO