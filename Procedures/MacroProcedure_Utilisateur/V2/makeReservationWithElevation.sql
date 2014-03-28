------------------------------------------------------------
-- Fichier     : makeReservationWithElevation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : Baiche Mourad
-- Integrateur : 
-- Commentaire : Renvoie l'id de la réservation, -1 en cas d'erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeReservationWithElevation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeReservationWithElevation	
GO

CREATE PROCEDURE dbo.makeReservationWithElevation
	@id_abonnement			int, -- FK
	@date_debut				dateTime,
	@date_fin				dateTime,
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	
	BEGIN TRANSACTION makeReservationWithElevation
	BEGIN TRY
		DECLARE @idRes 				int,
				@matricule 			VARCHAR(50),
				@matricule_dispo 	VARCHAR(50),
				@isDispo			int,
				@categorie			VARCHAR(50);
				
		DECLARE @marque_tmp	nvarchar(50), 
				@serie_tmp nvarchar(50), 
				@type_carburant_tmp nvarchar(50), 
				@portieres_tmp tinyint;
				
		SET @matricule_dispo = '0';
			
		 -- verifier s'il a le droit d'emprunter
		IF ((SELECT COUNT(*) FROM ListeNoire ln,Abonnement a WHERE a.nom_compteabonne=ln.nom AND a.prenom_compteabonne=ln.prenom AND a.date_naissance_compteabonne=ln.date_naissance ) !=0 )
		BEGIN
			PRINT('vous ne pouvez pas reserver vous etes en liste noire')
			return -1;
		END
		ELSE			
		BEGIN
		-- verifier si on a un vehicule disponible
			DECLARE matricule_cursor CURSOR LOCAL  
				FOR SELECT matricule FROM Vehicule WHERE marque_modele=@marque 
												   AND   serie_modele=@serie 
												   AND   portieres_modele=@portieres 
												   AND   type_carburant_modele=@type_carburant 
												   AND   a_supprimer='false';  

			OPEN matricule_cursor
			FETCH NEXT FROM matricule_cursor INTO @matricule;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC @isDispo = dbo.isDisponible1 @matricule, @date_debut, @date_fin
				IF (@isDispo = 1)
				BEGIN
					SET @matricule_dispo=@matricule;
					BREAK;
				END
				FETCH NEXT FROM matricule_cursor INTO @matricule 
			END 	
			CLOSE matricule_cursor;
			DEALLOCATE matricule_cursor;
			
			IF @matricule_dispo ='0'
			BEGIN
				PRINT('Aucun vehicule disponible pour le modele souhaiton, nous cherchons un autre vehicule de meme categorie');
				PRINT('-------------------------------------------------------------------');
				--on cherche un vehicule dans une categorie equivalente en gardant nb_porte et type_carburant
				SET @categorie = (SELECT nom_categorie FROM CategorieModele WHERE marque_modele = @marque
																			AND	  serie_modele = @serie
																			AND   type_carburant_modele = @type_carburant
																			AND   portieres_modele = @portieres);
				
				DECLARE model_cursor CURSOR LOCAL
				  FOR SELECT m.marque, m.serie, m.type_carburant, m.portieres FROM Modele m, CategorieModele cm WHERE m.marque = cm.marque_modele
																											AND   m.serie = cm.serie_modele
																											AND	  m.type_carburant = cm.type_carburant_modele
																											AND   m.portieres = cm.portieres_modele
																											AND   cm.nom_categorie = @categorie
																											AND   (m.marque <> @marque
																											OR    m.serie <> @serie
																											OR	  m.type_carburant <> @type_carburant
																											OR    m.portieres <> @portieres);
				OPEN model_cursor
				FETCH NEXT FROM model_cursor INTO @marque_tmp, @serie_tmp, @type_carburant_tmp, @portieres_tmp ;
				WHILE @@FETCH_STATUS = 0
				BEGIN
				
				--------boucle sur vehicule de meme modele
					DECLARE matricule_cursor CURSOR LOCAL  
						FOR SELECT matricule FROM Vehicule WHERE marque_modele=@marque_tmp 
														   AND   serie_modele=@serie_tmp 
														   AND   portieres_modele=@portieres_tmp 
														   AND   type_carburant_modele=@type_carburant_tmp 
														   AND   a_supprimer='false';  
														   
					OPEN matricule_cursor
					FETCH NEXT FROM matricule_cursor INTO @matricule;
					WHILE @@FETCH_STATUS = 0
					BEGIN
						
						EXEC @isDispo = dbo.isDisponible1 @matricule, @date_debut, @date_fin
						IF (@isDispo = 1)
						BEGIN						
							PRINT('Information du vehicule trouver-------------------------------------------------------------------');
							PRINT 'Marque : ' + convert(varchar(50),@marque_tmp);
							PRINT 'Serie : ' + convert(varchar(50),@serie_tmp);
							PRINT 'Type de carburant : ' + convert(varchar(50),@type_carburant_tmp);
							PRINT 'Nombre de porte : ' + convert(varchar(50),@portieres_tmp);
							PRINT 'Matricule : ' + convert(varchar(50),@matricule);
							PRINT('FIN Vehicule trouver-------------------------------------------------------------------');
							BREAK;
						END
						FETCH NEXT FROM matricule_cursor INTO @matricule 
					END 	
					CLOSE matricule_cursor;
					DEALLOCATE matricule_cursor;

				----------fin boucle sur vehicule de meme modele
					FETCH NEXT FROM model_cursor INTO @marque_tmp, @serie_tmp, @type_carburant_tmp, @portieres_tmp ;
				END 	
				CLOSE model_cursor;
				DEALLOCATE model_cursor;
				PRINT('-------------------------------------------------------------------');
				PRINT('FIN de recherche de vehicule equivalent');
				ROLLBACK TRANSACTION makeReservationWithElevation
				RETURN -1;
				
			END 

			EXEC @idRes = dbo.createReservation @date_debut, @date_fin, @id_abonnement;
			EXEC dbo.addVehiculeToReservation @idRes, @matricule_dispo ;

		END--fin else
	 
		COMMIT TRANSACTION makeReservationWithElevation
		PRINT('makeReservationWithElevation OK');
		RETURN @idRes;
	END TRY
	BEGIN CATCH
		PRINT('makeReservationWithElevation: ERROR');
		ROLLBACK TRANSACTION makeReservationWithElevation
		RETURN -1;
	END CATCH
GO