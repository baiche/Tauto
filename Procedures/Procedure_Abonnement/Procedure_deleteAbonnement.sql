------------------------------------------------------------
-- Fichier     : Procedure_deleteAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime un abonnement et l'ensemble des contrats associés
--				Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteAbonnement
	
GO
CREATE PROCEDURE dbo.deleteAbonnement
	@id 							int
AS
	BEGIN TRANSACTION deleteAbonnement
	BEGIN TRY
		DECLARE @CONTRATLOC_T TABLE(
			id int
		);
		DECLARE @id_contratLoc int, @res int;
		
		IF ( (SELECT a_supprimer FROM Abonnement WHERE id = @id) = 'false')
		BEGIN
			PRINT('deleteAbonnement: a_supprimer n''est pas à true');
			RETURN -1;
		END
		
		INSERT INTO @CONTRATLOC_T (SELECT id FROM ContratLocation WHERE id_abonnement = @id);
		
		DECLARE contratLoc_cursor CURSOR
			FOR SELECT * FROM @CONTRATLOC_T
			
		OPEN contratLoc_cursor
		FETCH NEXT FROM contratLoc_cursor INTO @id_contratLoc;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC @res = dbo.deleteContratLocation @id = @id_contratLoc;
			IF (@res = 1)
			BEGIN
				PRINT('deleteAbonnement: Contrat ' + @id_contratLoc + ' supprimé');
			END
			ELSE
			BEGIN
				PRINT('deleteAbonnement: Contrat ' + @id_contratLoc + ' impossible à supprimer');
				ROLLBACK TRANSACTION deleteAbonnement
				RETURN -1;
			END
			FETCH NEXT FROM contratLoc_cursor INTO @id_contratLoc;
		END
		
		CLOSE contratLoc_cursor;
		DEALLOCATE contratLoc_cursor;
		
		DELETE FROM Abonnement
		WHERE id = @id;
		
		COMMIT TRANSACTION deleteAbonnement
		PRINT('deleteAbonnement supprimé');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('deleteAbonnement: ERROR');
		ROLLBACK TRANSACTION deleteAbonnement
		RETURN -1;
	END CATCH
GO