------------------------------------------------------------
-- Fichier     : Procedure_updateFacturation
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie une facturation
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateFacturation;
GO

--modifie le montant et la date reception du paiment d'une facturation lié à une location.
CREATE PROCEDURE dbo.updateFacturation
	@id_location 					int,
	@montant						money,
	@date_reception					date
	
AS
	BEGIN TRANSACTION update_facturation
	BEGIN TRY
		DECLARE @id_facturation int;
		
		SET @id_facturation =(
		SELECT id_facturation
		FROM Facturation, Location
		WHERE Location.id = @id_location
		AND Facturation.id = Location.id_facturation);

		UPDATE Facturation
		SET montant = @montant,
		date_reception = @date_reception
		WHERE id = @id_facturation;
		COMMIT TRANSACTION update_facturation
		RETURN 1
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION update_facturation
		RETURN -1
	END CATCH
GO
