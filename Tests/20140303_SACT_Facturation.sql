------------------------------------------------------------
-- Fichier     : 20140303_SACT_Facturation.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Facturation
------------------------------------------------------------


USE Tauto_IBDR;

DELETE FROM Facturation;

--Test A.1
BEGIN TRY
	INSERT INTO Facturation(date_reception, montant) VALUES
	('2014-01-12', 175.25);
	IF (( SELECT COUNT(*)
		FROM Facturation
		WHERE date_creation = CONVERT(date, GETDATE())) = 1)
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH
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