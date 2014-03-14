------------------------------------------------------------
-- Fichier     : Procedure_updateAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un abonnement, les valeurs que l'on ne souhaite pas changer peuvent être nulle
--				 Renvoie 1 en cas de succès (pas d'erreur détectée), -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateAbonnement

GO
CREATE PROCEDURE dbo.updateAbonnement
	@id 							int,
	@renouvellement_auto			bit,
	@a_supprimer					bit
AS
	BEGIN TRANSACTION updateAbonnement
	BEGIN TRY
		IF ( (SELECT COUNT(*) FROM Abonnement WHERE id = @id) = 1)
		BEGIN
			IF ( @renouvellement_auto IS NOT NULL)
			BEGIN
				UPDATE Abonnement
				SET
					renouvellement_auto = @renouvellement_auto
				WHERE id = @id;
			END
			IF ( @a_supprimer IS NOT NULL)
			BEGIN
				UPDATE Abonnement
				SET
					a_supprimer = @a_supprimer
				WHERE id = @id;
			END
			
			COMMIT TRANSACTION updateAbonnement
			PRINT('updateAbonnement: changements effectués');
			RETURN 1;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION updateAbonnement
			PRINT('updateAbonnement: pas d''abonnement correspondant à l''id');
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION updateAbonnement
		PRINT('updateAbonnement: ERROR');
		RETURN -1;
	END CATCH
=======
GO

CREATE PROCEDURE dbo.updateAbonnement
AS
GO