------------------------------------------------------------
-- Fichier     : ScriptGeneration
-- Date        : 15/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;



---------------------------------
-- Création des tables-entités --
---------------------------------

CREATE TABLE Catalogue(
	nom 				nvarchar(50) 	PRIMARY KEY										CHECK(nom LIKE '[a-zA-Z ‘-]*'),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(),
	date_fin 			date
);


CREATE TABLE Categorie(
	nom					nvarchar(50) 	PRIMARY KEY										CHECK(nom LIKE '[a-zA-Z ‘-]*'),
	description 		nvarchar(50) 					NOT NULL						CHECK(description LIKE '[a-zA-Z ‘-,.]*'),
	nom_typepermis 		nvarchar(10) 					NOT NULL --c'est un enum
); 


CREATE TABLE Modele(
	marque 				nvarchar(50)													CHECK(marque LIKE '[a-zA-Z0-9 ‘-]*'),
	serie 				nvarchar(50)													CHECK(serie LIKE '[a-zA-Z0-9 ‘-]*'),
	type_carburant 		nvarchar(50) 					NOT NULL						CHECK(type_carburant LIKE '[a-zA-Z0-9 ‘-]*'), --c'est un enum
	annee 				int,
	prix 				money 							NOT NULL,
	reduction 			tinyint										DEFAULT 0			CHECK(reduction >= 0 AND reduction < 100),
	portieres 			tinyint 						NOT NULL 	DEFAULT 5,
	PRIMARY KEY(marque, serie, type_carburant, portieres)
);

CREATE TABLE SousPermis(
	nom_typepermis 		nvarchar(10) 					NOT NULL, --c'est un enum
	numero_permis 		nvarchar(50),
	date_obtention 		date 							NOT NULL,
	date_expiration 	date 							NOT NULL,
	periode_probatoire 	tinyint 						NOT NULL 	DEFAULT 3,
	PRIMARY KEY(nom_typepermis, numero_permis)
);

CREATE TABLE Permis(
	numero 				nvarchar(50) 	PRIMARY KEY										CHECK(numero LIKE '[a-zA-Z0-9]*'),
	valide 				bit 										DEFAULT 'true',
	points_estimes 		tinyint 						NOT NULL 	DEFAULT 12
);

CREATE TABLE Vehicule(
	matricule 			nvarchar(50) 	PRIMARY KEY										CHECK(matricule LIKE '[a-zA-Z0-9-]*'),
	kilometrage 		int 							NOT NULL 	DEFAULT 0,
	couleur 			nvarchar(50) 					NOT NULL 	DEFAULT ''			CHECK(couleur LIKE '[a-zA-Z -]*'), --c'est un enum
	statut 				nvarchar(50) 					NOT NULL 	DEFAULT 'Disponible' CHECK(statut LIKE '[a-zA-Z ''-]*'), --c'est un enum
	num_serie			nvarchar(50)					NOT NULL						CHECK(num_serie LIKE '[a-zA-Z0-9]*'),
	marque_modele 		nvarchar(50) 					NOT NULL,
	serie_modele 		nvarchar(50) 					NOT NULL,
	portieres_modele 	tinyint 						NOT NULL,
	type_carburant_modele nvarchar(50) 					NOT NULL --c'est un enum
);

CREATE TABLE Reservation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_creation 		date 							NOT NULL,
	date_debut datetime 								NOT NULL,
	date_fin datetime 									NOT NULL, 
	annule 				bit 										DEFAULT 'false',
	matricule_vehicule 	nvarchar(50),
	id_abonnement 		int
);

CREATE TABLE Abonnement(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(),
	duree 				int 							NOT NULL 	DEFAULT 1,
	renouvellement_auto bit 										DEFAULT 'false',
	nom_typeabonnement 	nvarchar(50),
	nom_compteabonne 	nvarchar(50),
	prenom_compteabonne nvarchar(50),
	date_naissance_compteabonne date
);

CREATE TABLE CompteAbonne(
	nom 				nvarchar(50)														CHECK(nom LIKE '[a-zA-Z ''-]*'),
	prenom 				nvarchar(50)														CHECK(prenom LIKE '[a-zA-Z ''-]*'),
	date_naissance 		date,
	actif				bit 							NOT NULL 	DEFAULT 'true',
	liste_grise 		bit 							NOT NULL 	DEFAULT 'false',
	iban 				char(25) 						NOT NULL							CHECK(iban LIKE '[A-Z](2)[0-9](25)'),
	courriel 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK(courriel LIKE '[a-z]+[@][a-z]+[.][a-z]+'),
	telephone 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK(telephone LIKE '[0-9](10)'),
	PRIMARY KEY(nom, prenom, date_naissance)
);

