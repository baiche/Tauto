------------------------------------------------------------
-- Fichier     : ScriptPeuplementBoris
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : 
-- Commentaire : Remplissage des tables :
--				-Retard
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--Retard
------------------------------------------------

INSERT INTO Retard(date, id_location, regle, niveau)
VALUES ('2014-03-04',5,0,1),--5
('2014-03-10',5,1,2),--5
('2012-12-31',5,0,3);--6

