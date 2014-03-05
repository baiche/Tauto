------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_TypeAbonnement.sql
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table TypeAbonnement.
------------------------------------------------------------


USE Tauto_IBDR;


--Test A.1
BEGIN TRY
	INSERT INTO TypeAbonnement (nom)
	VALUES ('1vehicule');
     
    IF
	  (SELECT prix
	   FROM TypeAbonnement 
	   WHERE nom='1vehicule') = 0
	   
	   AND 
	   
	  (SELECT nb_max_vehicules
	   FROM TypeAbonnement 
	   WHERE nom='1vehicule') = 1

	   AND 
	   
	  (SELECT a_supprimer 
	   FROM TypeAbonnement 
	   WHERE nom='1vehicule') = 'false'
	   
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 

DELETE FROM TypeAbonnement WHERE nom='1vehicule';


--Test A.2
BEGIN TRY
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze', 8, 20);
     
    IF
	  (SELECT prix
	   FROM TypeAbonnement 
	   WHERE nom='bronze') = 8
	   
	   AND 
	   
	  (SELECT nb_max_vehicules
	   FROM TypeAbonnement 
	   WHERE nom='bronze') = 20

	   AND 
	   
	  (SELECT a_supprimer 
	   FROM TypeAbonnement 
	   WHERE nom='bronze') = 'false'
	   
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 

DELETE FROM TypeAbonnement WHERE nom='bronze';


--Test B.1
BEGIN TRY
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze', 8, 20);

	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze', 6, 15);

	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 

DELETE FROM TypeAbonnement WHERE nom='bronze';


--Test B.2
BEGIN TRY
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('', 8, 20);
	
	PRINT('------------------------------Test B.2 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH 


--Test B.3
BEGIN TRY
	INSERT INTO TypeAbonnement (prix, nb_max_vehicules)
	VALUES (8, 20);

	PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 OK')
END CATCH 


--Test C.1
BEGIN TRY
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze@', 8, 20);
     
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 
