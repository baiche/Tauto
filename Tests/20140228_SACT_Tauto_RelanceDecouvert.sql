------------------------------------------------------------
-- Fichier     : 20140228_SACT_RelanceDecouvert.sql
-- Date        : 02/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
--	Test des contraintes sur RelanceDecouvert
------------------------------------------------------------

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables
--Mise en place du CompteAbonne
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
('de Finance','Boris','1990-09-08','true','false','FR7845163892548761329457816','boris.de.finance@mail.com','0647817920');

--Test A1

BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',1);
	
	IF((SELECT COUNT(*) 
	   FROM RelanceDecouvert
	   WHERE date_naissance_compteabonne='1990-09-08' 
			 AND nom_compteabonne='de Finance'
			 AND prenom_compteabonne='Boris'
			 AND date = '20140302 10:00:00'
			 AND niveau = 1) = 1)
	
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 

DELETE FROM RelanceDecouvert;
--Test A2

BEGIN TRY
	INSERT INTO RelanceDecouvert(nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('de Finance','Boris','1990-09-08',1);
	
	IF((SELECT COUNT(*) 
	   FROM RelanceDecouvert
	   WHERE  DATEDIFF(minute,date,GETDATE()) < 2
			 AND nom_compteabonne='de Finance'
			 AND prenom_compteabonne='Boris'
			 AND date_naissance_compteabonne = '1990-09-08'
			 AND niveau = 1) = 1)
	
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 

DELETE FROM RelanceDecouvert;


--TEST A3
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','Boris','1990-09-08',1);
	PRINT('------------------------------Test A.3 NOT OK')
	END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 

DELETE FROM RelanceDecouvert;
--Test A4
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','de Finance','1990-09-08',1);
	PRINT('------------------------------Test A.4 NOT OK')
	END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 

DELETE FROM RelanceDecouvert;

--Test A5
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08');
	
	IF((SELECT COUNT(*) 
	   FROM RelanceDecouvert
	   WHERE date = '20140302 10:00:00'
			 AND nom_compteabonne='de Finance'
			 AND prenom_compteabonne='Boris'
			 AND date_naissance_compteabonne = '1990-09-08'
			 AND niveau = 0) = 1)
	
		PRINT('------------------------------Test A.5 OK')
	ELSE
		PRINT('------------------------------Test A.5 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 NOT OK')
END CATCH 

DELETE FROM RelanceDecouvert;

--Test A6
BEGIN TRY
	INSERT INTO RelanceDecouvert(nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau,date) VALUES
	('de Finance','Boris','1990-09-08',1,null);
	PRINT('------------------------------Test A.6 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.6 OK')
END CATCH 

DELETE FROM RelanceDecouvert;

--TEST A7
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, prenom_compteabonne,date_naissance_compteabonne, niveau, nom_compteabonne) VALUES
	('20140302 10:00:00','Boris','1990-09-08',1,null);
	PRINT('------------------------------Test A.7 NOT OK')
	END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.7 OK')
END CATCH 

DELETE FROM RelanceDecouvert;

--Test A8
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne,date_naissance_compteabonne, niveau, prenom_compteabonne) VALUES
	('20140302 10:00:00','de Finance','1990-09-08',1,null);
	PRINT('------------------------------Test A.8 NOT OK')
	END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.8 OK')
END CATCH 

DELETE FROM RelanceDecouvert;

--Test A9
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne,niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',null);
	PRINT('------------------------------Test A.9 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.9 OK')
END CATCH 

DELETE FROM RelanceDecouvert;

--Test A10
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne,niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',0);
	IF((SELECT a_supprimer 
	   FROM RelanceDecouvert
	   WHERE date_naissance_compteabonne='1990-09-08' 
			 AND nom_compteabonne='de Finance'
			 AND prenom_compteabonne='Boris'
			 AND date = '20140302 10:00:00'
			 AND niveau = 0) = 0)
	
		PRINT('------------------------------Test A.10 OK')
	ELSE
		PRINT('------------------------------Test A.10 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.10 NOT OK')
END CATCH 

DELETE FROM RelanceDecouvert;


--Test B1
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',1);
	
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',2);
	
	PRINT('------------------------------Test B.1 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH

DELETE FROM RelanceDecouvert;
--Test C1
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',-1);
	
	PRINT('------------------------------Test C.1 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH

DELETE FROM RelanceDecouvert;
--Test C2
BEGIN TRY
	INSERT INTO RelanceDecouvert(date, nom_compteabonne, prenom_compteabonne,date_naissance_compteabonne, niveau) VALUES
	('20140302 10:00:00','de Finance','Boris','1990-09-08',6);
	
	PRINT('------------------------------Test C.2 NOT OK');	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
	
DELETE FROM RelanceDecouvert;
--Suppression du CompteAbonne de test
DELETE FROM CompteAbonne;

SET NOCOUNT OFF

