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
	@nom 					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date, -- PK
	@date_debut 			date,
	@duree 					int,
	@renouvellement_auto 	bit,
	@nom_typeabonnement 	nvarchar(50) -- FK
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