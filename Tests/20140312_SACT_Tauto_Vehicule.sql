------------------------------------------------------------
-- Fichier     : 20140312_SACT_Tauto_Vehicule.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Vehicule
------------------------------------------------------------
USE TAuto_IBDR;

DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;


--Test A.1

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',18522,'Bleu','Disponible',null,null,null,null,GETDATE(),null,'false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.1 NOT OK')
	ELSE
		PRINT('------------------------------Test A.1  OK')
END TRY
BEGIN CATCH
	PRINT('------------------CATCH--------Test A.1 OK')
END CATCH

DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.2

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH','','Gris','Disponible','445464645ff','Peugeot','207',5,'','Diesel','');
	IF (( SELECT COUNT(*)
		FROM Vehicule v WHERE v.kilometrage=0 AND v.couleur='Gris' AND v.statut='Disponible'  AND a_supprimer='false') = 1)
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.2 NOT OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.3

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH@',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.3 NOT OK')
	ELSE
		PRINT('------------------------------Test A.3 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.3 OK')
END CATCH



DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.4

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'toto','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.4 NOT OK')
	ELSE
		PRINT('------------------------------Test A.4 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.4 OK')
END CATCH



DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.5

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Non Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.5 NOT OK')
	ELSE
		PRINT('------------------------------Test A.5 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.5 OK')
END CATCH




DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.6

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff&','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.6 NOT OK')
	ELSE
		PRINT('------------------------------Test A.6 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.6 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test B.1

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');

	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
BEGIN TRY	
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 2)
		PRINT('------------------------------Test B.1 NOT OK')
	ELSE
		PRINT('------------------------------Test B.1 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test B.1 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test C.1.1

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','208',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;


--Test C.1.2

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugotss','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1.2 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1.2 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1.2 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;

--Test C.1.3

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',3,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1.3 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1.3 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1.3 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;

--Test C.1.4

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Essence','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1.4 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1.4 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1.4 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;


