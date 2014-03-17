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