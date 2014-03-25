------------------------------------------------------------
-- Fichier     : findOtherVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Renvoie 1 si l'action a pu être faite, une exception en cas d'erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.findOtherVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.findOtherVehicule	
GO

CREATE PROCEDURE dbo.findOtherVehicule
	@matricule 			nvarchar(50), -- PK
	@itMustBeDone		bit, -- true si c'est obligatoire (dans le cas d'une détérioration du véhicule), il faut modifier les réservations concernées
							 -- false si c'est pour étendre un contrat utiliser l'argument suivant
	@date_fin			datetime -- permet de déterminer s'il est possible d'étendre la location jusqu'à cette date
							 -- false si c'est pour étendre un contrat, utiliser l'argument suivant
	@date_fin			date -- permet de déterminer s'il est possible d'étendre la location jusqu'à cette date. Le conflit est obligatoirement avec la date de début !
AS
	--BEGIN TRANSACTION findOtherVehicule
	BEGIN TRY
		DECLARE @matricule_chreno nvarchar(50);
		DECLARE @marque_modele			nvarchar(50),
				@serie_modele			nvarchar(50),
				@type_carburant_modele 	nvarchar(50),
				@portieres_modele		tinyint,
				@date_fin_location 		datetime,
				@isDispo				int,
				@idAbonne				int,
				@returnPS				int,
				@asLocation				int;
				
		IF ( @matricule IS NULL)
		BEGIN
			PRINT('findOtherVehicule : ERROR veuillez indiquer le matricule du véhicule');
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
				RETURN -1;
			END
			IF ( @date_fin < GETDATE())
			BEGIN
				PRINT('findOtherVehicule : ERROR la date de fin indiquer pour etendre la location est déjà passée');
				RETURN -1;
			END
			
			--verifier qu'il existe une location en cours pour ce vehicule
			SET @asLocation	= (SELECT COUNT(cl.date_fin) FROM ContratLocation cl, Location l WHERE l.matricule_vehicule = @matricule
																							 AND   l.id_contratLocation = cl.id
																							 AND   cl.date_fin_effective IS NULL);
			IF ( @asLocation = 0)
			BEGIN
				PRINT('findOtherVehicule : ERROR pas de location en cours pour le vehicule indiqué');
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
				RETURN -1;
			END
			
			--e.debut = @date_fin_location
			--e.fin = @date_fin
			
			--compte le nombre de reservation qui rentre dans le chreno qui nous interresse pour notre vehicule
			SET @isDispo = (SELECT COUNT(rv.id_reservation) FROM Reservation r, ReservationVehicule rv WHERE rv.matricule_vehicule = @matricule
																									   AND   rv.id_reservation = r.id
																									   AND   r.annule = 'false'
																									   AND	
																									      ((r.date_debut < @date_fin_location AND   r.date_fin > @date_fin_location)
																									   OR
																									      (r.date_debut > @date_fin_location AND   r.date_fin < @date_fin)
																									   OR
																									      (r.date_debut < @date_fin AND   r.date_fin > @date_fin)
																									   OR
																									      (r.date_debut < @date_fin_location AND   r.date_fin > @date_fin)));
			
			--si aucune reservation n'occupe le chreno souhaiité, on modifie la date fin du contrat de location
			IF(@isDispo = 0)
			BEGIN																		  
				UPDATE cl SET date_fin = @date_fin FROM ContratLocation cl JOIN Location l ON l.id_contratLocation = cl.id  WHERE l.matricule_vehicule = @matricule 
																															AND   cl.date_fin_effective IS NULL;
				PRINT('findOtherVehicule : INFO le vehicule est disponible pour la prologation, prolongation effectué avec succés');
				RETURN 1;
			END
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
					SET @isDispo = (SELECT COUNT(rv.id_reservation) FROM Reservation r, ReservationVehicule rv WHERE rv.matricule_vehicule = @matricule_chreno
																											   AND   rv.id_reservation = r.id
																											   AND   r.annule = 'false'
																											   AND	
																													((r.date_debut < @date_fin_location AND   r.date_fin > @date_fin_location)
																											   OR
																													(r.date_debut > @date_fin_location AND   r.date_fin < @date_fin)
																											   OR
																													(r.date_debut < @date_fin AND   r.date_fin > @date_fin)
																											   OR
																													(r.date_debut < @date_fin_location AND   r.date_fin > @date_fin)));
			
					--si aucune reservation n'occupe le chreno souhaiité, on on cré un reservation pour le vehicule et on sort
					IF(@isDispo = 0)
					BEGIN																		  
						--creation de la reservation
						EXEC @returnPS = dbo.createReservation @date_fin_location, @date_fin, @idAbonne;
						INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule)VALUES (@returnPS,@matricule_chreno);
						PRINT('findOtherVehicule : INFO un autre vehicule est disponible pour la prologation, reservation effectué avec succés');
						CLOSE curseur_matricule
						DEALLOCATE curseur_matricule
						RETURN 1;
					END

					FETCH curseur_auteurs INTO @matricule_chreno
				END
				CLOSE curseur_matricule
				DEALLOCATE curseur_matricule
				PRINT('findOtherVehicule : INFO Aucun autre vehicule de meme modele n''est disponible pour la prologation, ECHEC de la prolongation');
				RETURN -1;
			END			
		END
		--si @itMustBeDone = true
		ELSE
		BEGIN
			PRINT('faut trip de boulot, j lache l''affaire mdrrrr');
		
		END
		
		
		
		
	
	
		--COMMIT TRANSACTION modifyConducteur
		RETURN -1;
	
		PRINT('findOtherVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('findOtherVehicule: ERROR');
		RETURN -1;
	END CATCH
GO
