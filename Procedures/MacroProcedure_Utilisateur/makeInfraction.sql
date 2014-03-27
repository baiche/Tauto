------------------------------------------------------------
-- Fichier     : makeInfraction.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeInfraction	
GO

CREATE PROCEDURE dbo.makeInfraction
	@matricule				nvarchar(50), -- FK
	@nom 					nvarchar(50),
	@montant 				money,
	@description 			nvarchar(50)
AS
	BEGIN TRANSACTION makeInfraction
	SELECT FROM Location WHERE matricule_vehicule=@matricule;
	BEGIN TRY
		COMMIT TRANSACTION makeInfraction
		PRINT('makeInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeInfraction: ERROR');
		ROLLBACK TRANSACTION makeInfraction
		RETURN -1;
	END CATCH
GO