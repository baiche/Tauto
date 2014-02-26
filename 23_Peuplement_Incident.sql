------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables :
--				-Incident
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--Incident
------------------------------------------------

INSERT INTO Incident(date, id_location, description, penalisable)
VALUES ('20140304 00:00:00',5,'crevaison',0),--5
('20140310 00:00:00',5,'injure au vendeur',1),--5
('20121231 00:00:00',5,'crevaison',0);--6




