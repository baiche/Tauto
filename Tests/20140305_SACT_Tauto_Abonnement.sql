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

SET NOCOUNT ON

USE Tauto_IBDR;

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

SET NOCOUNT OFF