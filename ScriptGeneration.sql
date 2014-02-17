USE IBDR;

------------------------------------------------------
--Création des tables sans les relations             -
------------------------------------------------------

CREATE TABLE Catalogue
(nom char(50) PRIMARY KEY,
date_debut date NOT NULL,
date_fin date);


CREATE TABLE Categorie
(nom char(50) PRIMARY KEY,
description char(50) NOT NULL,
nom_typepermis char(50)); -- clef etrangere

CREATE TABLE Modele
(marque char(50),
serie char(50),
type_carburant char(50),--un enum serait peut-etre mieu
annee int,
prix money NOT NULL,
reduction tinyint,
portieres tinyint NOT NULL,
PRIMARY KEY(marque,serie,type_carburant));

CREATE TABLE TypePermis
(nom char(50) PRIMARY KEY);

CREATE TABLE SousPermis
(nom_typepermis char(50),
numero_permis char(50),
date_obtention date NOT NULL,
date_expiration date NOT NULL,
periode_probatoire tinyint NOT NULL,
PRIMARY KEY(nom_typepermis,numero_permis));

CREATE TABLE Permis
(numero char(50) PRIMARY KEY,
valide bit,
points_estimes tinyint NOT NULL);

CREATE TABLE Vehicule
(matricule char(50) PRIMARY KEY,
kilometrage int NOT NULL,
couleur char(50) NOT NULL, --un enum serait peut-etre mieu
etat char(50) NOT NULL, -- un enum est prévu ici
marque_modele char(50),
serie_modele char(50) NOT NULL,
type_carburant_modele char(50));

CREATE TABLE Reservation
(id int PRIMARY KEY IDENTITY(1,1),
date_creation date NOT NULL,
date_debut datetime NOT NULL,
date_fin datetime NOT NULL, 
annule bit,
matricule_vehicule char(50),
id_abonnement int);

CREATE TABLE Abonnement
(id int PRIMARY KEY IDENTITY(1,1),
date_debut date NOT NULL,
duree int NOT NULL,
nom_typeabonnement char(50),
nom_compteabonne char(50),
prenom_compteabonne char(50),
date_naissance_compteabonne date);

CREATE TABLE CompteAbonne
(nom char(50),
prenom char(50),
date_naissance date,
actif bit NOT NULL,
liste_grise bit NOT NULL,
iban char(50) NOT NULL,
courriel char(50) NOT NULL,
telephone char(50) NOT NULL,
PRIMARY KEY(nom,prenom,date_naissance));

CREATE TABLE TypeAbonnement
(nom char(50) PRIMARY KEY IDENTITY(1,1),
prix money NOT NULL, --j'ai changé le type, dans le dictionnaire c'est un entier
nb_max_vehicules int);

CREATE TABLE Location
(id int PRIMARY KEY IDENTITY(1,1),
matricule_vehicule char(50),
id_facturation int,
date_etat_avant datetime,
date_etat_apres datetime,
id_contratLocation int);

CREATE TABLE Facturation
(id int PRIMARY KEY IDENTITY(1,1),
numero_location int NOT NULL,
date_creation date NOT NULL,
date_reception date,
montant money NOT NULL);

CREATE TABLE Etat
(date_creation datetime,
id_location int,
km int NOT NULL,
degat bit NOT NULL,
fiche char(50) NOT NULL,
PRIMARY KEY(date_creation,id_location));

CREATE TABLE ContratLocation
(id int PRIMARY KEY IDENTITY(1,1),
date_debut datetime NOT NULL,
date_fin datetime NOT NULL,
date_fin_effective datetime,
extension int,
id_abonnement int);

CREATE TABLE Conducteur
(piece_identite char(50),
nationalite char(50),
nom char(50) NOT NULL,
prenom char(50) NOT NULL,
id_permis char(50)
PRIMARY KEY(piece_identite,nationalite));

CREATE TABLE Infraction
(date datetime,
id_location int,
nom char(50) NOT NULL,
montant money NOT NULL,
description char(50) NOT NULL,
regle bit,
PRIMARY KEY(date,id_location));

CREATE TABLE Incident
(date datetime,
id_location int,
description char(50) NOT NULL,
penalisable bit NOT NULL,
PRIMARY KEY(date,id_location));

CREATE TABLE Retard
(date datetime,
id_location int,
regle bit,
niveau tinyint,
PRIMARY KEY(date,id_location));

CREATE TABLE RelanceDecouvert
(date datetime,
nom_compteabonne char(50),
prenom_compteabonne char(50),
date_naissance_compteabonne date,
niveau tinyint NOT NULL,
PRIMARY KEY(date,nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne));

CREATE TABLE ListeNoire
(date_naissance date,
nom char(50),
prenom char(50),
PRIMARY KEY(date_naissance,nom, prenom)); 

--------------------------------------------------------
--Ajout des relations                                  -
--------------------------------------------------------

CREATE TABLE CatalogueCategorie
(nom_catalogue char(50) REFERENCES Catalogue(nom),
nom_categorie char(50) REFERENCES  Categorie(nom),
PRIMARY KEY(nom_catalogue, nom_categorie));

CREATE TABLE CategorieModele
(marque_modele char(50),
serie_modele char(50),
type_carburant_modele char(50),
nom_categorie char(50),
PRIMARY KEY(marque_modele,serie_modele,type_carburant_modele, nom_categorie),
FOREIGN KEY(marque_modele,serie_modele,type_carburant_modele) 
	REFERENCES Modele(marque,serie,type_carburant),
FOREIGN KEY(nom_categorie) REFERENCES Categorie(nom));

CREATE TABLE ConducteurLocation
(id_location int,
piece_identite_conducteur char(50),
nationalite_conducteur char(50),
PRIMARY KEY(id_location, piece_identite_conducteur, nationalite_conducteur),
FOREIGN KEY(id_location) REFERENCES Location(id),
FOREIGN KEY(piece_identite_conducteur,nationalite_conducteur) 
	REFERENCES Conducteur(piece_identite, nationalite));

CREATE TABLE CompteAbonneConducteur
(nom_compteabonne char(50),
prenom_compteabonne char(50),
date_naissance_compteabonne date,
nationalite_conducteur char(50),
piece_identite_conducteur char(50),
PRIMARY KEY(nom_compteabonne, prenom_compteabonne, date_naissance_compteabonne,nationalite_conducteur,piece_identite_conducteur),
FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
	REFERENCES CompteAbonne(nom,prenom,date_naissance),
FOREIGN KEY(nationalite_conducteur,piece_identite_conducteur) 
	REFERENCES Conducteur(piece_identite,nationalite));

CREATE TABLE Entreprise
(siret char(14),
nom char(50),
nom_compte char(50),
prenom_compte char(50),
date_naissance_compte date,
PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte),
FOREIGN KEY (nom_compte, prenom_compte, date_naissance_compte)
	REFERENCES CompteAbonne(nom,prenom,date_naissance)
);

CREATE TABLE Particulier
(nom_compte char(50),
prenom_compte char(50),
date_naissance_compte date,
PRIMARY KEY (nom_compte, prenom_compte, date_naissance_compte),
FOREIGN KEY (nom_compte, prenom_compte, date_naissance_compte)
	REFERENCES CompteAbonne(nom,prenom,date_naissance)
);
	
ALTER TABLE Categorie
ADD FOREIGN KEY(nom_typepermis) REFERENCES TypePermis(nom);

ALTER TABLE SousPermis
ADD FOREIGN KEY(nom_typepermis) REFERENCES TypePermis(nom);

ALTER TABLE SousPermis
ADD FOREIGN KEY(numero_permis) REFERENCES Permis(numero);

ALTER TABLE Vehicule
ADD FOREIGN KEY(marque_modele, serie_modele, type_carburant_modele) 
REFERENCES Modele(marque,serie,type_carburant);

ALTER TABLE Reservation
ADD FOREIGN KEY(matricule_vehicule) REFERENCES Vehicule(matricule);

ALTER TABLE Reservation
ADD FOREIGN KEY (id_abonnement) REFERENCES Abonnement(id);

ALTER TABLE Abonnement
ADD FOREIGN KEY(nom_typeabonnement) REFERENCES TypeAbonnement(nom);

ALTER TABLE Abonnement
ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
REFERENCES CompteAbonne(nom,prenom,date_naissance);

ALTER TABLE Location
ADD FOREIGN KEY(matricule_vehicule) REFERENCES Vehicule(matricule);

ALTER TABLE Location
ADD FOREIGN KEY(id_facturation) REFERENCES Facturation(id);

ALTER TABLE Location
ADD FOREIGN KEY(date_etat_avant,id) REFERENCES Etat(date_creation,id_location);

ALTER TABLE Location
ADD FOREIGN KEY(date_etat_apres,id) REFERENCES Etat(date_creation,id_location);

ALTER TABLE Location
ADD FOREIGN KEY(id_contratLocation) REFERENCES  ContratLocation(id);

ALTER TABLE ContratLocation
ADD FOREIGN KEY(id_abonnement) REFERENCES Abonnement(id)

ALTER TABLE Conducteur
ADD FOREIGN KEY(id_permis) REFERENCES Permis(numero);

ALTER TABLE Infraction
ADD FOREIGN KEY(id_location) REFERENCES Location(id);

ALTER TABLE Incident
ADD FOREIGN KEY(id_location) REFERENCES Location(id);

ALTER TABLE Retard
ADD FOREIGN KEY(id_location) REFERENCES Location(id);

ALTER TABLE RelanceDecouvert
ADD FOREIGN KEY(nom_compteabonne,prenom_compteabonne,date_naissance_compteabonne)
	REFERENCES CompteAbonne(nom,prenom,date_naissance);
