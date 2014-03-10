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

GO
CREATE PROCEDURE dbo.createLocation

	@matricule_vehicule 	nvarchar(50),
	@id_contratLocation 	int,
	@fiche_etat_avant		nvarchar(50)

	--------------------------------------------------------------------------
	------------------------- RESUME DE LA PROCEDURE -------------------------
	--------------------------------------------------------------------------
	-- Hypotheses: 
	---- 1: La table des locations ne subit jamais de suppression
	--------------------------------------------------------------------------
	--------------------------------------------------------------------------
	-- PARTIE.A: Verification de coherence 
	---- DESCRIPTION: Dans cette partie, nous allons verifier que la base est 
	----------------- dans un etat valide pour effectuer cette operation.
	---- ETAPE.A.01: Vehicule disponible
	---- ETAPE.A.02: Vehicule reserve
	------- DESCRIPTION: Nous verifierons que la location fait suite a
	-------------------- une reservation valide.
	------- ETAPE.A.02.i:  Une reservation existe par rapport à un abonnement
	---------------------- valide.
	------- ETAPE.A.02.ii: Cette reservation n'est pas expire
	------- ETAPE.A.02.iii: Cette reservation concerne bien ce vehicule
	------- ETAPE.A.02.iv:  Cette reservation se realise dans le cadre du bon
	----------------------- abonnement.
	--------------------------------------------------------------------------
	--------------------------------------------------------------------------
	-- PARTIE.B: Realisation effective de l'operation 
	---- ETAPE.B.01: Insertion d'une location imcomplete.
	----- DESCRIPTION: Nous commencerons par inserer une location imcomplete
	------------------ pour eviter les probleme de references mutuelle. 
	---- ETAPE.B.02: Recuperation du degat du vehicule.
	---- ETAPE.B.03: Insertion de l'etat d'avant location.
	---- ETAPE.B.04: Mise a jour du statut du vehicule et finalisation de 
	---------------- la location .
	--------------------------------------------------------------------------
	
	
AS	
	BEGIN TRANSACTION create_location
		BEGIN TRY
		
			-------------------------------------------------------------------
			-------------------------------------------------------------------
			--------------- PARTIE.A: Verification de coherence ---------------
			-------------------------------------------------------------------
			-------------------------------------------------------------------
			
			----------------------------------
			-- ETAPE.A.01: Vehicule disponible
			----------------------------------
			
			IF (SELECT statut 
				FROM Vehicule 
				WHERE matricule=@matricule_vehicule) != 'Disponible'
					RAISERROR (
						N'Vous essayez de louer une voiture non disponible', 
						10, 
						-1); 
			
			
			
			------------------------------------------------------------------
			-- ETAPE.A.02:  Une reservation existe par rapport à un abonnement
			----------------- valide.
			------------------------------------------------------------------

			DECLARE @nbMatchingReservation int;
			
			SELECT @nbMatchingReservation=COUNT(r.id) 
			FROM Reservation r, 
				 ReservationVehicule rv,
				 ContratLocation cl, 
				 Abonnement a	
			 WHERE r.id = rv.id_reservation 
			   AND rv.matricule_vehicule = @matricule_vehicule
			   AND cl.id = @id_contratLocation
			   AND cl.id_abonnement = a.id
			   AND GETDATE() <= DATEADD(day,a.duree,a.date_debut)

			IF (@nbMatchingReservation=0)
				RAISERROR (
						N'Vous essayez de louer une voiture que vous n avez pas reserve', 
						10, 
						-1); 
			ELSE IF (@nbMatchingReservation > 1)
				RAISERROR (
						N'Incohérence, vehicule reserve plusieurs fois', 
						10, 
						-1); 

			
			
			
			
			
			
			------------------------------------------------------------------
			------------------------------------------------------------------
			--------- PARTIE.B: Realisation effective de l'operation ---------
			------------------------------------------------------------------
			------------------------------------------------------------------
			
			CREATE TABLE #TempLocationId (id int );
			CREATE TABLE #TempEtatId(id int);
			CREATE TABLE #TempVehiculeDegat(degat bit);
			
			
			
			--------------------------------------------------
			-- ETAPE.B.01: Insertion d'une location imcomplete
			--------------------------------------------------
			
			INSERT INTO Location(
				matricule_vehicule,
				id_facturation,
				id_etat,
				id_contratLocation
			)
			OUTPUT inserted.id INTO #TempLocationId(id)
			VALUES (
				@matricule_vehicule,
				NULL,
				NULL,
				@id_contratLocation
			);

			
			
			------------------------------------------------
			-- ETAPE.B.02: Recuperation du degat du vehicule
			------------------------------------------------
			
			INSERT INTO #TempVehiculeDegat(degat)
			SELECT TOP(1) e.degat
			FROM Etat e, Location l
			WHERE l.matricule_vehicule = @matricule_vehicule 
			  AND l.id_etat = e.id
			ORDER BY e.date_apres DESC
			
			IF (SELECT COUNT(*) FROM #TempVehiculeDegat) = 0 
				-- C'est la premiere fois que ce vehicule est utilise.
				INSERT INTO #TempVehiculeDegat(degat) VALUES (0);

				
				
			----------------------------------------------------
			-- ETAPE.B.03: Insertion de l'etat d'avant location.
			----------------------------------------------------

			INSERT INTO Etat(
				date_avant,
				date_apres,
				km_avant,
				km_apres,
				degat,
				fiche_avant,
				fiche_apres
			) 
			OUTPUT inserted.id INTO #TempEtatId(id)
			VALUES (
				GETDATE(),
				NULL,
			    (SELECT kilometrage FROM Vehicule WHERE matricule = @matricule_vehicule),
			    NULL,
				(SELECT degat FROM #TempVehiculeDegat),
				@fiche_etat_avant,
				NULL
			);
			
			
			
			------------------------------------------------------------------
			-- ETAPE.B.04: Mise a jour du statut du vehicule et finalisation
			-------------- de la location.
			------------------------------------------------------------------
			
			UPDATE Vehicule
			SET statut='Louee'
			WHERE matricule=@matricule_vehicule
			
			UPDATE Location 
			SET id_etat=(SELECT id FROM #TempEtatId)
			WHERE id=(SELECT id FROM #TempLocationId)
			
			
			
			RETURN (SELECT id FROM #TempLocationId);
			
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION create_location;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION create_location;
GO

EXEC dbo.createLocation @matricule_vehicule = '0775896wr',
						@id_contratLocation = 1,
						@fiche_etat_avant = '0300';
