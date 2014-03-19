------------------------------------------------------------
-- Fichier     : 20140306_SACT_Tauto_Incident.sql
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table Incident
------------------------------------------------------------

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation) VALUES
		(NULL,NULL,NULL,NULL,NULL);

		
--Test A1

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(1);
    
	IF(SELECT COUNT(*) FROM Incident
		WHERE id_location = 1
			AND DATEDIFF(minute,date,GETDATE()) < 2 ) = 1
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test A2

BEGIN TRY
	INSERT INTO Incident(date,id_location) VALUES
		('2014-03-06',1);
    IF(SELECT date FROM Incident
		WHERE id_location = 1) = '2014-03-06'
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test A3

BEGIN TRY
	INSERT INTO Incident(date,id_location) VALUES
		(NULL,1);
     
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM Incident;

--Test B1

BEGIN TRY
	INSERT INTO Incident(date) VALUES ('2014-03-06');
     
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 
DELETE FROM Incident;

--Test B2

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(1);
    
	IF(SELECT COUNT(*) FROM Incident
		WHERE id_location = 1
			AND DATEDIFF(minute,date,GETDATE()) < 2 ) = 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test B3

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(NULL);
    
	PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 OK')
END CATCH 
DELETE FROM Incident;

--Test C1

BEGIN TRY
	INSERT INTO Incident(id_location,description) VALUES
		(1,'description valide');
    
	IF(SELECT description FROM Incident
		WHERE id_location = 1) = 'description valide'
		PRINT('------------------------------Test C.1 OK')
	ELSE
		PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test C2

BEGIN TRY
	INSERT INTO Incident(id_location,description) VALUES
		(1,'@description');
    
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 
DELETE FROM Incident;

--Test C3

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(1);
    
	IF(SELECT description FROM Incident
		WHERE id_location = 1) = ''
		PRINT('------------------------------Test C.3 OK')
	ELSE
		PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test C4

BEGIN TRY
	INSERT INTO Incident(id_location,description) VALUES
		(1,NULL);

		PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 
DELETE FROM Incident;

--Test D1

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(1);
    
	IF(SELECT penalisable FROM Incident
		WHERE id_location = 1) = 'false'
		PRINT('------------------------------Test D.1 OK')
	ELSE
		PRINT('------------------------------Test D.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test D2

BEGIN TRY
	INSERT INTO Incident(id_location,penalisable) VALUES
		(1,'true');
    
	IF(SELECT penalisable FROM Incident
		WHERE id_location = 1) = 'true'
		PRINT('------------------------------Test D.2 OK')
	ELSE
		PRINT('------------------------------Test D.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 NOT OK')
END CATCH 
DELETE FROM Incident;

--Test D3

BEGIN TRY
	INSERT INTO Incident(id_location,penalisable) VALUES
		(1,NULL);
    
		PRINT('------------------------------Test D.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.3 OK')
END CATCH 
DELETE FROM Incident;

--Test E1

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(1),
		(1);
    
	PRINT('------------------------------Test E.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH 
DELETE FROM Incident;

DELETE FROM Location;

SET NOCOUNT OFF