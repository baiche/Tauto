------------------------------------------------------------
-- Fichier     : fixFacturation.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique que la facture a ete paye en ajoutant la 
-- date du paiement de la location. Si la
-- date de reception du paiement n'a pas ete renseigne, la
-- date renseigné est aujourd'hui.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixFacturation	
GO

CREATE PROCEDURE dbo.fixFacturation
	@id_contrat					nvarchar(50),	-- PK
	@matricule 					nvarchar(50),	-- PK
	@date_reception				date			-- nullable
AS
	BEGIN TRANSACTION fixFacturation
	DECLARE @msg varchar(4000)
	BEGIN TRY
		
		IF(@id_contrat IS NULL)
		BEGIN
			PRINT('fixFacturation: id_contrat ne doit pas etre NULL');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END 
		
		IF(@matricule IS NULL)
		BEGIN
			PRINT('fixFacturation: matricule ne doit pas etre NULL');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END 
		
		
		IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = @id_contrat
						AND matricule_vehicule = @matricule)) IS NOT NULL)
			BEGIN
				PRINT('fixFacturation: la facturation a deja ete regle');
				ROLLBACK TRANSACTION fixFacturation
				RETURN -1;
			END
			
		IF(@date_reception > GETDATE())
		BEGIN
			PRINT('fixFacturation: la facturation ne peut pas avoir ete regle dans le future');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END
		
		IF((SELECT date_creation 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = @id_contrat
						AND matricule_vehicule = @matricule)) > @date_reception)
		BEGIN
			PRINT('fixFacturation: la facturation ne peut pas avoir ete regle avant d''avoir ete cree');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END
						
		UPDATE Facturation
		SET date_reception =	CASE WHEN (@date_reception IS NULL) 
								THEN GETDATE()
								ELSE @date_reception
								END  
		WHERE id = (SELECT id_facturation 
					FROM Location
					WHERE id_contratLocation = @id_contrat
					AND matricule_vehicule = @matricule)
	
		COMMIT TRANSACTION fixFacturation
		PRINT('fixFacturation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixFacturation: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION fixFacturation
		RETURN -1;
	END CATCH
GO