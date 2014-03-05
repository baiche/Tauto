------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Conducteur.sql
-- Date        : 02/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table Conducteur
------------------------------------------------------------

USE Tauto_IBDR;

INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000001', DEFAULT, DEFAULT);
INSERT INTO SousPermis(nom_typepermis, numero_permis, date_obtention, date_expiration, periode_probatoire) VALUES
		('B', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);

--Test A1

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '0000000001');
     
	PRINT('------------------------------Test A.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 
DELETE FROM Conducteur;

--Test A2

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		(NULL, 'Francais', 'Deluze', 'Alexis', '0000000001');
    
	PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A3

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', NULL, 'Deluze', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A4

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', NULL, 'Alexis', '0000000001');
    
	PRINT('------------------------------Test A.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A5

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', NULL, '0000000001');
    
    PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A6

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', NULL);
    
    PRINT('------------------------------Test A.6 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.6 NOT OK')
END CATCH 
DELETE FROM Conducteur;

--Test A7

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '0000000002');
    
    PRINT('------------------------------Test A.7 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.7 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A8

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('', 'Francais', 'Deluze', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test A.8 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.8 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A9

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', '', 'Deluze', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test A.9 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.9 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A10

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', '', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test A.10 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.10 OK')
END CATCH 
DELETE FROM Conducteur;

--Test A11

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '');
    
    PRINT('------------------------------Test A.11 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.11 OK')
END CATCH 
DELETE FROM Conducteur;

--Test B1

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '0000000001');
    
    INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '0000000001');
	
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 
DELETE FROM Conducteur;

--Test B2

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456788', 'Francais', 'Deluze', 'Alexis', '0000000001');
    
    INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '0000000001');
	
	PRINT('------------------------------Test B.2 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 
DELETE FROM Conducteur;

--Test C1

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('', '0000000001', '2001-01-01', '9999-12-31', DEFAULT);
    	
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 
DELETE FROM Conducteur;

-- Fin des tests
DELETE FROM SousPermis;
DELETE FROM Permis;