------------------------------------------------------------
-- Fichier     : Generation
-- Date        : 15/02/2014
-- Version     : 1.1
-- Auteur      : Boris de Finance
-- Correcteurs : David Lecoconnier, Baiche Mourad, Alexis Deluze, Seyyid Ouir
-- Testeurs    : Baiche Mourad
-- Integrateur : 
-- Commentaire : ce script g�n�re toutes les tables
--				 si elles n'existent pas
------------------------------------------------------------

USE TAuto_IBDR;

PRINT('Script de g�n�ration de la base')
PRINT('===============================');


PRINT('
Configuration et cr�ation de l''assembly')
PRINT('===============================');
GO

sp_configure 'clr enabled', 1;
RECONFIGURE;
GO

BEGIN TRY
	CREATE ASSEMBLY RegExFunc FROM '$(Param1)\..\Generation\SQLServerCLR.dll';
	PRINT('Assembly RegExFunc cr��e.')
END TRY
BEGIN CATCH
	PRINT('Assembly RegExFunc d�j� existante.')
END CATCH 
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[clrRegex]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[clrRegex]
GO

CREATE FUNCTION dbo.clrRegex  
(  
 @pattern as nvarchar(200),
 @matchString as nvarchar(200)  
)   
RETURNS bit 
AS EXTERNAL NAME RegExFunc.[SQLServerCLR.RegExCompiled].RegExCompiledMatch
GO

PRINT('Fonction dbo.clrRegex cr��e.')
GO


---------------------------------
-- Cr�ation des tables-entit�s --
--------------------------------- 
PRINT('
Cr�ation des tables');
PRINT('===================');
GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Catalogue') 
BEGIN
 CREATE TABLE  Catalogue(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^((\p{L}|[0-9''-]|\s)+)$',nom) = 1),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(),		--CHECK(date_debut <= date_fin and date_debut >= GETDATE() ), 
	date_fin 			date,																--CHECK(date_debut <= date_fin and date_debut >= GETDATE() ), 
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);
PRINT('Table Catalogue cr��e');
END
ELSE PRINT('La table Catalogue existe d�ja');
 GO


GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Categorie')
BEGIN
CREATE TABLE Categorie(
	nom					nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^(([a-zA-Z0-9''-]|\s)+)$',nom) = 1),
	description 		nvarchar(50) 					NOT NULL							CHECK( dbo.clrRegex('^((\p{L}|[0-9'',\.-]|\s)+)$',description) = 1),
	nom_typepermis 		nvarchar(10) 					NOT NULL							CHECK(nom_typepermis IN('A1', 'A2', 'B', 'C', 'D', 'E', 'F')), --c'est un enum
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
); 

PRINT('Table Categorie cr��e');
END
ELSE PRINT('La table Categorie existe d�ja');

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Modele')
BEGIN
CREATE TABLE Modele(
	marque 				nvarchar(50)														CHECK( dbo.clrRegex('^(([a-zA-Z0-9''-]|\s)+)$',marque) = 1),
	serie 				nvarchar(50)														CHECK( dbo.clrRegex('^(([a-zA-Z0-9''-\.]|\s)+)$',serie) = 1),
	type_carburant 		nvarchar(50) 					NOT NULL 							CHECK(type_carburant IN('Essence', 'Diesel','GPL','Ethanol','Electrique')), --c'est un enum
	annee 				int,																--CHECK(annee <= YEAR(GETDATE())), --A voir si on a besoin de rajouter des modeles qui ne sont pas encor sorti
	prix 				money 							NOT NULL,
	reduction 			tinyint										DEFAULT 0				CHECK(reduction >= 0 AND reduction < 100),
	portieres 			tinyint 						NOT NULL 	DEFAULT 5,
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(marque, serie, type_carburant, portieres)
);

PRINT('Table Modele cr��e');
END
ELSE PRINT('La table Modele existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='SousPermis')
BEGIN
CREATE TABLE SousPermis(
	nom_typepermis 		nvarchar(10) 					NOT NULL CHECK(nom_typepermis IN('A1', 'A2', 'B', 'C', 'D', 'E', 'F')),--c'est un enum
	numero_permis 		nvarchar(50),							 
	date_obtention 		date 							NOT NULL, --CHECK(date_obtention < date_expiration),
	date_expiration 	date, --CHECK(date_obtention < date_expiration),
	periode_probatoire 	tinyint 						NOT NULL 	DEFAULT 3,
	PRIMARY KEY(nom_typepermis, numero_permis)
);

PRINT('Table SousPermis cr��e');
END
ELSE PRINT('La table SousPermis existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Permis')
BEGIN
CREATE TABLE Permis(
	numero 				nvarchar(50) 	PRIMARY KEY		/*voir regex sur format numero permis*/	 CHECK( dbo.clrRegex('[a-zA-Z0-9]+',numero) = 1),
	valide 				bit 										DEFAULT 'true',
	points_estimes 		tinyint 						NOT NULL 	DEFAULT 12, CHECK(points_estimes > 0 and points_estimes <= 12),
);

PRINT('Table Permis cr��e');
END
ELSE PRINT('La table Permis existe d�ja');
GO


GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Vehicule')
BEGIN
CREATE TABLE Vehicule(
	matricule 			nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^([a-zA-Z0-9-]+)$',matricule) = 1), --ex: AX-580-VT ca correspond??
	kilometrage 		int 							DEFAULT 0,
	couleur 			nvarchar(50) 					DEFAULT 'Gris'			CHECK(couleur IN('Bleu', 'Blanc', 'Rouge', 'Noir', 'Gris')), --c'est un enum  A changer
	statut 				nvarchar(50) 					DEFAULT 'Disponible'	CHECK(statut IN('Disponible', 'Louee', 'En panne', 'Perdue')), --c'est un enum
	num_serie			nvarchar(50)					NOT NULL							CHECK( dbo.clrRegex('^(([a-zA-Z0-9-\.]|\s)+)$',num_serie) = 1),
  	marque_modele 		nvarchar(50) 					NOT NULL,
	serie_modele 		nvarchar(50) 					NOT NULL,
	portieres_modele 	tinyint 						NOT NULL,
	date_entree			date							DEFAULT GETDATE(), 
	type_carburant_modele nvarchar(50) 					NOT NULL, --c'est un enum
	a_supprimer 		bit 						 	DEFAULT 'false'
);

PRINT('Table Vehicule cr��e');
END
ELSE PRINT('La table Vehicule existe d�ja');
GO


GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Reservation')
BEGIN
CREATE TABLE Reservation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_creation 		date 							NOT NULL 	DEFAULT GETDATE(),
	date_debut datetime 								NOT NULL, --CHECK(date_debut < date_fin),
	date_fin datetime 									NOT NULL, 
	annule 				bit 							NOT NULL 	DEFAULT 'false',
	id_abonnement 		int								NOT NULL,
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);
PRINT('Table Reservation cr��e');
END
ELSE PRINT('La table Reservation existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Abonnement')
BEGIN
CREATE TABLE Abonnement(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			date 							NOT NULL 	DEFAULT GETDATE(), --CHECK( GETDATE() <= date_debut ),
	duree 				int 							NOT NULL 	DEFAULT 1,
	renouvellement_auto bit 										DEFAULT 'false',
	nom_typeabonnement 	nvarchar(50),
	nom_compteabonne 	nvarchar(50),
	prenom_compteabonne nvarchar(50),
	date_naissance_compteabonne date,				
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false'
);
PRINT('Table Abonnement cr��e');
END
ELSE PRINT('La table Abonnement existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CompteAbonne')
BEGIN
CREATE TABLE CompteAbonne(
	nom 				nvarchar(50)														CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',nom) = 1),
	prenom 				nvarchar(50)														CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',prenom) = 1),
	date_naissance 		date,
	actif				bit 							NOT NULL 	DEFAULT 'true',
	liste_grise 		bit 							NOT NULL 	DEFAULT 'false',
	iban 				nvarchar(50)					NOT NULL							CHECK( dbo.clrRegex('^([A-Z]{2}[0-9]{25})$',iban) = 1),
	courriel 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( courriel='' or dbo.clrRegex('^([a-zA-Z0-9\._-]+@[a-z0-9\._-]{2,}\.[a-z]{2,4})$',courriel) = 1),

	telephone 			nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( telephone='' or dbo.clrRegex('^([0-9]{10})$',telephone) = 1),
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(nom, prenom, date_naissance)
);

PRINT('Table CompteAbonne cr��e');
END
ELSE PRINT('La table CompteAbonne existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Entreprise')
BEGIN
CREATE TABLE Entreprise(
	siret 				char(14) 						NOT NULL 							CHECK( dbo.clrRegex('^([0-9]{14})$',siret) = 1),
	nom 				nvarchar(50) 					NOT NULL 							CHECK( dbo.clrRegex('^((\p{L}|[''-]|\s)+)$',nom) = 1),
	nom_compte 			nvarchar(50),
	prenom_compte 		nvarchar(50),
	date_naissance_compte date,
	PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte)
);
PRINT('Table Entreprise cr��e');
END
ELSE PRINT('La table Entreprise existe d�ja');
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
PRINT('Table Particulier cr��e');
END
ELSE PRINT('La table Particulier existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='TypeAbonnement')
BEGIN
CREATE TABLE TypeAbonnement(
	nom 				nvarchar(50) 	PRIMARY KEY											CHECK( dbo.clrRegex('^([a-zA-Z0-9]+)$',nom) = 1),
	prix 				money 							NOT NULL 	DEFAULT 0, --j'ai chang� le type, dans le dictionnaire c'est un entier
	nb_max_vehicules 	int 							NOT NULL	DEFAULT 1				CHECK( nb_max_vehicules > 0),
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false',
	km					int								NOT NULL	DEFAULT 1000			CHECK( km >= 0 )
);
PRINT('Table TypeAbonnement cr��e');
END
ELSE PRINT('La table TypeAbonnement existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Location')
BEGIN
CREATE TABLE Location(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	matricule_vehicule 	nvarchar(50)					NOT NULL,
	id_facturation 		int,
	id_etat			 	int,
	id_contratLocation 	int								NOT NULL,
	km					int																	CHECK( km >= 0 )
);
PRINT('Table Location cr��e');
END
ELSE PRINT('La table Location existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Facturation')
BEGIN
CREATE TABLE Facturation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_creation 		date 							NOT NULL 	DEFAULT GETDATE(),-- CHECK( date_creation <= date_reception ),
	date_reception 		date,
	montant money 										NOT NULL							CHECK ( montant > 0)
);
PRINT('Table Facturation cr��e');
END
ELSE PRINT('La table Facturation existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Etat')
BEGIN
CREATE TABLE Etat(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_avant	 		datetime 						NOT NULL	DEFAULT GETDATE(),
	date_apres	 		datetime, 															CHECK( date_apres >= date_avant ),
	km_avant 			int 							NOT NULL 	DEFAULT 0				CHECK( km_avant >= 0 ),
	km_apres			int,									 							CHECK( km_apres >= km_avant ),
	degat 				bit,
	fiche_avant			nvarchar(50) 					NOT NULL							CHECK( dbo.clrRegex('^([a-zA-Z0-9]+)$', fiche_avant) = 1),
	fiche_apres			nvarchar(50) 								DEFAULT ''				CHECK( dbo.clrRegex('^([a-zA-Z0-9]*)$', fiche_apres) = 1)
);
PRINT('Table Etat cr��e');
END
ELSE PRINT('La table Etat existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ContratLocation')
BEGIN
CREATE TABLE ContratLocation(
	id 					int 			PRIMARY KEY IDENTITY(1,1),
	date_debut 			datetime 						NOT NULL, --CHECK( date_debut <= date_fin),
	date_fin 			datetime 						NOT NULL,
	date_fin_effective 	datetime,								  --CHECK( date_debut <= date_fin_effective),
	extension 			int											DEFAULT 0			CHECK ( extension >= 0 ),
	id_abonnement 		int
);
PRINT('Table ContratLocation cr��e');
END
ELSE PRINT('La table ContratLocation existe d�ja');
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
PRINT('Table Conducteur cr��e');
END
ELSE PRINT('La table Conducteur existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Infraction')
BEGIN
CREATE TABLE Infraction(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	nom 				nvarchar(50) 					NOT NULL 	DEFAULT ''				CHECK( nom='' or dbo.clrRegex('^((\p{L}|[0-9'',\.-]|\s)+)$',nom) = 1),
	montant 			money 							NOT NULL 	DEFAULT 0,
	description 		nvarchar(150)					NOT NULL 	DEFAULT ''				CHECK( description='' or dbo.clrRegex('^((\p{L}|[0-9'',\.\/-]|\s)+)$',description) = 1),
	regle 				bit 										DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);
PRINT('Table Infraction cr��e');
END
ELSE PRINT('La table Infraction existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Incident')
BEGIN
CREATE TABLE Incident(
	date 				datetime 									DEFAULT GETDATE(),
	id_location 		int,
	description 		nvarchar(150) 					NOT NULL 	DEFAULT ''				CHECK( description='' or dbo.clrRegex('^((\p{L}|[0-9''-,\.]|\s)+)$',description) = 1),
	penalisable 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(date, id_location)
);
PRINT('Table Incident cr��e');
END
ELSE PRINT('La table Incident existe d�ja');
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
PRINT('Table Retard cr��e');
END
ELSE PRINT('La table Retard existe d�ja');
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
	a_supprimer 		bit 							NOT NULL 	DEFAULT 'false',
	PRIMARY KEY(date, nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne)
);
PRINT('Table RelanceDecouvert cr��e');
END
ELSE PRINT('La table RelanceDecouvert existe d�ja');
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
PRINT('Table ListeNoire cr��e');
END
ELSE PRINT('La table ListeNoire existe d�ja');
GO