CREATE TABLE Entreprise(
	siret 				char(14) 						NOT NULL 	DEFAULT ''				CHECK(siret LIKE '[0-9](14)'),
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK(nom LIKE '[a-zA-Z ''-]*'),
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);

CREATE TABLE Particulier(
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);

CREATE TABLE TypeAbonnement(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK(nom LIKE '[a-zA-Z]*'),
	prix 				money 							NOT NULL 	DEFAULT 0, --j'ai changé le type, dans le dictionnaire c'est un entier
	nb_max_vehicules 	int 										DEFAULT 1
);

CREATE TABLE Location(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	matricule_vehicule 	nvarchar(50),
	id_facturation 		int,
	date_etat_avant 	datetime,
	date_etat_apres 	datetime,
	id_contratLocation 	int
);

CREATE TABLE Facturation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	numero_location 	int 							NOT NULL,
	date_creation 		date 							NOT NULL 	DEFAULT GETDATE(),
	date_reception 		date,
	montant money 										NOT NULL
);

CREATE TABLE Etat(
	date_creation 		datetime 									DEFAULT GETDATE(),
	id_location 		int,
	km 					int 							NOT NULL 	DEFAULT 0,
	degat 				bit 							NOT NULL,
	fiche 				nvarchar(50) 					NOT NULL							CHECK(fiche LIKE '[a-zA-Z0-9]*'),
	PRIMARY KEY(date_creation, id_location)
);

CREATE TABLE ContratLocation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			datetime 						NOT NULL,
	date_fin 			datetime 						NOT NULL,
	date_fin_effective 	datetime,
	extension 			int,
	id_abonnement 		int
);

CREATE TABLE Conducteur(
	piece_identite 		nvarchar(50)														CHECK(piece_identite LIKE '[a-zA-Z0-9]*'),
	nationalite 		nvarchar(50) 					NOT NULL							CHECK(nationalite LIKE '[a-zA-Z ‘-]*'),
	nom 				nvarchar(50) 					NOT NULL							CHECK(nom LIKE '[a-zA-Z ‘-]*'),
	prenom 				nvarchar(50) 					NOT NULL							CHECK(prenom LIKE '[a-zA-Z ‘-]*'),
	id_permis 			nvarchar(50)
	PRIMARY KEY(piece_identite, nationalite)
);

CREATE TABLE Infraction(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK(nom LIKE '[a-zA-Z ‘-]*'),
	montant 			money 							NOT NULL 	DEFAULT 0,
	description 		nvarchar(50)					NOT NULL 	DEFAULT ''				CHECK(description LIKE '[a-zA-Z ‘-.]*'),
	regle 				bit 										DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);

CREATE TABLE Incident(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	description 		nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK(description LIKE '[a-zA-Z ‘-.]*'),
	penalisable 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);

CREATE TABLE Retard(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	regle 				bit 										DEFAULT 'false',
	niveau 				tinyint 									DEFAULT 1,
	PRIMARY KEY(date, id_location)
);

