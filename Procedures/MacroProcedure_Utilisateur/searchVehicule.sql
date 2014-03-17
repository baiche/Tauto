------------------------------------------------------------
-- Fichier     : searchVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.searchVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.searchVehicule	
GO

CREATE PROCEDURE dbo.searchVehicule
	@nom_categorie			nvarchar(50), -- nullable
	@marque 				nvarchar(50), -- nullable
	@serie 					nvarchar(50), -- nullable
	@type_carburant 		nvarchar(50), -- nullable
	@portieres 				tinyint, -- nullable
	@prix_max 				money, -- nullable
	@prix_min 				money, -- nullable
	@date_debut 			date, -- nullable
	@date_fin 				date -- nullable
AS
	BEGIN TRANSACTION searchVehicule
	BEGIN TRY
	
		--On crée la table qui va contenir tous les vehicule correspondant aux différents filtre
		CREATE TABLE #out (
		matricule 			nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^([a-zA-Z0-9-]+)$',matricule) = 1), --ex: AX-580-VT ca correspond??
		kilometrage 		int 							NOT NULL 	DEFAULT 0,
		couleur 			nvarchar(50) 					NOT NULL 	DEFAULT 'Gris'			CHECK(couleur IN('Bleu', 'Blanc', 'Rouge', 'Noir', 'Gris')), --c'est un enum  A changer
		statut 				nvarchar(50) 					NOT NULL 	DEFAULT 'Disponible'	CHECK(statut IN('Disponible', 'Louee', 'En panne', 'Perdue')), --c'est un enum
		num_serie			nvarchar(50)					NOT NULL							CHECK( dbo.clrRegex('^(([a-zA-Z0-9-\.]|\s)+)$',num_serie) = 1),
  		marque_modele 		nvarchar(50) 					NOT NULL,
		serie_modele 		nvarchar(50) 					NOT NULL,
		portieres_modele 	tinyint 						NOT NULL,
		date_entree			date							NOT NULL	DEFAULT GETDATE(), 
		type_carburant_modele nvarchar(50) 					NOT NULL, --c'est un enum
		a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
		)
		
		CREATE TABLE #in (
		matricule 			nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^([a-zA-Z0-9-]+)$',matricule) = 1), --ex: AX-580-VT ca correspond??
		kilometrage 		int 							NOT NULL 	DEFAULT 0,
		couleur 			nvarchar(50) 					NOT NULL 	DEFAULT 'Gris'			CHECK(couleur IN('Bleu', 'Blanc', 'Rouge', 'Noir', 'Gris')), --c'est un enum  A changer
		statut 				nvarchar(50) 					NOT NULL 	DEFAULT 'Disponible'	CHECK(statut IN('Disponible', 'Louee', 'En panne', 'Perdue')), --c'est un enum
		num_serie			nvarchar(50)					NOT NULL							CHECK( dbo.clrRegex('^(([a-zA-Z0-9-\.]|\s)+)$',num_serie) = 1),
  		marque_modele 		nvarchar(50) 					NOT NULL,
		serie_modele 		nvarchar(50) 					NOT NULL,
		portieres_modele 	tinyint 						NOT NULL,
		date_entree			date							NOT NULL	DEFAULT GETDATE(), 
		type_carburant_modele nvarchar(50) 					NOT NULL, --c'est un enum
		a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
		)
		
		-- On met tous les vehicule louable en table de resultat
		INSERT INTO #out
		SELECT * 
		FROM Vehicule 
		WHERE statut = 'Disponible'
		AND a_supprimer = 'false'
		
		--si le nom de la categorie a été renseigné
		IF (@nom_categorie <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			
			INSERT INTO #out
			SELECT * FROM #in i, Modele m, CategorieModele cm
			WHERE  i.marque_modele = cm.marque_modele
			AND i.serie_modele = cm.serie_modele
			AND i.type_carburant_modele = cm.type_carburant_modele
			AND i.portieres_modele = cm.portieres_modele
			AND cm.nom_categorie = @nom_categorie
		END
		
		--si la marque a été renseignée
		IF (@marque <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE  i.marque_modele = @marque
		END
		
		--si la serie a été renseignée
		IF (@serie <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE  i.serie_modele = @serie
		END
		
		--si le type de carburant a été renseigné
		IF (@type_carburant <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE  i.type_carburant_modele = @type_carburant
		END
		
		--si le nombre de portières a a été renseigné
		IF (@portieres <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE  i.portieres_modele = @portieres
		END
		
		--si le prix maximum a été renseigné
		IF (@prix_max <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i, Modele m
			WHERE   i.marque_modele = m.marque
			AND i.serie_modele = m.serie
			AND i.type_carburant_modele = m.type_carburant
			AND i.portieres_modele = m.portieres
			AND m.prix <=  @prix_max
		END
		
		--si le prix minimum a été renseigné
		IF (@prix_min <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i, Modele m
			WHERE   i.marque_modele = m.marque
			AND i.serie_modele = m.serie
			AND i.type_carburant_modele = m.type_carburant
			AND i.portieres_modele = m.portieres
			AND m.prix >= @prix_min
		END
		
		--si la date de début a été renseigné
		IF (@date_debut <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE i.matricule NOT IN (
					SELECT i2.matricule
					FROM #in i2, Location l1, Etat e
					WHERE i.matricule = l1.matricule_vehicule
					AND e.id = l1.id_contratLocation
					AND (e.date_avant > @date_debut
					OR e.date_apres < @date_debut)
			  )
			AND i.matricule NOT IN (
				SELECT i3.matricule
				FROM #in i3, ReservationVehicule rv, Reservation r
				WHERE i.matricule = rv.matricule_vehicule
				AND rv.id_reservation = r.id
				AND (r.date_debut > @date_debut
					OR r.date_fin < @date_debut)
			)
		END
		
		--si la date de fin a été renseignée
		IF (@date_fin <> NULL)
		BEGIN
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE i.matricule NOT IN (
					SELECT i2.matricule
					FROM #in i2, Location l1, Etat e
					WHERE i2.matricule = l1.matricule_vehicule
					AND e.id = l1.id_contratLocation
					AND (e.date_avant > @date_fin
					OR e.date_apres < @date_fin)
			  )
			AND i.matricule NOT IN (
				SELECT i3.matricule
				FROM #in i3, ReservationVehicule rv, Reservation r
				WHERE i3.matricule = rv.matricule_vehicule
				AND rv.id_reservation = r.id
				AND (r.date_debut > @date_fin
					OR r.date_fin < @date_fin)
			)
		END
		
		--si les dates de debut et de fin ont été renseignées
		IF (@date_debut <> NULL AND @date_fin <> NULL )
		BEGIN
			IF (@date_debut > @date_fin)
			BEGIN
				PRINT('searchVehicule: La date de début doit être supèrieur a la date de fin');
				ROLLBACK TRANSACTION searchVehicule
				RETURN -1;
			END
		
			--recuperation du résultat précedent
			INSERT INTO #in
			SELECT * FROM #out
			--on vide la table recevant les resultats
			DELETE FROM #out
			--on insère les nouveaux résultats
			INSERT INTO #out
			SELECT * FROM #in i
			WHERE i.matricule NOT IN (
					SELECT i2.matricule
					FROM #in i2, Location l1, Etat e
					WHERE i2.matricule = l1.matricule_vehicule
					AND e.id = l1.id_contratLocation
					AND ((e.date_avant > @date_fin 
							AND e.date_avant > @date_debut)
						OR (e.date_apres < @date_fin
							AND e.date_apres < @date_debut))
			  )
			AND i.matricule NOT IN (
				SELECT i3.matricule
				FROM #in i3, ReservationVehicule rv, Reservation r
				WHERE i3.matricule = rv.matricule_vehicule
				AND rv.id_reservation = r.id
				AND ((r.date_debut > @date_fin 
						AND r.date_debut > @date_debut)
					OR (r.date_fin < @date_fin
						AND r.date_fin < @date_fin))
			)
		END
	
	
		COMMIT TRANSACTION searchVehicule
		PRINT('searchVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('searchVehicule: ERROR');
		ROLLBACK TRANSACTION searchVehicule
		RETURN -1;
	END CATCH
GO