-----------------------------
-- Ajout des associations  --
-----------------------------

PRINT('
Cr�ation des associations');
PRINT('=======================');

PRINT('Cr�ation des associations');

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CatalogueCategorie')
BEGIN
CREATE TABLE CatalogueCategorie(
	nom_catalogue 		nvarchar(50) REFERENCES Catalogue(nom),
	nom_categorie 		nvarchar(50) REFERENCES  Categorie(nom),
	PRIMARY KEY(nom_catalogue, nom_categorie)
);
PRINT('Table CatalogueCategorie cr��e');
END
ELSE PRINT('La table CatalogueCategorie existe d�ja');
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
PRINT('Table CategorieModele cr��e');
END
ELSE PRINT('La table CategorieModele existe d�ja');
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
PRINT('Table ConducteurLocation cr��e');
END
ELSE PRINT('La table ConducteurLocation existe d�ja');
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
		REFERENCES CompteAbonne(nom,prenom,date_naissance)
		ON UPDATE CASCADE,
	FOREIGN KEY(piece_identite_conducteur,nationalite_conducteur) 
		REFERENCES Conducteur(piece_identite,nationalite)
);
PRINT('Table CompteAbonneConducteur cr��e');
END
ELSE PRINT('La table CompteAbonneConducteur existe d�ja');
GO

