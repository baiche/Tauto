------------------------------------------------------------
-- Fichier     : makeEtat.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un état pour le véhicule associé à la location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeEtat	
GO

CREATE PROCEDURE dbo.makeEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_avant	 		datetime, --nullable
	@km_avant 			int, -- nullable
	@fiche_avant		nvarchar(50)
AS
	BEGIN TRANSACTION makeEtat
	BEGIN TRY
		DECLARE @id_Loc int, @idEtat int;
		
		SELECT @id_Loc = id, @idEtat = id_etat FROM Location WHERE matricule_vehicule = @matricule AND id_contratLocation = @idContratLocation;
		
		IF @id_Loc IS NULL
		BEGIN
			RAISERROR('Location pas trouvee', 10, -1);
			RETURN -1;
		END
			
		IF @idEtat IS NOT NULL
		BEGIN
			RAISERROR('Etat deja cree', 10, -1);
			RETURN -1;
		END
		
		IF @date_avant IS NULL
			SET @date_avant = GETDATE();
			
		IF @km_avant IS NULL
			SELECT @km_avant = kilometrage FROM Vehicule WHERE matricule = @matricule;
		ELSE IF @km_avant < (SELECT kilometrage FROM Vehicule WHERE matricule = @matricule)
		BEGIN
			RAISERROR('Kilometrage moins eleve que prevu', 10, -1);
			RETURN -1;
		END
		
		EXEC @idEtat = dbo.createEtat
			@date_avant = @date_avant,
			@km_avant = @km_avant,
			@fiche_avant = @fiche_avant;
			
		EXEC dbo.updateLocation
			@id = @id_Loc,
			@id_facturation = NULL,
			@id_etat = @idEtat;
		
		COMMIT TRANSACTION makeEtat
		PRINT('makeEtat OK');
		RETURN @idEtat;
	END TRY
	BEGIN CATCH
		PRINT('makeEtat: ERROR');
		ROLLBACK TRANSACTION makeEtat
		RETURN -1;
	END CATCH
GO