------------------------------------------------------------
-- Fichier     : makeIncident.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeIncident', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeIncident	
GO

CREATE PROCEDURE dbo.makeIncident
	@matricule				nvarchar(50), -- FK
	@description 			nvarchar(50),
	@penalisable 			bit, -- nullable, par défaut c'est false
	@vehicule_statut		nvarchar(50) -- nullable
AS
	BEGIN TRANSACTION makeIncident
	BEGIN TRY
		COMMIT TRANSACTION makeIncident
		PRINT('makeIncident OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeIncident: ERROR');
		ROLLBACK TRANSACTION makeIncident
		RETURN -1;
	END CATCH
GO