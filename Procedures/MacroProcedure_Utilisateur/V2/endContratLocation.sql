------------------------------------------------------------
-- Fichier     : endContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
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
	@date_fin_effective datetime -- nullable, en pratique, cet argument ne devrait pas apparaître. Il est présent pour faire le peuplement. Prendre la valeur du jour si nul
AS
	BEGIN TRANSACTION endContratLocation
	BEGIN TRY
		DECLARE @idLoc int, @idFac int, @idEtat int, @km int, @date_fi datetime, @extensio int;
		DECLARE @Location_T TABLE(
			id_facturation int,
			id_etat int,
			km int
		);
		IF @date_fin_effective IS NULL
			SET @date_fin_effective = GETDATE();
		
		SELECT @date_fi = date_fin_effective FROM ContratLocation WHERE id = @idContratLocation;
		IF @date_fi IS NOT NULL
		BEGIN
			RAISERROR('Contrat deja fini', 10, -1);
			RETURN -1;
		END
			
		INSERT INTO @Location_T(id_facturation, id_etat, km) (SELECT l.id_facturation, l.id_etat, e.km_apres FROM Location l, Etat e WHERE l.id_contratLocation = @idContratLocation AND e.id = l.id_etat);
		
		
		DECLARE Locat_cursor CURSOR
			FOR SELECT * FROM @Location_T
		OPEN Locat_cursor;
		FETCH NEXT FROM Locat_cursor
			INTO @idFac, @idEtat, @km;
			
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @idFac IS NULL
			BEGIN
				RAISERROR('Pas de facture cree', 10, -1);
				RETURN -1;
			END
			IF @km IS NULL
			BEGIN
				RAISERROR('Pas de km dans la location', 10, -1);
				RETURN -1;
			END
			IF (SELECT fiche_apres FROM Etat WHERE id = @idEtat) LIKE ''
			BEGIN
				RAISERROR('Etat non termine', 10, -1);
				RETURN -1;
			END
			FETCH NEXT FROM Locat_cursor
				INTO @idFac, @idEtat, @km;		
		END
		
		CLOSE Locat_cursor;
		DEALLOCATE Locat_cursor;
		
		SELECT @date_fi = date_fin, @extensio = extension FROM ContratLocation WHERE id = @idContratLocation;
		
		IF DATEADD(day, @extensio, @date_fi) < @date_fin_effective
			PRINT('Depassement detectee');
		
		UPDATE ContratLocation
		SET date_fin_effective = @date_fin_effective
		WHERE id = @idContratLocation;
			
		EXEC dbo.printContratLocation @idContratLocation;
		
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