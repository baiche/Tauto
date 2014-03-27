------------------------------------------------------------
-- Fichier     : findOtherVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Permet d’étendre une location du véhicule en cours de 
--				 location ou avec un autre de même modèle ou de remplacer 
--				 toute les réservations affectées à un véhicule qui serai 
--				 declaré par exemple endomager par d’autres véhicules de même modèle.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.findOtherVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.findOtherVehicule	
GO

CREATE PROCEDURE dbo.findOtherVehicule
	@matricule 			nvarchar(50), -- PK
	@itMustBeDone		bit, 		  -- true si c'est obligatoire (dans le cas d'une détérioration du véhicule), il faut modifier les réservations concernées
									  -- false si c'est pour étendre un contrat utiliser l'argument suivant
	@date_fin			datetime 	  -- permet de déterminer s'il est possible d'étendre la location jusqu'à cette date
AS
	BEGIN TRANSACTION findOtherVehicule
	BEGIN TRY
		
		DECLARE @marque_modele			nvarchar(50),
				@serie_modele			nvarchar(50),
				@type_carburant_modele 	nvarchar(50),
				@portieres_modele		tinyint,
				@asLocation				int,
				@idAbonne				int,
				@date_fin_location 		datetime,
				@isDispo				int,
				@matricule_chreno 		nvarchar(50),
				@returnPS				int,
				@breakIsOK				int;
				
		IF ( @matricule IS NULL)
		BEGIN
			PRINT('findOtherVehicule : ERROR veuillez indiquer le matricule du véhicule');
			ROLLBACK TRANSACTION findOtherVehicule
			RETURN -1;
		END
		
		IF ( (SELECT COUNT(*) FROM Vehicule WHERE matricule=@matricule) = 0)
		BEGIN
			PRINT('findOtherVehicule : ERROR aucun vehicule correspondant au matricule n''a été trouvé');
			ROLLBACK TRANSACTION findOtherVehicule
			RETURN -1;
		END
		
		SET @marque_modele = (SELECT marque_modele FROM Vehicule WHERE matricule=@matricule);
		SET @serie_modele = (SELECT serie_modele FROM Vehicule WHERE matricule=@matricule);
		SET @type_carburant_modele = (SELECT type_carburant_modele FROM Vehicule WHERE matricule=@matricule);
		SET @portieres_modele = (SELECT portieres_modele FROM Vehicule WHERE matricule=@matricule);
	
		IF(@itMustBeDone = 'false')
		BEGIN
			IF ( @date_fin IS NULL)
			BEGIN
				PRINT('findOtherVehicule : ERROR veuillez indiquer la date de fin pour etendre la location');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1;
			END
			IF ( @date_fin < GETDATE())
			BEGIN
				PRINT('findOtherVehicule : ERROR la date de fin indiquer pour etendre la location est déjà passée');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1;
			END
			
			--verifier qu'il existe une location en cours pour ce vehicule
			SET @asLocation	= (SELECT COUNT(cl.date_fin) FROM ContratLocation cl, Location l WHERE l.matricule_vehicule = @matricule
																							 AND   l.id_contratLocation = cl.id
																							 AND   cl.date_fin_effective IS NULL);
			IF ( @asLocation = 0)
			BEGIN
				PRINT('findOtherVehicule : ERROR pas de location en cours pour le vehicule indiqué');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1;
			END
			
			IF ( @asLocation > 1)
			BEGIN
				PRINT('findOtherVehicule : ERROR GROS PROBLEME, plusieurs  location en cours pour le vehicule indiqué');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1;
			END
			
			--recuperer l'id_abonnement ratacher au contratLocation
			SET @idAbonne = (SELECT cl.id_abonnement FROM ContratLocation cl, Location l WHERE l.matricule_vehicule = @matricule
																						 AND   l.id_contratLocation = cl.id
																						 AND   cl.date_fin_effective IS NULL);
			--recuperer la date de fin de la location en cours du vehicule
			SET @date_fin_location = (SELECT cl.date_fin FROM ContratLocation cl, Location l WHERE l.matricule_vehicule = @matricule
																							 AND   l.id_contratLocation = cl.id
																							 AND   cl.date_fin_effective IS NULL);
			
			--verfier que la date fin pour l'extention est coherente
			IF ( @date_fin_location >= @date_fin)
			BEGIN
				PRINT('findOtherVehicule : ERROR la date de fin indiquer pour etendre la location est anterieur a celle de la fin de location en cours');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1;
			END
			

			EXEC @isDispo =  dbo.isDisponible1 @matricule, @date_fin_location, @date_fin
			IF( @isDispo = 1)
			BEGIN																		  
				PRINT('findOtherVehicule : INFO le vehicule en question est disponible pour la prologation');
				COMMIT TRANSACTION modifyConducteur	
				RETURN 1;
			END
			ELSE
			BEGIN
				PRINT('findOtherVehicule : INFO le vehicule en question n''est pas disponible pour la prologation');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1;
			END
		END
		--si @itMustBeDone = true
		ELSE
		BEGIN
