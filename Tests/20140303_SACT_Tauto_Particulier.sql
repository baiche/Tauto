------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_Particulier.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test des contraintes de la table Particuliers.
------------------------------------------------------------


USE Tauto_IBDR;



--Test A.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname1', 'Firstname1', '1992-05-7','false', 'AB0020012800000012005276005', 
     'firstname.lastname@gmail.fr', '0605040301');
     
    INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
    ('Lastname1', 'Firstname1', '1992-05-7');
    
    IF(SELECT actif 
	   FROM CompteAbonne 
	   WHERE nom='Lastname1' 
			 AND prenom='Firstname1' 
		     AND date_naissance='1992-05-7') = 'true'
	
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH 



--Test A.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname2', 'Firstname2', '1992-05-7','false','false', 'AB0020012800000012005276005', 
     'firstname2.lastname2@gmail.fr', '0605040302');
     
    INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
    ('Lastname2', 'Firstname2', '1992-05-7');
    
    IF(SELECT actif 
	   FROM CompteAbonne 
	   WHERE nom='Lastname2' 
			 AND prenom='Firstname2' 
		     AND date_naissance='1992-05-7') = 'false'
	
		PRINT('------------------------------Test A.2 OK')
	ELSE
		PRINT('------------------------------Test A.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH 



--Test B.1
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,iban,courriel,telephone) VALUES
    ('Lastname3', 'Firstname3', '1992-05-7','false','AB0020012800000012005276005', 
     'firstname3.lastname3@gmail.fr', '0605040302');
     
    INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
    ('Lastname3', 'Firstname3', '1992-05-7');
    
    IF(SELECT liste_grise 
	   FROM CompteAbonne 
	   WHERE nom='Lastname3' 
			 AND prenom='Firstname3' 
		     AND date_naissance='1992-05-7') = 'false'
	
		PRINT('------------------------------Test B.1 OK')
	ELSE
		PRINT('------------------------------Test B.1 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.1 NOT OK')
END CATCH 



--Test B.2
BEGIN TRY

	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname4', 'Firstname4', '1992-05-7','false','true','AB0020012800000012005276005', 
     'firstname4.lastname4@gmail.fr', '0605040302');
     
    INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
    ('Lastname4', 'Firstname4', '1992-05-7');
    
    IF(SELECT liste_grise 
	   FROM CompteAbonne 
	   WHERE nom='Lastname4' 
			 AND prenom='Firstname4' 
		     AND date_naissance='1992-05-7') = 'true'
	
		PRINT('------------------------------Test B.2 OK')
	ELSE
		PRINT('------------------------------Test B.2 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 NOT OK')
END CATCH 




--Test C.1
--Test C.2
--Test C.3
--Test D.1
--Test D.2
--Test E.1
--Test E.2
--Test E.3
--Test E.4
--Test E.5
--Test F.1
--Test F.2