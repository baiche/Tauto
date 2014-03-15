------------------------------------------------------------
-- Fichier     : endEtat.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeEtat	
GO

CREATE PROCEDURE dbo.makeEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_apres	 		datetime,
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat 				bit -- nullable, mettre faux si rien n'est indiqué
AS
	BEGIN TRANSACTION makeEtat
	BEGIN TRY
		COMMIT TRANSACTION makeEtat
		PRINT('makeEtat OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeEtat: ERROR');
		ROLLBACK TRANSACTION makeEtat
		RETURN -1;
	END CATCH
GO