GO
IF NOT EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ReservationVehicule')
BEGIN
CREATE TABLE ReservationVehicule(
	id_reservation 					int,
	matricule_vehicule 			nvarchar(50)
	PRIMARY KEY(id_reservation, matricule_vehicule),
	
	FOREIGN KEY (id_reservation)
		REFERENCES Reservation(id),
	FOREIGN KEY (matricule_vehicule) 
		REFERENCES Vehicule(matricule)
);
PRINT('Table ReservationVehicule cr��e');
END
ELSE PRINT('La table ReservationVehicule existe d�ja');
GO

PRINT('
Ajout des cl�s �trang�res');
PRINT('=========================');
GO
ALTER TABLE Entreprise
	ADD FOREIGN KEY (nom_compte, prenom_compte, date_naissance_compte)
		REFERENCES CompteAbonne(nom,prenom,date_naissance)
		ON UPDATE CASCADE;
PRINT('Table Entreprise modifi�e');

GO
ALTER TABLE Particulier
	ADD FOREIGN KEY(nom_compte, prenom_compte, date_naissance_compte)
		REFERENCES CompteAbonne(nom,prenom,date_naissance)
		ON UPDATE CASCADE;
PRINT('Table Particulier modifi�e');

GO
ALTER TABLE SousPermis
	ADD FOREIGN KEY(numero_permis)
		REFERENCES Permis(numero);
PRINT('Table SousPermis modifi�e');

GO
ALTER TABLE Vehicule
	ADD FOREIGN KEY(marque_modele, serie_modele, type_carburant_modele, portieres_modele) 
		REFERENCES Modele(marque, serie, type_carburant, portieres);
PRINT('Table Vehicule modifi�e');

GO
ALTER TABLE Reservation
	ADD FOREIGN KEY (id_abonnement)
			REFERENCES Abonnement(id);
PRINT('Table Reservation modifi�e');

GO
ALTER TABLE Abonnement
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
			REFERENCES CompteAbonne(nom,prenom,date_naissance)
			ON UPDATE CASCADE,
		FOREIGN KEY(nom_typeabonnement)
			REFERENCES TypeAbonnement(nom);
PRINT('Table Abonnement modifi�e');

GO
ALTER TABLE Location
	ADD FOREIGN KEY(matricule_vehicule)
			REFERENCES Vehicule(matricule),
		FOREIGN KEY(id_facturation)
			REFERENCES Facturation(id),
		FOREIGN KEY(id_etat)
			REFERENCES Etat(id),
		FOREIGN KEY(id_contratLocation)
			REFERENCES  ContratLocation(id);
PRINT('Table Location modifi�e');

GO
ALTER TABLE ContratLocation
	ADD FOREIGN KEY(id_abonnement)
		REFERENCES Abonnement(id);
PRINT('Table ContratLocation modifi�e');

GO
ALTER TABLE Conducteur
	ADD FOREIGN KEY(id_permis)
		REFERENCES Permis(numero);
PRINT('Table Conducteur modifi�e');

GO
ALTER TABLE Infraction
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);
PRINT('Table Infraction modifi�e');

GO
ALTER TABLE Incident
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);
PRINT('Table Incident modifi�e');

GO
ALTER TABLE Retard
	ADD FOREIGN KEY(id_location)
		REFERENCES Location(id);
PRINT('Table Retard modifi�e');

GO
ALTER TABLE RelanceDecouvert
	ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
		REFERENCES CompteAbonne(nom,prenom,date_naissance)
		ON UPDATE CASCADE;
PRINT('Table RelanceDecouvert modifi�e');

GO
