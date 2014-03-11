------------------------------------------------------------
-- Fichier     : 20140309_SACT_Tauto_Reservation.sql
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Reservation.
------------------------------------------------------------


USE Tauto_IBDR;

-- preparation : un vehicule, un abonnement

DELETE FROM Reservation
DELETE FROM Abonnement
DELETE FROM TypeAbonnement
DELETE FROM Particulier
DELETE FROM CompteAbonne
DELETE FROM Vehicule


INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2013-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

DECLARE @IdAbonnement int;
SET @IdAbonnement = SCOPE_IDENTITY();

--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
    IF
      (SELECT date_creation
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = CONVERT (date, GETDATE())

	   AND

	  (SELECT annule
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = 'false'

		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 


--Test A.2
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, date_fin, id_abonnement)
	VALUES
		('2013-03-10', '20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
    IF
      (SELECT date_creation
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = '2013-03-10'
	   
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH


--Test A.3
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, date_fin, id_abonnement)
	VALUES
		(NULL, '20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 


--Test A.4
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_fin, id_abonnement)
	VALUES
		('2013-03-10', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 


--Test A.5
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, id_abonnement)
	VALUES
		('2013-03-10', '20130317 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(id, date_debut, date_fin, id_abonnement)
	VALUES
		(11, '20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test B.2
BEGIN TRY
	-- preparation
	DELETE FROM Reservation
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);

	DECLARE @IdPredecesseur int;
	SET @IdPredecesseur = SCOPE_IDENTITY();

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', @IdAbonnement);
	
	-- verification
    IF SCOPE_IDENTITY() = @IdPredecesseur + 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', @IdAbonnement + 1);
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH