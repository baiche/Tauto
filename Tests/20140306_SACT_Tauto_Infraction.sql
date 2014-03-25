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

SET NOCOUNT OFF