CREATE TABLE RelanceDecouvert(
	date 				datetime 									DEFAULT GETDATE(),
	nom_compteabonne 	nvarchar(50),
	prenom_compteabonne nvarchar(50),
	date_naissance_compteabonne date,
	niveau 				tinyint 						NOT NULL 	DEFAULT 0				CHECK(niveau >= 0 AND niveau <= 5),
	PRIMARY KEY(date, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
);

CREATE TABLE ListeNoire(
	date_naissance 		date,
	nom 				nvarchar(50)														CHECK(nom LIKE '[a-zA-Z ‘-]*'),
	prenom 				nvarchar(50)														CHECK(prenom LIKE '[a-zA-Z ‘-]*'),
	PRIMARY KEY(date_naissance, nom, prenom)
); 



-----------------------------------
-- Ajout des tables-énumérations --
-----------------------------------

CREATE TABLE TypePermis
	(nom nvarchar(10) PRIMARY KEY CHECK(nom IN('A1', 'A2', 'B', 'C', 'D', 'E', 'F')));

CREATE TABLE TypeCarburant
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Essence', 'Diesel')));

CREATE TABLE Nationalite
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Français', 'Anglais')));

CREATE TABLE CouleurVehicule
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Bleu', 'Blanc', 'Rouge')));

CREATE TABLE StatutVehicule
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Disponible', 'Louee', 'En panne')));



-----------------------------
-- Ajout des associations  --
-----------------------------

CREATE TABLE CatalogueCategorie(
	nom_catalogue 		nvarchar(50) REFERENCES Catalogue(nom),
	nom_categorie 		nvarchar(50) REFERENCES  Categorie(nom),
	PRIMARY KEY(nom_catalogue, nom_categorie)
);

CREATE TABLE CategorieModele(
	marque_modele 					nvarchar(50),
	serie_modele 					nvarchar(50),
	type_carburant_modele 			nvarchar(50),
	portieres_modele 				tinyint,
	nom_categorie 					nvarchar(50),
	PRIMARY KEY(marque_modele,serie_modele,type_carburant_modele, portieres_modele, nom_categorie),
	
	FOREIGN KEY(marque_modele,serie_modele,type_carburant_modele, portieres_modele) 
		REFERENCES Modele(marque,serie,type_carburant, portieres),
	FOREIGN KEY(nom_categorie)
		REFERENCES Categorie(nom)
);

CREATE TABLE ConducteurLocation(
	id_location 					int,
	piece_identite_conducteur 		nvarchar(50),
	nationalite_conducteur 			nvarchar(50),
	PRIMARY KEY(id_location, piece_identite_conducteur, nationalite_conducteur),
	
	FOREIGN KEY(id_location)
		REFERENCES Location(id),
	FOREIGN KEY(piece_identite_conducteur,nationalite_conducteur) 
		REFERENCES Conducteur(piece_identite, nationalite)
);

CREATE TABLE CompteAbonneConducteur(
	nom_compteabonne 				nvarchar(50),
	prenom_compteabonne 			nvarchar(50),
	date_naissance_compteabonne 	date,
	nationalite_conducteur 			nvarchar(50),
	piece_identite_conducteur 		nvarchar(50),
	PRIMARY KEY(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne,nationalite_conducteur,piece_identite_conducteur),
	
	FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance),
	FOREIGN KEY(nationalite_conducteur,piece_identite_conducteur) 
		REFERENCES Conducteur(piece_identite,nationalite)
);

ALTER TABLE Entreprise
	ADD FOREIGN KEY (nom_compte, prenom_compte, date_naissance_compte)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);

ALTER TABLE Particulier
	ADD FOREIGN KEY(nom_compte, prenom_compte, date_naissance_compte)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);

ALTER TABLE Categorie
	ADD FOREIGN KEY(nom_typepermis)
		REFERENCES TypePermis(nom);

ALTER TABLE Modele
	ADD FOREIGN KEY(type_carburant)
		REFERENCES TypeCarburant(nom);

ALTER TABLE SousPermis
	ADD FOREIGN KEY(nom_typepermis)
		REFERENCES TypePermis(nom);

ALTER TABLE SousPermis
	ADD FOREIGN KEY(numero_permis)
		REFERENCES Permis(numero);

ALTER TABLE Vehicule
	ADD FOREIGN KEY(marque_modele, serie_modele, type_carburant_modele, portieres_modele) 
		REFERENCES Modele(marque, serie, type_carburant, portieres);

ALTER TABLE Vehicule
	ADD FOREIGN KEY(couleur)
		REFERENCES CouleurVehicule(nom);

ALTER TABLE Reservation
	ADD FOREIGN KEY(matricule_vehicule)
		REFERENCES Vehicule(matricule);

ALTER TABLE Reservation
	ADD FOREIGN KEY (id_abonnement)
		REFERENCES Abonnement(id);

ALTER TABLE Abonnement
	ADD FOREIGN KEY(nom_typeabonnement)
		REFERENCES TypeAbonnement(nom);

ALTER TABLE Abonnement
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);

ALTER TABLE Location
	ADD FOREIGN KEY(matricule_vehicule)
		REFERENCES Vehicule(matricule);

ALTER TABLE Location
	ADD FOREIGN KEY(id_facturation)
		REFERENCES Facturation(id);

ALTER TABLE Location
	ADD FOREIGN KEY(date_etat_avant,id)
		REFERENCES Etat(date_creation,id_location);

ALTER TABLE Location
	ADD FOREIGN KEY(date_etat_apres,id)
		REFERENCES Etat(date_creation,id_location);

ALTER TABLE Location
	ADD FOREIGN KEY(id_contratLocation)
		REFERENCES  ContratLocation(id);

ALTER TABLE ContratLocation
	ADD FOREIGN KEY(id_abonnement)
		REFERENCES Abonnement(id)

ALTER TABLE Conducteur
	ADD FOREIGN KEY(id_permis)
		REFERENCES Permis(numero);

ALTER TABLE Conducteur
	ADD FOREIGN KEY(nationalite)
		REFERENCES Nationalite(nom);

ALTER TABLE Infraction
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);

ALTER TABLE Incident
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);

ALTER TABLE Retard
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);

ALTER TABLE RelanceDecouvert
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);

