------------------------------------------------------------
-- Fichier     : 20140316_TPS_TAuto_notReservedVehicle1
-- Date        : 16/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "notReservedVehicle1"
------------------------------------------------------------

USE TAuto_IBDR;

-- Contexte
PRINT('Le vehicule "0775896we" est reservé pour les dates suivantes :');
PRINT('Réservation1 : 2014-03-25 08:00" -> "2014-04-04 17:00"');
PRINT('Réservation2 : 2014-04-06 13:00" -> "2014-04-10 17:00"'+char(13));

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-03-20T08:00:00',
			@dateFin = '2014-03-24T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 -- OK');
		PRINT('Test 1 : "2014-03-20" -> "2014-03-24" réservation possible'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - - NOT OK');
END CATCH
GO


--Test 2
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-03-20T08:00:00',
			@dateFin = '2014-03-26T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- OK');
		PRINT('Test 2 : "2014-03-20" -> "2014-03-26" réservation impossible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-03-27T08:00:00',
			@dateFin = '2014-03-29T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- OK');
		PRINT('Test 3 : "2014-03-27" -> "2014-03-29" réservation impossible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


--Test 4
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-04-01T08:00:00',
			@dateFin = '2014-04-05T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- OK');
		PRINT('Test 4 : "2014-04-01" -> "2014-04-05" réservation impossible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO


--Test 5
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-04-01T08:00:00',
			@dateFin = '2014-04-08T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- OK');
		PRINT('Test 5 : "2014-04-01" -> "2014-04-08" réservation impossible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-04-05T08:00:00',
			@dateFin = '2014-04-05T18:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 6 -- OK');
		PRINT('Test 6 : "2014-04-05 08h" -> "2014-04-05 18h" réservation possible'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO
