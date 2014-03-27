------------------------------------------------------------
-- Fichier     : findOtherVehiculeWithElevation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Permet de confirmer l'extention de la location du véhicule  
--				 en cours de location  ou de remplacer 
--				 toute les réservations affectées à un véhicule qui serai 
--				 declaré par exemple endomager par d’autres véhicules de même modèle exactement.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.findOtherVehiculeWithElevation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.findOtherVehiculeWithElevation	
GO

CREATE PROCEDURE dbo.findOtherVehiculeWithElevation
	@matricule 			nvarchar(50), -- PK
	@itMustBeDone		bit, 		  -- true si c'est obligatoire (dans le cas d'une détérioration du véhicule), il faut modifier les réservations concernées
									  -- false si c'est pour étendre un contrat utiliser l'argument suivant
	@date_fin			datetime 	  -- permet de déterminer s'il est possible d'étendre la location jusqu'à cette date
AS
	BEGIN TRANSACTION findOtherVehiculeWithElevation
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
				@breakIsOK				int,
				@categorie				varchar(50);
				
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
																	AND serie_modele = @serie_modele
																	AND type_carburant_modele = @type_carburant_modele
																	AND portieres_modele = @portieres_modele);
	
/*		IF(@itMustBeDone = 'false')
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
*/
		--si @itMustBeDone = true
--		ELSE
--		BEGIN

			--pour chaque reservation qui correspondent aux vehicule endomager chercher un autre vehicule de meme modele qui colle au chreno
				--si trouver, mise a jour de la table ReservationVehicule avec le matricule du nouveau vehicule
				--si non un message de non possibiliter et on sort en annulant toute les modif precedente
			DECLARE @id_res int,
					@date_d datetime,
					@date_f datetime;

			DECLARE curseur_reservation CURSOR LOCAL FOR
				 SELECT r.id FROM ReservationVehicule rv, Reservation r WHERE rv.matricule_vehicule = @matricule
																		AND   rv.id_reservation = r.id

			OPEN curseur_reservation
			FETCH NEXT FROM curseur_reservation INTO @id_res

			WHILE @@FETCH_STATUS = 0
			BEGIN
				--curseur sur les vehicule de meme modele
				----------------------------
				SET @date_d= (SELECT date_debut FROM Reservation WHERE id=@id_res)
				SET @date_f= (SELECT date_fin FROM Reservation WHERE id=@id_res)
--K1-----------------------------------------------
				DECLARE curseur_matricule CURSOR FOR
						SELECT matricule FROM Vehicule WHERE marque_modele = @marque_modele
													   AND   serie_modele = @serie_modele
													   AND   type_carburant_modele = @type_carburant_modele
													   AND   portieres_modele = @portieres_modele
													   AND   matricule <> @matricule;
												   
				OPEN curseur_matricule
				FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
				SET @breakIsOK = 0;

				WHILE @@FETCH_STATUS = 0
				BEGIN

					--si aucune reservation n'occupe le chreno souhaiité, on retourne 1 pour le vehicule et on sort
					EXEC @isDispo = dbo.isDisponible1 @matricule_chreno, @date_d, @date_f

					IF( @isDispo = 1)
					BEGIN
					
						--modifie le matricule de la reservation dans reservation vehicule
						UPDATE ReservationVehicule SET matricule_vehicule = @matricule_chreno WHERE id_reservation = @id_res
																						      AND   matricule_vehicule = @matricule;
						SET @breakIsOK = 1;
						BREAK;
					END
					FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
				END
				CLOSE curseur_matricule
				DEALLOCATE curseur_matricule
--FIN K1-----------------------------------------------
				IF(@breakIsOK = 0)
				BEGIN
										PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele exactement');
										PRINT('findOtherVehicule : remplacer les reservation restante par des vehicule de meme equivalent avec surelevation');
					--K2-----------------------------------------------
										DECLARE curseur_matricule CURSOR FOR
											SELECT matricule FROM Vehicule WHERE marque_modele = @marque_modele
																		   AND   serie_modele = @serie_modele
																		   AND   type_carburant_modele <> @type_carburant_modele
																		   AND   portieres_modele <> @portieres_modele
																		   AND   matricule <> @matricule
																							 ;
																	   
									OPEN curseur_matricule
									FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
									SET @breakIsOK = 0;

									WHILE @@FETCH_STATUS = 0
									BEGIN

										--si aucune reservation n'occupe le chreno souhaiité, on retourne 1 pour le vehicule et on sort
										EXEC @isDispo = dbo.isDisponible1 @matricule_chreno, @date_d, @date_f

										IF( @isDispo = 1)
										BEGIN
										
											--modifie le matricule de la reservation dans reservation vehicule
											UPDATE ReservationVehicule SET matricule_vehicule = @matricule_chreno WHERE id_reservation = @id_res
																												  AND   matricule_vehicule = @matricule;
											SET @breakIsOK = 1;
											BREAK;
										END
										FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
									END
									CLOSE curseur_matricule
									DEALLOCATE curseur_matricule
					--FIN K2-----------------------------------------------
									IF(@breakIsOK = 0)
																BEGIN
																	PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele exactement');
																	PRINT('findOtherVehicule : remplacer les reservation restante par des vehicule de meme equivalent avec surelevation');
																	--ROLLBACK TRANSACTION findOtherVehicule
																	--RETURN -1;
												--K3 -----------------------------------------------				
																	
																	DECLARE curseur_matricule CURSOR FOR
																		SELECT matricule FROM Vehicule ,CategorieModel cm WHERE marque_modele = @marque_modele
																									   AND   serie_modele <> @serie_modele
																									   AND   type_carburant_modele <> @type_carburant_modele
																									   AND   portieres_modele <> @portieres_modele
																									   AND   matricule <> @matricule
																														   
																									   AND	marque_modele = cm.marque_modele
																									   AND  serie_modele=cm.serie_modele
																									   AND  type_carburant_modele = cm.type_carburant_modele
																									   AND  portieres_modele = cm.portieres_modele
																									   AND	cm.nom_categorie=@categorie;
																									   
																									  
																									   ;
																								   
																OPEN curseur_matricule
																FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
																SET @breakIsOK = 0;

																WHILE @@FETCH_STATUS = 0
																BEGIN

																	--si aucune reservation n'occupe le chreno souhaiité, on retourne 1 pour le vehicule et on sort
																	EXEC @isDispo = dbo.isDisponible1 @matricule_chreno, @date_d, @date_f

																	IF( @isDispo = 1)
																	BEGIN
																	
																		--modifie le matricule de la reservation dans reservation vehicule
																		UPDATE ReservationVehicule SET matricule_vehicule = @matricule_chreno WHERE id_reservation = @id_res
																																			  AND   matricule_vehicule = @matricule;
																		SET @breakIsOK = 1;
																		BREAK;
																	END
																	FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
																END
																CLOSE curseur_matricule
																DEALLOCATE curseur_matricule
											     --FIN K3-----------------------------------------------
																									IF(@breakIsOK = 0)
																									BEGIN
																										PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele exactement');
																										PRINT('findOtherVehicule : remplacer les reservation restante par des vehicule de meme equivalent avec surelevation');
																										
																										--K 4-----------------------------------------------
																																DECLARE curseur_matricule CURSOR FOR
																																SELECT matricule FROM Vehicule v,CategorieModele cm WHERE v.marque_modele <> @marque_modele
																																										   AND   v.serie_modele <> @serie_modele
																																										   AND   v.type_carburant_modele = @type_carburant_modele
																																										   AND   v.portieres_modele = @portieres_modele
																																										   AND   v.matricule <> @matricule
																																										   
																																										   AND	v.marque_modele = cm.marque_modele
																																										   AND  v.serie_modele=cm.serie_modele
																																										   AND  v.type_carburant_modele = cm.type_carburant_modele
																																										   AND  v.portieres_modele = cm.portieres_modele
																																										   AND	cm.nom_categorie=@categorie;
																																																	
																																									   
																																	OPEN curseur_matricule
																																	FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
																																	SET @breakIsOK = 0;

																																	WHILE @@FETCH_STATUS = 0
																																	BEGIN

																																		--si aucune reservation n'occupe le chreno souhaiité, on retourne 1 pour le vehicule et on sort
																																		EXEC @isDispo = dbo.isDisponible1 @matricule_chreno, @date_d, @date_f

																																		IF( @isDispo = 1)
																																		BEGIN
																																		
																																			--modifie le matricule de la reservation dans reservation vehicule
																																			UPDATE ReservationVehicule SET matricule_vehicule = @matricule_chreno WHERE id_reservation = @id_res
																																																				  AND   matricule_vehicule = @matricule;
																																			SET @breakIsOK = 1;
																																			BREAK;
																																		END
																																		FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
																																	END
																																	CLOSE curseur_matricule
																																	DEALLOCATE curseur_matricule
																											--FIN K4-----------------------------------------------
																																	IF(@breakIsOK = 0)
																																	
																																	BEGIN
																																	PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele exactement');
																																	PRINT('findOtherVehicule : remplacer les reservation restante par des vehicule de meme equivalent avec surelevation');
																													-- K5-----------------------------------------------								
																																								DECLARE curseur_matricule CURSOR FOR
																																											SELECT v.matricule FROM Vehicule v,CategorieModele cm WHERE cm.marque_modele = v.marque_modele
																																																					   AND  cm.serie_modele = v.serie_modele
																																																					   AND  cm.type_carburant_modele = v.type_carburant_modele
																																																					   AND  cm.portieres_modele = v.portieres_modele
																																																					   AND	v.matricule <> @matricule
																																																					   AND	cm.nom_categorie=@categorie
																																																					   AND v.matricule NOT IN (SELECT v2.matricule FROM Vehicule v2  WHERE cm.marque_modele = v2.marque_modele
																																																																						AND  cm.serie_modele = v2.serie_modele
																																																																					   AND  cm.type_carburant_modele = v2.type_carburant_modele
																																																																					   AND  cm.portieres_modele = v2.portieres_modele);
																																																				   
																																												OPEN curseur_matricule
																																												FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
																																												SET @breakIsOK = 0;

																																												WHILE @@FETCH_STATUS = 0
																																												BEGIN

																																													--si aucune reservation n'occupe le chreno souhaiité, on retourne 1 pour le vehicule et on sort
																																													EXEC @isDispo = dbo.isDisponible1 @matricule_chreno, @date_d, @date_f

																																													IF( @isDispo = 1)
																																													BEGIN
																																													
																																														--modifie le matricule de la reservation dans reservation vehicule
																																														UPDATE ReservationVehicule SET matricule_vehicule = @matricule_chreno WHERE id_reservation = @id_res
																																																															  AND   matricule_vehicule = @matricule;
																																														SET @breakIsOK = 1;
																																														BREAK;
																																													END
																																													FETCH NEXT FROM curseur_matricule INTO @matricule_chreno
																																												END
																																												CLOSE curseur_matricule
																																												DEALLOCATE curseur_matricule
																																						--FIN K5-----------------------------------------------
																																												IF(@breakIsOK = 0)
																																												
																																												BEGIN
																																												PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele');
																																												ROLLBACK TRANSACTION findOtherVehicule
																																												RETURN -1;
																																										
																																						END
																											
																											END
																END

									END
				-----------------------------
				FETCH NEXT FROM curseur_reservation INTO @id_res
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

