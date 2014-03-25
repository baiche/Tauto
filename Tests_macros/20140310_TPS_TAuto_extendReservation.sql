------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_extendReservation
-- Date        : 22/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'extension d'un contrat de location
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.extendReservation
	@id_reservation			int, -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
*/

--Test 1
-- cas normal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendReservation
		@id_reservation = 3,
		@marque = 'Peugeot',
		@serie = '206',
		@type_carburant = 'Essence',
		@portieres = 3;
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ReservationVehicule WHERE
			id_reservation = 3 AND
			matricule_vehicule = '0775896wy'

	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- 14 & 15, chevauchement de deux réservations, un autre exemplaire est libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendReservation
		@id_reservation = 14,
		@marque = 'Peugeot',
		@serie = '206',
		@type_carburant = 'Diesel',
		@portieres = 5;
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ReservationVehicule WHERE
			id_reservation = 14 AND
			matricule_vehicule = '0775896wi'
	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - OK');
END CATCH
GO

--Test 3
--  14 & 15, chevauchement de deux réservations, aucun autre exemplaire de libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendReservation
		@id_reservation = 16,
		@marque = 'Peugeot',
		@serie = '206',
		@type_carburant = 'Essence',
		@portieres = 3;
		
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - OK');
END CATCH
GO
