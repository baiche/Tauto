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

USE TAuto_IBDR;

INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation) VALUES
		(NULL,NULL,NULL,NULL,NULL);

		
--Test A1

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(1);
    
	IF(SELECT COUNT(*) FROM Retard
		WHERE id_location = 1
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
		('2014-03-06',1);
    IF(SELECT date FROM Retard
		WHERE id_location = 1) = '2014-03-06'
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
		(NULL,1);
     
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
		(1);
    
	IF(SELECT COUNT(*) FROM Retard
		WHERE id_location = 1
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
		(1);
    
	IF(SELECT regle FROM Retard
		WHERE id_location = 1) = 'false'
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
		(1,'true');
    
	IF(SELECT regle FROM Retard
		WHERE id_location = 1) = 'true'
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
		(1);
    
	IF(SELECT niveau FROM Retard
		WHERE id_location = 1) = 1
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
		(1,2);
    
	IF(SELECT niveau FROM Retard
		WHERE id_location = 1) = 2
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
		(1),
		(1);
    
	PRINT('------------------------------Test E.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH 
DELETE FROM Retard;

DELETE FROM Location;