------------------------------------------------------------
-- Fichier     : 26_Peuplement_RelanceDecouvert.sql
-- Date        : 26/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     :
-- Integrateur : Boris de Finance
-- Commentaire : Remplissage des tables :
--				-RelanceDecouvert
------------------------------------------------------------

USE TAuto_IBDR
------------------------------------------------
--RelanceDecouvert
------------------------------------------------

INSERT INTO RelanceDecouvert(date, nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne,niveau)
VALUES ('20140226 10:00:00','PIndustrie','PIndustrie','2014-02-17',2),
('20140226 11:00:00','Lecoconier', 'David', '1990-02-02',1),
('20140226 12:00:00','De Finance', 'Boris', '1990-09-08',0);
