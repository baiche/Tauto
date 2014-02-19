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

PRINT('Script de génération de la base
')


---------------------------------
-- Création des tables-entités --
--------------------------------- 
PRINT('Création des tables');

GO
CREATE TABLE Catalogue(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK( LEN (nom) > 1),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(),
	date_fin 			date
);
PRINT('Table Catalogue créée');

GO
CREATE TABLE Categorie(
	nom					nvarchar(50) 	PRIMARY KEY											CHECK( LEN (nom) > 1),
	description 		nvarchar(50) 					NOT NULL							CHECK( LEN (description) > 1),
	nom_typepermis 		nvarchar(10) 					NOT NULL --c'est un enum
); 
PRINT('Table Catégorie créée');

GO
CREATE TABLE Modele(
	marque 				nvarchar(50)														CHECK( LEN (marque) > 1),
	serie 				nvarchar(50)														CHECK( LEN (serie) > 1),
	type_carburant 		nvarchar(50) 					NOT NULL, --c'est un enum
	annee 				int,
	prix 				money 							NOT NULL,
	reduction 			tinyint										DEFAULT 0				CHECK(reduction >= 0 AND reduction < 100),
	portieres 			tinyint 						NOT NULL 	DEFAULT 5,
	PRIMARY KEY(marque, serie, type_carburant, portieres)
);
PRINT('Table Modele créée');

GO
CREATE TABLE SousPermis(
	nom_typepermis 		nvarchar(10) 					NOT NULL, --c'est un enum
	numero_permis 		nvarchar(50),
	date_obtention 		date 							NOT NULL,
	date_expiration 	date 							NOT NULL,
	periode_probatoire 	tinyint 						NOT NULL 	DEFAULT 3,
	PRIMARY KEY(nom_typepermis, numero_permis)
);
PRINT('Table SousPermis créée');

GO
CREATE TABLE Permis(
	numero 				nvarchar(50) 	PRIMARY KEY											CHECK( LEN (numero) > 1),
	valide 				bit 										DEFAULT 'true',
	points_estimes 		tinyint 						NOT NULL 	DEFAULT 12
);
PRINT('Table Permis créée');

GO
CREATE TABLE Vehicule(
	matricule 			nvarchar(50) 	PRIMARY KEY											CHECK( LEN (matricule) > 1),
	kilometrage 		int 							NOT NULL 	DEFAULT 0,
	couleur 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( LEN (couleur) > 1), --c'est un enum
	statut 				nvarchar(50) 					NOT NULL 	DEFAULT 'Disponible'	CHECK( LEN (statut) > 1), --c'est un enum
	num_serie			nvarchar(50)					NOT NULL							CHECK( LEN (num_serie) > 1),
	marque_modele 		nvarchar(50) 					NOT NULL,
	serie_modele 		nvarchar(50) 					NOT NULL,
	portieres_modele 	tinyint 						NOT NULL,
	type_carburant_modele nvarchar(50) 					NOT NULL --c'est un enum
);
PRINT('Table Vehicule créée');

GO
CREATE TABLE Reservation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_creation 		date 							NOT NULL,
	date_debut datetime 								NOT NULL,
	date_fin datetime 									NOT NULL, 
	annule 				bit 										DEFAULT 'false',
	matricule_vehicule 	nvarchar(50),
	id_abonnement 		int
);
PRINT('Table Reservation créée');

GO
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
PRINT('Table Abonnement créée');

GO
CREATE TABLE CompteAbonne(
	nom 				nvarchar(50)														CHECK( LEN (nom) > 1),
	prenom 				nvarchar(50)														CHECK( LEN (prenom) > 1),
	date_naissance 		date,
	actif				bit 							NOT NULL 	DEFAULT 'true',
	liste_grise 		bit 							NOT NULL 	DEFAULT 'false',
	iban 				char(25) 						NOT NULL							CHECK( LEN (iban) = 25),
	courriel 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK(courriel LIKE '%@%.%'),
	telephone 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( LEN (telephone) > 1),
	PRIMARY KEY(nom, prenom, date_naissance)
);
PRINT('Table CompteAbonne créée');

GO
CREATE TABLE Entreprise(
	siret 				char(14) 						NOT NULL 	DEFAULT ''				CHECK( LEN (siret) > 1),
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( LEN (nom) > 1),
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);
PRINT('Table Entreprise créée');

GO
CREATE TABLE Particulier(
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);
PRINT('Table Particulier créée');

