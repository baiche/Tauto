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
VALUES ('2014-03-04',5,'crevaison',0),--5
('2014-03-10',5,'injure au vendeur',1),--5
('2012-12-31',5,'crevaison',0);--6




