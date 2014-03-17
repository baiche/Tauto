------------------------------------------------------------
-- Fichier     : closeModele.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeModele	
GO

CREATE PROCEDURE dbo.closeModele
	@marque 			nvarchar(50),
	@serie 				nvarchar(50),
	@type_carburant 	nvarchar(50),
	@portieres 			tinyint,
	@vehiculeToo		bit -- nullable, false par défaut
AS
	BEGIN TRANSACTION closeModele
	BEGIN TRY
		COMMIT TRANSACTION closeModele
		PRINT('closeModele OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeModele: ERROR');
		ROLLBACK TRANSACTION closeModele
		RETURN -1;
	END CATCH
GO