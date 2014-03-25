------------------------------------------------------------
-- Fichier     : 20140324_TPS_TAuto_searchVehicule
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure recherche d'un
--				 véhicule
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON

/*dbo.searchVehicule
	@nom_categorie			nvarchar(50), -- nullable
	@marque 				nvarchar(50), -- nullable
	@serie 					nvarchar(50), -- nullable
	@type_carburant 		nvarchar(50), -- nullable
	@portieres 				tinyint, -- nullable
	@prix_max 				money, -- nullable
	@prix_min 				money, -- nullable
	@date_debut 			date, -- nullable
	@date_fin 				date -- nullable
*/

--Test 1
-- Utilisation de tous les champs 
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			1000,
			0,
			'2014-03-29',
			'2014-03-31',
			'Noir'
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO

--Test 2
-- Pas de date de réservation
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			1000,
			0,
			NULL,
			NULL,
			'Noir'
		)
			WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 3
-- Pas de date de réservation, pas de prix
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			NULL,
			NULL,
			NULL,
			NULL,
			'Noir'
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 4
-- Pas de date de réservation, pas de prix, pas de couleur
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 5
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 6
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 7
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes, pas de numéro de série
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			NULL,
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 8
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes, pas de numéro de série, pas de marque
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			NULL,
			NULL,
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '0775896wi'
			OR matricule = '0775896wr'
			OR matricule = '0775896wt'
			OR matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 6)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 9
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes, pas de numéro de série, pas de marque, pas de carburant
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '0775896we'
			OR matricule = '0775896wi'
			OR matricule = '0775896wr'
			OR matricule = '0775896wt'
			OR matricule = '0775896wy'
			OR matricule = '1775896we'
			OR matricule = '1775896wi'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt'
			OR matricule = '1775896wy' ) = 10)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO


--Test 10
-- Tous les champs à NULL
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '0775896we'
			OR matricule = '0775896wi'
			OR matricule = '0775896wr'
			OR matricule = '0775896wt'
			OR matricule = '0775896wy'
			OR matricule = '1775896we'
			OR matricule = '1775896wi'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt'
			OR matricule = '1775896wy' ) = 10)
		PRINT ('OK');
	ELSE
		PRINT ('KO');
END
GO