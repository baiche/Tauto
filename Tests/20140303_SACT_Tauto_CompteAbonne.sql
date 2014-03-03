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


USE Tauto_IBDR;



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
    ('Lastname4', 'Firstname4', '1992-05-7','false','true','AB0020012800000012005276005', 
     'firstname4.lastname4@gmail.fr', '0605040302');
    
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

DELETE FROM CompteAbonne WHERE nom='Lastname4' AND prenom='Firstname4' AND date_naissance='1992-05-7';



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
    ('Dupont', 'André', '1992-05-7','false','true','AB0020012800000012005276005', 
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
    ('Dupont', 'Jean','1992/05/7','false','true','AB0020012800000012005276005', 
     'jean.dupont@gmail.fr', '0605040302');
    
	PRINT('------------------------------Test G.3 NOT OK')
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test G.3 OK')
END CATCH 

DELETE FROM CompteAbonne WHERE nom='Dupont' AND prenom='Jean' AND date_naissance='1992-05-7';



--Test g.4
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