GO
CREATE TABLE TypeAbonnement(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK( LEN (nom) > 1),
	prix 				money 							NOT NULL 	DEFAULT 0, --j'ai changé le type, dans le dictionnaire c'est un entier
	nb_max_vehicules 	int 										DEFAULT 1
);
PRINT('Table TypeAbonnement créée');

GO
CREATE TABLE Location(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	matricule_vehicule 	nvarchar(50),
	id_facturation 		int,
	date_etat_avant 	datetime,
	date_etat_apres 	datetime,
	id_contratLocation 	int
);
PRINT('Table Location créée');

GO
CREATE TABLE Facturation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	numero_location 	int 							NOT NULL,
	date_creation 		date 							NOT NULL 	DEFAULT GETDATE(),
	date_reception 		date,
	montant money 										NOT NULL
);
PRINT('Table Facturation créée');

GO
CREATE TABLE Etat(
	date_creation 		datetime 									DEFAULT GETDATE(),
	id_location 		int,
	km 					int 							NOT NULL 	DEFAULT 0,
	degat 				bit 							NOT NULL,
	fiche 				nvarchar(50) 					NOT NULL							CHECK( LEN (fiche) > 1),
	PRIMARY KEY(date_creation, id_location)
);
PRINT('Table Etat créée');

GO
CREATE TABLE ContratLocation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			datetime 						NOT NULL,
	date_fin 			datetime 						NOT NULL,
	date_fin_effective 	datetime,
	extension 			int,
	id_abonnement 		int
);
PRINT('Table ContratLocation créée');

GO
CREATE TABLE Conducteur(
	piece_identite 		nvarchar(50)														CHECK( LEN (piece_identite) > 1),
	nationalite 		nvarchar(50) 					NOT NULL							CHECK( LEN (nationalite) > 1),
	nom 				nvarchar(50) 					NOT NULL							CHECK( LEN (nom) > 1),
	prenom 				nvarchar(50) 					NOT NULL							CHECK( LEN (prenom) > 1),
	id_permis 			nvarchar(50)
	PRIMARY KEY(piece_identite, nationalite)
);
PRINT('Table Conducteur créée');

GO
CREATE TABLE Infraction(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( LEN (nom) > 1),
	montant 			money 							NOT NULL 	DEFAULT 0,
	description 		nvarchar(50)					NOT NULL 	DEFAULT ''				CHECK( LEN (description) > 1),
	regle 				bit 										DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);
PRINT('Table Infraction créée');

GO
CREATE TABLE Incident(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	description 		nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( LEN (description) > 1),
	penalisable 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);
PRINT('Table Incident créée');

GO
CREATE TABLE Retard(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	regle 				bit 										DEFAULT 'false',
	niveau 				tinyint 									DEFAULT 1,
	PRIMARY KEY(date, id_location)
);
PRINT('Table Retard créée');

GO
CREATE TABLE RelanceDecouvert(
	date 				datetime 									DEFAULT GETDATE(),
	nom_compteabonne 	nvarchar(50),
	prenom_compteabonne nvarchar(50),
	date_naissance_compteabonne date,
	niveau 				tinyint 						NOT NULL 	DEFAULT 0				CHECK(niveau >= 0 AND niveau <= 5),
	PRIMARY KEY(date, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
);
PRINT('Table RelanceDecouvert créée');

GO
CREATE TABLE ListeNoire(
	date_naissance 		date,
	nom 				nvarchar(50)														CHECK( LEN (nom) > 1),
	prenom 				nvarchar(50)														CHECK( LEN (prenom) > 1),
	PRIMARY KEY(date_naissance, nom, prenom)
); 
PRINT('Table ListeNoire créée');



-----------------------------------
-- Ajout des tables-énumérations --
-----------------------------------
GO
CREATE TABLE TypePermis
	(nom nvarchar(10) PRIMARY KEY CHECK(nom IN('A1', 'A2', 'B', 'C', 'D', 'E', 'F')));
PRINT('Table TypePermis créée');

GO
CREATE TABLE TypeCarburant
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Essence', 'Diesel')));
PRINT('Table TypeCarburant créée');

GO
CREATE TABLE Nationalite
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Français', 'Anglais')));
PRINT('Table Nationalite créée');

GO
CREATE TABLE CouleurVehicule
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Bleu', 'Blanc', 'Rouge')));
PRINT('Table CouleurVehicule créée');

GO
CREATE TABLE StatutVehicule
	(nom nvarchar(50) PRIMARY KEY CHECK(nom IN('Disponible', 'Louee', 'En panne')));
PRINT('Table StatutVehicule créée');


-----------------------------
-- Ajout des associations  --
-----------------------------
PRINT('
Création des associations');
GO
CREATE TABLE CatalogueCategorie(
	nom_catalogue 		nvarchar(50) REFERENCES Catalogue(nom),
	nom_categorie 		nvarchar(50) REFERENCES  Categorie(nom),
	PRIMARY KEY(nom_catalogue, nom_categorie)
);
PRINT('Table CatalogueCategorie créée');

GO
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
PRINT('Table CategorieModele créée');

GO
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
PRINT('Table ConducteurLocation créée');

GO
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
PRINT('Table CompteAbonneConducteur créée');

GO
ALTER TABLE Entreprise
	ADD FOREIGN KEY (nom_compte, prenom_compte, date_naissance_compte)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);
PRINT('Table Entreprise modifiée');

GO
ALTER TABLE Particulier
	ADD FOREIGN KEY(nom_compte, prenom_compte, date_naissance_compte)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);
