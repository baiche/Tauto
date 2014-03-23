------------------------------------------------------------
-- Fichier     : 23_Peuplement_Incident.sql
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-Incident
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--Incident
------------------------------------------------

INSERT INTO Incident(date, id_location, description, penalisable)
VALUES ('20140304 00:00:00',5,'crevaison',0),--5
('2014-03-10T00:00:00',5,'injure au vendeur',1),--5
('2012-12-31T00:00:00',5,'crevaison',0),--6
('2014-03-25T08:58:45', 13, 'crevaison', 0),
('2014-03-21T14:42:23', 14, 'injure', 1);




