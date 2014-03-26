USE TAuto_IBDR;

-- Inscripton de Sophie Dupont avec choix de l'abonnement 1vehicule

-- declaration des informations pour sophie dupont
DECLARE @nom nvarchar(50) = 'Dupont',
		@prenom nvarchar(50) = 'Sophie',
		@date_naissance date = '1990-09-10',
		@iban nvarchar(50) = 'LU2800194006447500001234567',
		@courriel nvarchar(50) = 'sophie.dupont@mail.com',
		@telephone nvarchar(50) = '0123456789';

-- declaration des informations pour l'abonnement choisi		
DECLARE @date_debut_abo date = '2014-03-28',
		@duree int = 5,
		@renouvellement_auto bit = 'false',
		@nom_type_abonnement nvarchar(50) = '1vehicules';

PRINT('Liste des abonnements disponibles');
SELECT nom, prix, nb_max_vehicules AS nombre_vehicule, km FROM TypeAbonnement;

PRINT('Liste des abonnements avant l''ajout de celui de Sophie Dupont');		
SELECT cpta.nom, cpta.prenom, abo.nom_typeabonnement AS type_abonnement, abo.duree
	FROM CompteAbonne cpta
		JOIN Particulier par 
			ON cpta.nom=par.nom_compte 
			AND cpta.prenom=par.prenom_compte 
			AND cpta.date_naissance=par.date_naissance_compte
		JOIN Abonnement abo 
			ON cpta.nom=abo.nom_compteabonne 
			AND cpta.prenom=abo.prenom_compteabonne 
			AND cpta.date_naissance=abo.date_naissance_compteabonne;
			


EXEC makeCompteParticulier @nom, @prenom, @date_naissance, @iban, @courriel, @telephone;
EXEC makeAbonnement @date_debut_abo, @duree, @renouvellement_auto, @nom_type_abonnement, @nom, @prenom, @date_naissance;

PRINT('Liste des abonnements après l''ajout de celui de Sophie Dupont');
SELECT cpta.nom, cpta.prenom, abo.nom_typeabonnement AS type_abonnement, abo.duree 
	FROM CompteAbonne cpta
		JOIN Particulier par 
			ON cpta.nom=par.nom_compte 
			AND cpta.prenom=par.prenom_compte 
			AND cpta.date_naissance=par.date_naissance_compte
		JOIN Abonnement abo 
			ON cpta.nom=abo.nom_compteabonne 
			AND cpta.prenom=abo.prenom_compteabonne 
			AND cpta.date_naissance=abo.date_naissance_compteabonne;
			

PRINT('Ajout des conducteurs Sophie et Jean');

DECLARE @piece_identite_sophie nvarchar(50) = '123456009', 
		@nationalite nvarchar(50) = 'Francais', 
		@valide bit = 'true', 
		@points_estimes_sophie tinyint = 12,
		@numero_permis_sophie nvarchar(50) = '0000000006',
		@nom_typepermis nvarchar(50) = 'A2',
		@date_obtention_sophie date = '2010-03-14',
		@date_expiration_sophie date = '2025-03-14';
		
DECLARE @nom_jean nvarchar(50) = 'Dupont', 
		@prenom_jean nvarchar(50) = 'Jean', 
		@piece_identite_jean nvarchar(50) = '123456010',
		@points_estimes_jean tinyint = 6,
		@numero_permis_jean nvarchar(50) = '0000000007',
		@date_obtention_jean date = '2014-03-17',
		@date_expiration_jean date = '2029-03-17',
		@periode_probatoire tinyint = 3;

SELECT cpta.nom AS nom_abonne, cpta.prenom AS prenom_abonne, cond.nom AS nom_conducteur, cond.prenom AS prenom_conducteur 
	FROM Conducteur cond
		JOIN CompteAbonneConducteur cac
			ON cond.piece_identite=cac.piece_identite_conducteur
			AND cond.nationalite=cac.nationalite_conducteur
		JOIN CompteAbonne cpta 
			ON cac.nom_compteabonne = cpta.nom
			AND cac.prenom_compteabonne = cpta.prenom
			AND cac.date_naissance_compteabonne = cpta.date_naissance
	WHERE cpta.nom='Dupont'
		AND cpta.prenom='Sophie';

EXEC declareConducteur @nom, @prenom, @date_naissance, @nom, @prenom, @piece_identite_sophie, @nationalite, @numero_permis_sophie, @nom_typepermis, @date_obtention_sophie, NULL, @date_expiration_sophie, @valide, @points_estimes_sophie;
EXEC declareConducteur @nom, @prenom, @date_naissance, @nom_jean, @prenom_jean, @piece_identite_jean, @nationalite, @numero_permis_jean, @nom_typepermis, @date_obtention_jean, @periode_probatoire, @date_expiration_jean, @valide, @points_estimes_jean;

SELECT cpta.nom AS nom_abonne, cpta.prenom AS prenom_abonne, cond.nom AS nom_conducteur, cond.prenom AS prenom_conducteur 
	FROM Conducteur cond
		JOIN CompteAbonneConducteur cac
			ON cond.piece_identite=cac.piece_identite_conducteur
			AND cond.nationalite=cac.nationalite_conducteur
		JOIN CompteAbonne cpta 
			ON cac.nom_compteabonne = cpta.nom
			AND cac.prenom_compteabonne = cpta.prenom
			AND cac.date_naissance_compteabonne = cpta.date_naissance
	WHERE cpta.nom='Dupont'
		AND cpta.prenom='Sophie';
				
--EXEC makeReservation 

--DECLARE @id_reservation int =  XX, 
--		@km_reservation int = 100;
--EXEC turnReservationIntoContratLocat @id_reservation, @km_reservation;






DECLARE @id_abo int = (SELECT a.id FROM Abonnement a WHERE a.nom_compteabonne = 'Dupont' AND a.prenom_compteabonne = 'Sophie' AND a.date_naissance_compteabonne = '1990-09-10'),
		@date_debut date = '2014-03-28',
		@date_fin date = '2014-04-01',
		@marque nvarchar(50) = 'Peugeot',
		@serie nvarchar(50) = '406',
		@type_carburant nvarchar(50) = 'Diesel',
		@portiere int = 5;

DECLARE @id_reservation int,
		@km_reservation int = 100;

EXEC @id_reservation = makeReservation @id_abo, @date_debut, @date_fin, @marque, @serie, @type_carburant, @portiere;

SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.marque_modele, veh.serie_modele  
	FROM Reservation res
		JOIN ReservationVehicule resVeh
			ON res.id = resVeh.id_reservation
		JOIN Vehicule veh
			ON resVeh.matricule_vehicule=veh.matricule
		JOIN Abonnement abo
			ON res.id_abonnement=abo.id
	WHERE abo.nom_compteabonne='Dupont'
		AND abo.prenom_compteabonne='Sophie';



EXEC turnReservationIntoContratLocat @id_reservation, @km_reservation;





SELECT abo.nom_compteabonne, abo.prenom_compteabonne, res.date_debut, res.date_fin, veh.marque_modele, veh.serie_modele  
	FROM Reservation res
		JOIN ReservationVehicule resVeh
			ON res.id = resVeh.id_reservation
		JOIN Vehicule veh
			ON resVeh.matricule_vehicule=veh.matricule
		JOIN Abonnement abo
			ON res.id_abonnement=abo.id
	WHERE abo.nom_compteabonne='Dupont'
		AND abo.prenom_compteabonne='Sophie';


SELECT * FROM Location;



