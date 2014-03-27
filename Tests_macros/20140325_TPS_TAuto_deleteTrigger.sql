------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_modifyAbonnement
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la suppression 
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.closeVehicule
	@matricule varchar(50)--PK
*/

--Test 1
-- test de la suppression d'un catalogue
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Catalogue
	SET a_supprimer = 'true'
	WHERE nom = 'automne 2014'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du catalogue
		IF ((SELECT COUNT(*) FROM Catalogue
			WHERE nom = 'automne 2014') <> 0)
		BEGIN
			PRINT('------------------------------Test 1 - erreur de suppression dans la table Catalogue -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM CatalogueCategorie
			WHERE nom_catalogue = 'automne 2014') <> 0  )
			BEGIN
				PRINT('------------------------------Test 1 - Erreur de suppression dans la table CatalogueCategorie - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
--test de la suppression d'une categorie
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Categorie
	SET a_supprimer = 'true'
	WHERE nom = '4x4'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression de la categorie
		IF ((SELECT COUNT(*) FROM Categorie
			WHERE nom = '4x4') <> 0)
		BEGIN
			PRINT('------------------------------Test 2 - erreur de suppression dans la table Categorie -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM CatalogueCategorie
			WHERE nom_catalogue = '4x4') <> 0  )
			BEGIN
				PRINT('------------------------------Test 2 - Erreur de suppression dans la table CatalogueCategorie - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 2 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 2 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO


--Test 3
--test de la suppression d'un vehicule
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Vehicule
	SET a_supprimer = 'true'
	WHERE matricule = '0775896we'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du vehicule
		IF ((SELECT COUNT(*) FROM ReservationVehicule
			WHERE  matricule_vehicule = '0775896we') <> 0)
		BEGIN
			PRINT('------------------------------Test 3 - erreur de suppression dans la table ReservationVehicule -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Location
			WHERE matricule_vehicule = '0775896we') <> 0  )
			BEGIN
				PRINT('------------------------------Test 3 - Erreur de suppression dans la table Location - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Vehicule
				WHERE matricule = '0775896we') <> 0)
				BEGIN
					PRINT('------------------------------Test 3 - Erreur de suppression dans la table Vehicule - KO');
				END
				ELSE
				BEGIN
					PRINT('------------------------------Test 3 - OK');
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 3 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO


--Test 4
--test de la suppression d'un modele
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Modele
	SET a_supprimer = 'true'
	WHERE marque = 'BMW'
	AND serie = '5 F10 M5'
	AND type_carburant = 'Essence'
	AND portieres = 5
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du modele
		IF ((SELECT COUNT(*) FROM CategorieModele
			WHERE  marque_modele = 'BMW'
			AND serie_modele = '5 F10 M5'
			AND type_carburant_modele = 'Essence'
			AND portieres_modele = 5) <> 0)
		BEGIN
			PRINT('------------------------------Test 4 - erreur de suppression dans la table CategorieModele -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Vehicule
			WHERE  marque_modele = 'BMW'
			AND serie_modele = '5 F10 M5'
			AND type_carburant_modele = 'Essence'
			AND portieres_modele = 5) <> 0)
			BEGIN
				PRINT('------------------------------Test 4 - Erreur de suppression dans la table Vehicule - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 4 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO


--Test5
--test de la suppression d'une reservation
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Reservation
	SET a_supprimer = 'true'
	WHERE id = 1
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression de la reservation
		IF ((SELECT COUNT(*) FROM ReservationVehicule
			WHERE  id_reservation = 1) <> 0)
		BEGIN
			PRINT('------------------------------Test 5 - erreur de suppression dans la table ReservationVehicule -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Reservation
			WHERE  id = 1) <> 0)
			BEGIN
				PRINT('------------------------------Test 5 - Erreur de suppression dans la table Reservation - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 5 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test6
--test de la suppression abonnement
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Abonnement
	SET a_supprimer = 'true'
	WHERE id = 13
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression de l'abonnement
		IF ((SELECT COUNT(*) FROM Reservation
			WHERE  id_abonnement = 13) <> 0)
		BEGIN
			PRINT('------------------------------Test 6 - erreur de suppression dans la table Reservation -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM ContratLocation
			WHERE  id_abonnement = 13) <> 0)
			BEGIN
				PRINT('------------------------------Test 6 - Erreur de suppression dans la table ContratLocation - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Abonnement
				WHERE id = 13) <> 0)
				BEGIN
					PRINT('------------------------------Test 6 - Erreur de suppression dans la table Abonnement - KO');
				END
				ELSE
				BEGIN
					PRINT('------------------------------Test 6 - OK');
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 6 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO

--Test 7
--Test de la suppression d'un type d'abonnement
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE TypeAbonnement
	SET a_supprimer = 'true'
	WHERE nom = '1vehicules'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du type d'abonnement
		IF ((SELECT COUNT(*) FROM Abonnement
			WHERE  nom_typeabonnement = '1vehicules') <> 0)
		BEGIN
			PRINT('------------------------------Test 7 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM TypeAbonnement
			WHERE  nom = '1vehicules') <> 0)
			BEGIN
				PRINT('------------------------------Test 7  - Erreur de suppression dans la table TypeAbonnement - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 7 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 7 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - Exception leve - KO');
END CATCH
GO

