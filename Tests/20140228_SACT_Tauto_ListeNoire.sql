------------------------------------------------------------
-- Fichier     : 20140228_SACT_ListeNoire.sql
-- Date        : 02/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
--	Test des contraintes sur liste noire
------------------------------------------------------------

USE Tauto_IBDR;

--Test A1

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom) VALUES
	('de Finance','Boris');
     
	PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test A2

BEGIN TRY
	INSERT INTO ListeNoire(date_naissance,prenom) VALUES
	('1990-09-08','Boris');
    
	PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test A3

BEGIN TRY
	INSERT INTO ListeNoire(date_naissance,nom) VALUES
	('1990-09-08','de Finance');
    
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test A4

BEGIN TRY
	INSERT INTO ListeNoire(date_naissance,nom,prenom) VALUES
	('1990-09-08','de Finance','Boris');
    
    IF((SELECT COUNT(*) 
	   FROM ListeNoire
	   WHERE date_naissance='1990-09-08' 
			 AND nom='de Finance'
			 AND prenom='Boris') = 1)
	
		PRINT('------------------------------Test A.3 OK')
	ELSE
		PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 NOT OK')
END CATCH 

DELETE FROM ListeNoire;

--Test A5

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris',null);
     
	PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test A6

BEGIN TRY
	INSERT INTO ListeNoire(date_naissance,prenom,nom) VALUES
	('1990-09-08','Boris',null);
    
	PRINT('------------------------------Test A.6 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.6 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test A7

BEGIN TRY
	INSERT INTO ListeNoire(date_naissance,nom,prenom) VALUES
	('1990-09-08','de Finance',null);
    
	PRINT('------------------------------Test A.7 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.7 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test B1

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris', '1990-09-08');
    
    INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris', '1990-09-08');
	
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 

DELETE FROM ListeNoire;
--Test B2

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris', '1990-09-08');
    
    INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris', '1991-07-03');
    
    IF((SELECT COUNT(*) 
	   FROM ListeNoire
	   WHERE prenom='Boris') = 2)
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 

DELETE FROM ListeNoire;
--Test B3

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris', '1990-09-08');
    
    INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Jean', '1990-09-08');
    
    IF((SELECT COUNT(*) 
	   FROM ListeNoire
	   WHERE nom='de Finance') = 2)
		PRINT('------------------------------Test B.3 OK')
	ELSE
		PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 NOT OK')
END CATCH 

DELETE FROM ListeNoire;
--Test B4

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','Boris', '1990-09-08');
    
    INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Clairbois','Boris', '1990-09-08');
    
    IF((SELECT COUNT(*) 
	   FROM ListeNoire
	   WHERE prenom='Boris') = 2)
		PRINT('------------------------------Test B.4 OK')
	ELSE
		PRINT('------------------------------Test B.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.4 NOT OK')
END CATCH 

DELETE FROM ListeNoire;

--Test C1

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('de Finance','B', '1990-09-08');
    	
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 

DELETE FROM ListeNoire;

--Test C2

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('F','Boris', '1990-09-08');
    	
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 

DELETE FROM ListeNoire;