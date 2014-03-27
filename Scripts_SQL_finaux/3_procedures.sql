------------------------------------------------------------
-- Fichier     : 3_procedures
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script sql ajoutant toutes les procedures 
-- dans la base
------------------------------------------------------------

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

------------------------------------------------------------
-- Fichier     : ProcedureAnnexe.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : procedure "videTables" : Vider toutes les tables
------------------------------------------------------------


USE TAuto_IBDR;
GO

IF EXISTS (SELECT name FROM  sysobjects WHERE name = 'videTables' AND type = 'P')
BEGIN
    DROP PROCEDURE dbo.videTables
END
GO

CREATE PROCEDURE dbo.videTables
AS
BEGIN
	PRINT('Vider toutes les tables - Debut');
	PRINT('===============================');
	
	SET NOCOUNT  ON  

	DELETE FROM ReservationVehicule
	DELETE FROM CatalogueCategorie
	DELETE FROM CategorieModele
	DELETE FROM ConducteurLocation
	DELETE FROM CompteAbonneConducteur
	DELETE FROM Catalogue
	DELETE FROM Categorie
	DELETE FROM SousPermis
	DELETE FROM Conducteur
	DELETE FROM Permis
	DELETE FROM Reservation
	DELETE FROM Infraction
	DELETE FROM Incident
	DELETE FROM Retard
	DELETE FROM Location
	DELETE FROM Vehicule
	DELETE FROM Modele
	DELETE FROM ContratLocation
	DELETE FROM Abonnement
	DELETE FROM TypeAbonnement
	DELETE FROM RelanceDecouvert
	DELETE FROM Particulier
	DELETE FROM Entreprise
	DELETE FROM CompteAbonne
	DELETE FROM Facturation
	DELETE FROM Etat
	DELETE FROM ListeNoire
	
	SET NOCOUNT OFF  
	
	PRINT('Vider toutes les tables - Fin');
	PRINT('=============================');
END
GO

------------------------------------------------------------
-- Fichier     : Procedure_greyListCompteAbonne
-- Date        : 11/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.greyListCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.greyListCompteAbonne
GO

CREATE PROCEDURE dbo.greyListCompteAbonne
	@nom_abonne 				nvarchar(50),
	@prenom_abonne 				nvarchar(50),
	@date_naissance_abonne 		date
AS
	UPDATE CompteAbonne 
	SET liste_grise = 'true' 
	WHERE nom = @nom_abonne
	AND prenom = @prenom_abonne 
	AND date_naissance = @date_naissance_abonne;
GO


------------------------------------------------------------
-- Fichier     : Procedure_updateNiveauRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Augmente le niveau d'une RelanceDecouvert et remet la date à jour.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateNiveauRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateNiveauRelanceDecouvert
GO

CREATE PROCEDURE dbo.updateNiveauRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date,
	@date_creation					datetime
AS
	UPDATE RelanceDecouvert
	SET niveau = niveau + 1
	WHERE   nom_compteabonne = @nom_compteabonne 
		AND prenom_compteabonne = @prenom_compteabonne
		AND date_naissance_compteabonne = @date_naissance_compteabonne
		AND date = @date_creation;

GO

------------------------------------------------------------
-- Fichier     : Procedure_disableRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met le champ a_supprimer d'une RelanceDecouvert a true
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.disableRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableRelanceDecouvert
GO

CREATE PROCEDURE dbo.disableRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date,
	@date							datetime
AS
	UPDATE RelanceDecouvert
	SET a_supprimer = 'true'
	WHERE   nom_compteabonne = @nom_compteabonne
		AND prenom_compteabonne = @prenom_compteabonne
		AND date_naissance_compteabonne = @date_naissance_compteabonne
		AND date = @date;

GO

------------------------------------------------------------
-- Fichier     : Procedure_createRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée une nouvelle RelanceDecouvert à la date actuelle et au niveau 0.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createRelanceDecouvert
GO

CREATE PROCEDURE dbo.createRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date
AS
	INSERT INTO RelanceDecouvert(
		nom_compteabonne,
		prenom_compteabonne,
		date_naissance_compteabonne
	)
	VALUES (
		@nom_compteabonne,
		@prenom_compteabonne,
		@date_naissance_compteabonne
	);
	
GO


------------------------------------------------------------
-- Fichier     : Procedure_updateContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un contrat de location. Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateContratLocation
GO

CREATE PROCEDURE dbo.updateContratLocation
	@id						int,
	@date_fin_effective 	datetime,
	@extension 				int
AS
	/*BEGIN TRANSACTION updateContratLocation
	BEGIN TRY		
		IF ( (SELECT COUNT(*) FROM ContratLocation WHERE id = @id) = 1)
		BEGIN*/
			IF (@date_fin_effective IS NOT NULL)
			BEGIN
				IF ( (SELECT date_debut FROM ContratLocation WHERE id = @id) > @date_fin_effective)
				BEGIN
					/*PRINT('updateContratLocation: ERROR, date de fin réelle inférieure à la date de début');
					ROLLBACK TRANSACTION updateContratLocation
					RETURN -1;*/
					RAISERROR('Modification de des dates impossibles, debut > fin', 10, 1);
				END
				UPDATE ContratLocation
				SET
					date_fin_effective = @date_fin_effective
				WHERE id = @id;
			END
			
			IF (@extension IS NOT NULL)
			BEGIN
				UPDATE ContratLocation
				SET
					extension = @extension
				WHERE id = @id;
			END
			
			RETURN 1;
			/*PRINT('ContratLocation mis à jour');
			COMMIT TRANSACTION updateContratLocation
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('updateContratLocation: ERROR, introuvable');
			ROLLBACK TRANSACTION updateContratLocation
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('updateContratLocation: ERROR');
		ROLLBACK TRANSACTION updateContratLocation
		RETURN -1;
	END CATCH*/
GO

------------------------------------------------------------
-- Fichier     : Procedure_printFacturation
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : affiche la partie d'une facture concernant 
--				 1 location.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.printFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.printFacturation;
GO


CREATE PROCEDURE dbo.printFacturation
	@id_location 					int
AS
-- declaration des variables
DECLARE @matricule  nvarchar(50);
DECLARE @id_facture int;
DECLARE @montant money;
DECLARE @tva money;

-- obtention des valeurs necessaire a l'affichage
SET @matricule =(SELECT matricule_vehicule FROM Location WHERE Location.id = @id_location);
SET @id_facture = (SELECT id_facturation FROM Location WHERE Location.id = @id_location);
SET @montant = (SELECT montant FROM Facturation WHERE Facturation.id = @id_facture);
SET @tva = @montant - (@montant / 1.196) ;

--affichage de la facture liée à une location
PRINT '_________________________________________________________________________';
PRINT 'FACTURE numero : ' + convert(varchar(10),@id_facture);
PRINT 'Location du vehicule ' + @matricule +' montant : ' + convert(varchar(10),@montant) + 'euros dont TVA : ' + convert(varchar(10),@tva) + ' euros' ;
PRINT '_________________________________________________________________________';


GO


------------------------------------------------------------
-- Fichier     : Procedure_printContratLocation
-- Date        : 07/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Affiche la facture d'un contrat_location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.printContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.printContratLocation
GO

CREATE PROCEDURE dbo.printContratLocation
	@id_contrat_location	int