PRINT('Table Particulier modifiée');

GO
ALTER TABLE Categorie
	ADD FOREIGN KEY(nom_typepermis)
		REFERENCES TypePermis(nom);
PRINT('Table Categorie modifiée');

GO
ALTER TABLE Modele
	ADD FOREIGN KEY(type_carburant)
		REFERENCES TypeCarburant(nom);
PRINT('Table Modele modifiée');

GO
ALTER TABLE SousPermis
	ADD FOREIGN KEY(nom_typepermis)
		REFERENCES TypePermis(nom);
PRINT('Table SousPermis modifiée');

GO
ALTER TABLE SousPermis
	ADD FOREIGN KEY(numero_permis)
		REFERENCES Permis(numero);
PRINT('Table SousPermis modifiée');

GO
ALTER TABLE Vehicule
	ADD FOREIGN KEY(marque_modele, serie_modele, type_carburant_modele, portieres_modele) 
		REFERENCES Modele(marque, serie, type_carburant, portieres);
PRINT('Table Vehicule modifiée');

GO
ALTER TABLE Vehicule
	ADD FOREIGN KEY(couleur)
		REFERENCES CouleurVehicule(nom);
PRINT('Table Vehicule modifiée');

GO
ALTER TABLE Reservation
	ADD FOREIGN KEY(matricule_vehicule)
		REFERENCES Vehicule(matricule);
PRINT('Table Reservation modifiée');

GO
ALTER TABLE Reservation
	ADD FOREIGN KEY (id_abonnement)
		REFERENCES Abonnement(id);
PRINT('Table Reservation modifiée');

GO
ALTER TABLE Abonnement
	ADD FOREIGN KEY(nom_typeabonnement)
		REFERENCES TypeAbonnement(nom);
PRINT('Table Abonnement modifiée');

GO
ALTER TABLE Abonnement
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);
PRINT('Table Abonnement modifiée');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(matricule_vehicule)
		REFERENCES Vehicule(matricule);
PRINT('Table Location modifiée');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(id_facturation)
		REFERENCES Facturation(id);
PRINT('Table Location modifiée');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(date_etat_avant,id)
		REFERENCES Etat(date_creation,id_location);
PRINT('Table Location modifiée');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(date_etat_apres,id)
		REFERENCES Etat(date_creation,id_location);
PRINT('Table Location modifiée');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(id_contratLocation)
		REFERENCES  ContratLocation(id);
PRINT('Table Location modifiée');

GO
ALTER TABLE ContratLocation
	ADD FOREIGN KEY(id_abonnement)
		REFERENCES Abonnement(id)
PRINT('Table ContratLocation modifiée');

GO
ALTER TABLE Conducteur
	ADD FOREIGN KEY(id_permis)
		REFERENCES Permis(numero);
PRINT('Table Conducteur modifiée');

GO
ALTER TABLE Conducteur
	ADD FOREIGN KEY(nationalite)
		REFERENCES Nationalite(nom);
PRINT('Table Conducteur modifiée');

GO
ALTER TABLE Infraction
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);
PRINT('Table Infraction modifiée');

GO
ALTER TABLE Incident
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);
PRINT('Table Incident modifiée');

GO
ALTER TABLE Retard
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);
PRINT('Table Retard modifiée');

GO
ALTER TABLE RelanceDecouvert
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);
PRINT('Table RelanceDecouvert modifiée');

GO
INSERT INTO TypeCarburant(nom) VALUES ('Diesel');
INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES('Peugeot','206','Diesel',2003,39,0,3);