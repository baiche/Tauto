------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Retard.sql
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table Retard
------------------------------------------------------------

SET NOCOUNT ON

USE TAuto_IBDR;

EXEC dbo.videTables

INSERT INTO Modele (marque,serie,type_carburant,prix,portieres) VALUES ('Peugeot','406','Diesel',100,5);
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement(nom) VALUES ('10vehicules');
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
	
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
	    
INSERT INTO Location(matricule_vehicule,id_contratLocation) VALUES
		('1885896wx',
		(SELECT id 
		FROM ContratLocation 
		WHERE date_debut='2060-12-02 00:00:00'));

DECLARE @idLoc int = (SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

		
--Test A1

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Retard
		WHERE id_location = @idLoc
			AND DATEDIFF(minute,date,GETDATE()) < 2) = 1
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test A2

BEGIN TRY
	INSERT INTO Retard(date,id_location) VALUES
		('2014-03-06',@idLoc);
    IF(SELECT date FROM Retard
		WHERE id_location = @idLoc) = '2014-03-06'
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test A3

BEGIN TRY
	INSERT INTO Retard(date,id_location) VALUES
		(NULL,@idLoc);
     
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM Retard;

--Test B1

BEGIN TRY
	INSERT INTO Retard(date) VALUES ('2014-03-06');
     
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 
DELETE FROM Retard;

--Test B2

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Retard
		WHERE id_location = @idLoc
			AND DATEDIFF(minute,date,GETDATE()) <2 ) = 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK2')
END CATCH 
DELETE FROM Retard;

--Test B3

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(NULL);
    
	PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 OK')
END CATCH 
DELETE FROM Retard;

--Test C1

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(@idLoc);
    
	IF(SELECT regle FROM Retard
		WHERE id_location = @idLoc) = 'false'
		PRINT('------------------------------Test C.1 OK')
	ELSE
		PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test C2

BEGIN TRY
	INSERT INTO Retard(id_location,regle) VALUES
		(@idLoc,'true');
    
	IF(SELECT regle FROM Retard
		WHERE id_location = @idLoc) = 'true'
		PRINT('------------------------------Test C.2 OK')
	ELSE
		PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test D1

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(@idLoc);
    
	IF(SELECT niveau FROM Retard
		WHERE id_location = @idLoc) = 1
		PRINT('------------------------------Test D.1 OK')
	ELSE
		PRINT('------------------------------Test D.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test D2

BEGIN TRY
	INSERT INTO Retard(id_location,niveau) VALUES
		(@idLoc,2);
    
	IF(SELECT niveau FROM Retard
		WHERE id_location = @idLoc) = 2
		PRINT('------------------------------Test D.2 OK')
	ELSE
		PRINT('------------------------------Test D.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test E1

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(@idLoc),
		(@idLoc);
    
	PRINT('------------------------------Test E.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH 

EXEC dbo.videTables;

SET NOCOUNT OFF