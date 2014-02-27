------------------------------------------------------------
-- Fichier     : 21_Peuplement_Retard.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Retard
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--Retard
------------------------------------------------

INSERT INTO Retard(date, id_location, regle, niveau)
VALUES ('20140304 00:00:00',5,0,1),--5
('20140310 00:00:00',5,1,2),--5
('20121231 00:00:00',5,0,3);--6

