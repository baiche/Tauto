------------------------------------------------------------
-- Fichier     : Generation
-- Date        : 15/02/2014
-- Version     : 1.1
-- Auteur      : Boris de Finance
-- Correcteurs : David Lecoconnier, Baiche Mourad, Alexis Deluze, Seyyid Ouir
-- Testeurs    : Baiche Mourad
-- Integrateur : 
-- Commentaire : ce script génére toutes les tables
--				 si elles n'existent pas
------------------------------------------------------------

USE TAuto_IBDR;

PRINT('Script de génération de la base')
PRINT('===============================');

---------------------------------
-- Création des tables-entités --
--------------------------------- 
PRINT('Création des tables');
PRINT('===================');
GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Catalogue') 
BEGIN
 CREATE TABLE  Catalogue(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^((\p{L}|[0-9''-]|\s)+)$',nom) = 1),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(),
	date_fin 			date,
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);
PRINT('Table Catalogue créée');
END
ELSE PRINT('La table Catalogue existe déja');
 GO


GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Categorie')
BEGIN
CREATE TABLE Categorie(
	nom					nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^(([a-zA-Z0-9''-]|\s)+)$',nom) = 1),
	description 		nvarchar(50) 					NOT NULL							CHECK( dbo.clrRegex('^((\p{L}|[0-9''-,\.]|\s)+)$',description) = 1),
	nom_typepermis 		nvarchar(10) 					NOT NULL							CHECK(nom_typepermis IN('A1', 'A2', 'B', 'C', 'D', 'E', 'F')), --c'est un enum
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
); 

PRINT('Table Categorie créée');
END
ELSE PRINT('La table Categorie existe déja');

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Modele')
BEGIN
CREATE TABLE Modele(
	marque 				nvarchar(50)														CHECK( dbo.clrRegex('^(([a-zA-Z0-9''-]|\s)+)$',marque) = 1),
	serie 				nvarchar(50)														CHECK( dbo.clrRegex('^(([a-zA-Z0-9''-\.]|\s)+)$',serie) = 1),
	type_carburant 		nvarchar(50) 					NOT NULL 							CHECK(type_carburant IN('Essence', 'Diesel')), --c'est un enum
	annee 				int,
	prix 				money 							NOT NULL,
	reduction 			tinyint										DEFAULT 0				CHECK(reduction >= 0 AND reduction < 100),
	portieres 			tinyint 						NOT NULL 	DEFAULT 5,
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(marque, serie, type_carburant, portieres)
);

PRINT('Table Modele créée');
END
ELSE PRINT('La table Modele existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='SousPermis')
BEGIN
CREATE TABLE SousPermis(
	nom_typepermis 		nvarchar(10) 					NOT NULL CHECK(nom_typepermis IN('A1', 'A2', 'B', 'C', 'D', 'E', 'F')),--c'est un enum
	numero_permis 		nvarchar(50),
	date_obtention 		date 							NOT NULL,
	date_expiration 	date 							NOT NULL,
	periode_probatoire 	tinyint 						NOT NULL 	DEFAULT 3,
	PRIMARY KEY(nom_typepermis, numero_permis)
);

PRINT('Table SousPermis créée');
END
ELSE PRINT('La table SousPermis existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Permis')
BEGIN
CREATE TABLE Permis(
	numero 				nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('[a-zA-Z0-9]+',numero) = 1),
	valide 				bit 										DEFAULT 'true',
	points_estimes 		tinyint 						NOT NULL 	DEFAULT 12
);

PRINT('Table Permis créée');
END
ELSE PRINT('La table Permis existe déja');
GO


GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Vehicule')
BEGIN
CREATE TABLE Vehicule(
	matricule 			nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^([a-zA-Z0-9-]+)$',matricule) = 1),
	kilometrage 		int 							NOT NULL 	DEFAULT 0,
	couleur 			nvarchar(50) 					NOT NULL 	DEFAULT 'Gris'			CHECK(couleur IN('Bleu', 'Blanc', 'Rouge', 'Noir', 'Gris')), --c'est un enum
	statut 				nvarchar(50) 					NOT NULL 	DEFAULT 'Disponible'	CHECK(statut IN('Disponible', 'Louee', 'En panne', 'Perdue')), --c'est un enum
	num_serie			nvarchar(50)					NOT NULL							CHECK( dbo.clrRegex('^(([a-zA-Z0-9-\.]|\s)+)$',num_serie) = 1),
	marque_modele 		nvarchar(50) 					NOT NULL,
	serie_modele 		nvarchar(50) 					NOT NULL,
	portieres_modele 	tinyint 						NOT NULL,
	date_entree			date							NOT NULL	DEFAULT GETDATE(),
	type_carburant_modele nvarchar(50) 					NOT NULL, --c'est un enum
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);

PRINT('Table Vehicule créée');
END
ELSE PRINT('La table Vehicule existe déja');
GO


GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Reservation')
BEGIN
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
END
ELSE PRINT('La table Reservation existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Abonnement')
BEGIN
CREATE TABLE Abonnement(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(),
	duree 				int 							NOT NULL 	DEFAULT 1,
	renouvellement_auto bit 										DEFAULT 'false',
	nom_typeabonnement 	nvarchar(50),
	nom_compteabonne 	nvarchar(50),
	prenom_compteabonne nvarchar(50),
	date_naissance_compteabonne date,
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);
PRINT('Table Abonnement créée');
END
ELSE PRINT('La table Abonnement existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CompteAbonne')
BEGIN
CREATE TABLE CompteAbonne(
	nom 				nvarchar(50)														CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',nom) = 1),
	prenom 				nvarchar(50)														CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',prenom) = 1),
	date_naissance 		date,
	liste_grise 		bit 							NOT NULL 	DEFAULT 'false',
	iban 				nvarchar(50)					NOT NULL							CHECK( dbo.clrRegex('^([A-Z]{2}[0-9]{25})$',iban) = 1),
	courriel 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( courriel='' or dbo.clrRegex('^([a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4})$',courriel) = 1),
	telephone 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( telephone='' or dbo.clrRegex('^([0-9]{10})$',telephone) = 1),
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(nom, prenom, date_naissance)
);
PRINT('Table CompteAbonne créée');
END
ELSE PRINT('La table CompteAbonne existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Entreprise')
BEGIN
CREATE TABLE Entreprise(
	siret 				char(14) 						NOT NULL 	DEFAULT ''				CHECK( dbo.clrRegex('^([0-9]{14})$',siret) = 1),
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',nom) = 1),
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);
PRINT('Table Entreprise créée');
END
ELSE PRINT('La table Entreprise existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Particulier')
BEGIN
CREATE TABLE Particulier(
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);
PRINT('Table Particulier créée');
END
ELSE PRINT('La table Particulier existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='TypeAbonnement')
BEGIN
CREATE TABLE TypeAbonnement(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^([a-zA-Z0-9]+)$',nom) = 1),
	prix 				money 							NOT NULL 	DEFAULT 0, --j'ai changé le type, dans le dictionnaire c'est un entier
	nb_max_vehicules 	int 										DEFAULT 1,
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);
PRINT('Table TypeAbonnement créée');
END
ELSE PRINT('La table TypeAbonnement existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Location')
BEGIN
CREATE TABLE Location(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	matricule_vehicule 	nvarchar(50),
	id_facturation 		int,
	date_etat_avant 	datetime,
	date_etat_apres 	datetime,
	id_contratLocation 	int
);
PRINT('Table Location créée');
END
ELSE PRINT('La table Location existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Facturation')
BEGIN
CREATE TABLE Facturation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_creation 		date 							NOT NULL 	DEFAULT GETDATE(),
	date_reception 		date,
	montant money 										NOT NULL							CHECK ( montant > 0)
);
PRINT('Table Facturation créée');
END
ELSE PRINT('La table Facturation existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Etat')
BEGIN
CREATE TABLE Etat(
	date_creation 		datetime 									DEFAULT GETDATE(),
	id_location 		int,
	km 					int 							NOT NULL 	DEFAULT 0,
	degat 				bit 							NOT NULL,
	fiche 				nvarchar(50) 					NOT NULL							CHECK( dbo.clrRegex('^([a-zA-Z0-9]+)$',fiche) = 1),
	PRIMARY KEY(date_creation, id_location)
);
PRINT('Table Etat créée');
END
ELSE PRINT('La table Etat existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ContratLocation')
BEGIN
CREATE TABLE ContratLocation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			datetime 						NOT NULL,
	date_fin 			datetime 						NOT NULL,
	date_fin_effective 	datetime,
	extension 			int,
	id_abonnement 		int
);
PRINT('Table ContratLocation créée');
END
ELSE PRINT('La table ContratLocation existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Conducteur')
BEGIN
CREATE TABLE Conducteur(
	piece_identite 		nvarchar(50)														CHECK( dbo.clrRegex('^([a-zA-Z0-9]+)$',piece_identite) = 1),
	nationalite 		nvarchar(50) 					NOT NULL							CHECK( nationalite IN('Francais', 'Anglais')),
	nom 				nvarchar(50) 					NOT NULL							CHECK( dbo.clrRegex('^(([a-zA-Z''-]|\s)+)$',nom) = 1),
	prenom 				nvarchar(50) 					NOT NULL							CHECK( dbo.clrRegex('^(([a-zA-Z''-]|\s)+)$',prenom) = 1),
	id_permis 			nvarchar(50)
	PRIMARY KEY(piece_identite, nationalite)
);
PRINT('Table Conducteur créée');
END
ELSE PRINT('La table Conducteur existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Infraction')
BEGIN
CREATE TABLE Infraction(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( nom='' or dbo.clrRegex('^((\p{L}|[0-9''-,\.]|\s)+)$',nom) = 1),
	montant 			money 							NOT NULL 	DEFAULT 0,
	description 		nvarchar(50)					NOT NULL 	DEFAULT ''				CHECK( description='' or dbo.clrRegex('^((\p{L}|[0-9''-,\.\/]|\s)+)$',description) = 1),
	regle 				bit 										DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);
