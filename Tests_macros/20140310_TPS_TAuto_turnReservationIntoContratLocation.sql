------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_turnReservationIntoContratLocat
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de catalogue
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.turnReservationIntoContratLocat
	@id_reservation 		int, -- PK
	@km_reservation			int -- nombre de kilomètres autorisés pendant la location
*/

--Test 1
-- Transformation d'une réservation annulée
BEGIN TRY
	DECLARE @ReturnValue int;
	DECLARE @Location_T TABLE (
		matricule_vehicule 	nvarchar(50),
		id_facturation 		int,
		id_etat			 	int,
		km					int	
	);
	
	EXEC @ReturnValue = dbo.turnReservationIntoContratLocat 
			@id_reservation = 8,
			@km_reservation = 5
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non insere');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple insere');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id = @ReturnValue
		) = 0)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non trouve');
	END
	
	INSERT INTO @Location_T (matricule_vehicule, id_facturation, id_etat, km)
		(SELECT matricule_vehicule, id_facturation, id_etat, km FROM Location WHERE id_contratLocation = @ReturnValue)
	
	IF (  (SELECT COUNT (*) FROM @Location_T) = 2)
	BEGIN
		PRINT('------------------------------Test 1 - 2 tuples inseres');
	END
	
	IF (  (SELECT COUNT (*) FROM Reservation WHERE
			id = 8 AND a_supprimer = 'true'
		) = 1)
	BEGIN
		PRINT('------------------------------Test 1 - reservation supprimee');
	END
	PRINT('------------------------------Test 1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT -- OK');
END CATCH
GO

--Test 3
-- Transformation d'une réservation annulée
BEGIN TRY
	EXEC dbo.addConducteurToLocation 
			@id_reservation = 10,
			@km_reservation = 5
			
	PRINT('------------------------------Test 3 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 OK');
END CATCH
GO

--Test 4
-- Transformation avec un kilométrage négatif
BEGIN TRY
	EXEC dbo.addConducteurToLocation 
			@id_reservation = 6,
			@km_reservation = 5

	PRINT('------------------------------Test 4 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 OK');
END CATCH
GO