------------------------------------------------------------
-- Fichier     : 20140228_SACT_ImcompleteExample_Particulier.sql
-- Date        : 28/02/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
--	Ce document a pour but de montrer comment réaliser différents type de tests.
------------------------------------------------------------


USE Tauto_IBDR;

EXEC dbo.videTables

--(ERASEME: les commentaires suivant correspond au 1er test de la contrainte A 
-- répertorié dans le document 20140228_ACT_ImcompleteExample_Particulier.docx. 
-- Les autres commentaires correspondent chacun à un test dans le documents 
-- 20140228_ACT_ImcompleteExample_Particulier.docx en respectant la même logique.
-- Vous n'êtes cependant pas réduit à ces commentaires.)

--Test A.1
BEGIN TRY
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,liste_grise,iban,courriel,telephone) VALUES
    ('Lastname1', 'Firstname1', '1992-05-7','false', 'LU28 0019 4006 4475 0010', 
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
    ('Lastname2', 'Firstname2', '1992-05-7','false','false', 'LU28 0019 4006 4475 0020', 
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
--Test B.2
--Test C.1
--Test C.2



--Test C.3
BEGIN TRY
	
	INSERT INTO CompteAbonne(nom,prenom,actif,liste_grise,iban,courriel,telephone) VALUES
    ('LastnameX', 'FirstnameX','false','false', 'LU28 0019 4006 4475 00X0', 
     'firstnameX.lastnameX@gmail.fr', '0605040300');
    
    INSERT INTO Particulier(nom_compte,prenom_compte,date_naissance_compte) VALUES
    ('LastnameX', 'FirstnameX', '1992-05-7');
    
	PRINT('------------------------------Test C.3 NOT OK')
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH 



--Test D.1