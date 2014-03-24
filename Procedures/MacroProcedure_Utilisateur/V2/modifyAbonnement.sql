------------------------------------------------------------
-- Fichier     : modifyAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Methode modifant les champs d'un compte
-- autre que ceux permettant de l'identifier
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyAbonnement	
GO

CREATE PROCEDURE dbo.modifyAbonnement
	@id 					int, -- PK
	@renouvellement_auto	bit
AS
	BEGIN TRANSACTION modifyAbonnement
	BEGIN TRY
		
		COMMIT TRANSACTION modifyAbonnement
		PRINT('modifyAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyAbonnement: ERROR');
		ROLLBACK TRANSACTION modifyAbonnement
		RETURN -1;
	END CATCH
GO