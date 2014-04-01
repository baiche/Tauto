------------------------------------------------------------
-- Fichier     : demonstrateur
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Procedures de test pour le demonstrateur
------------------------------------------------------------
USE TAuto_IBDR;

----------------------testCatalogue-------------------------

IF OBJECT_ID ('dbo.testCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testCatalogue
GO

------------------------------------------------------------
-- Procédure de démonstration des macros:
--		makeCatalogue
--		makeCategorie
--		makeModele
--		makeVehicule
--
-- Scénario :
-- Création d'un catalogue printemps 2014. 
-- Ajout d'une catégorie voiture. 
-- Ajout d'un modèle Peugeot 406 Diesel 5 portes.
-- Ajout d'un véhicule de matricule 0123456ab, bleu et ayant
-- 1000km dans ce modèle.
------------------------------------------------------------
CREATE PROCEDURE dbo.testCatalogue
AS
	BEGIN
		SET NOCOUNT ON
		EXEC dbo.videTables;
		
		PRINT('Liste des catalogues avant ajout');
		SELECT * FROM Catalogue;
		PRINT('Liste des catégories avant ajout');
		SELECT * FROM Categorie;
		PRINT('Liste des modèles avant ajout');
		SELECT * FROM Modele;
		PRINT('Liste des véhicules avant ajout');
		SELECT * FROM Vehicule;
	
		EXEC dbo.makeCatalogue 'printemps 2014', '2014-03-20', '2014-06-20';
		EXEC dbo.makeCategorie 'printemps 2014', 'voiture', 'Voitures de toutes tailles', 'B';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '406', 'Diesel', 5, 2004, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ab', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		
		PRINT('');
		PRINT('Liste des catalogues après ajout');
		SELECT * FROM Catalogue;
		PRINT('Liste des catégories après ajout');
		SELECT * FROM Categorie;
		PRINT('Liste des modèles après ajout');
		SELECT * FROM Modele;
		PRINT('Liste des véhicules après ajout');
		SELECT * FROM Vehicule;
		
	END
GO	
-----------------testAbonnementLocation--------------------

IF OBJECT_ID ('dbo.testAbonnementLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testAbonnementLocation
GO

------------------------------------------------------------
-- Procédure de démonstration des macros:
--		makeCompteParticulier
--		makeAbonnement
--		declareConducteur
--		makeReservation
--		turnReservationIntoContratLocation
--		makeEtat
--
-- Scénario :
-- Inscripton de Sophie Dupont avec choix de l'abonnement 
-- 1vehicule pour une durée de 5 jours. 
-- Ajout de Jean Dupont et de Sophie Dupont comme conducteur.
-- Location immédiate d'une Peugeot 406 Diesel 5 portes pour
-- les 5 jours de l'abonnement.
------------------------------------------------------------
CREATE PROCEDURE dbo.testAbonnementLocation
AS
	BEGIN
		SET NOCOUNT ON
		
-- Remplissage des tables avec le minimum d'information nécéssaire
		
		EXEC dbo.videTables;
		PRINT('');
		PRINT('Remplissage des informations minimum nécéssaire au test');
		PRINT('');
		EXEC dbo.createTypeAbonnement '1vehicule', '5', 1, 100;
		EXEC dbo.makeCatalogue 'printemps 2014', '2014-03-20', '2014-06-20';
		EXEC dbo.makeCategorie 'printemps 2014', 'voiture', 'Voitures de toutes tailles', 'B';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '406', 'Diesel', 5, 2004, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ab', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ac', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		EXEC dbo.setStatutVehicule '0123456ab', 'En Panne';
		
		PRINT('');
			
		DECLARE @id_abo int,
				@id_reservation int,
				@id_contratLoc int,
				@date_deb date = '2014-03-29',
				@date_fin date = '2014-04-02';

-- debut du test

		PRINT('Création du CompteAbonne de Sophie Dupont et selection de l''abonnement 1vehicule');
		PRINT('');
		PRINT('Liste des associations Abonnement-CompteAbonne avant ajout');		
		SELECT cpta.nom, cpta.prenom, abo.nom_typeabonnement AS type_abonnement, abo.date_debut, abo.duree 
			FROM CompteAbonne cpta
				JOIN Abonnement abo 
					ON cpta.nom=abo.nom_compteabonne 
					AND cpta.prenom=abo.prenom_compteabonne 
					AND cpta.date_naissance=abo.date_naissance_compteabonne;
					

		EXEC dbo.makeCompteParticulier 'Dupont', 'Sophie', '1990-09-10', 'LU2800194006447500001234567', 'sophie.dupont@mail.com', '0123456789';
		EXEC dbo.makeAbonnement @date_deb, 5, 'false', '1vehicule', 'Dupont', 'Sophie', '1990-09-10';

		PRINT('');
		PRINT('Liste des associations Abonnement-CompteAbonne après ajout');
		SELECT cpta.nom, cpta.prenom, abo.nom_typeabonnement AS type_abonnement, abo.date_debut, abo.duree
			FROM CompteAbonne cpta
				JOIN Abonnement abo 
					ON cpta.nom=abo.nom_compteabonne 
					AND cpta.prenom=abo.prenom_compteabonne 
					AND cpta.date_naissance=abo.date_naissance_compteabonne;
					
		PRINT('');
		PRINT('Ajout des conducteurs Sophie et Jean Dupont associés au compte de Sophie');
		PRINT('');
		PRINT('Liste des conducteurs déclarés avant ajout');
		SELECT cpta.nom AS nom_abonne, cpta.prenom AS prenom_abonne, cond.nom AS nom_conducteur, cond.prenom AS prenom_conducteur 
			FROM Conducteur cond
				JOIN CompteAbonneConducteur cac
					ON cond.piece_identite=cac.piece_identite_conducteur
					AND cond.nationalite=cac.nationalite_conducteur
				JOIN CompteAbonne cpta 
					ON cac.nom_compteabonne = cpta.nom
					AND cac.prenom_compteabonne = cpta.prenom
					AND cac.date_naissance_compteabonne = cpta.date_naissance;

		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Sophie', '123456009', 'Francais', '0000000006', 'B', '2010-03-14', NULL, '2025-03-14', 'true', 12;
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Jean', '123456010', 'Francais', '0000000007', 'B', '2014-03-17', 3, '2029-03-17', 'true', 4;

		PRINT('');
		PRINT('Liste des conducteurs déclarés après ajout');
		SELECT cpta.nom AS nom_abonne, cpta.prenom AS prenom_abonne, cond.nom AS nom_conducteur, cond.prenom AS prenom_conducteur 
			FROM Conducteur cond
				JOIN CompteAbonneConducteur cac
					ON cond.piece_identite=cac.piece_identite_conducteur
					AND cond.nationalite=cac.nationalite_conducteur
				JOIN CompteAbonne cpta 
					ON cac.nom_compteabonne = cpta.nom
					AND cac.prenom_compteabonne = cpta.prenom
					AND cac.date_naissance_compteabonne = cpta.date_naissance;
				
		PRINT('Liste des véhicules existants');
		SELECT * FROM Vehicule;
		
		PRINT('Liste des reservations avant demande');
		SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.matricule, veh.marque_modele, veh.serie_modele, res.a_supprimer   
			FROM Reservation res
				JOIN ReservationVehicule resVeh
					ON res.id = resVeh.id_reservation
				JOIN Vehicule veh
					ON resVeh.matricule_vehicule=veh.matricule
				JOIN Abonnement abo
					ON res.id_abonnement=abo.id;

		PRINT('Reservation par Sophie d''une Peugeot 406 Diesel 5 portes du 2014-03-28 au 2014-04-01');		
		SET @id_abo = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Dupont' AND a.prenom_compteabonne = 'Sophie' AND a.date_naissance_compteabonne = '1990-09-10');

		EXEC @id_reservation = dbo.makeReservation @id_abo,@date_deb,@date_fin, 'Peugeot', '406', 'Diesel', 5;

		PRINT('');
		PRINT('Liste des reservations après demande');
		SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.matricule, veh.marque_modele, veh.serie_modele, res.a_supprimer   
			FROM Reservation res
				JOIN ReservationVehicule resVeh
					ON res.id = resVeh.id_reservation
				JOIN Vehicule veh
					ON resVeh.matricule_vehicule=veh.matricule
				JOIN Abonnement abo
					ON res.id_abonnement=abo.id;

		PRINT('Passage en Location immédiate');
		EXEC @id_contratLoc = dbo.turnReservationIntoContratLocat @id_reservation, 100;

		PRINT('');
		PRINT('Liste des reservations après location');
		SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.matricule, veh.marque_modele, veh.serie_modele, res.a_supprimer   
			FROM Reservation res
				JOIN ReservationVehicule resVeh
					ON res.id = resVeh.id_reservation
				JOIN Vehicule veh
					ON resVeh.matricule_vehicule=veh.matricule
				JOIN Abonnement abo
					ON res.id_abonnement=abo.id;

		PRINT('Liste des locations');
		SELECT  abo.nom_compteabonne AS nom, abo.prenom_compteabonne AS prenom, conLoc.date_debut, conLoc.date_fin, loc.matricule_vehicule, veh.marque_modele, veh.serie_modele
			FROM Location loc
				JOIN ContratLocation conLoc
					ON loc.id_contratLocation = conLoc.id
				JOIN Abonnement abo
					ON conLoc.id_abonnement = abo.id
				JOIN Vehicule veh
					ON veh.matricule = loc.matricule_vehicule;

		EXEC dbo.makeEtat @id_contratLoc, '0123456ac', NULL, NULL, 'Parfait';
		
		PRINT('');
		PRINT('Etat nouvellement créée pour la location');
		SELECT * FROM Etat;
		
		
	END
GO
-----------------testReservationModeleIndisponible--------------------

IF OBJECT_ID ('dbo.testReservationModeleIndisponible', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testReservationModeleIndisponible
GO

------------------------------------------------------------
-- Procédure de démonstration des macros:
--		makeReservationWithElevation
--
-- Scénario :
-- L'abonne Sophie reserve une peugeot 406.
-- L'abonne John reserve la deuxieme Peugeot 406
-- L'abonne Bob tente aussi une reservation d'une Peugeot 406,
-- un autre modèle lui est proposé.
------------------------------------------------------------
CREATE PROCEDURE dbo.testReservationModeleIndisponible
AS
	BEGIN
		SET NOCOUNT ON
		
-- Remplissage des tables avec le minimum d'information nécéssaire
		
		EXEC dbo.videTables;
		PRINT('');
		PRINT('Remplissage des informations minimum nécéssaire au test');
		PRINT('');
		
		DECLARE @id_abo1 int,
				@id_abo2 int,
				@id_abo3 int,
				@id_reservation int,
				@date_deb1 date = '2014-05-20',
				@date_deb2 date = '2014-05-21',
				@date_fin1 date = '2014-05-22',
				@date_fin2 date = '2014-05-24';
				
		EXEC dbo.createTypeAbonnement '1vehicule', '5', 1, 100;
		EXEC dbo.makeCatalogue 'printemps 2014', '2014-03-20', '2014-06-20';
		EXEC dbo.makeCategorie 'printemps 2014', 'voiture', 'Voitures de toutes tailles', 'B';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '406', 'Diesel', 5, 2004, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ab', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '9876543xw', 43500, 'Rouge', 'SQ5 2G1BVC 45660012', 'voiture';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '407', 'Diesel', 5, 2006, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '407', 'Diesel', 5, '5464521rt', 27984, 'Noir', 'YS1 6D2GHS 45123052', 'voiture';
		EXEC dbo.makeCompteParticulier 'Dupont', 'Sophie', '1990-09-10', 'LU2800194006447500001234567', 'sophie.dupont@mail.com', '0123456789';
		EXEC dbo.makeAbonnement '2014-03-29', 5, 'false', '1vehicule', 'Dupont', 'Sophie', '1990-09-10';
		EXEC dbo.makeCompteParticulier 'Smith', 'John', '1984-11-03', 'AZ2800112345447500001233210', 'john.smith@mail.com', '0987654321';
		EXEC dbo.makeAbonnement '2014-03-29', 5, 'false', '1vehicule', 'Smith', 'John', '1984-11-03';
		EXEC dbo.makeCompteParticulier 'Martin', 'Bob', '1985-02-17', 'LO2807887345447512332105555', 'bob.martin@mail.com', '0123443210';
		EXEC dbo.makeAbonnement '2014-03-29', 5, 'false', '1vehicule', 'Martin', 'Bob', '1985-02-17';
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Sophie', '123456009', 'Francais', '0000000006', 'B', '2010-03-14', NULL, '2025-03-14', 'true', 12;
		EXEC dbo.declareConducteur 'Smith', 'John', '1984-11-03', 'Smith', 'John', '123456010', 'Francais', '0000000007', 'B', '2002-03-17', NULL, '2017-03-17', 'true', 7;
		EXEC dbo.declareConducteur 'Martin', 'Bob', '1985-02-17', 'Martin', 'Bob', '123456011', 'Francais', '0000000008', 'B', '2002-05-28', NULL, '2017-05-28', 'true', 10;
		SET @id_abo1 = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Dupont' AND a.prenom_compteabonne = 'Sophie' AND a.date_naissance_compteabonne = '1990-09-10');
		SET @id_abo2 = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Smith' AND a.prenom_compteabonne = 'John' AND a.date_naissance_compteabonne = '1984-11-03');
		SET @id_abo3 = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Martin' AND a.prenom_compteabonne = 'Bob' AND a.date_naissance_compteabonne = '1985-02-17');
		
		PRINT('');
		PRINT('Liste des vehicules');
		SELECT * from Vehicule;
		
		PRINT('Premiere reservation d''une Peugeo 406');
		EXEC dbo.makeReservationWithElevation @id_abo1,@date_deb1,@date_fin1, 'Peugeot', '406', 'Diesel', 5;
		
		PRINT('');
		SELECT abo.nom_compteabonne AS nom, abo.prenom_compteabonne AS prenom, veh.matricule, veh.marque_modele AS marque, veh.serie_modele AS serie, res.date_debut, res.date_fin 
			FROM Reservation res, ReservationVehicule resVeh, Vehicule veh, Abonnement abo
			WHERE res.id = resVeh.id_reservation
				AND veh.matricule = resVeh.matricule_vehicule
				AND res.id_abonnement = abo.id;
		
		
		PRINT('Deuxieme reservation d''une Peugeo 406');
		EXEC dbo.makeReservationWithElevation @id_abo2,@date_deb2,@date_fin2, 'Peugeot', '406', 'Diesel', 5;
		
		PRINT('');
		SELECT abo.nom_compteabonne AS nom, abo.prenom_compteabonne AS prenom, veh.matricule, veh.marque_modele AS marque, veh.serie_modele AS serie, res.date_debut, res.date_fin 
			FROM Reservation res, ReservationVehicule resVeh, Vehicule veh, Abonnement abo
			WHERE res.id = resVeh.id_reservation
				AND veh.matricule = resVeh.matricule_vehicule
				AND res.id_abonnement = abo.id;

		PRINT('Troisieme reservation d''une Peugeo 406');
		EXEC dbo.makeReservationWithElevation @id_abo2,@date_deb2,@date_fin2, 'Peugeot', '406', 'Diesel', 5;
		
		PRINT('');
		SELECT abo.nom_compteabonne AS nom, abo.prenom_compteabonne AS prenom, veh.matricule, veh.marque_modele AS marque, veh.serie_modele AS serie, res.date_debut, res.date_fin 
			FROM Reservation res, ReservationVehicule resVeh, Vehicule veh, Abonnement abo
			WHERE res.id = resVeh.id_reservation
				AND veh.matricule = resVeh.matricule_vehicule
				AND res.id_abonnement = abo.id;
		

	END
GO
-----------------testChangementNomDeFamille--------------------

IF OBJECT_ID ('dbo.testChangementNomDeFamille', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testChangementNomDeFamille
GO

------------------------------------------------------------
-- Procédure de démonstration des macros:
--		modifyCompte
--		modifyConducteur
--
-- Scénario :
-- L'abonne Sophie Dupont vient de se marier et change donc 
-- de nom de famille pour s'appeler Sophie Martel.
------------------------------------------------------------
CREATE PROCEDURE dbo.testChangementNomDeFamille
AS
	BEGIN
		SET NOCOUNT ON
		
-- Remplissage des tables avec le minimum d'information nécéssaire
		
		EXEC dbo.videTables;
		PRINT('');
		PRINT('Remplissage des informations minimum nécéssaire au test');
		PRINT('');
		
		DECLARE @id_abo int,
				@id_reservation int,
				@date_deb1 date = '2014-05-20',
				@date_deb2 date = '2014-03-29',
				@date_fin1 date = '2014-05-22',
				@date_fin2 date = '2014-04-03';
				
		EXEC dbo.createTypeAbonnement '1vehicule', '5', 1, 100;
		EXEC dbo.makeCatalogue 'printemps 2014', '2014-03-20', '2014-06-20';
		EXEC dbo.makeCategorie 'printemps 2014', 'voiture', 'Voitures de toutes tailles', 'B';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '406', 'Diesel', 5, 2004, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ab', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		EXEC dbo.makeCompteParticulier 'Dupont', 'Sophie', '1990-09-10', 'LU2800194006447500001234567', 'sophie.dupont@mail.com', '0123456789';
		EXEC dbo.makeAbonnement '2014-03-29', 5, 'false', '1vehicule', 'Dupont', 'Sophie', '1990-09-10';
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Sophie', '123456009', 'Francais', '0000000006', 'B', '2010-03-14', NULL, '2025-03-14', 'true', 12;
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Jean', '123456010', 'Francais', '0000000007', 'B', '2014-03-17', 3, '2029-03-17', 'true', 4;
		SET @id_abo = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Dupont' AND a.prenom_compteabonne = 'Sophie' AND a.date_naissance_compteabonne = '1990-09-10');
		EXEC dbo.makeReservation @id_abo,@date_deb1,@date_fin1, 'Peugeot', '406', 'Diesel', 5;
		EXEC @id_reservation = dbo.makeReservation @id_abo,@date_deb2,@date_fin2, 'Peugeot', '406', 'Diesel', 5;
		EXEC dbo.turnReservationIntoContratLocat @id_reservation, 100;

		PRINT('');
		PRINT('Liste des compteAbonne-Abonnement avant modification');
		SELECT cpta.nom, cpta.prenom, abo.nom_typeabonnement AS type_abonnement, abo.date_debut, abo.duree 
			FROM CompteAbonne cpta
				JOIN Abonnement abo 
					ON cpta.nom=abo.nom_compteabonne 
					AND cpta.prenom=abo.prenom_compteabonne 
					AND cpta.date_naissance=abo.date_naissance_compteabonne;
					
		PRINT('Liste des conducteurs avant modification');
		SELECT cpta.nom AS nom_abonne, cpta.prenom AS prenom_abonne, cond.nom AS nom_conducteur, cond.prenom AS prenom_conducteur 
			FROM Conducteur cond
				JOIN CompteAbonneConducteur cac
					ON cond.piece_identite=cac.piece_identite_conducteur
					AND cond.nationalite=cac.nationalite_conducteur
				JOIN CompteAbonne cpta 
					ON cac.nom_compteabonne = cpta.nom
					AND cac.prenom_compteabonne = cpta.prenom
					AND cac.date_naissance_compteabonne = cpta.date_naissance;
		
		PRINT('Liste des reservations avant modification');
		SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.matricule, veh.marque_modele, veh.serie_modele, res.a_supprimer   
			FROM Reservation res
				JOIN ReservationVehicule resVeh
					ON res.id = resVeh.id_reservation
				JOIN Vehicule veh
					ON resVeh.matricule_vehicule=veh.matricule
				JOIN Abonnement abo
					ON res.id_abonnement=abo.id;

		PRINT('Liste des locations avant modification');
		SELECT  abo.nom_compteabonne AS nom, abo.prenom_compteabonne AS prenom, conLoc.date_debut, conLoc.date_fin, loc.matricule_vehicule, veh.marque_modele, veh.serie_modele
			FROM Location loc
				JOIN ContratLocation conLoc
					ON loc.id_contratLocation = conLoc.id
				JOIN Abonnement abo
					ON conLoc.id_abonnement = abo.id
				JOIN Vehicule veh
					ON veh.matricule = loc.matricule_vehicule;
		
		EXEC dbo.modifyCompte 'Dupont', 'Sophie', '1990-09-10', 'Martel', NULL, NULL, NULL, NULL, NULL, NULL, NULL;
		EXEC dbo.modifyConducteur 'Martel', NULL, '123456009', 'Francais', NULL, NULL, NULL, NULL, NULL, NULL;
		
		PRINT('');
		PRINT('Liste des compteAbonne-Abonnement après modification');
		SELECT cpta.nom, cpta.prenom, abo.nom_typeabonnement AS type_abonnement, abo.date_debut, abo.duree 
			FROM CompteAbonne cpta
				JOIN Abonnement abo 
					ON cpta.nom=abo.nom_compteabonne 
					AND cpta.prenom=abo.prenom_compteabonne 
					AND cpta.date_naissance=abo.date_naissance_compteabonne;
					
		PRINT('Liste des conducteurs après ajout');
		SELECT cpta.nom AS nom_abonne, cpta.prenom AS prenom_abonne, cond.nom AS nom_conducteur, cond.prenom AS prenom_conducteur 
			FROM Conducteur cond
				JOIN CompteAbonneConducteur cac
					ON cond.piece_identite=cac.piece_identite_conducteur
					AND cond.nationalite=cac.nationalite_conducteur
				JOIN CompteAbonne cpta 
					ON cac.nom_compteabonne = cpta.nom
					AND cac.prenom_compteabonne = cpta.prenom
					AND cac.date_naissance_compteabonne = cpta.date_naissance;
		
		PRINT('Liste des reservations après modification');
		SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.matricule, veh.marque_modele, veh.serie_modele, res.a_supprimer   
			FROM Reservation res
				JOIN ReservationVehicule resVeh
					ON res.id = resVeh.id_reservation
				JOIN Vehicule veh
					ON resVeh.matricule_vehicule=veh.matricule
				JOIN Abonnement abo
					ON res.id_abonnement=abo.id;

		PRINT('Liste des locations après modification');
		SELECT  abo.nom_compteabonne AS nom, abo.prenom_compteabonne AS prenom, conLoc.date_debut, conLoc.date_fin, loc.matricule_vehicule, veh.marque_modele, veh.serie_modele
			FROM Location loc
				JOIN ContratLocation conLoc
					ON loc.id_contratLocation = conLoc.id
				JOIN Abonnement abo
					ON conLoc.id_abonnement = abo.id
				JOIN Vehicule veh
					ON veh.matricule = loc.matricule_vehicule;

	END
GO

-----------------testFinDeLocation--------------------

IF OBJECT_ID ('dbo.testFinDeLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testFinDeLocation
GO

------------------------------------------------------------
-- Procédure de démonstration des macros:
--		endEtat
--		endContratLocation
--
-- Scénario :
-- L'abonne rend le vehicule dans un etat moyen et reçoit 
-- sa facture.
------------------------------------------------------------
CREATE PROCEDURE dbo.testFinDeLocation
AS
	BEGIN
		SET NOCOUNT ON
		
-- Remplissage des tables avec le minimum d'information nécéssaire
		
		EXEC dbo.videTables;
		PRINT('');
		PRINT('Remplissage des informations minimum nécéssaire au test');
		PRINT('');
		DECLARE @id_abo int,
				@id_reservation int,
				@id_contratLoc int,
				@date_deb1 date = '2014-05-20',
				@date_deb2 date = '2014-03-29',
				@date_fin1 date = '2014-05-22',
				@date_fin2 date = '2014-04-03';
				
		EXEC dbo.createTypeAbonnement '1vehicule', '5', 1, 100;
		EXEC dbo.makeCatalogue 'printemps 2014', '2014-03-20', '2014-06-20';
		EXEC dbo.makeCategorie 'printemps 2014', 'voiture', 'Voitures de toutes tailles', 'B';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '406', 'Diesel', 5, 2004, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ab', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		EXEC dbo.makeCompteParticulier 'Dupont', 'Sophie', '1990-09-10', 'LU2800194006447500001234567', 'sophie.dupont@mail.com', '0123456789';
		EXEC dbo.makeAbonnement '2014-03-29', 5, 'false', '1vehicule', 'Dupont', 'Sophie', '1990-09-10';
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Sophie', '123456009', 'Francais', '0000000006', 'B', '2010-03-14', NULL, '2025-03-14', 'true', 12;
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Jean', '123456010', 'Francais', '0000000007', 'B', '2014-03-17', 3, '2029-03-17', 'true', 4;
		SET @id_abo = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Dupont' AND a.prenom_compteabonne = 'Sophie' AND a.date_naissance_compteabonne = '1990-09-10');
		EXEC dbo.makeReservation @id_abo,@date_deb1,@date_fin1, 'Peugeot', '406', 'Diesel', 5;
		EXEC @id_reservation = dbo.makeReservation @id_abo,@date_deb2,@date_fin2, 'Peugeot', '406', 'Diesel', 5;
		EXEC @id_contratLoc = dbo.turnReservationIntoContratLocat @id_reservation, 100;
		EXEC dbo.makeEtat @id_contratLoc, '0123456ab', NULL, NULL, 'Parfait';
		
		PRINT('');
		PRINT('Etat lié au début de la location');
		SELECT * FROM Etat;
		EXEC dbo.endEtat @id_contratLoc, '0123456ab', @date_fin2, 1200, 'Moyen', 'true', NULL;
		PRINT('');
		PRINT('Etat à la fin de la location');
		SELECT * FROM Etat;
		
		PRINT('Finalise la location');
		EXEC dbo.endContratLocation @id_contratLoc, @date_fin2;

	END
GO

-----------------testInfraction--------------------

IF OBJECT_ID ('dbo.testInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testInfraction
GO

------------------------------------------------------------
-- Procédure de démonstration des macros:
--		makeInfraction
--		showInfraction
--		fixInfraction
--
-- Scénario :
-- L'abonne a commit une infraction et la paie, des points 
-- de permis lui sont retirés.
------------------------------------------------------------
CREATE PROCEDURE dbo.testInfraction
AS
	BEGIN
		SET NOCOUNT ON
		
-- Remplissage des tables avec le minimum d'information nécéssaire
		
		EXEC dbo.videTables;
		PRINT('');
		PRINT('Remplissage des informations minimum nécéssaire au test');
		PRINT('');
		DECLARE @id_abo int,
				@id_reservation int,
				@id_contratLoc int,
				@date_deb1 date = '2014-05-20',
				@date_fin1 date = '2014-05-22',
				@date_infrac date = '2014-05-21';
				
		EXEC dbo.createTypeAbonnement '1vehicule', '5', 1, 100;
		EXEC dbo.makeCatalogue 'printemps 2014', '2014-03-20', '2014-06-20';
		EXEC dbo.makeCategorie 'printemps 2014', 'voiture', 'Voitures de toutes tailles', 'B';
		EXEC dbo.makeModele 'printemps 2014', 'voiture', 'Peugeot', '406', 'Diesel', 5, 2004, 45, 0;
		EXEC dbo.makeVehicule 'Peugeot', '406', 'Diesel', 5, '0123456ab', 1000, 'Bleu', 'VF3 8C4HXF 81100000', 'voiture';
		EXEC dbo.makeCompteParticulier 'Dupont', 'Sophie', '1990-09-10', 'LU2800194006447500001234567', 'sophie.dupont@mail.com', '0123456789';
		EXEC dbo.makeAbonnement '2014-03-29', 5, 'false', '1vehicule', 'Dupont', 'Sophie', '1990-09-10';
		EXEC dbo.declareConducteur 'Dupont', 'Sophie', '1990-09-10', 'Dupont', 'Sophie', '123456009', 'Francais', '0000000006', 'B', '2010-03-14', NULL, '2025-03-14', 'true', 12;
		SET @id_abo = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Dupont' AND a.prenom_compteabonne = 'Sophie' AND a.date_naissance_compteabonne = '1990-09-10');
		EXEC @id_reservation = dbo.makeReservation @id_abo,@date_deb1,@date_fin1, 'Peugeot', '406', 'Diesel', 5;
		EXEC @id_contratLoc = dbo.turnReservationIntoContratLocat @id_reservation, 100;
		EXEC dbo.addConducteurToLocation @id_contratLoc, '123456009', 'Francais';
		
		PRINT('');
		PRINT('Création d''une infraction');
		EXEC dbo.makeInfraction '0123456ab', @date_infrac, 'Exces de vitesse' , 45 , 'exces de vitesse en ville';
		PRINT('');
		EXEC dbo.showInfraction '0123456ab', @date_infrac;
		
		SELECT cond.nom, cond.prenom, per.numero, per.points_estimes 
			FROM Conducteur cond, Permis per
			WHERE cond.id_permis = per.numero;
		PRINT('');
		PRINT('Réglement de l''infraction');
		EXEC dbo.fixInfraction '0123456ab', 'Dupont', 'Sophie', 45, 2, @date_infrac;
		PRINT('');
		EXEC dbo.showInfraction '0123456ab', @date_infrac;
		
		SELECT cond.nom, cond.prenom, per.numero, per.points_estimes 
			FROM Conducteur cond, Permis per
			WHERE cond.id_permis = per.numero;
		
	END
GO


------------------------------------------------------------
-- Date        : 28/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Commentaire : Test de la procédure "fixVehicule"

--               Le status du vehicule (matricule = 0775896wi) change : "Disponible" -> "En panne"

--               '0775896wi' est reserve pour les periodes suivantes :

--               - Reservation1  : 2014-04-06 -> 2014-04-10 
--               (d'autres vehicules disponibles pour ces dates : 2775896wi)

--               - Reservation2 : 2014-07-11 -> 2014-09-22 
--               (d'autres vehicules disponibles pour ces dates : 0775896wt ou 2775896wi)

--               la base doit etre peuplee avant le test
------------------------------------------------------------

IF OBJECT_ID ('dbo.testFixVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.testFixVehicule
GO


CREATE PROCEDURE dbo.testFixVehicule
AS
	BEGIN
	
		DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50),
				@marque_modele nvarchar(50), @serie_modele nvarchar(50),
				@portieres_modele tinyint, @type_carburant_modele nvarchar(50),
				@IdReservation1 int, @IdReservation2 int, @nbReservations int, 
				@Matricule_Reservation1_apres nvarchar(50), @Matricule_Reservation2_apres nvarchar(50),
				@Reservation1_date_debut datetime, @Reservation1_date_fin datetime,
				@Reservation2_date_debut datetime, @Reservation2_date_fin datetime,
				@matricule_boucle nvarchar(50), @isDispo int;
	
		PRINT('* Le status du vehicule (matricule = 0775896wi) va changer : "Disponible" -> "En panne"'+char(13));
		
		PRINT('Avant l''operation : ');
		PRINT('------------------- '+char(13));
		
		SELECT @Status_avant = statut, @marque_modele = marque_modele, @serie_modele = serie_modele, 
			   @portieres_modele = portieres_modele, @type_carburant_modele = type_carburant_modele
		FROM Vehicule 
		WHERE matricule = '0775896wi';
		
		PRINT('Le vehicule (matricule = 0775896wi) : ' + 
				@marque_modele + ', ' + @serie_modele + ', ' + 
				CONVERT(varchar(10), @portieres_modele) + ' portes, ' + 
				@type_carburant_modele + ', (status : ' +
				@Status_avant + ')');
				
		SELECT @nbReservations = COUNT(*)
		FROM ReservationVehicule
		WHERE matricule_vehicule = '0775896wi';
				
		PRINT('Reservations pour ce vehicule : ' +
				CONVERT(varchar(10), @nbReservations) + ' reservation(s)');
		
		-- Reservation 1
		
		SET @Reservation1_date_debut = '2014-04-06T13:00:00';
		SET @Reservation1_date_fin = '2014-04-10T18:00:00';
		
		SELECT @IdReservation1 = r.id 
		FROM Reservation r
		INNER JOIN ReservationVehicule rv ON r.id = rv.id_reservation
		WHERE rv.matricule_vehicule = '0775896wi' AND 
			  r.date_debut = @Reservation1_date_debut AND r.date_fin = @Reservation1_date_fin;
			  
		PRINT(' - R1 : (id = ' + CONVERT(varchar(10), @IdReservation1) + ')  "2014-04-06" -> "2014-04-10"');

		-- Reservation 2
		
		SET @Reservation2_date_debut = '2014-07-11T09:00:00';
		SET @Reservation2_date_fin = '2014-09-22T17:00:00';
		
		SELECT @IdReservation2 = r.id 
		FROM Reservation r
		INNER JOIN ReservationVehicule rv ON r.id = rv.id_reservation
		WHERE rv.matricule_vehicule = '0775896wi' AND 
			  r.date_debut = @Reservation2_date_debut AND r.date_fin = @Reservation2_date_fin;
		
		PRINT(' - R2 : (id = ' + CONVERT(varchar(10), @IdReservation2) + ') "2014-07-11" -> "2014-09-22"'+char(13));

		-- Les vehicules du meme modele (avant)

		PRINT('Les vehicules du meme modele : '+char(13));
		DECLARE curseur_matricule CURSOR FOR
					SELECT matricule 
					FROM Vehicule 
					WHERE marque_modele = @marque_modele AND
						  serie_modele = @serie_modele AND 
						  type_carburant_modele = @type_carburant_modele AND 
						  portieres_modele = @portieres_modele AND 
						  matricule <> '0775896wi';
										   
		OPEN curseur_matricule
		FETCH NEXT FROM curseur_matricule INTO @matricule_boucle
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
			PRINT(' ** Le vehicule (matricule = ' + @matricule_boucle + ') : ');
		
			SET NOCOUNT ON
			EXEC @isDispo = dbo.isDisponible1 @matricule_boucle, @Reservation1_date_debut, @Reservation1_date_fin

			IF( @isDispo = 1)
				PRINT('  --> Disponible pour R1 : "2014-04-06" -> "2014-04-10"');
			ELSE
				PRINT('  --> Pas disponible pour R1 : "2014-04-06" -> "2014-04-10"');
				
			SET NOCOUNT ON
			EXEC @isDispo = dbo.isDisponible1 @matricule_boucle, @Reservation2_date_debut, @Reservation2_date_fin

			IF( @isDispo = 1)
				PRINT('  --> Disponible pour R2 : "2014-07-11" -> "2014-09-22"');
			ELSE
				PRINT('  --> Pas disponible pour R2 : "2014-07-11" -> "2014-09-22"');
				
			PRINT('');
			
			FETCH NEXT FROM curseur_matricule INTO @matricule_boucle
		END
		CLOSE curseur_matricule
		DEALLOCATE curseur_matricule


		PRINT('EXECUTE fixVehicule : ');
		PRINT('------------------- '+char(13));

		EXEC @ReturnValue = dbo.fixVehicule
				@matricule = '0775896wi',
				@statut_future = 'En panne'

		IF( @ReturnValue = 1)
			PRINT('===> Operation reussi' + char(13));

		PRINT('Apres l''operation : ');
		PRINT('------------------- '+char(13));
		
		SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wi';

		PRINT('Le vehicule (matricule = 0775896wi) : (status avant : ' + @Status_avant + 
				') -> (status apres : ' + @Status_apres + ')' + char(13));

		-- le matricule qui est associe a la reservation 1 apres l'execution de la procedure
		SELECT @Matricule_Reservation1_apres = matricule_vehicule 
		FROM ReservationVehicule 
		WHERE id_reservation = @IdReservation1;
		
		PRINT('Pour R1 ("2014-04-06" -> "2014-04-10") ==> vehicule (matricule = ' + @Matricule_Reservation1_apres + ')' + char(13));
		
		-- le matricule qui est associe a la reservation 2 apres l'execution de la procedure
		SELECT @Matricule_Reservation2_apres = matricule_vehicule 
		FROM ReservationVehicule 
		WHERE id_reservation = @IdReservation2;

		PRINT('Pour R2 ("2014-07-11" -> "2014-09-22") ==> vehicule (matricule = ' + @Matricule_Reservation2_apres + ')' + char(13));

	END
GO	

