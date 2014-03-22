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

IF OBJECT_ID ('dbo.endContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.endContratLocation	
GO

CREATE PROCEDURE dbo.endContratLocation
	@idContratLocation	int, -- PK
	@date_fin_effective datetime, -- nullable, en pratique, cet argument ne devrait pas apparaître. Il est présent pour faire le peuplement. Prendre la valeur du jour si nul
AS
	BEGIN TRANSACTION endContratLocation
	BEGIN TRY
		DECLARE @Location_T TABLE(
			id int,
			id_facturation int,
			id_etat int
		);
		IF @date_fin_effective IS NULL
			@date_fin_effective = GETDATE();
			
		DECLARE @Locat_cursor CURSOR
			FOR SELECT * FROM @Location_T;
		OPEN @Locat_cursor;
		FETCH NEXT FROM
			INTO ;
		CLOSE @Locat_cursor;
		DEALLOCATE @Locat_cursor;
			
			
		COMMIT TRANSACTION endContratLocation
		PRINT('endContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('endContratLocation: ERROR');
		ROLLBACK TRANSACTION endContratLocation
		RETURN -1;
	END CATCH
GO