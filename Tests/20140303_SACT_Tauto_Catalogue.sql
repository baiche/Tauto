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

SET NOCOUNT ON

USE Tauto_IBDR;

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

SET NOCOUNT OFF