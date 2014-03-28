------------------------------------------------------------
-- Fichier     : 8_tests_contraintes.sql
-- Date        : 28/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : execution des tests de contraintes
------------------------------------------------------------
SET NOCOUNT ON
GO

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes ListeNoire')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables 
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
	('de Finance','', '1990-09-08');
    	
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 

DELETE FROM ListeNoire;

--Test C2

BEGIN TRY
	INSERT INTO ListeNoire(nom,prenom,date_naissance) VALUES
	('','Boris', '1990-09-08');
    	
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 

DELETE FROM ListeNoire;

SET NOCOUNT ON

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes RelanceDecouvert')
PRINT('--------------------------------------------------')

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

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Catalogue.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Catalogue
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Catalogue')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

DELETE FROM Catalogue;

--Test A.1
BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
	('Catalogue1', '2015-10-12', '2016-11-12', 'false'),
	('Catalogue1', '2015-01-12', '2016-09-12','true')
	PRINT('------------------------------Test A.1 NOT OK')	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 OK')
END CATCH
DELETE FROM Catalogue

--Test A.2
BEGIN TRY
	INSERT INTO Catalogue(date_debut, date_fin, a_supprimer) VALUES
	('2015-01-12', '2016-09-12','false');
	PRINT('------------------------------Test A.2 NOT OK')	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM Catalogue

--Test A.3
BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
	('Catalogue1', '2015-10-12', '2016-11-12', 'false')
	PRINT('------------------------------Test A.3 OK')	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 NOT OK')
END CATCH
DELETE FROM Catalogue

--Test A.4
BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
	('@TA', '2015-01-12', '2016-09-12','false');
	PRINT('------------------------------Test A.4 NOT OK.1')	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK.1')
END CATCH
DELETE FROM Catalogue

BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
    ('TA_Auto', '2015-01-12', '2016-09-12','false');
	PRINT('------------------------------Test A.4 NOT OK.2')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK.2')
END CATCH
DELETE FROM Catalogue

BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
    ('_', '2015-01-12', '2016-09-12','false');
	PRINT('------------------------------Test A.4 NOT OK.3')	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK.3')
END CATCH
DELETE FROM Catalogue

BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
    (' ', '2015-01-12', '2016-09-12','false');
	PRINT('------------------------------Test A.4 NOT OK.4')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK.4')
END CATCH

DELETE FROM Catalogue




--Test B.1
BEGIN TRY
	INSERT INTO Catalogue(nom, date_fin, a_supprimer ) VALUES
	('Catalogue1','2014-06-12', 'false');
	IF (( SELECT COUNT(*)
		FROM Catalogue
		WHERE date_debut = CONVERT(date, GETDATE())) = 1)
		PRINT('------------------------------Test B.1 OK')
	ELSE
		PRINT('------------------------------Test B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 NOT OK')
END CATCH
DELETE FROM Catalogue;

--Test B.2
BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
	('Catalogue1', '2015-03-06', '2016-11-12','false');
	IF (( SELECT COUNT(*)
		FROM Catalogue
		WHERE date_debut = '2015-03-06') = 1)
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH
DELETE FROM Catalogue;


--Test C.1
BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, a_supprimer) VALUES
	('Catalogue1', '2014-01-01','false');
	IF (( SELECT COUNT(*)
		FROM Catalogue
		WHERE date_debut = '2014-01-01'
			  AND date_fin IS NULL) = 1)
		PRINT('------------------------------Test C.1 OK')
	ELSE
		PRINT('------------------------------Test C.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK')
END CATCH
DELETE FROM Catalogue;

--Test C.2
BEGIN TRY
	INSERT INTO Catalogue(nom, date_debut, date_fin, a_supprimer) VALUES
	('Catalogue1', '2014-03-01', '1980-01-01', 'false');
	IF (( SELECT date_fin
		FROM Catalogue
		WHERE date_debut = '2014-03-01') = '1980-01-01')
		PRINT('------------------------------Test C.2 OK')
	ELSE
		PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM Catalogue;

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CatalogueCategorie.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table CatalogueCategorie
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes CatalogueCategorie')
PRINT('--------------------------------------------------')

USE Tauto_IBDR;

DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps 2014', 'Vehicule simple');
	IF (( SELECT COUNT(*)
		FROM CatalogueCategorie) = 1)
		PRINT('------------------------------Test A.1 et B.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 et B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 et B.1 NOT OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test A.2
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps', 'Vehicule simple');
	PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;


--Test B.2
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps 2014', 'simple');
	PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CatalogueCategorie.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table CatalogueCategorie
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes CatalogueCategorie')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE TAuto_IBDR;

DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de vehicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps 2014', 'Vehicule simple');
	IF (( SELECT COUNT(*)
		FROM CatalogueCategorie) = 1)
		PRINT('------------------------------Test A.1 et B.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 et B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 et B.1 NOT OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test A.2
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps', 'Vehicule simple');
	PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;


--Test B.2
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps 2014', 'simple');
	PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CompteAbonne.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table CompteAbonne.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes CompteAbonne')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

--Test A.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
    IF(SELECT actif 
	   FROM CompteAbonne 
	   WHERE nom='Lastname' 
			 AND prenom='Firstname' 
		     AND date_naissance='1992-05-7') = 'true'
	
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test A.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7','false','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040302');
    
    IF(SELECT actif 
	   FROM CompteAbonne 
	   WHERE nom='Lastname' 
			 AND prenom='Firstname' 
		     AND date_naissance='1992-05-7') = 'false'
	
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname2' AND prenom='Firstname2' AND date_naissance='1992-05-7';



--Test A.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7', NULL,'false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3  OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test B.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7','false','AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040302');
    
    IF(SELECT liste_grise 
	   FROM CompteAbonne 
	   WHERE nom='Lastname' 
			 AND prenom='Firstname' 
		     AND date_naissance='1992-05-7') = 'false'
	
		PRINT('------------------------------Test B.1 OK')
	ELSE
		PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test B.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('LastnameTest', 'FirstnameTest', '1992-05-7','false','true','AB0020012800000012005276005', 
     'firstnametest.lastnametest@gmail.fr', '0605040302');
    
    IF(SELECT liste_grise 
	   FROM CompteAbonne 
	   WHERE nom='LastnameTest' 
			 AND prenom='FirstnameTest' 
		     AND date_naissance='1992-05-7') = 'true'
	
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='LastnameTest' AND prenom='FirstnameTest' AND date_naissance='1992-05-7';



---Test B.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7', 'true',NULL, 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3  OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test C.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test C.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('@Dupont', 'Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.2 NOT OK.1')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK.1')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='@Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Pseud*_Du_75', 'Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.2 NOT OK.2')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK.2')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Pseud*_Du_75' AND prenom='Jean' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('_', 'Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.2 NOT OK.3')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK.3')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='_' AND prenom='Jean' AND date_naissance='1992-05-7';


BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    (' ', 'Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.2 NOT OK.4')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK.4')
END CATCH 

DELETE FROM CompteAbonne WHERE nom=' ' AND prenom='Jean' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('UnNom93', 'Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.2 NOT OK.5')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK.5')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='UnNom93' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test C.3
BEGIN TRY

	INSERT INTO CompteAbonne(prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Jean', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE prenom='Jean' AND date_naissance='1992-05-7';



BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    (NULL, 'Firstname', '1992-05-7', 'true','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test D.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Andre', '1992-05-8','false','true','AB0020012800000012005276005', 
     'andre.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='André' AND date_naissance='1992-05-7';



--Test D.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', '@André', '1992-05-7','false','true','AB0020012800000012005276005', 
     'andré.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.2 NOT OK.1')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK.1')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='@Jean' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Pseud*_Du_75', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.2 NOT OK.2')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK.2')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Pseud*_Du_75' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', '_', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.2 NOT OK.3')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK.3')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='_' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', ' ', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.2 NOT OK.4')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK.4')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom=' ' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'UnPrenom92', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.2 NOT OK.5')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK.5')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='UnPrenom92' AND date_naissance='1992-05-7';



