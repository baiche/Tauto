------------------------------------------------------------
-- Fichier     : endContratLocation.sql
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
	@idContratLocation	int, -- PK
	@date_fin_effective date, -- nullable, en pratique, cet argument ne devrait pas apparaître. Il est présent pour faire le peuplement. Prendre la valeur du jour si nul
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