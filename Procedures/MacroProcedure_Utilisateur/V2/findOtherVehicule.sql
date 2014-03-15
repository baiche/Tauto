------------------------------------------------------------
-- Fichier     : findOtherVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.findOtherVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.findOtherVehicule	
GO

CREATE PROCEDURE dbo.findOtherVehicule
	@matricule 			nvarchar(50), -- PK
	@itMustBeDone		bit, -- true si c'est obligatoire, dans le cas d'une détérioration du véhicule, false si c'est pour étendre un contrat
	@date_fin			date
AS
	BEGIN TRY
		PRINT('findOtherVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('findOtherVehicule: ERROR');
		RETURN -1;
	END CATCH
GO
