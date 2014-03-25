 ------------------------------------------------------------
-- Fichier     : 22_Peuplement_Reservation.sql
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables Reservation
                 
------------------------------------------------------------

USE TAuto_IBDR
GO

-- preparation :

DECLARE @idAbonnementTA int, @PIndustrie int, @idAbonnementBoris int, @idAbonnementAlexis int;

SELECT @idAbonnementBoris = id
FROM Abonnement
WHERE nom_compteabonne = 'De Finance'; -- renouvellement auto

SELECT @idAbonnementAlexis = id
FROM Abonnement
WHERE nom_compteabonne = 'Deluze' AND date_debut = '2014-03-03'; -- pas de renouvellement auto

SELECT @PIndustrie = id
FROM Abonnement
WHERE nom_compteabonne = 'PIndustrie' AND date_debut = '2014-03-10'; -- renouvellement auto

SELECT @idAbonnementTA = id
FROM Abonnement
WHERE nom_compteabonne = 'TASociety' AND date_debut = '2014-03-15'; -- renouvellement auto

-- peuplement :

INSERT INTO Reservation
	(date_creation, date_debut, date_fin, annule, id_abonnement)
VALUES
	('2013-05-01', '2013-05-02T08:00:00', '2013-05-31T18:00:00', 1, @idAbonnementTA), -- 1
	('2013-06-10', '2013-06-15T10:00:00', '2013-06-25T18:00:00', 1, @idAbonnementTA), -- 2
	('2013-06-22', '2013-07-01T09:00:00', '2013-07-15T17:00:00', 1, @idAbonnementTA), -- 3
	
	('2014-01-13', '2014-01-14T08:00:00', '2014-01-21T08:00:00', 1, @idAbonnementBoris), -- 4
	('2014-01-20', '2014-01-21T08:00:00', '2014-01-23T12:00:00', 1, @idAbonnementBoris), -- 5
	
	('2014-02-03', '2014-04-06T13:00:00', '2014-04-10T18:00:00', 0, @idAbonnementBoris), -- 6
	('2014-02-24', '2014-04-28T08:00:00', '2014-05-05T17:00:00', 0, @idAbonnementBoris), -- 7
	
	('2014-03-01', '2014-04-07T10:00:00', '2014-04-24T18:00:00', 0, @PIndustrie), -- 8
	('2014-03-06', '2014-05-06T10:00:00', '2014-05-08T18:00:00', 0, @PIndustrie), -- 9
	('2014-03-08', '2014-06-01T09:00:00', '2014-06-13T17:00:00', 1, @PIndustrie), -- 10
	('2014-03-08', '2014-07-11T09:00:00', '2014-09-22T17:00:00', 0, @PIndustrie), -- 11
	('2014-03-01', '2014-11-05T08:00:00', '2014-11-05T16:00:00', 0, @PIndustrie), -- 12
	
	('2014-03-04', '2014-03-05T08:00:00', '2014-03-06T16:00:00', 0, @idAbonnementAlexis), -- 13
	
	('2014-03-08', '2014-12-01T09:00:00', '2014-12-22T17:00:00', 0, @PIndustrie), -- 14
	('2014-03-10', '2014-11-05T08:00:00', '2014-12-05T16:00:00', 0, @idAbonnementAlexis), -- 15
	('2014-02-24', '2014-11-28T08:00:00', '2014-12-05T17:00:00', 0, @idAbonnementBoris); -- 16
	
	-- In progress
	