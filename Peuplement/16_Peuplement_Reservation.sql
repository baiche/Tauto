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
	('2013-05-01', '20130502 08:00:00', '20130531 18:00:00', 1, @idAbonnementTA),
	('2013-06-10', '20130615 10:00:00', '20130625 18:00:00', 1, @idAbonnementTA),
	('2013-06-22', '20130701 09:00:00', '20130715 17:00:00', 1, @idAbonnementTA),
	
	('2014-01-13', '20140114 08:00:00', '20140121 08:00:00', 1, @idAbonnementBoris),
	('2014-01-20', '20140121 08:00:00', '20140123 12:00:00', 1, @idAbonnementBoris),
	
	('2014-02-24', '20140325 08:00:00', '20140404 17:00:00', 0, @idAbonnementBoris),
	('2014-02-03', '20140406 13:00:00', '20140410 18:00:00', 0, @idAbonnementBoris),
	
	('2014-03-01', '20140407 10:00:00', '20140424 18:00:00', 0, @PIndustrie),
	('2014-03-06', '20140506 10:00:00', '20140508 18:00:00', 0, @PIndustrie),
	('2014-03-08', '20140601 09:00:00', '20140613 17:00:00', 1, @PIndustrie),
	('2014-03-08', '20140711 09:00:00', '20140922 17:00:00', 0, @PIndustrie),
	('2014-03-01', '20141105 08:00:00', '20141105 16:00:00', 0, @PIndustrie);
	
	-- In progress
	