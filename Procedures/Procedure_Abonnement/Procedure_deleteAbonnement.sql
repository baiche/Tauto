------------------------------------------------------------
-- Fichier     : Procedure_deleteAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime un abonnement. Renvoie 1 en cas de succès, -1 autrement.
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
			DECLARE @Output TABLE (
				id INT
			);
			
			DECLARE @date_debut			date,
					@duree				int;
					
			SET @date_debut =(SELECT date_debut FROM Abonnement
								WHERE id=@id);
								
			SET @duree =(SELECT duree FROM Abonnement
								WHERE id=@id);

			
			IF ( DATEADD(day, @duree, @date_debut ) < GETDATE() )
			BEGIN
				--Print('deleteAbonnement: L abonnement n est pas encor fini');
				--RETURN -1;
				RAISERROR ('deleteAbonnement: L abonnement n est pas encor fini', 10, -1); 
			END
			
			DELETE Abonnement
			OUTPUT DELETED.id INTO @Output
			WHERE id = @id;
			
			IF ( (SELECT COUNT(*) FROM @Output) = 1)
			BEGIN
				PRINT('Abonnement supprimé');
				COMMIT TRANSACTION deleteAbonnement
				RETURN 1;
			END
			ELSE
			BEGIN
				RAISERROR ('deleteAbonnement: ERROR, pas supprimé', 10, -1); 
			END
		END TRY	
		BEGIN CATCH
			PRINT('deleteAbonnement: ERROR');
			ROLLBACK TRANSACTION deleteContratLocation
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION deleteAbonnement
GO
			