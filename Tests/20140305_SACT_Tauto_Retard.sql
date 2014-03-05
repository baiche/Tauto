------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Conducteur.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table Retard
------------------------------------------------------------

USE Tauto_IBDR;

INSERT INTO Location(matricule_vehicule,id_facturation,date_etat_avant,date_etat_apres,id_contratLocation) VALUES
		(NULL,NULL,NULL,NULL,NULL);

--Test A1

BEGIN TRY
	INSERT INTO Retard(date,id_location,niveau,regle) VALUES
		('2014-03-03',1,DEFAULT,DEFAULT);
     
	PRINT('------------------------------Test A.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 
DELETE FROM Retard;

--Test A2

BEGIN TRY
	INSERT INTO Retard(date,id_location,niveau,regle) VALUES
		(NULL,1,DEFAULT,DEFAULT);
     
	PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH 
DELETE FROM Retard;

--Test A3

BEGIN TRY
	INSERT INTO Retard(date,id_location,niveau,regle) VALUES
		('2014-03-03',NULL,DEFAULT,DEFAULT);
     
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM Retard;

--Test A4

BEGIN TRY
	INSERT INTO Retard(date,id_location,niveau,regle) VALUES
		('2014-03-03',2,DEFAULT,DEFAULT);
     
	PRINT('------------------------------Test A.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 
DELETE FROM Retard;


DELETE FROM Location;