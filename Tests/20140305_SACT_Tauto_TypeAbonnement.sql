------------------------------------------------------------
-- Fichier     : 20140305_SACT_Tauto_TypeAbonnement.sql
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table TypeAbonnement.
------------------------------------------------------------

SET NOCOUNT ON

USE Tauto_IBDR;

-- preparation
EXEC dbo.videTables;
GO

--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM TypeAbonnement
	
	-- test
	INSERT INTO TypeAbonnement (nom)
	VALUES ('1vehicule');
    
    -- verification
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
	   
	   AND 
	   
	  (SELECT km
	   FROM TypeAbonnement 
	   WHERE nom='1vehicule') = 1000
	   
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
	DELETE FROM TypeAbonnement
	
	-- test
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km)
	VALUES ('bronze', 8, 20, 500);
    
    -- verification
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
	   
	   AND 
	   
	  (SELECT km 
	   FROM TypeAbonnement 
	   WHERE nom='bronze') = 500
	   
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM TypeAbonnement
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze', 8, 20);

	-- test
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze', 6, 15);

	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test B.2
BEGIN TRY
	-- preparation
	DELETE FROM TypeAbonnement
	
	-- test
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('', 8, 20);
	
	-- verification
	PRINT('------------------------------Test B.2 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH 


--Test B.3
BEGIN TRY
	-- preparation
	DELETE FROM TypeAbonnement
	
	-- test
	INSERT INTO TypeAbonnement (prix, nb_max_vehicules)
	VALUES (8, 20);

	-- verification
	PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM TypeAbonnement
	
	-- test
	INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
	VALUES ('bronze@', 8, 20);
    
    -- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


EXEC dbo.videTables;
GO

SET NOCOUNT OFF