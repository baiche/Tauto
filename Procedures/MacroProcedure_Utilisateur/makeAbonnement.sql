------------------------------------------------------------
-- Fichier     : makeAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeAbonnement	
GO

CREATE PROCEDURE dbo.makeAbonnement
	@nom 					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@date_debut 			date,
	@duree 					int,
	@renouvellement_auto 	bit,
	@nom_typeabonnement 	nvarchar(50)
AS
	BEGIN TRANSACTION makeAbonnement
	BEGIN TRY
		COMMIT TRANSACTION makeAbonnement
		PRINT('makeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeAbonnement: ERROR');
		ROLLBACK TRANSACTION makeAbonnement
		RETURN -1;
	END CATCH
GO