AS
	BEGIN TRY
		--récupération de toute les locations liées au contrat
		CREATE TABLE #Temp(id_location int);
		INSERT INTO #Temp(id_location)
		SELECT id FROM Location WHERE Location.id_contratLocation = @id_contrat_location
		
		-- déclaration et initialisation des variables
		DECLARE @nb_location int
		DECLARE @id_location int
		DECLARE @total money
		SET @total = 0
		DECLARE @total_tva money
		SET @nb_location = (SELECT COUNT(*) FROM #Temp)
		
		-- affichage de l'en-tête du contrat
		PRINT 'contrat_location numero : ' + CONVERT(varchar(10), @id_contrat_location) + ' nombre de véhicules loué(s) : ' + CONVERT(varchar(10), @nb_location)
		
		-- affichage des factures liée a chaque contrat et calcul du total
		DECLARE Curseur_location CURSOR LOCAL FOR SELECT id_location FROM dbo.#Temp; 
		OPEN  Curseur_location
		FETCH NEXT FROM Curseur_location INTO @id_location
		WHILE	@@FETCH_STATUS=0
		BEGIN	
			EXEC dbo.printFacturation @id_location;
			SET @total += (SELECT  f.montant 
							FROM Facturation f, Location l
							WHERE l.id = @id_location
							AND l.id_facturation = f.id)
							
			FETCH NEXT FROM Curseur_location INTO @id_location
		END
		CLOSE Curseur_Location
		SET @total_tva = @total - (@total / 1.196)
		
		--affichage de la fin du contrat
		PRINT 'total : ' + CONVERT(varchar(10),@total) + ' dont TVA : ' + CONVERT(varchar(10), @total_tva)
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.printContratLocation',10,1)
	END CATCH	
GO

------------------------------------------------------------
-- Fichier     : Procedure_createFacturation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ajoute une facture a la location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createFacturation;
GO

--crée une nouvelle facturation lié à la location avec le montant non encore calculé et le paiement 
CREATE PROCEDURE dbo.createFacturation
	@montant		money
AS
	INSERT INTO Facturation(
		montant
	) VALUES (
		@montant
	);
	RETURN SCOPE_IDENTITY();
	
GO


------------------------------------------------------------
-- Fichier     : Procedure_setStatutVehicule
-- Date        : 04/04/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------


USE TAuto_IBDR;

IF OBJECT_ID ('dbo.setStatutVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.setStatutVehicule
GO

CREATE PROCEDURE dbo.setStatutVehicule
	@matricule 				nvarchar(50),
	@statut					nvarchar(50)
	
AS
	UPDATE Vehicule
	SET statut = @statut

	WHERE 	matricule = @matricule;

GO

------------------------------------------------------------
-- Fichier     : Procedure_setKilometrageVehicule
-- Date        : 04/04/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.setKilometrageVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.setKilometrageVehicule
GO

CREATE PROCEDURE dbo.setKilometrageVehicule
	@matricule 				nvarchar(50),
	@kilometrage 			int
	
AS
	UPDATE Vehicule
	SET	kilometrage = @kilometrage
	WHERE 	matricule = @matricule;

GO

------------------------------------------------------------
-- Fichier     : Procedure_updateEtat
-- Date        : 20/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un Etat
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateEtat
GO

-- Cette procedure permet de creer modifier un etat

CREATE PROCEDURE dbo.updateEtat
	@id 				int, -- PK
	@date_apres	 		datetime,
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat				bit
AS
	UPDATE Etat
	SET
		date_apres = @date_apres,
		km_apres = @km_apres,
		fiche_apres = @fiche_apres,
		degat = @degat
	WHERE id = @id
GO

------------------------------------------------------------
-- Fichier     : Procedure_updateLocation
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie une location
------------------------------------------------------------


USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateLocation
GO

CREATE PROCEDURE dbo.updateLocation
	@id 					int,
	@id_facturation 		int, -- nullable
	@id_etat			 	int  -- nullable
AS
	IF (@id IS NULL)
		RAISERROR('Mauvais id', 10, -1);
		
	IF ( @id_facturation IS NOT NULL)
	BEGIN
		UPDATE Location
		SET id_facturation = @id_facturation
		WHERE id = @id;
	END
	IF ( @id_etat IS NOT NULL)
	BEGIN
		UPDATE Location
		SET id_etat = @id_etat
		WHERE id = @id;
	END
	
GO

/*CREATE PROCEDURE dbo.updateLocation

	@matricule_vehicule 	nvarchar(50),
	@id_contratLocation 	int,
	@fiche_etat_avant		nvarchar(50),
	@km 					int

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
GO*/

------------------------------------------------------------
-- Fichier     : Procedure_createEtat
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un Etat et renvoie l'id de cet Etat, ou une erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEtat
GO

-- Cette procedure permet de creer un nouvel etat

CREATE PROCEDURE dbo.createEtat
	@date_avant	 		datetime,
	@km_avant 			int,
	@fiche_avant		nvarchar(50)
AS
	INSERT INTO Etat(
		date_avant,
		km_avant,
		fiche_avant
	)
	VALUES (
		@date_avant,
		@km_avant,
		@fiche_avant
	);
	RETURN SCOPE_IDENTITY();
GO

------------------------------------------------------------
-- Fichier     : Procedure_createTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un typeAbonnement et renvoie 1 en cas de succès, ou une erreur autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createTypeAbonnement
GO

CREATE PROCEDURE dbo.createTypeAbonnement
	@nom					nvarchar(50),
	@prix 					money,
	@nb_max_vehicules 		int,
	@km						int
AS
	INSERT INTO TypeAbonnement(
		nom, 
		prix, 
		nb_max_vehicules,
		km
	)
	VALUES (
		@nom,
		@prix,
		@nb_max_vehicules,
		@km
	);
	RETURN 1;
GO


------------------------------------------------------------
-- Fichier     : Procedure_createListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajoute une personne a la liste noire 
-- (attention elle ne supprime pas la personne des comptes 
-- abonnés).
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createListeNoire;
GO

CREATE PROCEDURE dbo.createListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	BEGIN TRY
		INSERT INTO ListeNoire(
			date_naissance,
			nom,
			prenom
		)
		VALUES (
			@date_naissance,
			@nom,
			@prenom
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createListeNoire',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : Procedure_createVehicule
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Baiche Mourad ( ajout de la colone a_supprimer )
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createVehicule
GO

CREATE PROCEDURE dbo.createVehicule
	@matricule 				nvarchar(50),
	@kilometrage 			int,
	@couleur				nvarchar(50),
	@statut					nvarchar(50),
	@num_serie				nvarchar(50),
	@marque_modele			nvarchar(50),
	@serie_modele			nvarchar(50),
	@portieres_modele		tinyint,
	@type_carburant_modele	nvarchar(50)
	
AS
	INSERT INTO Vehicule(
		matricule,
		kilometrage,
		couleur,
		statut,
		num_serie,
		marque_modele,
		serie_modele,
		portieres_modele,
		type_carburant_modele,
		a_supprimer
	)
	VALUES (
		@matricule,
		@kilometrage,
		@couleur,
		@statut,
		@num_serie,
		@marque_modele,
		@serie_modele,
		@portieres_modele,
		@type_carburant_modele,
		'false'
	);

GO


------------------------------------------------------------
-- Fichier     : Procedure_addModeleToCategorie
-- Date        : 04/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addModeleToCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addModeleToCategorie
GO

-- Cette procedure permet d'ajouter un modele a une categorie

CREATE PROCEDURE dbo.addModeleToCategorie
	@marque_modele 				nvarchar(50),
	@serie_modele					nvarchar(50),
	@type_carburant_modele 		nvarchar(50),
	@portieres_modele			tinyint,
	@nom_categorie				nvarchar(50)
	
AS
	INSERT INTO CategorieModele(
		marque_modele,
		serie_modele,
		type_carburant_modele,
		portieres_modele,
		nom_categorie
	)
	VALUES (
		@marque_modele,
		@serie_modele,
		@type_carburant_modele,
		@portieres_modele,
		@nom_categorie
	);
	
GO



------------------------------------------------------------
-- Fichier     : Procedure_createModele
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createModele
GO



-- Cette procedure permet de desactiver un modele

CREATE PROCEDURE dbo.createModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@annee					int,
	@prix					int,
	@reduction				int,
	@portieres 				tinyint
AS
	INSERT INTO Modele(
	marque,
	serie,
	type_carburant,
	annee,prix,reduction,
	portieres,
	a_supprimer
	)  
	VALUES(
	@marque,
	@serie,
	@type_carburant,
	@annee,
	@prix,
	@reduction,
	@portieres,
	'false'
	) ;
GO

------------------------------------------------------------
-- Fichier     : Procedure_addCategorieToCatalogue
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Procedure ajoutant une catagorie à un catalogue
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addCategorieToCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addCategorieToCatalogue;
GO

CREATE PROCEDURE dbo.addCategorieToCatalogue
	@nom_catalogue 					nvarchar(50),
	@nom_categorie 					nvarchar(50)
AS
	BEGIN TRY
		INSERT INTO CatalogueCategorie(
			nom_catalogue,
			nom_categorie
		)
		VALUES (
			@nom_catalogue,
			@nom_categorie
		)
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.addCategorieToCatalogue',10,1)
	END CATCH
	 
GO


------------------------------------------------------------
-- Fichier     : Procedure_createCategorie
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Baiche Mourad ( ajout du champs a_supprimer ) 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCategorie
GO


CREATE PROCEDURE dbo.createCategorie
	@nom					nvarchar(50),
	@description 			nvarchar(50),
	@nom_typepermis 		nvarchar(10)
AS

	BEGIN TRY
		BEGIN
	
			INSERT INTO Categorie(
			nom, 
			description, 
			nom_typepermis,
			a_supprimer
			)
			VALUES (
			@nom,
			@description,
			@nom_typepermis,
			'false'
			);
		END
		
		return 1;
	END TRY
	
	BEGIN CATCH
		RAISERROR('probleme lors de la creation de la categorie',10,1);
	END CATCH

GO


------------------------------------------------------------
-- Fichier     : Procedure_createCatalogue
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Procédure permettant de créer un catalogue. 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCatalogue;
GO

CREATE PROCEDURE dbo.createCatalogue
	@nom 					nvarchar(50),
	@date_debut 			date,
	@date_fin				date
AS
	BEGIN TRY
		INSERT INTO Catalogue(
			nom,
			date_debut,
			date_fin
		)
		VALUES (
			@nom,
			@date_debut,
			@date_fin
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createCatalogue',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : Procedure_createSousPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Insertion d'un nouveu sous permis
------------------------------------------------------------

USE TAuto_IBDR
GO


IF OBJECT_ID ('dbo.createSousPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createSousPermis
GO

CREATE PROCEDURE dbo.createSousPermis
	@nom_typepermis			nvarchar(50),
	@numero_permis 			nvarchar(50),
	@date_obtention 		date,
	@date_expiration		date,
	@periode_probatoire		tinyint
AS
	BEGIN TRY
		INSERT INTO SousPermis(
			nom_typepermis, 
			numero_permis, 
			date_obtention,
			date_expiration,
			periode_probatoire
			--actif
		)
		VALUES (
			@nom_typepermis,
			@numero_permis,
			@date_obtention,
			@date_expiration,
			@periode_probatoire
			--DEFAULT
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createSousPermis',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : Procedure_createPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Alexis Deluze
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajout d'un permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createPermis
GO


CREATE PROCEDURE dbo.createPermis
	@numero 				nvarchar(50),
	@valide 				bit,
	@points_estimes 		tinyint
AS
	BEGIN TRY
		INSERT INTO Permis (
			numero,
			valide,
			points_estimes
		)
		VALUES (
			@numero,
			@valide,
			@points_estimes
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createPermis',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : Procedure_createLocation
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée une location
------------------------------------------------------------


USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createLocation
GO

CREATE PROCEDURE dbo.createLocation
	@matricule_vehicule 	nvarchar(50),
	@id_contratLocation 	int,
	@km 					int
AS
	INSERT INTO Location(
		matricule_vehicule,
		id_contratLocation,
		km
	)
	VALUES (
		@matricule_vehicule,
		@id_contratLocation,
		@km
	);
	RETURN SCOPE_IDENTITY();
GO

/*CREATE PROCEDURE dbo.createLocation

	@matricule_vehicule 	nvarchar(50),
	@id_contratLocation 	int,
	@fiche_etat_avant		nvarchar(50),
	@km 					int

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
GO*/

------------------------------------------------------------
-- Fichier     : Procedure_createContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un contrat de location et renvoie l'id de ce contrat, -1 en cas d'erreur
--				 Vérifie que le contrat puisse être créé pendant la période de validité de l'abonnement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createContratLocation
GO

CREATE PROCEDURE dbo.createContratLocation
	@date_debut 			datetime,
	@date_fin 				datetime,
	@id_abonnement 			int
AS
	/*BEGIN TRY
		DECLARE @ABONNEMENT_T TABLE(
			date_debut 					datetime,
			duree						int,
			renouvellement_auto			bit
		)
		DECLARE @date_debut_curseur datetime, @duree_curseur int, @renouvellement_auto_curseur bit;
		
		INSERT INTO @ABONNEMENT_T(date_debut, duree, renouvellement_auto)
			(SELECT date_debut, duree, renouvellement_auto
			FROM Abonnement 
			WHERE id = @id_abonnement);
		
		IF ( (SELECT COUNT(*) FROM @ABONNEMENT_T) = 0 )
		BEGIN
			Print('createContratLocation: aucun abonnement correspondant');
			RETURN -1;
		END
		
		DECLARE abonne_cursor CURSOR
			FOR SELECT * FROM @ABONNEMENT_T
			
		OPEN abonne_cursor
		FETCH NEXT FROM abonne_cursor
			INTO @date_debut_curseur, @duree_curseur, @renouvellement_auto_curseur;
		CLOSE abonne_cursor;
		DEALLOCATE abonne_cursor;
		
		IF ( @date_debut_curseur > @date_debut )
		BEGIN
			Print('createContratLocation: Date de début inférieur à celle de l''abonnement');
			RETURN -1;
		END
		
		IF ( DATEADD(day, @duree_curseur, @date_debut_curseur) < @date_fin AND @renouvellement_auto_curseur = 'false')
		BEGIN
			Print('createContratLocation: Date de fin supérieure à celle de l''abonnement');
			RETURN -1;
		END*/
		
		INSERT INTO ContratLocation (
			date_debut,
			date_fin,
			extension,
			id_abonnement
		)
		VALUES (
			@date_debut,
			@date_fin,
			0,
			@id_abonnement
		);
		--PRINT('createContratLocation créé ' + CAST(SCOPE_IDENTITY() AS CHAR(5)) );
		RETURN SCOPE_IDENTITY();
	/*END TRY
	BEGIN CATCH
		PRINT('createContratLocation: ERROR');
		RETURN -1;
	END CATCH*/
GO


------------------------------------------------------------
-- Fichier     : Procedure_addVehiculeToReservation
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addVehiculeToReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addVehiculeToReservation
GO

CREATE PROCEDURE dbo.addVehiculeToReservation
	@id_reservation				INT,
	@matricule_vehicule			VARCHAR(50)
AS
	INSERT INTO ReservationVehicule
	(	id_reservation,
		matricule_vehicule
	)
	VALUES (
		@id_reservation,
		@matricule_vehicule
	);

GO

------------------------------------------------------------
-- Fichier     : Procedure_createReservation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : Baiche Mourad
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createReservation
GO

CREATE PROCEDURE dbo.createReservation
	@date_debut				datetime,
	@date_fin				datetime,
	@id_abonnement			int
AS
	INSERT INTO Reservation(
		date_creation,
		date_debut,
		date_fin,
		a_supprimer,
		id_abonnement
	)
	VALUES (
		GETDATE(),
		@date_debut,
		@date_fin,
		'false',
		@id_abonnement
	);
	RETURN SCOPE_IDENTITY();
GO


------------------------------------------------------------
-- Fichier     : Procedure_notReservedVehicle1
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique si un vehicule n'est pas déjà réservé 
--               entre une date de début et une date de fin
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.notReservedVehicle1', 'P') IS NOT NULL
	DROP PROCEDURE dbo.notReservedVehicle1;
GO


CREATE PROCEDURE dbo.notReservedVehicle1
	@matricule 	nvarchar(50),
	@dateDebut	datetime,
	@dateFin	datetime
AS
	BEGIN TRY
		IF exists
			(SELECT 1
			FROM ReservationVehicule rv
			INNER JOIN Reservation r
			ON rv.id_reservation = r.id
			WHERE 
					rv.matricule_vehicule = @matricule
					AND 
					(r.date_debut between @dateDebut AND @dateFin
						OR r.date_fin between @dateDebut AND @dateFin
						OR (r.date_debut <= @dateDebut AND r.date_fin >= @dateFin)
					)
			)	
		BEGIN
			RETURN -1
		END
		
		ELSE
		BEGIN
			RETURN 1
		END
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la procedure dbo.notReservedVehicle1',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : Procedure_isDisponible1
-- Date        : 16/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique si un vehicule est disponible pour une reservation  
--               entre une date de début et une date de fin
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.isDisponible1', 'P') IS NOT NULL
	DROP PROCEDURE dbo.isDisponible1;
GO


CREATE PROCEDURE dbo.isDisponible1
	@matricule 	nvarchar(50),
	@dateDebut	datetime,
	@dateFin	datetime
AS
	BEGIN TRY
		DECLARE @VehiculeStatus nvarchar(50);
		
		SELECT @VehiculeStatus = statut FROM Vehicule WHERE matricule = @matricule;
		
		IF @VehiculeStatus = 'Perdue'
		BEGIN
			PRINT('-- ' + @matricule + ' Perdue');
			RETURN -1
		END
		
		IF @VehiculeStatus = 'En panne'
		BEGIN
			PRINT('-- ' + @matricule + ' En panne');
			RETURN -1
		END
		
		IF @VehiculeStatus = 'Louee'
		BEGIN
			DECLARE @DateFinLocation datetime;
			SELECT @DateFinLocation = cl.date_fin 
			FROM Location l
			INNER JOIN ContratLocation cl
			ON l.id_contratLocation = cl.id
			WHERE l.matricule_vehicule = @matricule AND cl.date_fin >= @dateDebut;
			
			IF (@DateFinLocation IS NOT NULL)	
			BEGIN
				PRINT('-- ' + @matricule + ' Louee jusqu au ' + CONVERT(varchar, @DateFinLocation, 121));
				RETURN -1
			END
		END
		
		DECLARE @ReturnValue int;
		EXEC @ReturnValue = dbo.notReservedVehicle1 
				@matricule,
				@dateDebut,
				@dateFin
		IF ( @ReturnValue = 1 )
		BEGIN
			PRINT('-- ' + @matricule + ' Disponible pour ces dates');
			RETURN 1;
		END
		
		ELSE
		BEGIN
			PRINT('-- ' + @matricule + ' Réservé pour ces dates');
			RETURN -1
		END
		
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la procedure dbo.isDisponible1',10,1)
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : findOtherVehicule.sql
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
				IF(@breakIsOK = 0)
				BEGIN
					PRINT('findOtherVehicule : Impossible de remplacer toute les reservation par un vehicule de meme modele');
					ROLLBACK TRANSACTION findOtherVehicule
					RETURN -1;
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



------------------------------------------------------------
-- Fichier     : Procedure_addConducteurToCompteAbonne
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée une jointure seulement si le tuple n'existe pas.
--				 Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addConducteurToCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addConducteurToCompteAbonne
GO

CREATE PROCEDURE dbo.addConducteurToCompteAbonne
	@nom_compteabonne 					nvarchar(50),
	@prenom_compteabonne 				nvarchar(50),
	@date_naissance_compteabonne 		date,
	@piece_identite_conducteur 			nvarchar(50),
	@nationalite_conducteur 			nvarchar(50)
AS
	/*BEGIN TRANSACTION addConducteurToCompteAbonne
	BEGIN TRY
		IF ( (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = @nom_compteabonne AND
			prenom_compteabonne = @prenom_compteabonne AND
			date_naissance_compteabonne = @date_naissance_compteabonne AND
			piece_identite_conducteur = @piece_identite_conducteur AND
			nationalite_conducteur = @nationalite_conducteur
			) = 0)
		BEGIN*/
			INSERT INTO CompteAbonneConducteur (
				nom_compteabonne,
				prenom_compteabonne,
				date_naissance_compteabonne,
				piece_identite_conducteur,
				nationalite_conducteur
			)
			VALUES (
				@nom_compteabonne,
				@prenom_compteabonne,
				@date_naissance_compteabonne,
				@piece_identite_conducteur,
				@nationalite_conducteur
			);
			--RAISERROR('Creation de la jointure CompteAbonneConducteur impossible', 10, 1);
			/*PRINT('Conducteur ajouté au compte abonné');
			COMMIT TRANSACTION addConducteurToCompteAbonne*/
			RETURN 1;
		/*END
		ELSE
		BEGIN
			PRINT('addConducteurToCompteAbonne: ERROR, tuple existant');
			ROLLBACK TRANSACTION addConducteurToCompteAbonne
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('addConducteurToCompteAbonne: ERROR, clef primaire');
		ROLLBACK TRANSACTION addConducteurToCompteAbonne
		RETURN -1;
	END CATCH*/
GO

------------------------------------------------------------
-- Fichier     : Procedure_createConducteur
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Alexis Deluze
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ajoute un conducteur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createConducteur
GO

CREATE PROCEDURE dbo.createConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50),
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@id_permis 			nvarchar(50)
AS
	BEGIN TRY
		INSERT INTO Conducteur (
			piece_identite,
			nationalite,
			nom,
			prenom,
			id_permis
		)
		VALUES (
			@piece_identite,
			@nationalite,
			@nom,
			@prenom,
			@id_permis
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createConducteur',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : Procedure_updateAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Neti Mohamed
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un abonnement, les valeurs que l'on ne souhaite pas changer peuvent être nulle
--				 Renvoie 1 en cas de succès, erreur autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateAbonnement
GO

CREATE PROCEDURE dbo.updateAbonnement
	@id 							int,
	@date_debut 					date,
	@duree 							int, -- nullable
	@renouvellement_auto			bit -- nullable
AS
 	BEGIN
		UPDATE Abonnement
		SET date_debut = @date_debut
		WHERE id = @id;
	END
	
	IF ( @duree IS NOT NULL)
	BEGIN
		UPDATE Abonnement
		SET duree = @duree
		WHERE id = @id;
	END

	IF ( @renouvellement_auto IS NOT NULL)
	BEGIN
		UPDATE Abonnement
		SET renouvellement_auto = @renouvellement_auto
		WHERE id = @id;
	END

	RETURN 1;
GO

------------------------------------------------------------
-- Fichier     : Procedure_createCompteAbonne
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : David Lecoconneir
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createParticulier
GO


CREATE PROCEDURE dbo.createParticulier
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@iban					nvarchar(50),
	@courriel				nvarchar(50),
	@telephone				nvarchar(50)
AS
	INSERT INTO CompteAbonne(
		nom,
		prenom,
		date_naissance,
		iban,
		courriel,
		telephone
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance,
		@iban,
		@courriel,
		@telephone
	);
	INSERT INTO Particulier(
		nom_compte,
		prenom_compte,
		date_naissance_compte
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance
	);
GO


IF OBJECT_ID ('dbo.createEntreprise', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEntreprise
GO

CREATE PROCEDURE dbo.createEntreprise
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@iban					nvarchar(50),
	@courriel				nvarchar(50),
	@telephone				nvarchar(50),
	@siret 					char(14),
	@nom_entreprise			nvarchar(50)
AS
	INSERT INTO CompteAbonne(
		nom,
		prenom,
		date_naissance,
		iban,
		courriel,
		telephone
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance,
		@iban,
		@courriel,
		@telephone
	);
	INSERT INTO Entreprise (
		siret,
		nom,
		nom_compte,
		prenom_compte,
		date_naissance_compte)
	VALUES (
		@siret,
		@nom_entreprise,
		@nom,
		@prenom,
		@date_naissance
	);
GO


------------------------------------------------------------
-- Fichier     : Procedure_isInListeNoire
-- Date        : 16/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : modifie une personne dans la liste noire
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.isInListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.isInListeNoire;
GO

CREATE PROCEDURE dbo.isInListeNoire
	@nom							nvarchar(50),
	@prenom							nvarchar(50),
	@date_naissance			 		date
AS
	BEGIN TRY
		DECLARE @present			INT	
		SET @present = 
		(SELECT COUNT(*) FROM ListeNoire
		WHERE nom = @nom
		AND prenom = @prenom
		AND date_naissance = @date_naissance)
		IF (@present = 0)
			RETURN 0
		ELSE
			RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.isInListeNoire',10,1)
	END CATCH
GO


------------------------------------------------------------
-- Fichier     : makeCompteParticulier.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajout d'un particulier dans la base
--				si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCompteParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteParticulier	
GO

CREATE PROCEDURE dbo.makeCompteParticulier
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50)
AS
	BEGIN TRANSACTION makeCompteParticulier
	DECLARE @msg varchar(4000)
	BEGIN TRY
	
		
		--On s'assure que  les champs ne sont pas NULL 
		IF (@nom IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le nom doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@prenom IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le prenom doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@date_naissance IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: La date_naissance doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@iban IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le numero IBAN doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@courriel IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le courriel doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		IF (@telephone IS NULL)
		BEGIN
				PRINT('makeCompteParticulier: Le numero de telephone doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END
		
		--On veut s'assurer que l'on peut ajouter le CompteAbonne
		--Gestion de la liste noire
		DECLARE @isInListeNoire		INT
		BEGIN TRY
			EXEC @isInListeNoire = dbo.isInListeNoire @nom,@prenom,@date_naissance;
			IF(@isInListeNoire = 1)
			BEGIN
				PRINT('makeCompteParticulier: La personne est sur liste noire');
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
			END
		END TRY
		BEGIN CATCH
			PRINT('makeCompteParticulier: ERROR');
			SET @msg = ERROR_MESSAGE()
			PRINT(@msg)
			ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1
		END CATCH

		--Je n'ai pas à gérer le cas ou a_supprimer est vrai car cela veut dire que le 
		-- compte_abonne est sur liste noire
		
		--Si la personne n'existe pas déjà
		IF((
			SELECT COUNT(*) 
			FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 0)
			BEGIN 
				--ajout du compte abonne
				EXEC dbo.createParticulier @nom, @prenom, @date_naissance, @iban ,@courriel, @telephone
				--ajout dans la table particulier
				--INSERT INTO Particulier (nom_compte, prenom_compte, date_naissance_compte)
				--VALUES (@nom,@prenom,@date_naissance)
				COMMIT TRANSACTION makeCompteParticulier
				PRINT('makeCompteParticulier OK');
				RETURN 1;
			END
			
		ELSE
		BEGIN
		-- Si la personne existe déjà
			--On regarde si le compte est actif
			IF((
				SELECT actif 
				FROM CompteAbonne
				WHERE nom = @nom
				AND prenom = @prenom
				AND date_naissance = @date_naissance) =  1
			)
			-- s'il l'est on le signale
			BEGIN 
				PRINT 'makeCompteParticulier : Le compte existe déjà'
				ROLLBACK TRANSACTION makeCompteParticulier
				RETURN -1;
			END
			ELSE
			-- s'il ne l'est pas on le rend actif
			BEGIN
				UPDATE CompteAbonne
				SET actif = 1
				WHERE nom = @nom
				AND prenom = @prenom
				AND date_naissance = @date_naissance
				COMMIT TRANSACTION makeCompteParticulier
				PRINT('makeCompteParticulier OK');
				RETURN 1 	
			END
		END
	END TRY
	BEGIN CATCH
		PRINT 'makeCompteParticulier : Exception recue'
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION makeCompteParticulier
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeCompteEntreprise.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCompteEntreprise', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCompteEntreprise	
GO

CREATE PROCEDURE dbo.makeCompteEntreprise
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50),
	@siret 				nvarchar(50),
	@nom_entreprise		nvarchar(50)
AS
	BEGIN TRANSACTION makeCompteEntreprise
	DECLARE @msg varchar(4000)
	BEGIN TRY
		--On s'assure que  les champs ne sont pas NULL 
		IF (@nom IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le nom doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		IF (@prenom IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le prenom doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		IF (@date_naissance IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: La date_naissance doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		IF (@iban IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le numero IBAN doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		IF (@courriel IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le courriel doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		IF (@telephone IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le numero de telephone doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		IF (@siret IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le numero de siret doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		
		IF (@nom_entreprise IS NULL)
		BEGIN
				PRINT('makeCompteEntreprise: Le nom de l''entreprise doit etre renseigne');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		
		--On ne veut pas que le siret que l'on veut inserer soit trop long
		IF (LEN(@siret) > 14)
		BEGIN
				PRINT('makeCompteEntreprise: Le numero de siret est trop long');
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1
		END
		--On veut s'assurer que l'on peut ajouter le CompteAbonne
		
		--Gestion de la liste noire
		DECLARE @isInListeNoire		INT

		EXEC @isInListeNoire = dbo.isInListeNoire @nom,@prenom,@date_naissance;

		IF(@isInListeNoire = 1)
		BEGIN
			PRINT('makeCompteEntreprise: La personne est sur liste noire');
			ROLLBACK TRANSACTION makeCompteEntreprise
			RETURN -1
		END

		--Je n'ai pas à gérer le cas ou a_supprimer est vrai car cela veut dire que le 
		-- compte_abonne est sur liste noire
		
		--Si la personne n'existe pas déjà
		
		IF((
			SELECT COUNT(*) 
			FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 0)
			BEGIN 
				--ajout du compte abonne
				EXEC dbo.createEntreprise @nom, @prenom, @date_naissance, @iban, @courriel, @telephone, @siret, @nom_entreprise;
			END
		ELSE
		-- Si la personne existe déjà
			--On regarde si le compte est actif
			IF((
				SELECT actif 
				FROM CompteAbonne
				WHERE nom = @nom
				AND prenom = @prenom
				AND date_naissance = @date_naissance) =  1
			)
			-- s'il l'est on le signale
			BEGIN 
				PRINT 'makeCompteEntreprise : Le compte existe déjà'
				ROLLBACK TRANSACTION makeCompteEntreprise
				RETURN -1;
			END
			ELSE
			-- s'il ne l'est pas on le rend actif
			BEGIN
				UPDATE CompteAbonne
				SET actif = 1
				WHERE nom = @nom
				AND prenom = @prenom
				AND date_naissance = @date_naissance
				COMMIT TRANSACTION makeCompteEntreprise
				PRINT('makeCompteEntreprise OK');
				RETURN 1 	
			END	
		
			COMMIT TRANSACTION makeCompteEntreprise
			PRINT('makeCompteEntreprise OK');
			RETURN 1;
		END TRY
	BEGIN CATCH
		PRINT('makeCompteEntreprise: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION makeCompteEntreprise
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeAbonnement.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un abonnement correspondant à un 
--				compte abonne et à un type d'abonnement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeAbonnement	
GO

CREATE PROCEDURE dbo.makeAbonnement
	@date_debut 						date,
	@duree 								int,
	@renouvellement_auto 				bit,
	@nom_typeabonnement 				nvarchar(50), -- FK
	@nom_compteabonne 					nvarchar(50), -- FK
	@prenom_compteabonne 				nvarchar(50), -- FK
	@date_naissance_compteabonne 		date 		  -- FK
	
AS
	BEGIN TRANSACTION makeAbonnement
	DECLARE @msg varchar(4000)
	BEGIN TRY
	
		DECLARE @asCompteAbonne	 	int,
				@asTypeAbonnement	int,
				@idAbonnement		int,
				@returnPS			int;
		
		IF(@date_debut IS NULL)
		BEGIN
			PRINT('makeAbonnement: la date de debut doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@duree IS NULL)
		BEGIN
			PRINT('makeAbonnement: la duree doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END

		IF(@renouvellement_auto IS NULL)
		BEGIN
			PRINT('makeAbonnement: le renouvellement automatique de l''abonnement doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END


		IF(@nom_compteabonne IS NULL)
		BEGIN
			PRINT('makeAbonnement: le nom doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@prenom_compteabonne IS NULL)
		BEGIN
			PRINT('makeAbonnement: le prenom doit etre renseigne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@date_naissance_compteabonne IS NULL)
		BEGIN
			PRINT('makeAbonnement: la date de naissance doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		SET @asCompteAbonne = (SELECT COUNT(*) FROM CompteAbonne 
										WHERE nom = @nom_compteabonne 
										AND   prenom = @prenom_compteabonne
										AND   date_naissance = @date_naissance_compteabonne);
										
		IF ( @asCompteAbonne = 0)
		BEGIN
			PRINT('makeAbonnement: pas de compte abonne correspondant');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@nom_typeabonnement IS NULL)
		BEGIN
			PRINT('makeAbonnement: la type de l''abonnement doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		SET @asTypeAbonnement = (SELECT COUNT(*) FROM TypeAbonnement 
										WHERE nom = @nom_typeabonnement);
										
		IF ( @asTypeAbonnement = 0)
		BEGIN
			PRINT('makeAbonnement: pas de type abonnement correspondant');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		INSERT INTO Abonnement(
			nom_typeabonnement,
			nom_compteabonne,
			prenom_compteabonne,
			date_naissance_compteabonne
		)
		VALUES (
			@nom_typeabonnement,
			@nom_compteabonne,
			@prenom_compteabonne,
			@date_naissance_compteabonne
		);
		
		IF(@@ERROR <> 0)
		BEGIN
			PRINT('makeAbonnement: Error');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		SET @idAbonnement = SCOPE_IDENTITY();
		
		IF(@date_debut IS NOT NULL AND GETDATE ( ) > @date_debut)
		BEGIN
			PRINT('makeAbonnement: Veuillez saisire une date de debut présente ou future');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@duree IS NOT NULL AND @duree < 1 )
		BEGIN
			PRINT('makeAbonnement: La durée saisie n''es pas bonne');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END

		EXEC @returnPS = dbo.updateAbonnement @idAbonnement, @date_debut, @duree, @renouvellement_auto;
		
		IF(@returnPS <> 1)
		BEGIN
			PRINT('makeAbonnement: Error');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		
/*
		IF(@date_debut = NULL)
		BEGIN
			PRINT('makeAbonnement: la date de debut doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@duree = NULL)
		BEGIN
			PRINT('makeAbonnement: la duree doit etre renseignee');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
		
		IF(@renouvellement_auto = NULL)
		BEGIN
			PRINT('makeAbonnement: il faut préciser si l''abonnement est renouvelable automatiquement');
			ROLLBACK TRANSACTION makeAbonnement
			RETURN -1;
		END
	
		EXEC dbo.makeAbonnement @nom, @prenom, @date_naissance,@date_debut,@duree,@renouvellement_auto, @nom_typeabonnement
*/			
		
		COMMIT TRANSACTION makeAbonnement
		PRINT('makeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeAbonnement: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION makeAbonnement
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : declareConducteur.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Déclare un conducteur à un compte abonné. Crée le conducteur
--			 	 avec son permis et le lie au compte abonné s’il n’existe pas,
--				 ou vérifie s’il possède le permis (l’ajoute à défaut), et vérifie 
--				 s’il est lié au compte abonné (le lie à default).
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.declareConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.declareConducteur	
GO

CREATE PROCEDURE dbo.declareConducteur
	@nom 				nvarchar(50), -- PK nom de l'abonné
	@prenom 			nvarchar(50), -- PK prénom de l'abonné
	@date_naissance 	date, 		  -- PK date de naissance de l'abonné
	@nom_conducteur		nvarchar(50), -- nom du conducteur
	@prenom_conducteur	nvarchar(50), -- prénom du conducteur
	@piece_identite 	nvarchar(50), -- PK piece d'identite du conducteur
	@nationalite 		nvarchar(50), -- PK nationalité du conducteur
	@numero_permis		nvarchar(50), -- nullable numero de permis
	@nom_typepermis 	nvarchar(10), -- nullable nom du sous permis (A1,A2,B...)
	@date_obtention 	date,		  -- nullable, si null ne pas prendre en compte la suite des arguments : date d'obtention du sous permis
	@periode_probatoire tinyint,      -- nullable, csq sur le nombre de points de base : peride probatoir du sous permis
	@date_expiration 	date,         -- nullable, null signifiant pas de limite : date d'expiration du sous permis
	@valide				bit,		  -- boolean pour la validité du permis
	@points_estimes		tinyint		  -- estimation du nombre de point du permis
AS
	BEGIN TRANSACTION declareConducteur
	BEGIN TRY
		DECLARE @asCompteAbonne		int,
				@asConducteur	 	int,
				@asPermis			int,
				@asSousPermis		int;
		
		--Si les information concernant le compte de l'abonne pas renseigner, on sort
		IF(@nom IS NULL OR @prenom IS NULL OR @date_naissance IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le compte abonne son incomplet');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		--Si les information concernant le conducteur pas renseigner, on sort
		IF(@piece_identite IS NULL OR @nationalite IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le conducteur son incomplet');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		--on verifie que le compte abonne au quel on veut ajouter le conducteur existe
		SET @asCompteAbonne = (SELECT COUNT(*) FROM CompteAbonne 
										WHERE nom = @nom
										AND   prenom = @prenom
										AND   date_naissance = @date_naissance);
		
		--on verifie que le conducteur qu'on veut ajouter existe
		SET @asConducteur = (SELECT COUNT(*) FROM Conducteur 
										WHERE piece_identite = @piece_identite
										AND   nationalite = @nationalite);
										
		--on verifie que le compte abonne au quel on veut ajouter le conducteur existe, a defaut on sort
		IF(@asCompteAbonne = 0)
		BEGIN
			PRINT('declareConducteur: ERROR compte abonné correspondant est introuvable');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		--SI le conducteur qu'on veut ajouter existe
		IF ( @asConducteur = 1 )
		BEGIN
			--si ne numero de permis est renseigné, on verifie que c le meme que celui du conducteur, a defaut on sort
			if( @numero_permis IS NOT NULL AND ((SELECT id_permis FROM Conducteur WHERE piece_identite = @piece_identite
																			   AND   nationalite = @nationalite) <> @numero_permis))
			BEGIN
				PRINT('declareConducteur: ERROR le numéro de permis du conducteur n''est pas bon');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			
			SET @numero_permis = (SELECT id_permis FROM Conducteur WHERE piece_identite = @piece_identite AND   nationalite = @nationalite);
			--si le conducteur n'as pas le sous permis renseignern, on lui ajoute le sous permis correspondant
			if( @nom_typepermis IS NOT NULL AND (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = @nom_typepermis
																			  AND   numero_permis = @numero_permis)=0)
			BEGIN
				--la date d'obtention et la date d'expiration du sous permis doivent etre indique, a defaut on sort
				IF(@date_obtention IS NULL OR @date_expiration IS NULL)
				BEGIN
					PRINT('declareConducteur: ERROR veuillez indiquer la date d''obtention et la date d''expiration');
					ROLLBACK TRANSACTION declareConducteur
					RETURN -1;
				END
				--verification de la coherence de la date_expiration et date_obtention
				IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
				BEGIN
					PRINT('declareConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
					ROLLBACK TRANSACTION declareConducteur
					RETURN -1;
				END
				--on insert le sous permis correspondant 
				INSERT INTO SousPermis (nom_typepermis,numero_permis,date_obtention,date_expiration)
								VALUES (@nom_typepermis,@numero_permis,@date_obtention,@date_expiration);
				--si la periode probatoir est renseigner, on met a jour la valeur correspondante
				IF(@periode_probatoire IS NOT NULL)
				BEGIN
					UPDATE SousPermis --ATTENTION verifier la valeur de periode_probatoir
					SET periode_probatoire = @periode_probatoire
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numero_permis;
				END
			END
			--verifie que le conducteur correspondant n'est pas deja ratache au compte abonne,a defaut on le ratache
			IF( (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = @nom
															 AND	prenom_compteabonne = @prenom
															 AND	date_naissance_compteabonne = @date_naissance
															 AND	piece_identite_conducteur = @piece_identite
															 AND	nationalite_conducteur = @nationalite) = 0)
			BEGIN	
				EXECUTE dbo.addConducteurToCompteAbonne @nom,@prenom,@date_naissance,@piece_identite,@nationalite;
			END	
		END
		--cas ou le conducteur n'existe pas
		ELSE
		BEGIN
			--le numero de permis et le nom du sous permis doivent etre renseginer, a defaut on sort
			IF(@numero_permis IS NULL OR @nom_typepermis IS NULL)
			BEGIN
				PRINT('declareConducteur: ERROR Veuillez renseignerginer le numéro de permis et le nom du type de permis');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			--la date_expiration et la date_obtention du sous permis doivent etre renseginer, a defaut on sort
			IF(@date_obtention IS NULL OR @date_expiration IS NULL)
			BEGIN
				PRINT('declareConducteur: ERROR Veuillez renseigner la date d''obtention et la date d''expiration du type de permis');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			--verification de la coherence de la date_expiration et date_obtention
			IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
			BEGIN
				PRINT('declareConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
			--le nom et le prenom du conducteur doivent renseginer, a defaut on sort
			IF(@nom_conducteur IS NULL OR @prenom_conducteur IS NULL)
			BEGIN
				PRINT('declareConducteur: ERROR Veuillez renseigner le nom et le prénom du conducteur');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1;
			END
		
		
			--creation du permis 
			INSERT INTO Permis (numero)VALUES (@numero_permis);
			--si le boolean valide du permis est renseginer, on met la valeur correspondante a jour
			IF(@valide IS NOT NULL)
			BEGIN
				UPDATE Permis
				SET valide = @valide
				WHERE numero = @numero_permis;
			END
			--si l'estimation de point du permis est renseginer, on met la valeur correspondante a jour
			IF(@points_estimes IS NOT NULL)
			BEGIN
				UPDATE Permis
				SET points_estimes = @points_estimes
				WHERE numero = @numero_permis;
			END
			--creation sous_permis
			INSERT INTO SousPermis (nom_typepermis,numero_permis,date_obtention,date_expiration)
								VALUES (@nom_typepermis,@numero_permis,@date_obtention,@date_expiration);
			--si la periode probatoir du sous permis est renseginer, on met la valeur correspondante a jour
			IF(@periode_probatoire IS NOT NULL)
			BEGIN
				UPDATE SousPermis
				SET periode_probatoire = @periode_probatoire
				WHERE nom_typepermis = @nom_typepermis
				AND numero_permis = @numero_permis;
			END
			--creation du conducteur 
			EXECUTE dbo.createConducteur @piece_identite,@nationalite,@nom_conducteur,@prenom_conducteur,@numero_permis;
			--liaison conducteur et compte abonne
			EXECUTE dbo.addConducteurToCompteAbonne @nom,@prenom,@date_naissance,@piece_identite,@nationalite;

		END
		COMMIT TRANSACTION declareConducteur
		PRINT('declareConducteur OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('declareConducteur: ERROR');
		ROLLBACK TRANSACTION declareConducteur
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : associateConducteurToLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.associateConducteurToLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.associateConducteurToLocation	
GO

CREATE PROCEDURE dbo.associateConducteurToLocation
	@id_location					int, -- FK
	@piece_identite_conducteur		nvarchar(50), -- FK
	@nationalite_conducteur			nvarchar(50) -- FK
AS
	BEGIN TRANSACTION associateConducteurToLocation
	BEGIN TRY
	
		-- les informations concernant le conducteur ne sont pas renseignees
		IF(@piece_identite_conducteur IS NULL OR @nationalite_conducteur IS NULL)
		BEGIN
			PRINT('associateConducteurToLocation: ERROR Les informations concernant le conducteur sont incompletes');
			ROLLBACK TRANSACTION associateConducteurToLocation
			RETURN -1;
		END

		-- l'identifiant de la location n'est pas renseigne
		IF(@id_location IS NULL)
		BEGIN
			PRINT('associateConducteurToLocation: ERROR L''identifiant de la location n''est pas renseigne');
			ROLLBACK TRANSACTION associateConducteurToLocation
			RETURN -1;
		END

		IF not exists
			(SELECT 1
			 FROM Conducteur
			 WHERE piece_identite = @piece_identite_conducteur AND nationalite = @nationalite_conducteur
			)	
		BEGIN
			PRINT('associateConducteurToLocation: ERROR Les informations concernant le conducteur sont incorrectes');
			ROLLBACK TRANSACTION associateConducteurToLocation
			RETURN -1
		END
		
		IF not exists
			(SELECT 1
			 FROM Location
			 WHERE id = @id_location
			)	
		BEGIN
			PRINT('associateConducteurToLocation: ERROR L''identifiant de la location est incorrect');
			ROLLBACK TRANSACTION associateConducteurToLocation
			RETURN -1
		END
		
		IF exists
			(SELECT 1
			 FROM ConducteurLocation
			 WHERE id_location = @id_location AND
			       piece_identite_conducteur = @piece_identite_conducteur AND
			       nationalite_conducteur = @nationalite_conducteur
			)	
		BEGIN
			PRINT('associateConducteurToLocation: ERROR Le conducteur est deja associe a la location');
			ROLLBACK TRANSACTION associateConducteurToLocation
			RETURN -1
		END
		
		-- verifier que le conducteur est associe au compte abonne
		
		DECLARE @nom_compteabonne nvarchar(50), @prenom_compteabonne nvarchar(50), @date_naissance_compteabonne date;

		SELECT @nom_compteabonne = a.nom_compteabonne,@prenom_compteabonne = a.prenom_compteabonne, @date_naissance_compteabonne = a.date_naissance_compteabonne
		FROM Location l
		INNER JOIN ContratLocation cl
		ON cl.id = l.id_contratLocation
		INNER JOIN Abonnement a
		ON a.id = cl.id_abonnement
		WHERE l.id = @id_location;

		IF not exists
			(SELECT 1
			 FROM CompteAbonneConducteur
			 WHERE nom_compteabonne = @nom_compteabonne AND
			       prenom_compteabonne = @prenom_compteabonne AND
			       date_naissance_compteabonne = @date_naissance_compteabonne AND
			       piece_identite_conducteur = @piece_identite_conducteur AND
			       nationalite_conducteur = @nationalite_conducteur
			)	
		BEGIN
			EXECUTE dbo.addConducteurToCompteAbonne 
						@nom_compteabonne, @prenom_compteabonne, @date_naissance_compteabonne,
						@piece_identite_conducteur, @nationalite_conducteur;
		END
		
		EXECUTE dbo.addConducteurToLocation @id_location, @piece_identite_conducteur, @nationalite_conducteur;

		COMMIT TRANSACTION associateConducteurToLocation
		PRINT('associateConducteurToLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('associateConducteurToLocation: ERROR');
		ROLLBACK TRANSACTION associateConducteurToLocation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : searchVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Retourne une table de Vehicules en fonction
--               de plusieurs paramètres de recherche.
------------------------------------------------------------

USE TAuto_IBDR;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
IF OBJECT_ID(N'[dbo].[searchVehicule]', 'TF') IS NOT NULL 
    DROP FUNCTION [dbo].[searchVehicule]
GO
  
  
CREATE FUNCTION [dbo].[searchVehicule] (
	@nom_categorie			nvarchar(50),
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@portieres 				tinyint,
	@prix_max 				money,
	@prix_min 				money,
	@date_debut 			date,
	@date_fin 				date,
	@couleur				nvarchar(50)
)
RETURNS @returnTable TABLE (
	matricule 				nvarchar(50) 	PRIMARY KEY,
	kilometrage 			int,
	couleur 				nvarchar(50),
	statut 					nvarchar(50),
	num_serie				nvarchar(50),				
	marque_modele 			nvarchar(50),
	serie_modele 			nvarchar(50),
	portieres_modele 		tinyint,
	date_entree				date,
	type_carburant_modele	nvarchar(50),
	a_supprimer 			bit
)
AS
BEGIN
	INSERT @returnTable
		SELECT * 
		FROM Vehicule v
		WHERE (@marque IS NULL OR v.marque_modele = @marque)
			AND (@serie IS NULL OR v.serie_modele = @serie)
			AND (@type_carburant IS NULL OR v.type_carburant_modele = @type_carburant)
			AND (@portieres IS NULL OR v.portieres_modele = @portieres)
			AND (@couleur IS NULL OR v.couleur = @couleur)
			AND (v.a_supprimer = 'false')
			AND (v.statut <> 'Perdue')
	
	DECLARE @matricule_courant nvarchar(50)
	DECLARE @statut_courant nvarchar(50)
	DECLARE @isDispo INT;
	DECLARE Curseur_vehicule CURSOR LOCAL FOR
		SELECT matricule,statut FROM @returnTable
	OPEN Curseur_vehicule
		FETCH NEXT FROM Curseur_vehicule 
			INTO @matricule_courant, @statut_courant					
		WHILE @@FETCH_STATUS=0
		BEGIN
			IF @statut_courant = 'Perdue'
			BEGIN
				DELETE FROM @returnTable where matricule = @matricule_courant;
			END
			
			IF @statut_courant = 'En panne'
			BEGIN
				DELETE FROM @returnTable where matricule = @matricule_courant;
			END
			
			IF @statut_courant = 'Louee'
			BEGIN
				DECLARE @DateFinLocation datetime;
				SELECT @DateFinLocation = cl.date_fin 
				FROM Location l
				INNER JOIN ContratLocation cl
				ON l.id_contratLocation = cl.id
				WHERE l.matricule_vehicule = @matricule_courant AND cl.date_fin >= @date_debut;
				
				IF (@DateFinLocation IS NOT NULL)	
				BEGIN
					DELETE FROM @returnTable where matricule = @matricule_courant;
				END
			END
		
			IF EXISTS
				(SELECT 1
				FROM ReservationVehicule rv
				INNER JOIN Reservation r
				ON rv.id_reservation = r.id
				WHERE 
					rv.matricule_vehicule = @matricule_courant
					AND (r.date_debut BETWEEN @date_debut AND @date_fin
					OR r.date_fin BETWEEN @date_debut AND @date_fin
					OR (r.date_debut <= @date_debut AND r.date_fin >= @date_fin))
				)
			BEGIN
				DELETE FROM @returnTable where matricule = @matricule_courant;
			END
			
			FETCH NEXT FROM Curseur_vehicule
			INTO	@matricule_courant,
					@statut_courant
		END
		CLOSE Curseur_vehicule
    RETURN
END
GO

------------------------------------------------------------
-- Fichier     : makeReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : David Lecoconnier
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
		DECLARE @ReturnValue int;
		DECLARE @return INT ;
		DECLARE @matricule VARCHAR(50);
		DECLARE @matricule_disponible VARCHAR(50);
		SET @matricule_disponible = '0';
			
		 -- verifier s'il a le droit d'emprunter
		IF (SELECT COUNT(*) FROM ListeNoire ln,Abonnement a WHERE a.nom_compteabonne=ln.nom AND a.prenom_compteabonne=ln.prenom AND a.date_naissance_compteabonne=ln.date_naissance ) !=0
		BEGIN
			PRINT('vous ne pouvez pas reserver vous etes en liste noire')
			return -1;
		END
		ELSE
			
		BEGIN

		-- verifier si on a un vehicule disponible
			DECLARE ListeVoiture CURSOR LOCAL  
			FOR SELECT matricule 
			FROM Vehicule  
			WHERE marque_modele=@marque AND serie_modele=@serie AND portieres_modele=@portieres AND type_carburant_modele=@type_carburant AND a_supprimer='false';  
			
			
			OPEN ListeVoiture
			FETCH NEXT FROM ListeVoiture INTO @matricule;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
			
				IF (SELECT v.statut FROM Vehicule v WHERE v.matricule=@matricule)='Disponible'
				BEGIN
					
					SET @matricule_disponible=@matricule;
				
					BREAK;
				END
			
			FETCH NEXT FROM ListeVoiture INTO @matricule 
			END 
			
			CLOSE ListeVoiture;
			
			IF @matricule_disponible ='0'
			BEGIN
				PRINT('Aucun vehicule disponible')
				return -1;
			END 
			ELSE 
			BEGIN
			 
			-- creer la reservation
			-- 
			EXEC @return=dbo.isDisponible1 @matricule_disponible,@date_debut,@date_fin ;
			
			IF (@return =1 ) 
			BEGIN 
				
				EXEC @ReturnValue = dbo.createReservation
					@date_debut, @date_fin, @id_abonnement;
				EXEC dbo.addVehiculeToReservation
					@ReturnValue, @matricule_disponible ;
			END
			END 
		END
	 
		COMMIT TRANSACTION makeReservation
		PRINT('makeReservation OK');
		RETURN @ReturnValue;
	END TRY
	BEGIN CATCH
		PRINT('makeReservation: ERROR');
		ROLLBACK TRANSACTION makeReservation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : cancelReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.cancelReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.cancelReservation	
GO

CREATE PROCEDURE dbo.cancelReservation
	@matricule		VARCHAR(50), -- PK
	@date_debut		datetime,
	@date_fin		datetime
AS
	BEGIN TRANSACTION cancelReservation
	BEGIN TRY

	IF (SELECT COUNT(*) FROM ReservationVehicule  WHERE matricule_vehicule=@matricule)=0
		BEGIN
			PRINT('cette reservation n''existe pas! ')
			return -1;
		END  
	ELSE

	DECLARE @res INT;
		SET @res = (SELECT  id_reservation  FROM ReservationVehicule WHERE matricule_vehicule=@matricule);
		
		EXEC annulerReservation @res;
	
		DELETE FROM ReservationVehicule WHERE matricule_vehicule=@matricule;

	
		COMMIT TRANSACTION cancelReservation
		PRINT('cancelReservation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('cancelReservation: ERROR');
		ROLLBACK TRANSACTION cancelReservation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : turnReservationIntoContratLocat.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Jean-Luc Amitousa Mankoy
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Transforme une réservation en location
--				 L'état des véhicules est vérifié (Disponible)
--				 Pas de vérification sur l'abbonnement, on le suppose valide
--				 Etat a_supprimer de la réservation vérifié
--				 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.turnReservationIntoContratLocat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.turnReservationIntoContratLocat	
GO

CREATE PROCEDURE dbo.turnReservationIntoContratLocat
	@id_reservation 		int, -- PK
	@km_reservation			int -- nombre de kilomètres autorisés pendant la location
AS
	BEGIN TRANSACTION turnReservationIntoContratLocat
	BEGIN TRY
		DECLARE @id_abonnem int, @matricule_veh nvarchar(50), @date_d datetime, @date_f datetime, @id_contratLoc int, @annul bit,
				@vehiculeStatut nvarchar(50), @nomTitulaire nvarchar(50), @a_supprimer bit;
		DECLARE @ReservationVehicule_T TABLE (
			matricule_vehicule nvarchar(50)
		);
		DECLARE @Reservation_T TABLE (
			date_debut datetime,
			date_fin datetime, 
			annule bit,
			id_abonnement int,
			a_supprimer bit
		);
		DECLARE @Vehicule_T TABLE(
			matricule nvarchar(50),
			statut nvarchar(50)
		);
		
		INSERT INTO @ReservationVehicule_T(matricule_vehicule)
			(SELECT matricule_vehicule FROM ReservationVehicule WHERE id_reservation = @id_reservation);
			
		INSERT INTO @Reservation_T(date_debut, date_fin, annule, id_abonnement, a_supprimer)
			(SELECT date_debut, date_fin, annule, id_abonnement, a_supprimer FROM Reservation WHERE id = @id_reservation);
		
		DECLARE Reservation_T_cursor CURSOR
			FOR SELECT * FROM @Reservation_T
			
		OPEN Reservation_T_cursor
		FETCH NEXT FROM Reservation_T_cursor
			INTO @date_d, @date_f, @annul, @id_abonnem, @a_supprimer;
		CLOSE Reservation_T_cursor;
		DEALLOCATE Reservation_T_cursor;
			
		IF ( @annul = 'true' )
		BEGIN
			RAISERROR('Reservation annulee', 16, 1);
			RETURN -1;
		END
			
		IF ( @a_supprimer = 'true' )
		BEGIN
			RAISERROR('Reservation supprimee', 11, 1);
			RETURN -1;
		END
			
		SELECT @nomTitulaire = nom_compteabonne FROM Abonnement WHERE id = @id_abonnem;
			
			
		PRINT('Contrat de location de ' + @nomTitulaire);
		
		
		IF ( SELECT COUNT (*) FROM @ReservationVehicule_T) > 0
		BEGIN
			EXEC @id_contratLoc = dbo.createContratLocation
				@date_debut = @date_d,
				@date_fin = @date_f,
				@id_abonnement = @id_abonnem;
			
			DECLARE ReserVehi_cursor CURSOR
				FOR SELECT * FROM @ReservationVehicule_T;
			OPEN ReserVehi_cursor;
			FETCH NEXT FROM ReserVehi_cursor
				INTO @matricule_veh;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @vehiculeStatut = statut FROM Vehicule WHERE matricule = @matricule_veh;				
				
				IF (@vehiculeStatut NOT LIKE 'Disponible')
				BEGIN
					RAISERROR('Vehicule louee', 10, -1);
				END
					
				EXEC dbo.createLocation 
					@matricule_vehicule = @matricule_veh,
					@id_contratLocation = @id_contratLoc,
					@km = @km_reservation;
				
				FETCH NEXT FROM ReserVehi_cursor
					INTO @matricule_veh;
			END
			
			CLOSE ReserVehi_cursor;
			DEALLOCATE ReserVehi_cursor;
		END
		
		UPDATE Reservation 
		SET a_supprimer = 'true'
		WHERE id = @id_reservation;
	
		COMMIT TRANSACTION turnReservationIntoContratLocat
		PRINT('turnReservationIntoContratLocat OK');
		RETURN @id_contratLoc;
	END TRY
	BEGIN CATCH
		PRINT('turnReservationIntoContratLocat: ERROR');
		ROLLBACK TRANSACTION turnReservationIntoContratLocat
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : modifyCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Methode modifant les champs d'un compte
-- autre que ceux permettant de l'identifier
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyCompte	
GO

CREATE PROCEDURE dbo.modifyCompte
	@nom 					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date,		  -- PK
	@nouveau_nom			nvarchar(50), -- nullable
	@nouveau_prenom			nvarchar(50), -- nullable
	@iban 					nvarchar(50), -- nullable
	@courriel 				nvarchar(50), -- nullable
	@telephone 				nvarchar(50), -- nullable
	@siret 					nvarchar(50), -- nullable
	@nom_entreprise			nvarchar(50), -- nullable
	@greyList				bit 		  -- nullable
AS
	BEGIN TRANSACTION modifyCompte
	DECLARE @msg varchar(4000)
	BEGIN TRY
		IF	(@nom IS NULL)
		BEGIN
			PRINT('modifyCompte: Le nom ne doit pas être NULL');
			ROLLBACK TRANSACTION modifyCompte
			RETURN -1;
		END
		
		IF	(@prenom IS NULL)
		BEGIN
			PRINT('modifyCompte: Le prenom ne doit pas être NULL');
			ROLLBACK TRANSACTION modifyCompte
			RETURN -1;
		END
		
		IF	(@date_naissance IS NULL)
		BEGIN
			PRINT('modifyCompte: La date_naissance ne doit pas être NULL');
			ROLLBACK TRANSACTION modifyCompte
			RETURN -1;
		END
		
		IF (@iban IS NOT NULL)
			UPDATE CompteAbonne
			SET iban = @iban
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		IF (@nom IS NOT NULL)
			UPDATE CompteAbonne
			SET courriel = @courriel
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		IF (@telephone IS NOT NULL)
			UPDATE CompteAbonne
			SET telephone = @telephone
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
		
		IF (@siret IS NOT NULL)
			UPDATE Entreprise
			SET siret = @siret
			WHERE nom_compte = @nom
			AND	prenom_compte = @prenom
			AND date_naissance_compte = @date_naissance
		
		IF (@date_naissance IS NOT NULL)
			UPDATE Entreprise
			SET nom = @nom_entreprise
			WHERE nom_compte = @nom
			AND	prenom_compte = @prenom
			AND date_naissance_compte = @date_naissance
		
		IF (@greylist IS NOT NULL)
			UPDATE CompteAbonne
			SET liste_grise = @greyList
			WHERE nom = @nom
			AND	prenom = @prenom
			AND date_naissance = @date_naissance
			
		IF (@nouveau_nom IS NOT NULL)
		BEGIN
			UPDATE CompteAbonne
			SET CompteAbonne.nom = @nouveau_nom
			WHERE CompteAbonne.nom = @nom
			AND	CompteAbonne.prenom = @prenom
			AND CompteAbonne.date_naissance = @date_naissance
		END
		
		IF(@nouveau_nom IS NULL)
		BEGIN
			IF (@nouveau_prenom IS NOT NULL)
				UPDATE CompteAbonne
				SET prenom = @nouveau_prenom
				WHERE nom = @nom
				AND	prenom = @prenom
				AND date_naissance = @date_naissance
		END
		ELSE
		BEGIN
			IF (@nouveau_prenom IS NOT NULL)
				UPDATE CompteAbonne
				SET prenom = @nouveau_prenom
				WHERE nom = @nouveau_nom
				AND	prenom = @prenom
				AND date_naissance = @date_naissance
		END
		
		COMMIT TRANSACTION modifyCompte
		PRINT('modifyCompte OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyCompte: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION modifyCompte
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : modifyConducteur.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : modifie le conducteur ou modifie un permis. 
--				 Les arguments sont optionnels. Le nom du type 
--				 de permis est à recherché dans l'ensemble des sous-permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyConducteur	
GO

CREATE PROCEDURE dbo.modifyConducteur
	--Conducteur
	@nom 				nvarchar(50), -- NOT NULL
	@prenom 			nvarchar(50), -- NOT NULL	
	@piece_identite 	nvarchar(50), -- PK
	@nationalite 		nvarchar(50), -- PK
	--SousPermis
	@nom_typepermis		nvarchar(10), -- PK
	@date_obtention 	date,     	  -- NOT NULL
	@periode_probatoire tinyint,   	  -- NOT NULL 	DEFAULT 3
	@date_expiration 	date,         -- NOT NULL
	--Permis
	@valide 			bit,		  -- DEFAULT 'true'
	@points_estimes 	tinyint 	  -- NOT NULL 	DEFAULT 12
AS
	BEGIN TRANSACTION modifyConducteur
	BEGIN TRY
		DECLARE @asConducteur	 	int,
				@asSousPermis		int,
				@numPemis			nvarchar(50);
	
		--Si les information concernant le conducteur pas renseigner, on sort
		IF(@piece_identite IS NULL OR @nationalite IS NULL)
		BEGIN
			PRINT('modifyConducteur: ERROR Les informations concernant le conducteur son incomplet');
			ROLLBACK TRANSACTION modifyConducteur
			RETURN -1;
		END
		
		--on verifie que le conducteur existe
		SET @asConducteur = (SELECT COUNT(*) FROM  Conducteur 
											 WHERE piece_identite = @piece_identite
											 AND   nationalite = @nationalite);
		--on verifie que le conducteur existe, a defaut on sort
		IF(@asConducteur = 0)
		BEGIN
			PRINT('modifyConducteur: ERROR conducteur correspondant est introuvable');
			ROLLBACK TRANSACTION modifyConducteur
			RETURN -1;
		END
		
		--On recupere le numero de permis du conducteur
		SET @numPemis = (SELECT id_permis FROM Conducteur
										  WHERE piece_identite = @piece_identite
										  AND   nationalite = @nationalite);
		
		--Si le nom est renseigner, on met a jour le nom du conducteur
		IF(@nom IS NOT NULL)
		BEGIN
			UPDATE Conducteur
			SET nom = @nom
			WHERE piece_identite = @piece_identite
			AND   nationalite = @nationalite;
		END

		--Si le prenom est renseigner, on met a jour le prenom du conducteur
		IF(@prenom IS NOT NULL)
		BEGIN
			UPDATE Conducteur
			SET prenom = @prenom
			WHERE piece_identite = @piece_identite
			AND   nationalite = @nationalite;
		END
	
		--Si la validité du permis est renseigner, on met a jour la validité du permis du conducteur
		IF(@valide IS NOT NULL)
		BEGIN
			UPDATE Permis
			SET valide = @valide
			WHERE numero = @numPemis;
		END

		--Si l'estimation de point du permis est renseigner, on met a jour l'estimation de point du permis du conducteur
		IF(@points_estimes IS NOT NULL)
		BEGIN
			UPDATE Permis
			SET points_estimes = @points_estimes
			WHERE numero = @numPemis;
		END
		
		--Si le nom du sous permis est renseigner
		IF(@nom_typepermis IS NOT NULL)
		BEGIN
			--on verifie que le sous permis inquer existe ou pas
			SET @asSousPermis = (SELECT COUNT(*) FROM  SousPermis
												 WHERE nom_typepermis = @nom_typepermis
												 AND   numero_permis = @numPemis);
												 
			--si le sous permis n'existe pas deja, on le cré
			IF(@asSousPermis = 0)
			BEGIN
				--on verifie que la date d'obtention et d'expiration sont renseigner, a defaut on sort
				IF(@date_obtention IS NULL OR @date_expiration IS NULL)
				BEGIN
					PRINT('modifyConducteur: ERROR veuillez indiquer la date d''obtention et la date d''expiration');
					ROLLBACK TRANSACTION modifyConducteur
					RETURN -1;
				END
				--verification de la coherence de la date_expiration et date_obtention
				IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
				BEGIN
					PRINT('modifyConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
					ROLLBACK TRANSACTION modifyConducteur
					RETURN -1;
				END
				--on insert le sous permis correspondant 
				INSERT INTO SousPermis (nom_typepermis,numero_permis,date_obtention,date_expiration)
								VALUES (@nom_typepermis,@numPemis,@date_obtention,@date_expiration);
				--si la periode probatoir est renseigner, on met a jour la valeur correspondante
				IF(@periode_probatoire IS NOT NULL)
				BEGIN
					UPDATE SousPermis --ATTENTION verifier la valeur de periode_probatoir
					SET periode_probatoire = @periode_probatoire
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END	
			END
			----si le sous permis existe deja, on le modifie
			ELSE
			BEGIN
				--si la date d'obtention du sous permis est renseigner
				IF(@date_obtention IS NOT NULL)
				BEGIN
					--verification de la coherence de la date_obtention
					IF(@date_obtention > GETDATE())
					BEGIN
						PRINT('modifyConducteur: ERROR problème avec la date d''obtention du sous permis');
						ROLLBACK TRANSACTION modifyConducteur
						RETURN -1;
					END
					--on met a jour la date d'obtention du sous permis
					UPDATE SousPermis 
					SET date_obtention = @date_obtention
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END
				--si la date d'expiration du sous permis est renseigner
				IF(@date_expiration IS NOT NULL)
				BEGIN
					--verification de la coherence de la date_expiration
					IF(@date_expiration < GETDATE())
					BEGIN
						PRINT('modifyConducteur: ERROR problème avec la date d''expiration du sous permis');
						ROLLBACK TRANSACTION modifyConducteur
						RETURN -1;
					END
					--on met a jour la date d'expiration du sous permis
					UPDATE SousPermis 
					SET date_expiration = @date_expiration
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END
				--si la periode probatoir est renseigner, on met a jour la valeur correspondante
				IF(@periode_probatoire IS NOT NULL)
				BEGIN
					UPDATE SousPermis --ATTENTION verifier la valeur de periode_probatoir
					SET periode_probatoire = @periode_probatoire
					WHERE nom_typepermis = @nom_typepermis
					AND numero_permis = @numPemis;
				END
				--verification de la coherence de la date_expiration et date_obtention si les 2 renseigner
				IF(@date_obtention IS NOT NULL AND @date_expiration IS NOT NULL)
				BEGIN
					IF(@date_obtention > @date_expiration OR @date_obtention > GETDATE() OR @date_expiration < GETDATE()  )
					BEGIN
						PRINT('modifyConducteur: ERROR problème avec la date d''obtention et d''expiration du sous permis');
						ROLLBACK TRANSACTION modifyConducteur
						RETURN -1;
					END
				END
			END
		END
		--Le nom du sous permis n'est pas renseigner
		ELSE
		BEGIN
			PRINT('modifyConducteur: INFORMATION le nom du sous permis n''a pas été renseigner, impossible d''effectuer des operation sur ce dernier');
		END
		COMMIT TRANSACTION modifyConducteur
		PRINT('modifyConducteur OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyConducteur: ERROR');
		ROLLBACK TRANSACTION modifyConducteur
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : declarePermis.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.declarePermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.declarePermis	
GO

CREATE PROCEDURE dbo.declarePermis
	@piece_identite 	nvarchar(50), -- PK
	@nationalite 		nvarchar(50), -- PK
	@numero				nvarchar(50), -- nullable, pas besoin de resaisir le permis s'il existe déjà en base
	@nom_typepermis		nvarchar(10),  -- PK
	@date_obtention 	date,
	@periode_probatoire tinyint, -- csq sur le nombre de points de base
	@date_expiration 	date -- nullable, null signifiant pas de limite
AS
	BEGIN TRANSACTION declarePermis
	BEGIN TRY
	
		-- les information concernant le conducteur ne sont pas renseignees
		IF(@piece_identite IS NULL OR @nationalite IS NULL)
		BEGIN
			PRINT('declarePermis: ERROR Les informations concernant le conducteur sont incompletes');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1;
		END
		
		-- les information concernant le type de permis ne sont pas renseignees
		IF(@nom_typepermis IS NULL OR @date_obtention IS NULL)
		BEGIN
			PRINT('declarePermis: ERROR Les informations concernant le type de permis sont incompletes');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1;
		END
		
		IF not exists
			(SELECT 1
			 FROM Conducteur
			 WHERE piece_identite = @piece_identite AND nationalite = @nationalite
			)	
		BEGIN
			PRINT('declarePermis: ERROR Les informations concernant le conducteur sont incorrectes');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1
		END
		
		IF @nom_typepermis NOT IN ('A1', 'A2', 'B', 'C', 'D', 'E', 'F')
		BEGIN
			PRINT('declarePermis: ERROR Le type de permis est incorrect');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1
		END
		
		IF @date_obtention > GETDATE()
		BEGIN
			PRINT('declarePermis: ERROR La date d''obtention est postéreure à la date d''aujourd''hui');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1
		END
		
		IF @date_expiration IS NOT NULL AND @date_expiration < GETDATE()
		BEGIN
			PRINT('declarePermis: ERROR La date d''expiration est antérieure à la date d''aujourd''hui');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1
		END
		
		DECLARE @numero_permis nvarchar(50);
		
		SELECT @numero_permis = id_permis 
		FROM Conducteur 
		WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
		
		IF @numero_permis IS NULL
		BEGIN
			IF @numero IS NULL
			BEGIN
				PRINT('makeAbonnement: le numero de permis doit etre renseigne');
				ROLLBACK TRANSACTION declarePermis
				RETURN -1
			END

			IF exists (SELECT 1 FROM Permis WHERE numero = @numero)	
			BEGIN
				PRINT('declarePermis: ERROR Le numero de permis renseigne est le numero de permis d''un autre conducteur');
				ROLLBACK TRANSACTION declarePermis
				RETURN -1
			END
		
			SET @numero_permis = @numero;
			EXECUTE dbo.createPermis @numero_permis, 1, 12;
			
			UPDATE Conducteur
			SET id_permis = @numero_permis
			WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
		END
		
		IF exists 
			(SELECT 1
			 FROM SousPermis
			 WHERE nom_typepermis = @nom_typepermis AND numero_permis = @numero_permis
			)	
		BEGIN
			PRINT('declarePermis: ERROR Le type de permis est deja enregistre');
			ROLLBACK TRANSACTION declarePermis
			RETURN -1
		END

		EXECUTE dbo.createSousPermis @nom_typepermis, @numero_permis, @date_obtention, @date_expiration, 0;

		IF(@periode_probatoire IS NOT NULL)
		BEGIN
			UPDATE SousPermis
			SET periode_probatoire = @periode_probatoire
			WHERE nom_typepermis = @nom_typepermis
			AND numero_permis = @numero_permis;
		END
	
		COMMIT TRANSACTION declarePermis
		PRINT('declarePermis OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('declarePermis: ERROR');
		ROLLBACK TRANSACTION declarePermis
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeCatalogue.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Jean-Luc Amitousa Mankoy
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCatalogue	
GO

CREATE PROCEDURE dbo.makeCatalogue
	@nom 					nvarchar(50), -- PK
	@date_debut 			date, -- nullable, la date par défaut est la date du jour
	@date_fin		 		date  -- vérifier debut <= fin
AS
	BEGIN TRANSACTION makeCatalogue
	BEGIN TRY
		IF ( (SELECT COUNT(*) FROM Catalogue WHERE nom = @nom) = 1)
		BEGIN
			PRINT('makeCatalogue: nom pris');
			RETURN -1;
		END
		
		IF ( @date_debut IS NULL)
		BEGIN
			SET @date_debut = GETDATE();
		END
		
		IF (@date_debut < @date_fin)
		BEGIN
			EXEC dbo.createCatalogue @nom, @date_debut, @date_fin;
			COMMIT TRANSACTION makeCatalogue
			PRINT('makeCatalogue OK');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('makeCatalogue: ERROR, date de fin anterieure');
			ROLLBACK TRANSACTION makeCatalogue
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('makeCatalogue: ERROR');
		ROLLBACK TRANSACTION makeCatalogue
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeCategorie.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeCategorie	
GO

CREATE PROCEDURE dbo.makeCategorie
	@nom_catalogue			nvarchar(50), -- FK
	@nom					nvarchar(50), -- PK
	@description 			nvarchar(50),
	@nom_typepermis			nvarchar(10)
AS
	BEGIN TRANSACTION makeCategorie
	BEGIN TRY
	
		EXEC createCategorie @nom,@description,@nom_typepermis;
		PRINT ('la categorie a été crée ');
		
		IF(SELECT count(*) FROM Catalogue c WHERE c.nom=@nom_catalogue)=0
			BEGIN 
			PRINT ('Le Catalogue n''existe pas ')
			return -1 ;
			END
		ELSE
			BEGIN

			EXEC addCategorieToCatalogue @nom_catalogue,@nom;
			END
			
			
		COMMIT TRANSACTION makeCategorie
		PRINT('makeCategorie OK');
		RETURN 1;
		
		
	END TRY
	BEGIN CATCH
		PRINT('makeCategorie: ERROR');
		ROLLBACK TRANSACTION makeCategorie
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeModele.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeModele	
GO

CREATE PROCEDURE dbo.makeModele
	@nom_catalogue			nvarchar(50), -- FK
	@nom_categorie			nvarchar(50), -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint,  -- PK
	@annee 					int,
	@prix 					money,
	@reduction 				tinyint	-- nullable
AS
	BEGIN TRANSACTION makeModele
	BEGIN TRY
	
	IF(SELECT count(*) FROM Catalogue c WHERE c.nom=@nom_catalogue)=0
			BEGIN 
			PRINT ('Le Catalogue n''existe pas ')
			return -1 ;
			END
		ELSE
		
		BEGIN
			IF(SELECT count(*) FROM CatalogueCategorie cc WHERE cc.nom_categorie=@nom_categorie AND cc.nom_catalogue=@nom_catalogue)=0
			BEGIN 
			PRINT ('Cette categorie n''existe pas dans ce catalogue ')
			return -1 ;
			END
		
			ELSE
				BEGIN
				EXEC createModele @marque,@serie,@type_carburant,@annee,@prix,@reduction,@portieres;
				EXEC addModeleToCategorie @marque,@serie,@type_carburant,@portieres,@nom_categorie;
				END
		END
			
	
		COMMIT TRANSACTION makeModele
		PRINT('makeModele OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeModele: ERROR');
		ROLLBACK TRANSACTION makeModele
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeVehicule.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajout d'un vehicule dans la base de donnée / Alexis : désolé j'ai fait cette procédure mais y'a eu un conflit dans l'excel de la répartition des taches ...
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeVehicule	
GO

CREATE PROCEDURE dbo.makeVehicule
	@marque_modele 			nvarchar(50), -- FK
	@serie 					nvarchar(50), -- FK
	@type_carburant 		nvarchar(50), -- FK
	@portieres 				tinyint,  -- FK
	@matricule 				nvarchar(50), --PK
	@kilometrage 			int,
	@couleur 				nvarchar(50),
	@num_serie				nvarchar(50),
	@nom_categorie			nvarchar(50)
AS
	BEGIN TRANSACTION makeVehicule
	
	BEGIN TRY
	
				IF (SELECT count(*) FROM CategorieModele cm WHERE cm.nom_categorie=@nom_categorie AND cm.marque_modele=@marque_modele AND cm.portieres_modele=@portieres AND cm.serie_modele = @serie
				  AND cm.type_carburant_modele=@type_carburant )= 0
				  BEGIN
					PRINT ('Cette modele n''existe pas dans cette categorie ')
					return -1 ;
				  END
				  
				ELSE 
				EXEC createVehicule @matricule ,@kilometrage,@couleur,'Disponible',@num_serie,@marque_modele,@serie,@portieres,@type_carburant ;
	
		COMMIT TRANSACTION makeVehicule
		PRINT('makeVehicule OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeVehicule: ERROR');
		ROLLBACK TRANSACTION makeVehicule
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : closeCompte.sql
-- Date        : 17/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Fermeture d'un compte
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCompte	
GO

CREATE PROCEDURE dbo.closeCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
AS
	BEGIN TRANSACTION closeCompte
	DECLARE @msg varchar(4000)
	BEGIN TRY
		-- verification des arguments
		IF(@nom IS NULL)
		BEGIN
			PRINT('closeCompte: Le nom doit etre renseigne');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END
		
		IF(@prenom IS NULL)
		BEGIN
			PRINT('closeCompte: Le prenom doit etre renseigne');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END
		
		IF(@date_naissance IS NULL)
		BEGIN
			PRINT('closeCompte: La date_naissance doit etre renseignee');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END
	
		-- on regarde si le compte existe
		
		IF((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 0)
		BEGIN
			PRINT('closeCompte: Le compte n''existe pas');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END 
	
		-- on regarde si le compte n'est pas déjà inactif
		IF((SELECT actif FROM CompteAbonne
			WHERE nom = @nom
			AND prenom = @prenom
			AND date_naissance = @date_naissance) = 'false')
		BEGIN
			PRINT('closeCompte: Le compte est deja inactif');
			ROLLBACK TRANSACTION closeCompte
			RETURN -1;
		END 
		
		UPDATE CompteAbonne 
		SET actif = 'false'
		WHERE nom = @nom
		AND prenom = @prenom
		AND date_naissance = @date_naissance
		
		COMMIT TRANSACTION closeCompte
		PRINT('closeCompte OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('closeCompte: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeCompte
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : blackListCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.blackListCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.blackListCompte	
GO

CREATE PROCEDURE dbo.blackListCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
AS
	BEGIN TRANSACTION blackListCompte
	BEGIN TRY
	
		IF(@nom IS NULL OR @prenom IS NULL OR @date_naissance IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le compte abonne sont incompletes');
			ROLLBACK TRANSACTION blackListCompte
			RETURN -1;
		END
		
		DECLARE @IsInBlackList int;

		EXEC @IsInBlackList = dbo.isInListeNoire @nom, @prenom, @date_naissance;
		
		IF(@IsInBlackList = 1)
		BEGIN
			PRINT('declareConducteur: ERROR Il est deja en liste noire');
			ROLLBACK TRANSACTION blackListCompte
			RETURN -1;
		END
		
		-- ajouter dans la liste noire
		EXECUTE dbo.createListeNoire @date_naissance, @nom, @prenom;

		-- desactiver le compte
		UPDATE CompteAbonne
		SET actif = 0
		WHERE nom = @nom AND prenom = @prenom AND date_naissance = @date_naissance;
		
		-- a_supprimer pour RelanceDecouvert
		UPDATE RelanceDecouvert
		SET a_supprimer = 1
		WHERE nom_compteabonne = @nom AND prenom_compteabonne = @prenom AND date_naissance_compteabonne = @date_naissance;
		
		CREATE TABLE #Temp(id_reservation int);
		INSERT INTO #Temp(id_reservation)
			SELECT r.id 
			FROM Reservation r
			INNER JOIN Abonnement a
			ON a.id = r.id_abonnement
			WHERE a.nom_compteabonne = @nom AND a.prenom_compteabonne = @prenom AND a.date_naissance_compteabonne = @date_naissance
		
		-- annuler les reservation
		UPDATE Reservation SET annule = 1, a_supprimer = 1 WHERE id in (select id_reservation from #Temp);

		-- liberer les voitures reservees
		DELETE FROM ReservationVehicule WHERE id_reservation in (select id_reservation from #Temp);
		
		COMMIT TRANSACTION blackListCompte
		PRINT('blackListCompte OK');
		RETURN 1;
		
	END TRY
	BEGIN CATCH
		PRINT('blackListCompte: ERROR');
		ROLLBACK TRANSACTION blackListCompte
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeTypeAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un type d'abonnement, remplace les champs nuls par les valeurs par défaut.
--				 Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeTypeAbonnement	
GO

CREATE PROCEDURE dbo.makeTypeAbonnement
	@nom 				nvarchar(50), -- PK
	@prix 				money,
	@nb_max_vehicules 	int, -- nullable
	@km					int -- nullable
AS
	BEGIN TRANSACTION makeTypeAbonnement
	BEGIN TRY
		IF @nb_max_vehicules IS NULL
			SET @nb_max_vehicules = 1;
		IF @km IS NULL
			SET @km = 1000;
			
		EXEC dbo.createTypeAbonnement
			@nom = @nom,
			@prix = @prix,
			@nb_max_vehicules = @nb_max_vehicules,
			@km = @km;
		COMMIT TRANSACTION makeTypeAbonnement
		PRINT('makeTypeAbonnement OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeTypeAbonnement: ERROR');
		ROLLBACK TRANSACTION makeTypeAbonnement
		RETURN -1;
	END CATCH
GO

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

------------------------------------------------------------
-- Fichier     : endEtat.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met fin à un état non terminé
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.endEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.endEtat	
GO

CREATE PROCEDURE dbo.endEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_apres	 		datetime, -- nullable
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat 				bit, -- nullable, mettre faux si rien n'est indiqué
	@vehicule_statut	nvarchar(50) -- nullable, met dispo par défaut
AS
	BEGIN TRANSACTION endEtat
	BEGIN TRY
		DECLARE @id_Loc int, @idEtat int, @date_av datetime, @date_ap datetime, @km_ap int, @fiche_ap nvarchar(50), @diffDay int;
		DECLARE @prix money, @idFac int, @nbIntePenal int, @sumInfra int, @reduction int;
		
		SELECT @id_Loc = id, @idEtat = id_etat FROM Location WHERE matricule_vehicule = @matricule AND id_contratLocation = @idContratLocation;
				
		IF @id_Loc IS NULL
		BEGIN
			RAISERROR('Location pas trouvee', 10, -1);
			RETURN -1;
		END
			
		IF @idEtat IS NULL
		BEGIN
			RAISERROR('Etat inexistant', 10, -1);
			RETURN -1;
		END		
		
		SELECT @date_ap = date_apres, @km_ap = km_apres, @fiche_ap = fiche_apres, @date_av = date_avant FROM Etat WHERE id = @idEtat;
		
		IF @date_ap IS NOT NULL OR @km_ap IS NOT NULL OR @fiche_ap NOT LIKE ''
		BEGIN
			RAISERROR('Etat deja termine', 10, -1);
			RETURN -1;
		END
			
		IF @km_apres < (SELECT km_avant FROM Etat WHERE id = @idEtat)
		BEGIN
			RAISERROR('Kilometrage moins eleve que prevu', 10, -1);
			RETURN -1;
		END
		
		IF @degat IS NULL
			SET @degat = 'false';
			
		IF @date_apres IS NULL
			SET @date_apres = GETDATE();
			
		IF @vehicule_statut IS NULL
			SET @vehicule_statut = 'Disponible';
			
		IF @vehicule_statut IN ('En panne', 'Perdue')
			EXEC dbo.findOtherVehicule
				@matricule = @matricule,
				@itMustBeDone = 'true',
				@date_fin = NULL;
		
		EXEC dbo.updateEtat
			@id = @idEtat,
			@date_apres = @date_apres,
			@km_apres = @km_apres,
			@fiche_apres = @fiche_apres,
			@degat = @degat;
			
		EXEC dbo.setKilometrageVehicule
			@matricule = @matricule,
			@kilometrage = @km_apres;
		
		EXEC dbo.setStatutVehicule
			@matricule = @matricule,
			@statut = @vehicule_statut;
			
		SELECT @diffDay = DATEDIFF(day, @date_av, @date_apres) + (SELECT extension FROM ContratLocation WHERE id = @idContratLocation);
		SET @prix = @diffDay * (SELECT prix FROM TypeAbonnement WHERE nom = 
			(SELECT nom_typeabonnement FROM Abonnement WHERE id =
				(SELECT id_abonnement FROM ContratLocation WHERE id = @idContratLocation)))
				
		SELECT @reduction = reduction FROM Modele m, Vehicule v
		WHERE   v.matricule = @matricule
			AND m.marque = v.marque_modele
			AND m.serie = v.serie_modele
			AND m.portieres = v.portieres_modele
			AND m.type_carburant = v.type_carburant_modele;
				
		SET @prix = (@prix * (100 - @reduction )) / 100;

		SET @sumInfra = 0;
		SELECT @sumInfra = SUM(montant) FROM Infraction WHERE id_location = @id_Loc AND regle = 'false';
		SELECT @nbIntePenal = COUNT(*) FROM Incident WHERE id_location = @id_Loc AND penalisable = 'true';
		
		IF @sumInfra IS NULL
			SET @sumInfra = 0;
		
		SET @prix += (50.0*@nbIntePenal) + @sumInfra;
		
		EXEC @idFac = dbo.createFacturation
			@montant = @prix;
		
		UPDATE Location
		SET id_facturation = @idFac
		WHERE id = @id_Loc;
			
		COMMIT TRANSACTION endEtat
		PRINT('endEtat OK');
		RETURN @idEtat;
	END TRY
	BEGIN CATCH
		PRINT('endEtat: ERROR');
		ROLLBACK TRANSACTION endEtat
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : endContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.endContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.endContratLocation	
GO

CREATE PROCEDURE dbo.endContratLocation
	@idContratLocation	int, -- PK
	@date_fin_effective datetime -- nullable, en pratique, cet argument ne devrait pas apparaître. Il est présent pour faire le peuplement. Prendre la valeur du jour si nul
AS
	BEGIN TRANSACTION endContratLocation
	BEGIN TRY
		DECLARE @idLoc int, @idFac int, @idEtat int, @km int, @date_fi datetime, @extensio int;
		DECLARE @Location_T TABLE(
			id_facturation int,
			id_etat int,
			km int
		);
		IF @date_fin_effective IS NULL
			SET @date_fin_effective = GETDATE();
		
		SELECT @date_fi = date_fin_effective FROM ContratLocation WHERE id = @idContratLocation;
		IF @date_fi IS NOT NULL
		BEGIN
			RAISERROR('Contrat deja fini', 10, -1);
			RETURN -1;
		END
			
		INSERT INTO @Location_T(id_facturation, id_etat, km) (SELECT l.id_facturation, l.id_etat, e.km_apres FROM Location l, Etat e WHERE l.id_contratLocation = @idContratLocation AND e.id = l.id_etat);
		
		
		DECLARE Locat_cursor CURSOR
			FOR SELECT * FROM @Location_T
		OPEN Locat_cursor;
		FETCH NEXT FROM Locat_cursor
			INTO @idFac, @idEtat, @km;
			
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @idFac IS NULL
			BEGIN
				RAISERROR('Pas de facture cree', 10, -1);
				RETURN -1;
			END
			IF @km IS NULL
			BEGIN
				RAISERROR('Pas de km dans la location', 10, -1);
				RETURN -1;
			END
			IF (SELECT fiche_apres FROM Etat WHERE id = @idEtat) LIKE ''
			BEGIN
				RAISERROR('Etat non termine', 10, -1);
				RETURN -1;
			END
			FETCH NEXT FROM Locat_cursor
				INTO @idFac, @idEtat, @km;		
		END
		
		CLOSE Locat_cursor;
		DEALLOCATE Locat_cursor;
		
		SELECT @date_fi = date_fin, @extensio = extension FROM ContratLocation WHERE id = @idContratLocation;
		
		IF DATEADD(day, @extensio, @date_fi) < @date_fin_effective
			PRINT('Depassement detectee');
		
		UPDATE ContratLocation
		SET date_fin_effective = @date_fin_effective
		WHERE id = @idContratLocation;
			
		EXEC dbo.printContratLocation @idContratLocation;
		
		COMMIT TRANSACTION endContratLocation
		PRINT('endContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('endContratLocation: ERROR');
		ROLLBACK TRANSACTION endContratLocation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : extendContratLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendContratLocation	
GO

CREATE PROCEDURE dbo.extendContratLocation
	@idContratLocation	int, -- PK
	@extension			int
AS
	BEGIN TRANSACTION extendContratLocation
	BEGIN TRY
		DECLARE @date_f datetime, @date_f_ext datetime, @matricule nvarchar(50), @res int;
		DECLARE @Vehicule_T TABLE(
			matricule nvarchar(50)
		);
		
		IF @extension <= 0
		BEGIN
			RAISERROR('L''extension doit etre positive', 10, -1);
			RETURN -1;
		END
		
		SELECT @date_f = date_fin FROM ContratLocation WHERE id = @idContratLocation;
		SET @date_f_ext = DATEADD(day, @extension, @date_f);
		INSERT INTO @Vehicule_T (matricule)
			(SELECT matricule_vehicule FROM Location WHERE id_contratLocation = @idContratLocation);
		
		DECLARE veh_cursor CURSOR
			FOR SELECT * FROM @Vehicule_T;
		OPEN veh_cursor;
		FETCH NEXT FROM veh_cursor
			INTO @matricule;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (SELECT COUNT(r.id) FROM Reservation r, ReservationVehicule rv WHERE
					rv.matricule_vehicule = @matricule
				AND rv.id_reservation = r.id
				AND r.date_debut <= @date_f_ext) > 0
			BEGIN
				EXEC @res = dbo.findOtherVehicule
					@matricule = @matricule,
					@itMustBeDone = 'false',
					@date_fin = @date_f_ext;
				IF @res = -1
				BEGIN
					RAISERROR('Extension impossible, chevauchement sur une reservation', 10, -1);
					RETURN -1;
				END
			END
			FETCH NEXT FROM veh_cursor
				INTO @matricule;
		END
		
		CLOSE veh_cursor;
		DEALLOCATE veh_cursor;
		
		EXEC dbo.updateContratLocation
			@id = @idContratLocation,
			@date_fin_effective = NULL,
			@extension = @extension;
		
		COMMIT TRANSACTION extendContratLocation
		PRINT('extendContratLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('extendContratLocation: ERROR');
		ROLLBACK TRANSACTION extendContratLocation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : closeVehicule.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met le vehicule a supprimer si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeVehicule	
GO

CREATE PROCEDURE dbo.closeVehicule
	@matricule varchar(50)
AS
	BEGIN TRANSACTION closeVehicule	
	DECLARE @msg varchar(4000)
	DECLARE @tmp int
	BEGIN TRY 
		
		--verification de l'argument
		IF(@matricule IS NULL)
		BEGIN
			PRINT('closeVehicule: Le matricule doit etre renseigne');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END
		
		--est-ce que le vehicule existe
		IF((SELECT COUNT(*)
			FROM Vehicule
			WHERE matricule = @matricule) <> 1)
		BEGIN
			PRINT('closeVehicule: Le vehicule n''existe pas');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END	
		
		--est ce que le vehicule est deja a supprimer
		IF((SELECT a_supprimer
			FROM Vehicule
			WHERE matricule = @matricule) <> 'false')
		BEGIN
			PRINT('closeVehicule: Le vehicule est deja a supprimer');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END	
		
		-- le vehicule est-il present dans la table ReservationVehicule
		IF((SELECT COUNT(*)
			FROM ReservationVehicule
			WHERE matricule_vehicule = @matricule) > 0)
		BEGIN
			BEGIN TRY
				EXEC  findOtherVehicule @matricule, 'true', NULL
				-- TODO : gerer le surclassement
				PRINT('Le vehicule a ete remplace dans toutes les autres reservations future')
			END TRY
			BEGIN CATCH
				PRINT('closeVehicule: Le vehicule est reserve et ne peut etre remplace par un modele equivalent.');
				ROLLBACK TRANSACTION closeVehicule
				RETURN -1			
			END CATCH
		END
		
		-- le vehicule est-il present dans la table Location
		/*IF((SELECT COUNT(*)
			FROM Location
			WHERE matricule_vehicule = @matricule) > 0)
		BEGIN
			--TODO : la fonction delete doit verifier 
			PRINT('closeVehicule: Le vehicule est loué');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END
		*/
		-- mise a supprimer du vehicule
		UPDATE Vehicule
		SET a_supprimer = 'true'
		WHERE matricule = @matricule
			
		COMMIT TRANSACTION closeVehicule
		PRINT('closeVehicule OK');
		RETURN 1 		
	END TRY
	BEGIN CATCH
		PRINT 'closeVehicule : Exception recue'
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeVehicule
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : extendReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Etend une réservation en lui associant un nouveau véhicule. Prend le premier disponible.
--				 Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendReservation	
GO

CREATE PROCEDURE dbo.extendReservation
	@id_reservation			int, -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	BEGIN TRANSACTION extendReservation
	BEGIN TRY
		DECLARE @matricule nvarchar(50), @date_d datetime, @date_f datetime, @res int, @continuer bit;
		DECLARE @Veh_T TABLE(
			matricule nvarchar(50)
		);
		
		IF @id_reservation IS NULL
		BEGIN
			RAISERROR('ID reservation nul', 10, -1);
			RETURN -1;
		END
		
		SELECT @date_d = date_debut, @date_f = date_fin FROM Reservation WHERE id = @id_reservation;
		
		SET @continuer = 'true';
		
		INSERT INTO @Veh_T(matricule)
			(SELECT matricule FROM Vehicule WHERE
					marque_modele = @marque
				AND serie_modele = @serie
				AND type_carburant_modele = @type_carburant
				AND portieres_modele = @portieres
				AND statut IN ('Louee', 'Disponible') );
		
		DECLARE veh_cursor CURSOR
			FOR SELECT * FROM @Veh_T;
		OPEN veh_cursor;
		
		FETCH NEXT FROM veh_cursor
			INTO @matricule;
			
		WHILE @@FETCH_STATUS = 0 AND @continuer = 'true'
		BEGIN
			SELECT @res = COUNT(r.id) FROM ReservationVehicule rv, Reservation r WHERE 
					rv.matricule_vehicule = @matricule
				AND r.id = rv.id_reservation
				AND (  ( @date_d < r.date_debut AND @date_f > r.date_debut )
					OR ( @date_d > r.date_debut AND @date_f < r.date_fin)
					OR ( @date_d < r.date_fin   AND @date_f > r.date_fin)
					)
			IF @res > 0
			BEGIN				
				FETCH NEXT FROM veh_cursor
					INTO @matricule;
			END
			ELSE
			BEGIN
				SET @continuer = 'false';
			END
		END
		
		CLOSE veh_cursor;
		DEALLOCATE veh_cursor;
		
		IF @continuer = 'false'
		BEGIN
			INSERT INTO ReservationVehicule(id_reservation, matricule_vehicule)
			VALUES (@id_reservation, @matricule);
			COMMIT TRANSACTION extendReservation
			PRINT('extendReservation OK');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('Pas d''extension possible avec le modele demande');
			RETURN -1;
		END
		
	END TRY
	BEGIN CATCH
		PRINT('extendReservation: ERROR');
		ROLLBACK TRANSACTION extendReservation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : modifyAbonnement.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie le renouvellement automatique de l'abonnement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyAbonnement	
GO

CREATE PROCEDURE dbo.modifyAbonnement
	@id 					int, -- PK
	@renouvellement_auto	bit
AS
	BEGIN TRANSACTION modifyAbonnement
	BEGIN TRY
		
		IF @renouvellement_auto IS NOT NULL AND @id IS NOT NULL
		BEGIN
			UPDATE Abonnement
			SET renouvellement_auto = @renouvellement_auto
			WHERE id = @id;
			COMMIT TRANSACTION modifyAbonnement
			PRINT('modifyAbonnement OK');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('renouvellement_auto ou id nul');
			ROLLBACK TRANSACTION modifyAbonnement
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('modifyAbonnement: ERROR');
		ROLLBACK TRANSACTION modifyAbonnement
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : fixFacturation.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Indique que la facture a ete paye en ajoutant la 
-- date du paiement de la location. Si la
-- date de reception du paiement n'a pas ete renseigne, la
-- date renseigné est aujourd'hui.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixFacturation	
GO

CREATE PROCEDURE dbo.fixFacturation
	@id_contrat					nvarchar(50),	-- PK
	@matricule 					nvarchar(50),	-- PK
	@date_reception				date			-- nullable
AS
	BEGIN TRANSACTION fixFacturation
	DECLARE @msg varchar(4000)
	BEGIN TRY
		
		/*
		DECLARE @tmp int;
		SET @tmp =(SELECT id
					FROM Location
					WHERE id_contratLocation = @id_contrat
					AND matricule_vehicule = @matricule)
		PRINT('test1')
		PRINT('id_location = ' + CONVERT(varchar(10),@tmp))
		PRINT('test2')
		*/
						
		IF(@id_contrat IS NULL)
		BEGIN
			PRINT('fixFacturation: id_contrat ne doit pas etre NULL');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END 
		
		IF(@matricule IS NULL)
		BEGIN
			PRINT('fixFacturation: matricule ne doit pas etre NULL');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END 
		
		
		IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = @id_contrat
						AND matricule_vehicule = @matricule)) IS NOT NULL)
			BEGIN
				PRINT('fixFacturation: la facturation a deja ete regle');
				ROLLBACK TRANSACTION fixFacturation
				RETURN -1;
			END
			
		IF(@date_reception > GETDATE())
		BEGIN
			PRINT('fixFacturation: la facturation ne peut pas avoir ete regle dans le future');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END
		
		IF((SELECT date_creation 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = @id_contrat
						AND matricule_vehicule = @matricule)) > @date_reception)
		BEGIN
			PRINT('fixFacturation: la facturation ne peut pas avoir ete regle avant d''avoir ete cree');
			ROLLBACK TRANSACTION fixFacturation
			RETURN -1;
		END
						
		UPDATE Facturation
		SET date_reception =	CASE WHEN (@date_reception IS NULL) 
								THEN GETDATE()
								ELSE @date_reception
								END  
		WHERE id = (SELECT id_facturation 
					FROM Location
					WHERE id_contratLocation = @id_contrat
					AND matricule_vehicule = @matricule)
	
		COMMIT TRANSACTION fixFacturation
		PRINT('fixFacturation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixFacturation: ERROR');
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION fixFacturation
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : makeInfraction.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeInfraction	
GO

CREATE PROCEDURE dbo.makeInfraction
	@matricule				nvarchar(50), -- FK
	@date					datetime,
	@nom 					nvarchar(50),
	@montant 				money,
	@description 			nvarchar(50)
AS
	BEGIN TRANSACTION makeInfraction
	BEGIN TRY
	
		DECLARE @id_location INT;
		SET @id_location = (SELECT l.id FROM Location l,ContratLocation cl 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id_contratLocation=cl.id 
										AND cl.date_debut<=@date
										AND cl.date_fin >= @date);
		
		EXEC createInfraction @date,@id_location,@nom,@montant,@description,'false' ;
		
		COMMIT TRANSACTION makeInfraction
		PRINT('makeInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeInfraction: ERROR');
		ROLLBACK TRANSACTION makeInfraction
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : fixInfraction.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixInfraction	
GO

CREATE PROCEDURE dbo.fixInfraction
	@matricule				nvarchar(50), -- FK
	@date					datetime
AS
	BEGIN TRANSACTION fixInfraction
	BEGIN TRY
	
		DECLARE @id_location INT;
		SET @id_location = (SELECT l.id FROM Location l,Infraction i 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id=i.id_location
										AND i.date = @date);	
										
		UPDATE Infraction SET regle='true' WHERE date = @date			
										   AND id_location = @id_location;			

		COMMIT TRANSACTION fixInfraction
		PRINT('fixInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixInfraction: ERROR');
		ROLLBACK TRANSACTION fixInfraction
		RETURN -1;
	END CATCH
GO

------------------------------------------------------------
-- Fichier     : showInfraction.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.showInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.showInfraction	
GO

CREATE PROCEDURE dbo.showInfraction
	@matricule				nvarchar(50), -- FK
	@date					datetime
AS
	BEGIN TRANSACTION showInfraction
	BEGIN TRY
	
		DECLARE @id_location		INT,
				@nom_Infraction		varchar(50),
				@description		varchar(50),
				@montant			money,
				@regle				bit,
				@nom				varchar(50),
				@prenom				varchar(50),
				@date_naissance		date;
		
		
		SET @id_location = (SELECT l.id FROM Location l,Infraction i 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id=i.id_location
										AND i.date = @date);
										
		SELECT @nom_Infraction = nom, @description=description, @montant = montant, @regle = regle   FROM Infraction WHERE date = @date
																													 AND   id_location = @id_location;
										
										
		SELECT @nom=a.nom_compteabonne, @prenom=a.prenom_compteabonne, @date_naissance=a.date_naissance_compteabonne  FROM Abonnement a, ContratLocation cl, Location l
																													  WHERE l.id = @id_location
																													  AND   cl.id = l.id_contratLocation
																													  AND   a.id = cl.id_abonnement;
	
	
--affichage de l(infraction
PRINT '_________________________________________________________________________';
PRINT 'Nom infraction : ' + convert(varchar(50),@nom_Infraction);
PRINT 'Date infraction : ' + convert(varchar(10),@date);
PRINT 'Description de l''infraction : ' + convert(varchar(50),@description);
PRINT 'Montant de l''infraction : ' + convert(varchar(50),@montant);
IF(@regle = 'false')
BEGIN
PRINT 'Infraction réglé : NON';
END
ELSE
BEGIN
PRINT 'Infraction réglé : OUI';
END
PRINT 'Information de l''abonné concerné par l''infraction : ';
PRINT '		Nom : ' + convert(varchar(50),@nom);
PRINT '		Prenom : ' + convert(varchar(50),@prenom);
PRINT '		Date de naissance : ' + convert(varchar(50),@date_naissance);

PRINT '_________________________________________________________________________';

		COMMIT TRANSACTION showInfraction
		PRINT('showInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('showInfraction: ERROR');
		ROLLBACK TRANSACTION showInfraction
		RETURN -1;
	END CATCH
GO