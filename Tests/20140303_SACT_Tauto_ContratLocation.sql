------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_ContratLocation.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table ContratLocation
------------------------------------------------------------

USE Tauto_IBDR;

DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

DECLARE @id_Abonnement int;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test A.1 et B.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 et B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 et B.1 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test A.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	INSERT INTO ContratLocation(id,date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('15879','20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,SCOPE_IDENTITY());
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test A.2 NOT OK')
	ELSE
		PRINT('------------------------------Test A.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test A.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	INSERT INTO ContratLocation(id,date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('test ID','20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,SCOPE_IDENTITY());
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test A.3 NOT OK')
	ELSE
		PRINT('------------------------------Test A.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test A.4
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 2)
		PRINT('------------------------------Test A.4 OK')
	ELSE
		PRINT('------------------------------Test A.4 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test B.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,'1545');
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test B.2 NOT OK')
	ELSE
		PRINT('------------------------------Test B.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test C.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('mal forme','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT C.1 OK')
	ELSE
		PRINT('------------------------------Test C.1 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.1 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test C.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('12262014 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT C.2 OK')
	ELSE
		PRINT('------------------------------Test C.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test C.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00 ','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT C.3 OK')
	ELSE
		PRINT('------------------------------Test C.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test D.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','mal forme','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT D.1 OK')
	ELSE
		PRINT('------------------------------Test D.1 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.1 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test D.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','12262014 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT D.2 OK')
	ELSE
		PRINT('------------------------------Test D.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test D.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20151520 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT D.3 OK')
	ELSE
		PRINT('------------------------------Test D.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test D.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test E.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20140326 00:00:00','mal forme',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT E.1 OK')
	ELSE
		PRINT('------------------------------Test E.1 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.1 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test E.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20140326 00:00:00','12262014 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT E.2 OK')
	ELSE
		PRINT('------------------------------Test E.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test E.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
	SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20151520 00:00:00','20140326 00:00:00','20151520 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test NOT E.3 OK')
	ELSE
		PRINT('------------------------------Test E.3 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test E.3 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;




--Test F.1
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',0,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test F.1 OK')
	ELSE
		PRINT('------------------------------Test F.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.1 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test F.2
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00','uneExtension',@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test F.2 NOT OK')
	ELSE
		PRINT('------------------------------Test F.2 OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.2 OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;

--Test F.3
BEGIN TRY
	INSERT INTO TypeAbonnement(nom, prix, nb_max_vehicules) VALUES
		('1vehicules', 1, 1);
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
		('Neti', 'Mohamed', '1988-03-26', 'true', 'false', 'LU2800194006447500001234567', 'mohamed.neti@gmail.com', '0607080904');
	INSERT INTO Abonnement(date_debut, duree, renouvellement_auto, nom_typeabonnement, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne) VALUES
		('2014-02-22',  5, 0, '1vehicules',  'Neti', 'Mohamed', '1988-03-26');
		SET @id_Abonnement = SCOPE_IDENTITY();
	INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement)VALUES
		('20140108 00:00:00','20140306 00:00:00','20140326 00:00:00',-13,@id_Abonnement);
	IF (( SELECT COUNT(*)
		FROM ContratLocation) = 1)
		PRINT('------------------------------Test F.3 OK')
	ELSE
		PRINT('------------------------------Test F.3 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test F.3 NOT OK')
END CATCH
DELETE FROM ContratLocation;
DELETE FROM Abonnement;
DELETE FROM CompteAbonne;
DELETE FROM TypeAbonnement;