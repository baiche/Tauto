------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Permis.sql
-- Date        : 02/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table Permis
------------------------------------------------------------

USE Tauto_IBDR;

--Test A1

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		(NULL, DEFAULT, NULL);
     
	PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 OK')
END CATCH 
DELETE FROM Permis;

--Test A2

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, NULL);
    
	PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH 
DELETE FROM Permis;

--Test A3

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		(NULL, DEFAULT, DEFAULT);
    
    PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM Permis;

--Test A4

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, DEFAULT);
    
	PRINT('------------------------------Test A.4 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK')
END CATCH 
DELETE FROM Permis;

--Test A5

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('_', DEFAULT, DEFAULT);
    
    PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 
DELETE FROM Permis;

--Test B1

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, DEFAULT);
    
    INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, DEFAULT);
	
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 
DELETE FROM Permis;

--Test B2

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, DEFAULT);
    
    INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000002', DEFAULT, DEFAULT);
	
	PRINT('------------------------------Test B.2 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 
DELETE FROM Permis;

--Test C1

BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('', DEFAULT, DEFAULT);
    	
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 
DELETE FROM Permis;