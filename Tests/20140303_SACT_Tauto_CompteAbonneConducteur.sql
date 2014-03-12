------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CompteAbonneConducteur.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table CompteAbonneConducteur
------------------------------------------------------------

SET NOCOUNT ON

USE Tauto_IBDR;


DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test A.1, B.1, C.1, D.1, E.1
BEGIN TRY
	INSERT INTO Permis(numero, valide, points_estimes) VALUES
	('0000000002', 'true', 12);
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
		
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
			'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'Francais', '987654321');
	
	IF (( SELECT COUNT(*)
		FROM CompteAbonneConducteur
		WHERE nom_compteabonne = 'TASociety'
			AND prenom_compteabonne = 'TASociety'
			AND date_naissance_compteabonne = '2014-02-24'
			AND nationalite_conducteur = 'Francais'
			AND piece_identite_conducteur = '987654321'
			) = 1)
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT -- OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test A.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASoety', 'TASociety', '2014-02-24', 'Francais', '987654321');
		
	PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test B.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TSoety', '2014-02-24', 'Francais', '987654321');
		
	PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test C.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-12-24', 'Francais', '987654321');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test D.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'Britannique', '987654321');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

--Test E.2
BEGIN TRY
	INSERT INTO Conducteur(piece_identite, nationalite, nom, prenom, id_permis) VALUES
		('987654321', 'Francais', 'le Coco', 'David', '0000000002');
	INSERT INTO CompteAbonne(nom,prenom,date_naissance,a_supprimer,liste_grise,iban,courriel,telephone) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'true', 
		'false', 'AL47 2121 1009 0000 0002 3569 8741', 'ta_society@hotmail.fr', '0506038405');
	INSERT INTO Entreprise(siret,nom,nom_compte,prenom_compte,date_naissance_compte) VALUES
		('843 930 431', 'TASociety','TASociety','TASociety','2014-02-24');
		
	INSERT INTO CompteAbonneConducteur(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne, nationalite_conducteur, piece_identite_conducteur) VALUES
		('TASociety', 'TASociety', '2014-02-24', 'Francais', '123456789');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CompteAbonneConducteur;
DELETE FROM Entreprise;
DELETE FROM CompteAbonne;
DELETE FROM Conducteur;
DELETE FROM Permis;

SET NOCOUNT OFF