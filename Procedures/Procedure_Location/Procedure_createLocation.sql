------------------------------------------------------------
-- Fichier     : Procedure_createLocation
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------


USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createLocation
GO

CREATE PROCEDURE dbo.createLocation

	@matricule_vehicule 	nvarchar(50),
	@id_contratLocation 	int,
	@fiche_etat_avant		nvarchar(50)

	--------------------------------------------------------------------------
	------------------------- RESUME DE LA PROCEDURE -------------------------
	--------------------------------------------------------------------------
	--------------------------------------------------------------------------
	-- PARTIE.A: Delegation de la verification de la coherence 
	--------------------------------------------------------------------------
	--------------------------------------------------------------------------
	-- PARTIE.B: Realisation effective de l'operation 
	---- ETAPE.B.01: Insertion d'une location imcomplete.
	----- DESCRIPTION: Nous commencerons par inserer une location imcomplete
	------------------ pour eviter les probleme de references mutuelle. 
	---- ETAPE.B.02: Insertion de l'etat d'avant location.
	---- ETAPE.B.03: Mise a jour du statut du vehicule 
	---- ETAPE.B.04: Finalisation de la location.
	--------------------------------------------------------------------------
	
	
AS	
	BEGIN TRANSACTION create_location
		BEGIN TRY
		
			------------------------------------------------------------------
			------------------------------------------------------------------
			------------- PARTIE.A: Verification de la coherence -------------
			------------------------------------------------------------------
			------------------------------------------------------------------
			
			EXEC dbo.checkIsValidLocation @matricule_vehicule,
										  @id_contratLocation,
										  @fiche_etat_avant
				

				
										  
										  
										  
			------------------------------------------------------------------
			------------------------------------------------------------------
			--------- PARTIE.B: Realisation effective de l'operation ---------
			------------------------------------------------------------------
			------------------------------------------------------------------
			
			CREATE TABLE #TempTableLocationId (id int);
			
			DECLARE		 @the_id_location	 int;
			DECLARE		 @the_etat_id 	     int;
			


			--------------------------------------------------
			-- ETAPE.B.01: Insertion d'une location imcomplete
			-------------------------------------------------
	
			INSERT INTO Location(
				matricule_vehicule,
				id_facturation,
				id_etat,
				id_contratLocation
			)
			OUTPUT inserted.id INTO #TempTableLocationId(id)
			VALUES (
				@matricule_vehicule,
				NULL,
				NULL,
				@id_contratLocation
			);

			SELECT @LocationId=id FROM #TempTableLocationId;


			----------------------------------------------------
			-- ETAPE.B.02: Insertion de l'etat d'avant location.
			----------------------------------------------------
		
			--@TempEtatId=
				EXEC dbo.createEtat 
						@id_location=(SELECT id FROM #TempLocationId),
						@km=(SELECT kilometrage FROM Vehicule WHERE matricule = @matricule_vehicule),
					    @degat=0,
					    @fiche=@fiche_avant;
			
			
			------------------------------------------------
			-- ETAPE.B.03: Mise a jour du statut du vehicule
			------------------------------------------------
			
			DECLARE  @kilometrage_before_update 			int,
					 @couleur_before_update					nvarchar(50),
					 @statut_before_update					nvarchar(50),
					 @num_serie_before_update				nvarchar(50),
					 @marque_modele_before_update			nvarchar(50),
					 @serie_modele_before_update			nvarchar(50),
					 @portieres_modele_before_update		tinyint,
					 @type_carburant_modele_before_update	nvarchar(50);
					 
			SELECT @kilometrage_before_update=kilometrage,
				   @couleur_before_update=couleur,
				   @statut_before_update='Louee',
				   @num_serie_before_update=num_serie,
				   @marque_modele_before_update=marque_modele,
				   @serie_modele_before_update=serie_modele,
				   @portieres_modele_before_update=portieres_modele,
				   @type_carburant_modele_before_update=type_carburant_modele
			FROM Vehicule
			WHERE matricule=@matricule_vehicule

			dbo.updateVehicule   @matricule,
				    			 @kilometrage_before_update,
								 @couleur_before_update,
								 @statut_before_update,
								 @num_serie_before_update,
								 @marque_modele_before_update,
								 @serie_modele_before_update,
								 @portieres_modele_before_update,
								 @type_carburant_modele_before_update

								 
								 
			-------------------------------------------
			-- ETAPE.B.04: Finalisation de la location.
			-------------------------------------------
			
			UPDATE Location 
			SET id_etat=@TempEtatId
			WHERE id=(SELECT id FROM #TempLocationId)
			
			
			
			RETURN (SELECT id FROM #TempLocationId);
			
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION create_location;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION create_location;
GO