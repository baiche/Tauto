USE TAuto_IBDR

-----------------------------------------------------------
-- Fichier     : ScriptPeuplementVehicule.sql
-- Date        : 17/02/2014
-- Auteur      : Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script de remplissage de la table Vehicule
--
------------------------------------------------------------

GO

INSERT INTO Vehicule (matricule,kilometrage,couleur,etat,marque_modele,serie_modele,portieres_modele,type_carburant_modele)VALUES
		('0775896wx','18000','Bleu','Louee','Peugeot','206',5,'Diesel'), 
		('0775896we','14000','Bleu','Disponible','Peugeot','206',3,'Essence'),
		('0775896wr','25000','Bleu','Disponible','Peugeot','206',5,'Diesel'),
		('0775896wt','35000','Bleu','Disponible','Peugeot','206',5,'Diesel'), 
		('0775896wy','30000','Bleu','Disponible','Peugeot','206',4,'Essence'), 
		('0775896wu','60000','Bleu','Louee','Peugeot','206',5,'Diesel'), 
		('0775896wi','120000','Bleu','Disponible','Peugeot','206',5,'Diesel')   
		
GO