PRINT('TEST');	
			--pour chaque reservation qui correspondent aux vehicule endomager chercher un autre vehicule de meme modele qui colle au chreno
				--si trouver, mise a jour de la table ReservationVehicule avec le matricule du nouveau vehicule
				--si non un message de non possibiliter et on sort en annulant toute les modif precedente
			DECLARE @id_res int,
					@date_d datetime,
					@date_f datetime;
PRINT('TEST0');
			DECLARE curseur_reservation CURSOR FOR
				-- SELECT r.id, r.date_debut, r.date_fin FROM ReservationVehicule rv, Reservation r WHERE rv.matricule_vehicule = @matricule
																								 -- AND   rv.id_reservation = r.id
				SELECT r.id, r.date_debut, r.date_fin FROM Reservation r JOIN ReservationVehicule rv ON rv.matricule_vehicule = @matricule
																								 WHERE   rv.id_reservation = r.id;

PRINT('TEST1');			
			OPEN curseur_reservation
			--FETCH curseur_reservation INTO @id_res, @date_d, @date_f
			FETCH NEXT FROM curseur_reservation INTO @id_res, @date_d, @date_f
PRINT('TEST2');	
			WHILE @@FETCH_STATUS = 0
			BEGIN
				--curseur sur les vehicule de meme modele
				----------------------------
				DECLARE curseur_matricule CURSOR FOR
						SELECT matricule FROM Vehicule WHERE marque_modele = @marque_modele
													   AND   serie_modele = @serie_modele
													   AND   type_carburant_modele = @type_carburant_modele
													   AND   portieres_modele = @portieres_modele
													   AND   matricule <> @matricule;
												   
				OPEN curseur_matricule
				--FETCH curseur_matricule INTO @matricule_chreno
				FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
				SET @breakIsOK = 0;
				WHILE @@FETCH_STATUS = 0
				BEGIN
PRINT('COUCOU');
					--si aucune reservation n'occupe le chreno souhaiité, on retourne 1 pour le vehicule et on sort
					EXEC @isDispo = dbo.isDisponible1 @matricule_chreno, @date_d, @date_f
PRINT('COUCOU0');
					IF( @isDispo = 1)
					BEGIN
PRINT('COUCOU2');					
						--modifie le matricule de la reservation dans reservation vehicule
						UPDATE ReservationVehicule SET matricule_vehicule = @matricule_chreno WHERE id_reservation = @id_res
																						      AND   matricule_vehicule = @matricule;
						SET @breakIsOK = 1;
						BREAK;
					END
PRINT('COUCOU3');
					--FETCH curseur_auteurs INTO @matricule_chreno
					FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
				END
				CLOSE curseur_matricule
				DEALLOCATE curseur_matricule
				IF(@breakIsOK = 0)
				BEGIN
					PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele');
					ROLLBACK TRANSACTION findOtherVehicule
					RETURN -1;
				END
				-----------------------------
				--FETCH curseur_reservation INTO @id_res, @date_d, @date_f
				FETCH NEXT FROM curseur_reservation INTO @id_res, @date_d, @date_f
			END
			CLOSE curseur_reservation
			DEALLOCATE curseur_reservation
		END
		COMMIT TRANSACTION modifyConducteur	
		PRINT('findOtherVehicule OK : remplacement de toute les reservation par un vehicule de meme modele');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('findOtherVehicule: ERROR');
		ROLLBACK TRANSACTION findOtherVehicule
		RETURN -1;
	END CATCH