--Test D.3
BEGIN TRY

	INSERT INTO CompteAbonne(nom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', '1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test D.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.3 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND date_naissance='1992-05-7';



--Test D.4
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', NULL, '1992-05-7', 'true','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test D.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.4 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test E.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');

	PRINT('------------------------------Test E.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test E.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB002001280000001200527', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test E.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test E.3
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB00200128000000120052760057896', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test E.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E. OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';


--Test E.4
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB002001280000001200527600@', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test E.4 NOT OK.1')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.4 OK.1')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';


BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB00200128000000120052VWXYZ', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test E.4 NOT OK.2')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.4 OK.2')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';


BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB 0200 2800 0001 0052 WXYZ', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test E.4 NOT OK.3')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.4 OK.3')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test E.5
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test E.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.5 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test E.6
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7', 'true','false', NULL, 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test E.6 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.6 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test F.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.com', '0605040302');
    
	PRINT('------------------------------Test F.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test F.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont', '0605040302');
    
	PRINT('------------------------------Test F.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.2 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test F.3
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', '0605040302');
    
	IF(SELECT courriel 
	   FROM CompteAbonne
	   WHERE nom='Dupont'
	     AND prenom='Jean'
		 AND date_naissance='1992-05-07') = ''
		 
		 PRINT('------------------------------Test F.3 OK')
	ELSE
		PRINT('------------------------------Test F.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.3 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test F.4
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', '1992-05-7', 'true','false', 'AB0020012800000012005276005', 
     NULL, '0605040301');
     
	PRINT('------------------------------Test F.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.4 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test G.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test G.1 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.1 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test G.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
     
	PRINT('------------------------------Test G.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.2 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';






--Test G.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', 'Firstname', NULL, 'true','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test G.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.4 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test H.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302 ');

	PRINT('------------------------------Test H.1 OK.1')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.1 NOT OK.1')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0141119931  ');

	PRINT('------------------------------Test H.1 OK.2')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.1 NOT OK.2')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0906050401');

	PRINT('------------------------------Test H.1 OK.3')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.1 NOT OK.3')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test H.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '06054NOT0X  ');

	PRINT('------------------------------Test H.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.2 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test H.3
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr');

	IF(SELECT telephone 
	   FROM CompteAbonne
	   WHERE nom='Dupont'
	     AND prenom='Jean'
		 AND date_naissance='1992-05-07') = ''
		 
		 PRINT('------------------------------Test H.3 OK')
	ELSE
		PRINT('------------------------------Test H.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.3 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test H.4
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605');

	PRINT('------------------------------Test H.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.4 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';

--Test H.5
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '060504030201');

	PRINT('------------------------------Test H.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.5 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--TestH.6
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname', NULL, '1992-05-7', 'true','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
	PRINT('------------------------------Test H.6 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test H.6 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Lastname' AND prenom='Firstname' AND date_naissance='1992-05-7';



--Test I.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302'),
	('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005271004', 
     'jean.dupont@gmail.fr', '0606050403');

	PRINT('------------------------------Test I.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test I.1 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test I.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302'),
	('Mankoy', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302')

	PRINT('------------------------------Test I.2  OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test I.2 NOT OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';

SET NOCOUNT ON


------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CompteAbonneConducteur.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table CompteAbonneConducteur
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes CompteAbonneConducteur')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;


DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test A.1, B.1, C.1, D.1, E.1
BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
		('0000000002', 'true', 12);
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
		
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
			'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'Francais', '987654321');
	
	IF (( SELECT COUNT(*)
		FROM CompteAbonneConducteur
		WHERE nom_compteabonne = 'TASociety'
			AND prenom_compteabonne = 'TASociety'
			AND date_naissance_compteabonne = '2014-02-24'
			AND nationalite_conducteur = 'Francais'
			AND piece_identite_conducteur = '987654321'
			) = 1)
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT -- OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test A.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASoety', 'TASociety', '2014-02-24', 'Francais', '987654321');
		
	PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test B.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TSoety', '2014-02-24', 'Francais', '987654321');
		
	PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test C.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-12-24', 'Francais', '987654321');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test D.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'Britannique', '987654321');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test E.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'LU2800194006447545001234567', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('84393043114586', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'Francais', '123456789');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

SET NOCOUNT ON

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Conducteur')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

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

--Test B3

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '0000000001');
    
    INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Anglais', 'Deluze', 'Alexis', '0000000001');
	
	PRINT('------------------------------Test B.3 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 NOT OK')
END CATCH 
DELETE FROM Conducteur;

--Test C1

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('', 'Francais', 'Deluze', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 
DELETE FROM Conducteur;

--Test C2

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', '', 'Deluze', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 
DELETE FROM Conducteur;

--Test C3

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', '', 'Alexis', '0000000001');
    
    PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH 
DELETE FROM Conducteur;

--Test C4

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', '', '0000000001');
    
    PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 
DELETE FROM Conducteur;

--Test C5

BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('123456789', 'Francais', 'Deluze', 'Alexis', '');
    
    PRINT('------------------------------Test C.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.5 OK')
END CATCH 
DELETE FROM Conducteur;

-- Fin des tests
DELETE FROM SousPermis;
DELETE FROM Permis;

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_ContratLocation.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table ContratLocation
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes ContratLocation')
PRINT('--------------------------------------------------')

USE Tauto_IBDR;

DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

DECLARE @id_Abonnement int;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test A.1 et B.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 et B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 et B.1 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test A.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	INSERT INTO ContratLocation(id,date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('15879','20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,SCOPE_IDENTITY());
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test A.2 NOT OK')
	ELSE
		PRINT('------------------------------Test A.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test A.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	INSERT INTO ContratLocation(id,date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('test ID','20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,SCOPE_IDENTITY());
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test A.3 NOT OK')
	ELSE
		PRINT('------------------------------Test A.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test A.4
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 2)
		PRINT('------------------------------Test A.4 OK')
	ELSE
		PRINT('------------------------------Test A.4 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test B.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,'1545');
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test B.2 NOT OK')
	ELSE
		PRINT('------------------------------Test B.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test C.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('mal forme','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT C.1 OK')
	ELSE
		PRINT('------------------------------Test C.1 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test C.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('12262014 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT C.2 OK')
	ELSE
		PRINT('------------------------------Test C.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test C.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00 ','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT C.3 OK')
	ELSE
		PRINT('------------------------------Test C.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test D.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','mal forme','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT D.1 OK')
	ELSE
		PRINT('------------------------------Test D.1 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test D.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','12262014 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT D.2 OK')
	ELSE
		PRINT('------------------------------Test D.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test D.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20151520 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT D.3 OK')
	ELSE
		PRINT('------------------------------Test D.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test E.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20140326 00:00:00','mal forme',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT E.1 OK')
	ELSE
		PRINT('------------------------------Test E.1 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test E.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20140326 00:00:00','12262014 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT E.2 OK')
	ELSE
		PRINT('------------------------------Test E.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test E.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20140326 00:00:00','20151520 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT E.3 OK')
	ELSE
		PRINT('------------------------------Test E.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;




--Test F.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test F.1 OK')
	ELSE
		PRINT('------------------------------Test F.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.1 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test F.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00','uneExtension',@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test F.2 NOT OK')
	ELSE
		PRINT('------------------------------Test F.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test F.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',-13,@id_Abonnement);


	PRINT('------------------------------Test F.3 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Entreprise.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Entreprise.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Entreprise')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

--Test A.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', 'TAautomobile', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test A.1 OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test A.2
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('732829320000', 'TAautomobile', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test A.2 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test A.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('7328293200007456', 'TAautomobile', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test A.3 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test A.4
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('TAautomobile', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test A.4 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test A.5
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('732829INTERDIT', 'TAautomobile', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test A.5 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test A.6
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	(NULL, 'TAautomobile', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test A.6 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.6 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test B.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074','Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test B.1 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test B.2
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', '@TA', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test B.2 NOT OK.1')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK.1')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', 'TA_Auto', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test B.2 NOT OK.2')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK.2')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', '_', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test B.2 NOT OK.3')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK.3')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', ' ', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test B.2 NOT OK.4')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK.4')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test B.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', NULL, 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test B.3 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test C.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', 'TAautomobile', 'Tauto', 'Tauto','1992-05-7'),
	('73282932000075', 'TAautomobileDeux', 'Tauto', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test C.1 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test C.2
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', 'TAautomobile', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test C.2 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH

DELETE FROM Entreprise WHERE prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test C.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,date_naissance_compte) VALUES
	('73282932000074','TAautomobile','Tauto','1992-05-7');
	
	PRINT('------------------------------Test C.3 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test C.4
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte) VALUES
	('73282932000074', 'TAautomobile', 'Tauto', 'Tauto');
	
	PRINT('------------------------------Test C.4 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='Tauto' AND prenom_compte='Tauto'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'



--Test C.5
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Tauto', 'Tauto','1992-05-7','false','true','AB0020012800000012005276005', 'tauto@gmail.fr', '0605040302');
	
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
	('73282932000074', 'TAautomobile', 'TautoNotExistingLastName', 'Tauto','1992-05-7');
	
	PRINT('------------------------------Test C.5 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.5 OK')
END CATCH

DELETE FROM Entreprise WHERE nom_compte='TautoNotExistingLastName' AND prenom_compte='Tauto' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Tauto' AND prenom='Tauto' AND date_naissance='1992-05-7'


SET NOCOUNT ON


------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Facturation.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Facturation
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Facturation')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

DELETE FROM Facturation;

--Test A.1
--BEGIN TRY
	INSERT INTO Facturation(date_reception, montant) VALUES
	('2014-01-12', 175.25);
	IF (( SELECT COUNT(*)
		FROM Facturation
		WHERE date_creation = CONVERT(date, GETDATE())) = 1)
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
/*END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH*/
DELETE FROM Facturation;

--Test A.2
BEGIN TRY
	INSERT INTO Facturation(date_creation, date_reception, montant) VALUES
	('2014-01-01', '2014-01-12',175.25);
	IF (( SELECT COUNT(*)
		FROM Facturation
		WHERE date_creation = '2014-01-01') = 1)
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH
DELETE FROM Facturation;

--Test B.1
BEGIN TRY
	INSERT INTO Facturation(date_creation, montant) VALUES
	('2014-01-01',175.25);
	IF (( SELECT COUNT(*)
		FROM Facturation
		WHERE date_creation = '2014-01-01'
			  AND date_reception IS NULL) = 1)
		PRINT('------------------------------Test B.1 OK')
	ELSE
		PRINT('------------------------------Test B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 NOT OK')
END CATCH
DELETE FROM Facturation;

--Test B.2
BEGIN TRY
	INSERT INTO Facturation(date_creation, date_reception, montant) VALUES
	('2014-01-01', '1980-01-01', 175.25);
	IF (( SELECT date_reception
		FROM Facturation
		WHERE date_creation = '2014-01-01') = '1980-01-01')
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH
DELETE FROM Facturation;

--Test B.3
BEGIN TRY
	INSERT INTO Facturation(date_creation, date_reception, montant) VALUES
	('2014-01-01', '2020-01-01', 175.25);
	IF (( SELECT date_reception
		FROM Facturation
		WHERE date_creation = '2014-01-01') = '2020-01-01')
		PRINT('------------------------------Test B.3 OK')
	ELSE
		PRINT('------------------------------Test B.3 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 NOT OK')
END CATCH
DELETE FROM Facturation;

--Test C.1
BEGIN TRY
	INSERT INTO Facturation(date_creation, date_reception) VALUES
	('2014-01-01', '1980-01-01');
	
	SELECT * FROM Facturation WHERE date_creation = '2014-01-01'
	
	PRINT('------------------------------Test C.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH
DELETE FROM Facturation;

--Test C.2
BEGIN TRY
	INSERT INTO Facturation(date_creation, date_reception, montant) VALUES
	('2014-01-01', '2020-01-01', 0.00);
	
	SELECT date_reception FROM Facturation WHERE date_creation = '2014-01-01';
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM Facturation;

--Test C.3
BEGIN TRY
	INSERT INTO Facturation(date_creation, date_reception, montant) VALUES
	('2014-01-01', '1980-01-01', 5.00);
	IF (( SELECT montant
		FROM Facturation
		WHERE date_creation = '2014-01-01') = 5.00)
		PRINT('------------------------------Test C.3 OK')
	ELSE
		PRINT('------------------------------Test C.3 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 NOT OK')
END CATCH
DELETE FROM Facturation;

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Particulier.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Particulier.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Particulier')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

--Test A.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr', '0605040302');
	
	INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jean', '1992-05-7'),
	('Dupont', 'Jean', '1992-05-7');
	
	PRINT('------------------------------Test A.1  NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 OK')
END CATCH

DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jean' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7'


--Test A.2
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr', '0605040302');
	
	INSERT INTO Particulier(prenom_compte,date_naissance_compte) VALUES
	('Jean', '1992-05-7');
	
	PRINT('------------------------------Test A.2  NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH

DELETE FROM Particulier WHERE prenom_compte='Jean' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7'



--Test A.3
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr', '0605040302');
	
	INSERT INTO Particulier(nom_compte,date_naissance_compte) VALUES
	('Dupont','1992-05-7');
	
	PRINT('------------------------------Test A.3  NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH

DELETE FROM Particulier WHERE nom_compte='Dupont' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7'



--Test A.4
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr', '0605040302');
	
	INSERT INTO Particulier(nom_compte,prenom_compte) VALUES
	('Dupont', 'Jean');
	
	PRINT('------------------------------Test A.4  NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH

DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jean'
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7'



--Test A.5
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr', '0605040302');
	
	INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'André', '1992-05-7');
	
	PRINT('------------------------------Test A.5  NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH

DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='André' AND date_naissance_compte='1992-05-7'
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7'

SET NOCOUNT ON

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Permis')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

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

SET NOCOUNT ON

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes SousPermis')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

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
    
	PRINT('------------------------------Test A.10 OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.10 NOT OK')
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

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140304_SACT_Location.sql
-- Date        : 04/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Location.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Location')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

------------------------------
--INITIALISATIONS FOR Test A.1
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test A.1
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) 
	VALUES
		('1885896aa', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test A.1 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 OK');
END CATCH 

------------------------------
--CLEAN FOR Test A.1
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896aa';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';
 
 
 
 
 
 
------------------------------
--INITIALISATIONS FOR Test A.2
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);

------------------------------
--REALIZATION OF Test A.2
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		(NULL, 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test A.2 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK');
END CATCH 

------------------------------
--CLEAN FOR Test A.2
------------------------------
DELETE FROM Location WHERE id_facturation=(SELECT id FROM Facturation WHERE date_creation='2060-12-09');
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';






------------------------------
--INITIALISATIONS FOR Test B.1
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test B.1
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 -1,
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test B.1 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK');
END CATCH 

------------------------------
--CLEAN FOR Test B.1
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';





------------------------------
--INITIALISATIONS FOR Test B.2
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test B.2
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 NULL,
		 NULL,
		 (SELECT id FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00')); 
		 
	PRINT('------------------------------Test B.2 OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK');
END CATCH 

------------------------------
--CLEAN FOR Test B.2
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';





------------------------------
--INITIALISATIONS FOR Test C.1
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test C.1
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 -1); 
		 
	PRINT('------------------------------Test C.1 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK');
END CATCH 

------------------------------
--CLEAN FOR Test C.1
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';





------------------------------
--INITIALISATIONS FOR Test C.2
------------------------------
INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','406','Diesel',2004,45,0,5,'false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');
INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules, km) VALUES
	('10vehicules', 5, 10, DEFAULT);
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7')); 
INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2060-12-09','2060-12-11',200);
		
------------------------------
--REALIZATION OF Test C.2
------------------------------
BEGIN TRY
	INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('1885896wx', 
		 (SELECT id FROM Facturation WHERE date_creation='2060-12-09'),
		 NULL,
		 NULL); 
		 
	PRINT('------------------------------Test C.2 NOT OK');
		 
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK');
END CATCH 

------------------------------
--CLEAN FOR Test C.2
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2060-12-09';
DELETE FROM ContratLocation WHERE date_debut='2060-12-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2060-12-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' AND prenom_compte='Jacques' AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jacques' AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM Modele WHERE marque='Peugeot' AND serie='406' AND type_carburant='Diesel';

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140305_SACT_Tauto_Abonnement.sql
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Abonnement.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Abonnement')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;
GO

-- preparation : un type abonnement, un compte abonne

EXEC dbo.videTables;
GO

INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont', 'Jean','1992-05-7','false','true','AB0020012800000012005276005', 'jean.dupont@gmail.fr', '0605040302');

INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');


--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM Abonnement

	-- test
	INSERT INTO Abonnement
	(nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	('bronze', 'Dupont', 'Jean', '1992-05-7');
	
	-- verification
    IF
      (SELECT date_debut
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = CONVERT (date, GETDATE())
	   
	   AND

	  (SELECT duree
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = 1
	   
	   AND

	  (SELECT renouvellement_auto
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = 'false'
	   
	   AND
	   
	  (SELECT a_supprimer 
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = 'false'
	   
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
	DELETE FROM Abonnement

	-- test
	INSERT INTO Abonnement
	(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	('2013-01-12', 22, 1, 'bronze', 'Dupont', 'Jean', '1992-05-7');
	
	-- verification
    IF
      (SELECT date_debut
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = '2013-01-12'
	   
	   AND

	  (SELECT duree
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = 22
	   
	   AND
	   
	  (SELECT renouvellement_auto
	   FROM Abonnement 
	   WHERE id=SCOPE_IDENTITY()) = 'true'
	   
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
	DELETE FROM Abonnement

	-- test
	INSERT INTO Abonnement
	(id, date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	(66, '2013-01-12', 22, 'bronze', 'Dupont', 'Jean', '1992-05-7');
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test B.2
BEGIN TRY
	-- preparation
	DELETE FROM Abonnement
	INSERT INTO Abonnement
	(date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	('2013-01-12', 22, 'bronze', 'Dupont', 'Jean', '1992-05-7');

	DECLARE @IdPredecesseur int;
	SET @IdPredecesseur = SCOPE_IDENTITY();

	-- test
	INSERT INTO Abonnement
	(date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	('2013-02-24', 30, 'bronze', 'Dupont', 'Jean', '1992-05-7');
	
	-- verification
    IF SCOPE_IDENTITY() = @IdPredecesseur + 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM Abonnement

	-- test
	INSERT INTO Abonnement
	(date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	('2013-01-12', 22, 'bronzeAAAAA', 'Dupont', 'Jean', '1992-05-7');
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


--Test C.2
BEGIN TRY
	-- preparation
	DELETE FROM Abonnement

	-- test
	INSERT INTO Abonnement
	(date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
	VALUES
	('2013-01-12', 22, 'bronze', 'DupontAA', 'JeanBB', '1992-05-7');
	
	-- verification
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 


EXEC dbo.videTables;
GO

SET NOCOUNT ON


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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Retard')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE TAuto_IBDR;

EXEC dbo.videTables

INSERT INTO Modele (marque,serie,type_carburant,prix,portieres) VALUES ('Peugeot','406','Diesel',100,5);
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement(nom) VALUES ('10vehicules');
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
	
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
	    
INSERT INTO Location(matricule_vehicule,id_contratLocation) VALUES
		('1885896wx',
		(SELECT id 
		FROM ContratLocation 
		WHERE date_debut='2060-12-02 00:00:00'));

DECLARE @idLoc int = (SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

		
--Test A1

BEGIN TRY
	INSERT INTO Retard(id_location) VALUES
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Retard
		WHERE id_location = @idLoc
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
		('2014-03-06',@idLoc);
    IF(SELECT date FROM Retard
		WHERE id_location = @idLoc) = '2014-03-06'
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
		(NULL,@idLoc);
     
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
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Retard
		WHERE id_location = @idLoc
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
		(@idLoc);
    
	IF(SELECT regle FROM Retard
		WHERE id_location = @idLoc) = 'false'
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
		(@idLoc,'true');
    
	IF(SELECT regle FROM Retard
		WHERE id_location = @idLoc) = 'true'
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
		(@idLoc);
    
	IF(SELECT niveau FROM Retard
		WHERE id_location = @idLoc) = 1
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
		(@idLoc,2);
    
	IF(SELECT niveau FROM Retard
		WHERE id_location = @idLoc) = 2
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
		(@idLoc),
		(@idLoc);
    
	PRINT('------------------------------Test E.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH 

EXEC dbo.videTables;

SET NOCOUNT ON

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes TypeAbonnement')
PRINT('--------------------------------------------------')

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

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140228_SACT_Etat.sql
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Etat.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Etat')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

------------------------------
--INITIALISATIONS FOR All TESTS
------------------------------

INSERT INTO Catalogue(nom,date_debut,date_fin)
VALUES('Flotte','2014-01-01', '2014-06-01');

INSERT INTO Categorie(nom,description,nom_typepermis) 
VALUES('Vehicule simple','Tout type de vehicule simple a 4 roues','B');

INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie)
VALUES('Flotte', 'Vehicule simple');

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres) 
VALUES('Peugeot','406','Diesel',2004,45,0,5);

INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) 
VALUES('Peugeot','406','Diesel',5,'Vehicule Simple');

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) 
VALUES('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) 
VALUES('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');

INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) 
VALUES('Dupont', 'Jacques', '1992-05-7');

INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules, km)
VALUES('10vehicules', 5, 10, DEFAULT);

INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) 
VALUES('2014-02-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
	
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) 
VALUES('2014-02-02 00:00:00',
	   '2014-02-12 00:00:00',
	   '2014-02-11 00:00:00',
	   0,
	   (SELECT id 
	    FROM Abonnement 
	    WHERE nom_compteabonne='Dupont' 
	      AND prenom_compteabonne='Jacques' 
	      AND date_naissance_compteabonne='1992-05-7'));

INSERT INTO Facturation(date_creation,date_reception,montant) 
VALUES('2014-02-11','2014-02-13',200);

INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation,km) 
VALUES('1885896wx', 
	   (SELECT id FROM Facturation WHERE date_creation='2014-02-11'),
	   NULL,
	   (SELECT id FROM ContratLocation WHERE date_debut='2014-02-02 00:00:00'),
	   0); 		

--Test A.1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 'true',
			 '0100');
	PRINT('------------------------------Test A.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK '+ERROR_MESSAGE());
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

--Test A.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 -1,
			 0,
			 '0100');
	PRINT('------------------------------Test A.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test A.3
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 NULL,
			 0,
			 '0100');
	PRINT('------------------------------Test A.3 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test A.4
BEGIN TRY
INSERT INTO Etat(date_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 0,
			 '0100');
	IF (SELECT km_avant FROM Etat WHERE date_avant='2014-02-02') = 0
		PRINT('------------------------------Test A.4 OK');
	ELSE
		PRINT('------------------------------Test A.4 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

--Test B.1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 '0100');
	PRINT('------------------------------Test B.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test B.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 NULL,
			 '0100');
	PRINT('------------------------------Test B.2 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test C.1
BEGIN TRY
INSERT INTO Etat(km_avant,degat,fiche_avant) VALUES
			(10,
			 0,
			 '0100');
	IF (SELECT COUNT(*) 
		FROM Etat 
		WHERE date_avant IS NULL 
		  AND km_avant=10) = 0
		PRINT('------------------------------Test C.1 OK');
	ELSE
		PRINT('------------------------------Test C.1 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK lalala');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test C.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			(NULL, 
			 10,
			 0,
			 '0100');
	PRINT('------------------------------Test C.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
			  
--Test E.1
----------Part 1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 '');
	PRINT('------------------------------Test E.1 NOT OK.1');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.1');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

----------Part 2		  
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 ' ');
	PRINT('------------------------------Test E.1 NOT OK.2');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.2');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

----------Part 3
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 'm@Fiche');
	PRINT('------------------------------Test E.1 NOT OK.3');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK.3');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test E.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('25-11-2060', 
			 10,
			 0,
			 NULL);
	PRINT('------------------------------Test E.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';


--Test G.1
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,km_apres,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 10,
			 0,
			 '0100');
	PRINT('------------------------------Test G.1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.1 NOT OK ');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

--Test G.2
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,km_apres,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 -1,
			 0,
			 '0100');
	PRINT('------------------------------Test G.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.2 OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test G.3
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,km_apres,degat,fiche_avant) VALUES
			('2014-02-02',
			 10,
			 NULL,
			 0,
			 '0100');
	PRINT('------------------------------Test G.3 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.3 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';
				  
--Test G.4
BEGIN TRY
INSERT INTO Etat(date_avant,km_avant,degat,fiche_avant) VALUES
			('2014-02-02', 
			 10,
			 0,
			 '0100');
	IF (SELECT km_apres FROM Etat WHERE date_avant='2014-02-02') IS NULL
		PRINT('------------------------------Test G.4 OK');
	ELSE
		PRINT('------------------------------Test G.4 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.4 NOT OK');
END CATCH

DELETE FROM Etat WHERE date_avant='2014-02-02';

------------------------------
--CLEAN FOR ALL TESTS
------------------------------
DELETE FROM Location WHERE matricule_vehicule='1885896wx';
DELETE FROM Facturation WHERE date_creation='2014-02-11';
DELETE FROM ContratLocation WHERE date_debut='2014-02-02 00:00:00';
DELETE FROM Abonnement WHERE date_debut='2014-02-01 00:00:00';
DELETE FROM TypeAbonnement WHERE nom='10vehicules';
DELETE FROM Particulier WHERE nom_compte='Dupont' 
						  AND prenom_compte='Jacques' 
						  AND date_naissance_compte='1992-05-7';
DELETE FROM CompteAbonne WHERE nom='Dupont' 
						   AND prenom='Jacques' 
						   AND date_naissance='1992-05-7';
DELETE FROM Vehicule WHERE matricule='1885896wx';
DELETE FROM CatalogueCategorie WHERE nom_catalogue='Flotte';
DELETE FROM CategorieModele WHERE marque_modele='Peugeot' 
							  AND serie_modele='406' 
							  AND type_carburant_modele='Diesel';
DELETE FROM Categorie WHERE nom='Vehicule simple';
DELETE FROM Modele WHERE marque='Peugeot'
					 AND serie='406'
					 AND type_carburant='Diesel'
DELETE FROM Catalogue WHERE nom='Flotte';

SET NOCOUNT ON

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

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Incident')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables

INSERT INTO Modele (marque,serie,type_carburant,prix,portieres) VALUES ('Peugeot','406','Diesel',100,5);
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement(nom) VALUES ('10vehicules');
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
	
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
	    
INSERT INTO Location(matricule_vehicule,id_contratLocation) VALUES
		('1885896wx',
		(SELECT id 
		FROM ContratLocation 
		WHERE date_debut='2060-12-02 00:00:00'));

DECLARE @idLoc int = (SELECT id FROM Location WHERE matricule_vehicule='1885896wx');

		
--Test A1

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Incident
		WHERE id_location = @idLoc
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
		('2014-03-06',@idLoc);
    IF(SELECT date FROM Incident
		WHERE id_location = @idLoc) = '2014-03-06'
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
		(NULL,@idLoc);
     
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
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Incident
		WHERE id_location = @idLoc
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
		(@idLoc,'description valide');
    
	IF(SELECT description FROM Incident
		WHERE id_location = @idLoc) = 'description valide'
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
		(@idLoc,'@description');
    
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 
DELETE FROM Incident;

--Test C3

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(@idLoc);
    
	IF(SELECT description FROM Incident
		WHERE id_location = @idLoc) = ''
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
		(@idLoc,NULL);

		PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 
DELETE FROM Incident;

--Test D1

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(@idLoc);
    
	IF(SELECT penalisable FROM Incident
		WHERE id_location = @idLoc) = 'false'
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
		(@idLoc,'true');
    
	IF(SELECT penalisable FROM Incident
		WHERE id_location = @idLoc) = 'true'
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
		(@idLoc,NULL);
    
		PRINT('------------------------------Test D.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.3 OK')
END CATCH 
DELETE FROM Incident;

--Test E1

BEGIN TRY
	INSERT INTO Incident(id_location) VALUES
		(@idLoc),
		(@idLoc);
    
	PRINT('------------------------------Test E.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH 

EXEC dbo.videTables

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140306_SACT_Tauto_Infraction.sql
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes sur la table Infraction
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Infraction')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

EXEC dbo.videTables;

INSERT INTO Modele (marque,serie,type_carburant,prix,portieres) VALUES ('Peugeot','406','Diesel',100,5);
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele) VALUES
	('1885896wx','18000','Bleu','En panne','VF3 8C5ZXF 81100100','Peugeot','406',5,'Diesel');

INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Dupont', 'Jacques','1992-05-7','false','true','AB0020012800000012005276005', 'jacques.dupont@gmail.fr', '0605040302');
INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
	('Dupont', 'Jacques', '1992-05-7');
INSERT INTO TypeAbonnement(nom) VALUES ('10vehicules');
INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement,nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
	('2060-12-01 00:00:00',90,0,'10vehicules','Dupont', 'Jacques','1992-05-7');
	
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
	('2060-12-02 00:00:00','2060-12-12 00:00:00','2060-12-09 00:00:00',0,
	 (SELECT id 
	  FROM Abonnement 
	  WHERE nom_compteabonne='Dupont' 
	    AND prenom_compteabonne='Jacques' 
	    AND date_naissance_compteabonne='1992-05-7'));
	    
INSERT INTO Location(matricule_vehicule,id_contratLocation) VALUES
		('1885896wx',
		(SELECT id 
		FROM ContratLocation 
		WHERE date_debut='2060-12-02 00:00:00'));

DECLARE @idLoc int = (SELECT id FROM Location WHERE matricule_vehicule='1885896wx');
		
--Test A1

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Infraction
		WHERE id_location = @idLoc
			AND DATEDIFF(minute,date,GETDATE()) < 2 ) = 1
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test A2

BEGIN TRY
	INSERT INTO Infraction(date,id_location) VALUES
		('2014-03-06',@idLoc);
    IF(SELECT date FROM Infraction
		WHERE id_location = @idLoc) = '2014-03-06'
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test A3

BEGIN TRY
	INSERT INTO Infraction(date,id_location) VALUES
		(NULL,@idLoc);
     
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 
DELETE FROM Infraction;

--Test B1

BEGIN TRY
	INSERT INTO Infraction(date) VALUES ('2014-03-06');
     
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 
DELETE FROM Infraction;

--Test B2

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc);
    
	IF(SELECT COUNT(*) FROM Infraction
		WHERE id_location = @idLoc
			AND DATEDIFF(minute,date,GETDATE()) < 2 ) = 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test B3

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(NULL);
    
	PRINT('------------------------------Test B.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.3 OK')
END CATCH 
DELETE FROM Infraction;

--Test C1

BEGIN TRY
	INSERT INTO Infraction(id_location,description) VALUES
		(@idLoc,'description valide');
    
	IF(SELECT description FROM Infraction
		WHERE id_location = @idLoc) = 'description valide'
		PRINT('------------------------------Test C.1 OK')
	ELSE
		PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test C2

BEGIN TRY
	INSERT INTO Infraction(id_location,description) VALUES
		(@idLoc,'@description');
    
	PRINT('------------------------------Test C.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 
DELETE FROM Infraction;

--Test C3

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc);
    
	IF(SELECT description FROM Infraction
		WHERE id_location = @idLoc) = ''
		PRINT('------------------------------Test C.3 OK')
	ELSE
		PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test C4

BEGIN TRY
	INSERT INTO Infraction(id_location,description) VALUES
		(@idLoc,NULL);

		PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 
DELETE FROM Infraction;

--Test D1

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc);
    
	IF(SELECT regle FROM Infraction
		WHERE id_location = @idLoc) = 'false'
		PRINT('------------------------------Test D.1 OK')
	ELSE
		PRINT('------------------------------Test D.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test D2

BEGIN TRY
	INSERT INTO Infraction(id_location,regle) VALUES
		(@idLoc,'true');
    
	IF(SELECT regle FROM Infraction
		WHERE id_location = @idLoc) = 'true'
		PRINT('------------------------------Test D.2 OK')
	ELSE
		PRINT('------------------------------Test D.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test E1

BEGIN TRY
	INSERT INTO Infraction(id_location,nom) VALUES
		(@idLoc,'nom valide');
    
	IF(SELECT nom FROM Infraction
		WHERE id_location = @idLoc) = 'nom valide'
		PRINT('------------------------------Test E.1 OK')
	ELSE
		PRINT('------------------------------Test E.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test E2

BEGIN TRY
	INSERT INTO Infraction(id_location,nom) VALUES
		(@idLoc,'@nom');
    
	PRINT('------------------------------Test E.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK')
END CATCH 
DELETE FROM Infraction;

--Test E3

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc);
    
	IF(SELECT nom FROM Infraction
		WHERE id_location = @idLoc) = ''
		PRINT('------------------------------Test E.3 OK')
	ELSE
		PRINT('------------------------------Test E.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.3 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test E4

BEGIN TRY
	INSERT INTO Infraction(id_location,nom) VALUES
		(@idLoc,NULL);

		PRINT('------------------------------Test E.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.4 OK')
END CATCH 
DELETE FROM Infraction;

--Test F1

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc);
    
	IF(SELECT montant FROM Infraction
		WHERE id_location = @idLoc) = 0
		PRINT('------------------------------Test F.1 OK')
	ELSE
		PRINT('------------------------------Test F.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.1 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test F2

BEGIN TRY
	INSERT INTO Infraction(id_location,montant) VALUES
		(@idLoc,1);
    
	IF(SELECT montant FROM Infraction
		WHERE id_location = @idLoc) = 1
		PRINT('------------------------------Test F.2 OK')
	ELSE
		PRINT('------------------------------Test F.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.2 NOT OK')
END CATCH 
DELETE FROM Infraction;

--Test F3

BEGIN TRY
	INSERT INTO Infraction(id_location,montant) VALUES
		(@idLoc,NULL);
    
	PRINT('------------------------------Test F.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.3 OK')
END CATCH 
DELETE FROM Infraction;

--Test G1

BEGIN TRY
	INSERT INTO Infraction(id_location) VALUES
		(@idLoc),
		(@idLoc);
    
	PRINT('------------------------------Test G.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.1 OK')
END CATCH 

EXEC dbo.videTables;

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140309_SACT_Tauto_ConducteurLocation.sql
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table ConducteurLocation.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes ConducteurLocation')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

-- preparation :

EXEC dbo.videTables;
GO

-- preparation : 3 conducteurs

INSERT INTO Permis(numero)
VALUES ('0000000001'),
       ('0000000002'),
       ('0000000003');

INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis)
VALUES ('123456789', 'Francais', 'de Finance', 'Boris', '0000000001'),
       ('987654321', 'Francais', 'le Coco', 'David', '0000000002'),
       ('100000001', 'Anglais', 'Amitousa', 'Jean Luc', '0000000003');

-- preparation : 2 locations

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres)
VALUES ('Peugeot', '406', 'Essence', 2006, 45, 0, 5);

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele)
VALUES ('0775896we', '14000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence'),
       ('0999996aa', '65000', 'Gris', 'Disponible', 'VF3 8C4HXF 11800000', 'Peugeot', '406', 5, 'Essence');

INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2014-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

DECLARE @IdAbonnement int;
SET @IdAbonnement = SCOPE_IDENTITY();

INSERT INTO ContratLocation(date_debut, date_fin, extension, id_abonnement)
VALUES ('20140303 08:00:00', '20140314 18:00:00', 0, @IdAbonnement);

DECLARE @IdContratLocation int;
SET @IdContratLocation = SCOPE_IDENTITY();

INSERT INTO Location(matricule_vehicule, id_contratLocation)
VALUES ('0775896we', @IdContratLocation); 

DECLARE @IdLocation1 int;
SET @IdLocation1 = SCOPE_IDENTITY();

INSERT INTO Location(matricule_vehicule, id_contratLocation)
VALUES ('0999996aa', @IdContratLocation); 

DECLARE @IdLocation2 int;
SET @IdLocation2 = SCOPE_IDENTITY();


--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 1

	   AND

      (SELECT id_location
	   FROM ConducteurLocation) = @IdLocation1

	   AND

	  (SELECT piece_identite_conducteur
	   FROM ConducteurLocation) = '123456789'
	   
	   AND

	  (SELECT nationalite_conducteur
	   FROM ConducteurLocation) = 'Francais'

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
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais'),
		(@IdLocation1, '100000001', 'Anglais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation1) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais') = 1
	   
	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais') = 1

		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 


--Test A.3
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais'),
		(@IdLocation2, '123456789', 'Francais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais') = 2
	   

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation1) = 1

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation2) = 1


		PRINT('------------------------------Test A.3 OK')
	ELSE
		PRINT('------------------------------Test A.3 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 NOT OK')
END CATCH 


--Test A.4
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais'),
		(@IdLocation1, '987654321', 'Francais'),
		(@IdLocation1, '100000001', 'Anglais'),
		(@IdLocation2, '100000001', 'Anglais'),
		(@IdLocation2, '987654321', 'Francais');

	-- verification
    IF
      (SELECT count(*)
	   FROM ConducteurLocation) = 5

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation1) = 3

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE id_location = @IdLocation2) = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais') = 1

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '987654321' AND nationalite_conducteur = 'Francais') = 2

	   AND

      (SELECT count(*)
	   FROM ConducteurLocation
	   WHERE piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais') = 2

		PRINT('------------------------------Test A.4 OK')
	ELSE
		PRINT('------------------------------Test A.4 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais');
	
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', 'Francais');
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(NULL, '123456789', 'Francais');
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


--Test C.2
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, NULL, 'Francais');
	
	-- verification
	PRINT('------------------------------Test C.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 


--Test C.3
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '123456789', NULL);
	
	-- verification
	PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH 


--Test C.4
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation2 + 5, '123456789', 'Francais');
	
	-- verification
	PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 


--Test C.5
BEGIN TRY
	-- preparation
	DELETE FROM ConducteurLocation

	-- test
	INSERT INTO ConducteurLocation
		(id_location, piece_identite_conducteur, nationalite_conducteur)
	VALUES
		(@IdLocation1, '999999999', 'Francais');
	
	-- verification
	PRINT('------------------------------Test C.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.5 OK')
END CATCH 


EXEC dbo.videTables;
GO

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140309_SACT_Tauto_Reservation.sql
-- Date        : 09/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Reservation.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Reservation')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

-- preparation : un vehicule, un abonnement

EXEC dbo.videTables;
GO

INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2013-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

DECLARE @IdAbonnement int;
SET @IdAbonnement = SCOPE_IDENTITY();

--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
    IF
      (SELECT date_creation
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = CONVERT (date, GETDATE())

	   AND

	  (SELECT annule
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = 'false'

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
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, date_fin, id_abonnement)
	VALUES
		('2013-03-10', '20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
    IF
      (SELECT date_creation
	   FROM Reservation 
	   WHERE id=SCOPE_IDENTITY()) = '2013-03-10'
	   
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH


--Test A.3
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, date_fin, id_abonnement)
	VALUES
		(NULL, '20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH 


--Test A.4
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_fin, id_abonnement)
	VALUES
		('2013-03-10', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH 


--Test A.5
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_creation, date_debut, id_abonnement)
	VALUES
		('2013-03-10', '20130317 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test A.5 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(id, date_debut, date_fin, id_abonnement)
	VALUES
		(11, '20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test B.2
BEGIN TRY
	-- preparation
	DELETE FROM Reservation
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);

	DECLARE @IdPredecesseur int;
	SET @IdPredecesseur = SCOPE_IDENTITY();

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', @IdAbonnement);
	
	-- verification
    IF SCOPE_IDENTITY() = @IdPredecesseur + 1
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM Reservation

	-- test
	INSERT INTO Reservation
		(date_debut, date_fin, id_abonnement)
	VALUES
		('20130325 08:00:00', '20130326 18:00:00', @IdAbonnement + 1);
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH


EXEC dbo.videTables;

SET NOCOUNT ON
GO

------------------------------------------------------------
-- Fichier     : 20140310_SACT_Tauto_ReservationVehicule.sql
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table ReservationVehicule.
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes ReservationVehicule')
PRINT('--------------------------------------------------')

SET NOCOUNT ON

USE Tauto_IBDR;

-- preparation :
EXEC dbo.videTables;
GO

DECLARE @IdAbonnement int, @IdReservation1 int, @IdReservation2 int;

-- preparation : 3 Vehicules

INSERT INTO Modele (marque,serie,type_carburant,annee,prix,reduction,portieres)
VALUES ('Peugeot', '406', 'Essence', 2006, 45, 0, 5);

INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele)
VALUES ('0775896we', '14000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence'),
       ('0115896wx', '18000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence'),
       ('0445896wr', '25000', 'Bleu', 'Disponible', 'VF3 8C4HXF 81100000', 'Peugeot', '406', 5, 'Essence');

-- preparation : 2 Reservations

INSERT INTO TypeAbonnement (nom, prix, nb_max_vehicules)
VALUES ('bronze', 8, 20);

INSERT INTO CompteAbonne (nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone)
VALUES ('Dupont','Jean','1992-05-7','false','true','AB0020012800000012005276005','jean.dupont@gmail.fr','0605040302');

INSERT INTO Particulier (nom_compte,prenom_compte,date_naissance_compte)
VALUES ('Dupont', 'Jean', '1992-05-7');

INSERT INTO Abonnement (date_debut, duree, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
VALUES ('2013-03-01', 60, 'bronze', 'Dupont', 'Jean', '1992-05-7');

SET @IdAbonnement = SCOPE_IDENTITY();

INSERT INTO Reservation (date_debut, date_fin, id_abonnement)
VALUES ('20130317 08:00:00', '20130324 08:00:00', @IdAbonnement);

SET @IdReservation1 = SCOPE_IDENTITY();

INSERT INTO Reservation (date_debut, date_fin, id_abonnement)
VALUES ('20130319 08:00:00', '20130321 17:00:00', @IdAbonnement);

SET @IdReservation2 = SCOPE_IDENTITY();

--Test A.1
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 1

	   AND

      (SELECT id_reservation
	   FROM ReservationVehicule) = @IdReservation1

	   AND

	  (SELECT matricule_vehicule
	   FROM ReservationVehicule) = '0775896we'

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
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we'),
		(@IdReservation1, '0115896wx');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation1) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0775896we') = 1
	   
	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0115896wx') = 1

		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 


--Test A.3
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we'),
		(@IdReservation2, '0775896we');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0775896we') = 2
	   

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation1) = 1

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation2) = 1


		PRINT('------------------------------Test A.3 OK')
	ELSE
		PRINT('------------------------------Test A.3 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 NOT OK')
END CATCH 


--Test A.4
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we'),
		(@IdReservation1, '0115896wx'),
		(@IdReservation1, '0445896wr'),
		(@IdReservation2, '0445896wr'),
		(@IdReservation2, '0115896wx');

	-- verification
    IF
      (SELECT count(*)
	   FROM ReservationVehicule) = 5

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation1) = 3

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE id_reservation = @IdReservation2) = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0775896we') = 1

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0115896wx') = 2

	   AND

      (SELECT count(*)
	   FROM ReservationVehicule
	   WHERE matricule_vehicule = '0445896wr') = 2

		PRINT('------------------------------Test A.4 OK')
	ELSE
		PRINT('------------------------------Test A.4 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK')
END CATCH 


--Test B.1
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we');
	
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0775896we');
	
	-- verification
	PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 OK')
END CATCH 


--Test C.1
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(NULL, '0775896we');
	
	-- verification
	PRINT('------------------------------Test C.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH 


--Test C.2
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation2 + 5, '0775896we');
	
	-- verification
	PRINT('------------------------------Test C.2 NOT OK')

END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH 


--Test C.3
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, NULL);
	
	-- verification
	PRINT('------------------------------Test C.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH 


--Test C.4
BEGIN TRY
	-- preparation
	DELETE FROM ReservationVehicule

	-- test
	INSERT INTO ReservationVehicule
		(id_reservation, matricule_vehicule)
	VALUES
		(@IdReservation1, '0999999xx');
	
	-- verification
	PRINT('------------------------------Test C.4 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.4 OK')
END CATCH 


EXEC dbo.videTables;
GO

SET NOCOUNT ON

------------------------------------------------------------
-- Fichier     : 20140312_SACT_Tauto_Categorie.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Categorie
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Categorie')
PRINT('--------------------------------------------------')

USE TAuto_IBDR;

DELETE FROM CatalogueCategorie;
DELETE FROM Categorie;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','', '','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.1  NOT OK')
	ELSE
		PRINT('------------------------------Test A.1   OK')
END TRY
BEGIN CATCH
	PRINT('---------------CATCH---------Test A.1 OK')
END CATCH

DELETE FROM Categorie;

--Test A.2
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('4x4','description de la categorie 4x4', 'B','');
		IF((SELECT c.a_supprimer FROM Categorie c WHERE c.nom='4x4')='false')
			PRINT('------------------------------Test A.2  OK')
		ELSE 
			PRINT('------------------------------Test A.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH

DELETE FROM Categorie;


--Test A.3
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','description du pic-up', 'X','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.3  NOT OK')
	ELSE
		PRINT('------------------------------Test A.3   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3  OK')
END CATCH

DELETE FROM Categorie;


--Test A.4
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','my description avec le caractere @ ....', 'B','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.4  NOT OK')
	ELSE
		PRINT('------------------------------Test A.4   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH

DELETE FROM Categorie;

--Test A.5
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('my / Categorie ','my description ', 'B','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.5  NOT OK')
	ELSE
		PRINT('------------------------------Test A.5   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH


DELETE FROM Categorie;

--Test B.1
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','my description ', 'B','false');
		
	BEGIN TRY
		INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
			('pic-up','my description ', 'B','false');
		
		IF (( SELECT COUNT(*) FROM Categorie) = 2)
			PRINT('------------------------------Test B.1  NOT OK')
		ELSE
			PRINT('------------------------------Test B.1   OK')
	END TRY
	BEGIN CATCH
		PRINT('------------------------------Test B.1 OK')
	END CATCH
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH

------------------------------------------------------------
-- Fichier     : 20140312_SACT_Tauto_Modele.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Modele
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Modele')
PRINT('--------------------------------------------------')

USE TAuto_IBDR;

DELETE FROM CategorieModele;
DELETE FROM Modele;

--Test A.1
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207',null,2013,null,15,5,'false');
	IF (( SELECT COUNT(*)
		FROM Modele) = 1)
		PRINT('------------------------------Test A.1  NOT OK')
	ELSE
		PRINT('------------------------------Test A.1   OK')
END TRY
BEGIN CATCH
	PRINT('---------------CATCH----------Test A.1  OK')
END CATCH

DELETE FROM Modele;

--Test A.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207', 'Essence',2013,35,0,'','');
	IF (( SELECT COUNT(*)
		FROM Modele) != 1)
		PRINT('------------------------------Test A.2  NOT OK')
	ELSE
		BEGIN
			IF((SELECT COUNT(*) FROM Modele m WHERE m.portieres=0 AND m.reduction=0 AND m.a_supprimer='false')=1) 
				PRINT('------------------------------Test A.2  OK')
			ELSE 
				PRINT('------------------------------Test A.2 NOT OK')
		END
END TRY
BEGIN CATCH
	PRINT('---------------CATCH-------------Test A.2 NOT OK')
END CATCH

DELETE FROM Modele;

--Test A.3
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207', 'toto','2013',35,0,5,'false');
	IF (( SELECT COUNT(*)
		FROM Modele) = 1)
		PRINT('------------------------------Test A.3  NOT OK')
	ELSE
		PRINT('------------------------------Test A.3   OK')
END TRY
BEGIN CATCH
	PRINT('----------------CATCH----------Test A.3 OK')
END CATCH

DELETE FROM Modele;


--Test A.4
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207', 'Essence','2013',35,120,5,'false');
	IF (( SELECT COUNT(*)
		FROM Modele) = 1)
		PRINT('------------------------------Test A.4  NOT OK')
	ELSE
		PRINT('------------------------------Test A.4   OK')
END TRY
BEGIN CATCH
	PRINT('------------CATCH-----------Test A.4 OK')
END CATCH

DELETE FROM Modele;

--Test A.5.1
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot@','207', 'Diesel','2013',35,0,5,'false');
	IF (( SELECT COUNT(*)
		FROM Modele) = 1)
		PRINT('------------------------------Test A.5.1  NOT OK')
	ELSE
		PRINT('------------------------------Test A.5.1   OK')
END TRY
BEGIN CATCH
	PRINT('----------------CATCH---------Test A.5.1 OK')
END CATCH

DELETE FROM Modele;

--Test A.5.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207@', 'Diesel','2013',35,0,5,'false');
	IF (( SELECT COUNT(*)
		FROM Modele) = 1)
		PRINT('------------------------------Test A.5.2  NOT OK')
	ELSE
		PRINT('------------------------------Test A.5.2   OK')
END TRY
BEGIN CATCH
	PRINT('------------CATCH------------Test A.5.2 OK')
END CATCH

DELETE FROM Modele;


--Test B.1
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207', 'Diesel','2013',35,0,5,'false');
	
	BEGIN TRY	
		INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
			('Peugeot','207', 'Diesel','2013',35,0,5,'false');
	
		IF (( SELECT COUNT(*)
			FROM Modele) = 2)
			PRINT('------------------------------Test B.1  NOT OK')
		ELSE
			PRINT('------------------------------Test B.1   OK')

	END TRY
	BEGIN CATCH
		PRINT('------------CATCH------------Test B.1 OK')
	END CATCH

END TRY
BEGIN CATCH
	PRINT('------------CATCH------------Test B.1 OK')
END CATCH

DELETE FROM Modele;

------------------------------------------------------------
-- Fichier     : 20140312_SACT_Tauto_Vehicule.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Vehicule
------------------------------------------------------------

PRINT('--------------------------------------------------')
PRINT('Tests de contraintes Vehicule')
PRINT('--------------------------------------------------')

USE TAuto_IBDR;

DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;


--Test A.1

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',18522,'Bleu','Disponible',null,null,null,null,GETDATE(),null,'false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.1 NOT OK')
	ELSE
		PRINT('------------------------------Test A.1  OK')
END TRY
BEGIN CATCH
	PRINT('------------------CATCH--------Test A.1 OK')
END CATCH

DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.2

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH','','Gris','Disponible','445464645ff','Peugeot','207',5,'','Diesel','');
	IF (( SELECT COUNT(*)
		FROM Vehicule v WHERE v.kilometrage=0 AND v.couleur='Gris' AND v.statut='Disponible'  AND a_supprimer='false') = 1)
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.2 NOT OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.3

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH@',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.3 NOT OK')
	ELSE
		PRINT('------------------------------Test A.3 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.3 OK')
END CATCH



DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.4

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'toto','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.4 NOT OK')
	ELSE
		PRINT('------------------------------Test A.4 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.4 OK')
END CATCH



DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.5

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Non Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.5 NOT OK')
	ELSE
		PRINT('------------------------------Test A.5 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.5 OK')
END CATCH




DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test A.6

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff&','Peugeot','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test A.6 NOT OK')
	ELSE
		PRINT('------------------------------Test A.6 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test A.6 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test B.1

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');

	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
BEGIN TRY	
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Diesel','false');
	
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 2)
		PRINT('------------------------------Test B.1 NOT OK')
	ELSE
		PRINT('------------------------------Test B.1 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test B.1 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;




--Test C.1.1

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','208',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;


--Test C.1.2

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugotss','207',5,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1.2 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1.2 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1.2 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;

--Test C.1.3

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',3,GETDATE(),'Diesel','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1.3 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1.3 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1.3 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;

--Test C.1.4

	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres,a_supprimer) VALUES
		('Peugeot','207','Diesel',2013,35,15,5,'false');
BEGIN TRY
	INSERT INTO Vehicule(matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,date_entree,type_carburant_modele,a_supprimer) VALUES
		('15486GH',15548,'Gris','Disponible','445464645ff','Peugeot','207',5,GETDATE(),'Essence','false');
	IF (( SELECT COUNT(*)
		FROM Vehicule) = 1)
		PRINT('------------------------------Test C.1.4 NOT OK')
	ELSE
		PRINT('------------------------------Test C.1.4 OK')
END TRY

BEGIN CATCH
	PRINT('------------------CATCH--------Test C.1.4 OK')
END CATCH


DELETE FROM ReservationVehicule;
DELETE FROM CategorieModele;
DELETE FROM ConducteurLocation;
DELETE FROM Etat;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM Location;
DELETE FROM Vehicule;
DELETE FROM Modele;


