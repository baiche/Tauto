------------------------------------------------------------
-- Fichier     : makeReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : David Lecoconnier & Neti Mohamed
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Renvoie l'id de la réservation, -1 en cas d'erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeReservation	
GO

CREATE PROCEDURE dbo.makeReservation
	@id_abonnement			int, -- FK
	@date_debut				dateTime,
	@date_fin				dateTime,
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	
	BEGIN TRANSACTION makeReservation
	BEGIN TRY
		DECLARE @idRes 				int,
				@matricule 			VARCHAR(50),
				@matricule_dispo 	VARCHAR(50),
				@isDispo			int,
				@categorie			VARCHAR(50);
				
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
																											AND   m.marque <> @marque
																											AND   m.serie <> @serie
																											AND	  m.type_carburant <> @type_carburant
																											AND   m.portieres <> @portieres;
				OPEN model_cursor
				FETCH NEXT FROM model_cursor INTO @marque, @serie, @type_carburant, @portieres ;
				WHILE @@FETCH_STATUS = 0
				BEGIN
				--------boucle sur vehicule de meme modele
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
							PRINT('Information du vehicule trouver-------------------------------------------------------------------');
							PRINT 'Marque : ' + convert(varchar(50),@marque);
							PRINT 'Serie : ' + convert(varchar(50),@serie);
							PRINT 'Type de carburant : ' + convert(varchar(50),@type_carburant);
							PRINT 'Nombre de porte : ' + convert(varchar(50),@portieres);
							PRINT 'Matricule : ' + convert(varchar(50),@matricule);
							PRINT('FIN Vehicule trouver-------------------------------------------------------------------');
							BREAK;
						END
						FETCH NEXT FROM matricule_cursor INTO @matricule 
					END 	
					CLOSE matricule_cursor;
					DEALLOCATE matricule_cursor;
				
				----------fin boucle sur vehicule de meme modele

				END 	
				CLOSE model_cursor;
				DEALLOCATE model_cursor;
				PRINT('-------------------------------------------------------------------');
				PRINT('FIN de recherche de vehicule equivalent');
				ROLLBACK TRANSACTION makeReservation
				RETURN -1;
				
			END 

			EXEC @idRes = dbo.createReservation @date_debut, @date_fin, @id_abonnement;
			EXEC dbo.addVehiculeToReservation @idRes, @matricule_dispo ;

		END--fin else
	 
		COMMIT TRANSACTION makeReservation
		PRINT('makeReservation OK');
		RETURN @idRes;
	END TRY
	BEGIN CATCH
		PRINT('makeReservation: ERROR');
		ROLLBACK TRANSACTION makeReservation
		RETURN -1;
	END CATCH
GO