GO

--e.debut = @date_fin_location
			--e.fin = @date_fin
			--compte le nombre de reservation qui rentre dans le chreno qui nous interresse pour notre vehicule
			-- SET @isDispo = (SELECT COUNT(rv.id_reservation) FROM Reservation r, ReservationVehicule rv WHERE rv.matricule_vehicule = @matricule
																									   -- AND   rv.id_reservation = r.id
																									   -- AND   r.annule = 'false'
																									   -- AND	
																									      -- ((r.date_debut < @date_fin_location AND   r.date_fin > @date_fin_location)
																									   -- OR
																									      -- (r.date_debut > @date_fin_location AND   r.date_fin < @date_fin)
																									   -- OR
																									      -- (r.date_debut < @date_fin AND   r.date_fin > @date_fin)
																									   -- OR
																									      -- (r.date_debut < @date_fin_location AND   r.date_fin > @date_fin)));
			
			--si aucune reservation n'occupe le chreno souhaité pour ce meme vehicule, on modifie la date fin du contrat de location
			-- IF(@isDispo = 0)

			/*
			--Si non on cherche un autre vehicule du meme modele qui colle dans le chreno souhaiter
			ELSE
			BEGIN
				DECLARE curseur_matricule CURSOR FOR
						SELECT matricule FROM Vehicule WHERE marque_modele = @marque_modele
													   AND   serie_modele = @serie_modele
													   AND   type_carburant_modele = @type_carburant_modele
													   AND   portieres_modele = @portieres_modele
													   AND   matricule <> @matricule;
													   
				OPEN curseur_matricule
				FETCH curseur_matricule INTO @matricule_chreno
				WHILE @@FETCH_STATUS = 0
				BEGIN
					-- SET @isDispo = (SELECT COUNT(rv.id_reservation) FROM Reservation r, ReservationVehicule rv WHERE rv.matricule_vehicule = @matricule_chreno
																											   -- AND   rv.id_reservation = r.id
																											   -- AND   r.annule = 'false'
																											   -- AND	
																													-- ((r.date_debut < @date_fin_location AND   r.date_fin > @date_fin_location)
																											   -- OR
																													-- (r.date_debut > @date_fin_location AND   r.date_fin < @date_fin)
																											   -- OR
																													-- (r.date_debut < @date_fin AND   r.date_fin > @date_fin)
																											   -- OR
																													-- (r.date_debut < @date_fin_location AND   r.date_fin > @date_fin)));
			
					--si aucune reservation n'occupe le chreno souhaité pour un autre vehicule de meme modele, on cré la reservation correspondante
					-- IF(@isDispo = 0)
					EXEC @isDispo =  dbo.isDisponible1 @matricule_chreno, @date_fin_location, @date_fin
					IF( @isDispo = 1)
					BEGIN																		  
						--creation de la reservation
						EXEC @returnPS = dbo.createReservation @date_fin_location, @date_fin, @idAbonne;
						INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule)VALUES (@returnPS,@matricule_chreno);
						PRINT('findOtherVehicule : INFO un autre vehicule de meme modele est disponible pour la prologation, reservation effectué avec succés : '+@matricule_chreno);
						CLOSE curseur_matricule
						DEALLOCATE curseur_matricule
						COMMIT TRANSACTION modifyConducteur	
						RETURN 1;
					END

					FETCH curseur_auteurs INTO @matricule_chreno
				END
				CLOSE curseur_matricule
				DEALLOCATE curseur_matricule
				PRINT('findOtherVehicule : INFO Aucun autre vehicule de meme modele n''est disponible pour la prologation, ECHEC de la prolongation');
				ROLLBACK TRANSACTION findOtherVehicule
				RETURN -1; 
			END	
*/	