--Test 8
--Test de la suppression d'un compte particulier
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE CompteAbonne
	SET a_supprimer = 'true'
	WHERE nom = 'De Finance'
	AND prenom = 'Boris'
	AND date_naissance = '1990-09-08'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du compte particulier
		IF ((SELECT COUNT(*) FROM Abonnement
			WHERE  nom_compteabonne = 'De Finance'
			AND prenom_compteabonne = 'Boris'
			AND date_naissance_compteabonne = '1990-09-08') <> 0)
		BEGIN
			PRINT('------------------------------Test 8 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Particulier
			WHERE  nom_compte = 'De Finance'
			AND prenom_compte = 'Boris'
			AND date_naissance_compte = '1990-09-08') <> 0)
			BEGIN
				PRINT('------------------------------Test 8  - Erreur de suppression dans la table Particulier - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Entreprise
				WHERE  nom_compte = 'De Finance'
				AND prenom_compte = 'Boris'
				AND date_naissance_compte = '1990-09-08') <> 0)
				BEGIN
					PRINT('------------------------------Test 8  - Erreur de suppression dans la table Entreprise - KO');
				END
				ELSE
				BEGIN
					IF((SELECT COUNT(*) FROM CompteAbonneConducteur
					WHERE  nom_compteabonne = 'De Finance'
					AND prenom_compteabonne = 'Boris'
					AND date_naissance_compteabonne = '1990-09-08') <> 0)
					BEGIN
						PRINT('------------------------------Test 8  - Erreur de suppression dans la table CompteAbonneConducteur - KO');
					END
					ELSE
					BEGIN
						IF((SELECT COUNT(*) FROM RelanceDecouvert
						WHERE  nom_compteabonne = 'De Finance'
						AND prenom_compteabonne = 'Boris'
						AND date_naissance_compteabonne = '1990-09-08') <> 0)
						BEGIN
							PRINT('------------------------------Test 8  - Erreur de suppression dans la table RelanceDecouvert - KO');
						END
						ELSE
						BEGIN
							IF((SELECT COUNT(*) FROM CompteAbonne
							WHERE  nom = 'De Finance'
							AND prenom = 'Boris'
							AND date_naissance = '1990-09-08') <> 0)
							BEGIN
								PRINT('------------------------------Test 8  - Erreur de suppression dans la table CompteAbonne - KO');
							END
							ELSE
							BEGIN
								PRINT('------------------------------Test 8 - OK');
							END
						END
					END
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 8 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - Exception leve - KO');
END CATCH
GO

--Test 9
--Test de la suppression d'un compte d'Entreprise
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE CompteAbonne
	SET a_supprimer = 'true'
	WHERE nom = 'TASociety'
	AND prenom = 'TASociety'
	AND date_naissance = '2014-02-24'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du compte particulier
		IF ((SELECT COUNT(*) FROM Abonnement
			WHERE  nom_compteabonne = 'TASociety'
			AND prenom_compteabonne = 'TASociety'
			AND date_naissance_compteabonne = '2014-02-24') <> 0)
		BEGIN
			PRINT('------------------------------Test 9 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Particulier
			WHERE  nom_compte = 'TASociety'
			AND prenom_compte = 'TASociety'
			AND date_naissance_compte = '2014-02-24') <> 0)
			BEGIN
				PRINT('------------------------------Test 9  - Erreur de suppression dans la table Particulier - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Entreprise
				WHERE  nom_compte = 'TASociety'
				AND prenom_compte = 'TASociety'
				AND date_naissance_compte = '2014-02-24') <> 0)
				BEGIN
					PRINT('------------------------------Test 9  - Erreur de suppression dans la table Entreprise - KO');
				END
				ELSE
				BEGIN
					IF((SELECT COUNT(*) FROM CompteAbonneConducteur
					WHERE  nom_compteabonne = 'TASociety'
					AND prenom_compteabonne = 'TASociety'
					AND date_naissance_compteabonne = '2014-02-24') <> 0)
					BEGIN
						PRINT('------------------------------Test 9  - Erreur de suppression dans la table CompteAbonneConducteur - KO');
					END
					ELSE
					BEGIN
						IF((SELECT COUNT(*) FROM RelanceDecouvert
						WHERE  nom_compteabonne = 'TASociety'
						AND prenom_compteabonne = 'TASociety'
						AND date_naissance_compteabonne = '2014-02-24') <> 0)
						BEGIN
							PRINT('------------------------------Test 9  - Erreur de suppression dans la table RelanceDecouvert - KO');
						END
						ELSE
						BEGIN
							IF((SELECT COUNT(*) FROM CompteAbonne
							WHERE  nom = 'TASociety'
							AND prenom = 'TASociety'
							AND date_naissance = '2014-02-24') <> 0)
							BEGIN
								PRINT('------------------------------Test 9  - Erreur de suppression dans la table CompteAbonne - KO');
							END
							ELSE
							BEGIN
								PRINT('------------------------------Test 9 - OK');
							END
						END
					END
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 9 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - Exception leve - KO');
END CATCH
GO

--Test 10 
--Test de la suppression d'une relance decouvert
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE RelanceDecouvert
	SET a_supprimer = 'true'
	WHERE date = '20140226 11:00:00' 
	AND nom_compteabonne = 'Lecoconier'
	AND prenom_compteabonne = 'David'
	AND date_naissance_compteabonne = '1990-02-02'
	
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du type d'abonnement
		IF ((SELECT COUNT(*) FROM RelanceDecouvert
			WHERE date = '20140226 11:00:00' 
			AND nom_compteabonne = 'Lecoconier'
			AND prenom_compteabonne = 'David'
			AND date_naissance_compteabonne = '1990-02-02') <> 0)
		BEGIN
			PRINT('------------------------------Test 10 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE
		BEGIN 	
			PRINT('------------------------------Test 10 - OK');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 10 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - Exception leve - KO');
END CATCH
GO