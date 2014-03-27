------------------------------------------------------------
-- Fichier     : findOtherVehiculeWithElevation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Permet de remplacer toute les réservations affectées à un véhicule qui serai 
--				 declaré par exemple endomager par d’autres véhicules de même modèle ou equivalent.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.findOtherVehiculeWithElevation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.findOtherVehiculeWithElevation	
GO

CREATE PROCEDURE dbo.findOtherVehiculeWithElevation
	@matricule 			nvarchar(50), -- PK
	@itMustBeDone		bit,
	@nom_categorie		nvarchar(50), -- PK
	@type_carburant 	nvarchar(50),
	@portieres 			tinyint,
	@date_debut			datetime,
	@date_fin			datetime,

AS
	BEGIN TRANSACTION findOtherVehiculeWithElevation
	BEGIN TRY
		DECLARE @marque_modele			nvarchar(50),
				@serie_modele			nvarchar(50),
				@type_carburant_modele 	nvarchar(50),
				@portieres_modele		tinyint,
				@categorie				nvarchar(50),
				@isDispo				int,
				@id_res 				int,
				@date_d 				datetime,
				@date_f					datetime;
				
		IF(@itMustBeDone = 'true')
		BEGIN
			IF ( @matricule IS NULL)
			BEGIN
				PRINT('findOtherVehiculeWithElevation : ERROR veuillez indiquer le matricule du véhicule');
				ROLLBACK TRANSACTION findOtherVehiculeWithElevation
				RETURN -1;
			END
			IF ( (SELECT COUNT(*) FROM Vehicule WHERE matricule=@matricule) = 0)
			BEGIN
				PRINT('findOtherVehiculeWithElevation : ERROR aucun vehicule correspondant au matricule n''a été trouvé');
				ROLLBACK TRANSACTION findOtherVehiculeWithElevation
				RETURN -1;
			END
			SET @marque_modele = (SELECT marque_modele FROM Vehicule WHERE matricule=@matricule);
			SET @serie_modele = (SELECT serie_modele FROM Vehicule WHERE matricule=@matricule);
			SET @type_carburant_modele = (SELECT type_carburant_modele FROM Vehicule WHERE matricule=@matricule);
			SET @portieres_modele = (SELECT portieres_modele FROM Vehicule WHERE matricule=@matricule);
			SET @categorie = (SELECT nom_categorie FROM CategorieModele WHERE marque_modele = @marque_modele
																		AND   serie_modele = @serie_modele
																		AND   type_carburant_modele = @type_carburant_modele
																		AND   portieres_modele = @portieres_modele);
																		
			--commencer le cursor
			
		END --fin de IF(@itMustBeDone = 'true')
		--si @itMustBeDone = 'false'
		ELSE
		BEGIN
		
		END
	
	
	
	
	
	
	
	
		COMMIT TRANSACTION findOtherVehiculeWithElevation
		PRINT('findOtherVehiculeWithElevation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('findOtherVehiculeWithElevation: ERROR');
		ROLLBACK TRANSACTION findOtherVehiculeWithElevation
		RETURN -1;
	END CATCH
GO