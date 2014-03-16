 ------------------------------------------------------------
-- Fichier     : 22_Peuplement_Reservation.sql
-- Date        : 20/02/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ahmed Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables Reservation
                 
------------------------------------------------------------

USE TAuto_IBDR
GO

-- preparation :

DECLARE @idAbonnementTA int, @PIndustrie int, @idAbonnementBoris int;

SELECT @idAbonnementBoris = id
FROM Abonnement
WHERE nom_compteabonne = 'De Finance';

SELECT @PIndustrie = id
FROM Abonnement
WHERE nom_compteabonne = 'PIndustrie' AND date_debut = '2014-03-10';

SELECT @idAbonnementTA = id
FROM Abonnement
WHERE nom_compteabonne = 'TASociety' AND date_debut = '2014-03-15';

-- peuplement :

INSERT INTO Reservation
	(date_creation, date_debut, date_fin, annule, id_abonnement)
VALUES
	('2013-05-01', '2013-05-02T08:00:00', '2013-05-31T18:00:00', 1, @idAbonnementTA),
	('2013-06-10', '2013-06-15T10:00:00', '2013-06-25T18:00:00', 1, @idAbonnementTA),
	('2013-06-22', '2013-07-01T09:00:00', '2013-07-15T17:00:00', 1, @idAbonnementTA),
	
	('2014-01-13', '2014-01-14T08:00:00', '2014-01-21T08:00:00', 1, @idAbonnementBoris),
	('2014-01-20', '2014-01-21T08:00:00', '2014-01-23T12:00:00', 1, @idAbonnementBoris),
	
	('2014-02-03', '2014-04-06T13:00:00', '2014-04-10T18:00:00', 0, @idAbonnementBoris),
	('2014-02-24', '2014-04-28T08:00:00', '2014-05-05T17:00:00', 0, @idAbonnementBoris),
	
	('2014-03-01', '2014-04-07T10:00:00', '2014-04-24T18:00:00', 0, @PIndustrie),
	('2014-03-06', '2014-05-06T10:00:00', '2014-05-08T18:00:00', 0, @PIndustrie),
	('2014-03-08', '2014-06-01T09:00:00', '2014-06-13T17:00:00', 1, @PIndustrie),
	('2014-03-08', '2014-07-11T09:00:00', '2014-09-22T17:00:00', 0, @PIndustrie),
	('2014-03-01', '2014-11-05T08:00:00', '2014-11-05T16:00:00', 0, @PIndustrie);
	
	-- In progress
	