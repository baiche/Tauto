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


USE Tauto_IBDR;



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