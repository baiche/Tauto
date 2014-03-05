------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_SousPermis.sql
-- Date        : 02/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table SousPermis
------------------------------------------------------------

USE Tauto_IBDR;

INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, DEFAULT);

--Test A1

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
     
	PRINT('------------------------------Test A.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 
DELETE FROM SousPermis;

--Test A2

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('Z', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
    
	PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A3

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000002', '2001-01-01', '9999-12-31', DEFAULT);
    
    PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A4

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', 'a', '9999-12-31', DEFAULT);
    
	PRINT('------------------------------Test A.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A5

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', 'a', DEFAULT);
    
    PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A6

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', 'a');
    
    PRINT('------------------------------Test A.6 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.6 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A6

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', -1);
    
    PRINT('------------------------------Test A.6 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.6 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A7

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		(NULL, '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
    
	PRINT('------------------------------Test A.7 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.7 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A8

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', NULL, '2001-01-01', '9999-12-31', DEFAULT);
    
	PRINT('------------------------------Test A.8 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.8 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A9

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', NULL, '9999-12-31', DEFAULT);
    
	PRINT('------------------------------Test A.9 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.9 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A10

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', NULL, DEFAULT);
    
	PRINT('------------------------------Test A.10 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.10 OK')
END CATCH 
DELETE FROM SousPermis;

--Test A11

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', NULL);
    
	PRINT('------------------------------Test A.11 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.11 OK')
END CATCH 
DELETE FROM SousPermis;

--Test B1

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
    
    INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
	
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 
DELETE FROM SousPermis;

--Test B2

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
    
    INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('A1', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
	
	PRINT('------------------------------Test B.2 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 
DELETE FROM SousPermis;

--Test C1

BEGIN TRY
	INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
    	
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 
DELETE FROM SousPermis;

-- Fin des tests
DELETE FROM Permis;