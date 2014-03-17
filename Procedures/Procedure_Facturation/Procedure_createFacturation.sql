------------------------------------------------------------
-- Fichier     : Procedure_createFacturation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ajoute une facture a la location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createFacturation;
GO

--crée une nouvelle facturation lié à la location avec le montant non encore calculé et le paiement 
CREATE PROCEDURE dbo.createFacturation
	@id_location 					int
AS
	BEGIN TRY
		CREATE TABLE #Temp1 (id int );
		--creation de la ligne  
		INSERT INTO Facturation(
			date_reception
		)
		OUTPUT inserted.id INTO #Temp1(id)
		VALUES (
			null
		);	
		-- creation de la reference de la location vers la facturation.
		UPDATE Location
		SET id_facturation = (SELECT id FROM #Temp1)
		WHERE id = @id_location
		RETURN (SELECT id FROM #Temp1)
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createFacturation',10,1)
	END CATCH
GO