PRINT('Table Infraction créée');
END
ELSE PRINT('La table Infraction existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Incident')
BEGIN
CREATE TABLE Incident(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	description 		nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( description='' or dbo.clrRegex('^((\p{L}|[0-9''-,\.]|\s)+)$',description) = 1),
	penalisable 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);
PRINT('Table Incident créée');
END
ELSE PRINT('La table Incident existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Retard')
BEGIN
CREATE TABLE Retard(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	regle 				bit 										DEFAULT 'false',
	niveau 				tinyint 									DEFAULT 1,
	PRIMARY KEY(date, id_location)
);
PRINT('Table Retard créée');
END
ELSE PRINT('La table Retard existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='RelanceDecouvert')
BEGIN
CREATE TABLE RelanceDecouvert(
	date 				datetime 									DEFAULT GETDATE(),
	nom_compteabonne 	nvarchar(50),
	prenom_compteabonne nvarchar(50),
	date_naissance_compteabonne date,
	niveau 				tinyint 						NOT NULL 	DEFAULT 0				CHECK(niveau >= 0 AND niveau <= 5),
	PRIMARY KEY(date, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
);
PRINT('Table RelanceDecouvert créée');
END
ELSE PRINT('La table RelanceDecouvert existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ListeNoire')
BEGIN
CREATE TABLE ListeNoire(
	date_naissance 		date,
	nom 				nvarchar(50)														CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',nom) = 1),
	prenom 				nvarchar(50)														CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',prenom) = 1),
	PRIMARY KEY(date_naissance, nom, prenom)
); 
PRINT('Table ListeNoire créée');
END
ELSE PRINT('La table ListeNoire existe déja');
GO


-----------------------------
-- Ajout des associations  --
-----------------------------

PRINT('
Création des associations');
PRINT('=======================');

PRINT('Création des associations');

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CatalogueCategorie')
BEGIN
CREATE TABLE CatalogueCategorie(
	nom_catalogue 		nvarchar(50) REFERENCES Catalogue(nom),
	nom_categorie 		nvarchar(50) REFERENCES  Categorie(nom),
	PRIMARY KEY(nom_catalogue, nom_categorie)
);
PRINT('Table CatalogueCategorie créée');
END
ELSE PRINT('La table CatalogueCategorie existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CategorieModele')
BEGIN
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
END
ELSE PRINT('La table CategorieModele existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ConducteurLocation')
BEGIN
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
END
ELSE PRINT('La table ConducteurLocation existe déja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CompteAbonneConducteur')
BEGIN
CREATE TABLE CompteAbonneConducteur(
	nom_compteabonne 				nvarchar(50),
	prenom_compteabonne 			nvarchar(50),
	date_naissance_compteabonne 	date,
	piece_identite_conducteur 		nvarchar(50),
	nationalite_conducteur 			nvarchar(50),
	PRIMARY KEY(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne,nationalite_conducteur,piece_identite_conducteur),
	
	FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance),
	FOREIGN KEY(piece_identite_conducteur,nationalite_conducteur) 
		REFERENCES Conducteur(piece_identite,nationalite)
);
PRINT('Table CompteAbonneConducteur créée');
END
ELSE PRINT('La table CompteAbonneConducteur existe déja');
GO

PRINT('
Ajout des clés étrangéres');
PRINT('=========================');
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
ALTER TABLE Reservation
	ADD FOREIGN KEY(matricule_vehicule)
		REFERENCES Vehicule(matricule),
		FOREIGN KEY (id_abonnement)
		REFERENCES Abonnement(id);
PRINT('Table Reservation modifiée');

GO
ALTER TABLE Abonnement
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance);
PRINT('Table Abonnement modifiée');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(matricule_vehicule)
		REFERENCES Vehicule(matricule),
		FOREIGN KEY(id_facturation)
		REFERENCES Facturation(id),
		FOREIGN KEY(date_etat_avant,id)
		REFERENCES Etat(date_creation,id_location),
		FOREIGN KEY(date_etat_apres,id)
		REFERENCES Etat(date_creation,id_location),
		FOREIGN KEY(id_contratLocation)
		REFERENCES  ContratLocation(id);
PRINT('Table Location modifiée');

GO
ALTER TABLE ContratLocation
	ADD FOREIGN KEY(id_abonnement)
		REFERENCES Abonnement(id);
PRINT('Table ContratLocation modifiée');

GO
ALTER TABLE Conducteur
	ADD FOREIGN KEY(id_permis)
		REFERENCES Permis(numero);
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