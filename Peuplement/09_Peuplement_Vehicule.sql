-----------------------------------------------------------
-- Fichier     : 15_Peuplement_Vehicule.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : Boris de Finance
-- Commentaire : Script de remplissage de la table Vehicule
--
------------------------------------------------------------

USE TAuto_IBDR


INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('0775896wx','18000','Bleu','En panne','VF3 8C4HXF 81100000','Peugeot','406',5,'Diesel','false'), 
		('0775896we','14000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','406',5,'Essence','false'),
		('0775896wr','25000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','406',5,'Diesel','false'),
		('0775896wt','35000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false'), 
		('0775896wy','30000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',3,'Essence','false'), 
		('0775896wu','60000','Bleu','Perdue','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false'), 
		('0775896wi','120000','Bleu','Disponible','VF3 8C4HXF 81100000','Peugeot','206',5,'Diesel','false'),	
		-- ajouts pour la recherche : BMW Noires
		('1775896wx','18000','Noir','En panne','ABS X0988 150','BMW','5 F10 M5',5,'Diesel','false'), 
		('1775896we','14000','Noir','Disponible','ABS X0988 151','BMW','5 F10 M5',5,'Diesel','false'),
		('1775896wr','25000','Noir','Disponible','ABS X0988 152','BMW','5 F10 M5',5,'Diesel','false'),
		('1775896wt','35000','Noir','Disponible','ABS X0988 153','BMW','5 F10 M5',5,'Diesel','false'), 
		('1775896wy','30000','Noir','Disponible','ABS X0988 154','BMW','5 F10 M5',5,'Essence','false'), 
		('1775896wu','60000','Noir','Perdue','ABS X0988 155','BMW','5 F10 M5',5,'Essence','false'), 
		('1775896wi','120000','Noir','Disponible','ABS X0988 156','BMW','5 F10 M5',5,'Essence','false');   	
GO
