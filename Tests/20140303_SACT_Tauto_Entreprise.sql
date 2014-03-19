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


SET NOCOUNT OFF