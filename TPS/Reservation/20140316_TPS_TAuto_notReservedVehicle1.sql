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
PRINT('Réservation1 : "2014-04-07 10:00" -> "2014-04-24 18:00"');
PRINT('Réservation2 : "2014-04-28 08:00" -> "2014-05-05 17:00"'+char(13));

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.notReservedVehicle1 
			@matricule = '0775896we',
			@dateDebut = '2014-03-28T08:00:00', -- GETDATE() le jour de la soutenance
			@dateFin =   '2014-04-04T09:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 -- OK');
		PRINT('Test 1 : "2014-03-28" -> "2014-04-04" réservation possible'+char(13));
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
			@dateDebut = '2014-04-01T08:00:00',
			@dateFin =   '2014-04-10T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- OK');
		PRINT('Test 2 : "2014-04-01" -> "2014-04-10" réservation impossible'+char(13));
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
			@dateDebut = '2014-04-10T08:00:00',
			@dateFin =   '2014-04-20T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- OK');
		PRINT('Test 3 : "2014-04-10" -> "2014-04-20" réservation impossible'+char(13));
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
			@dateDebut = '2014-04-20T08:00:00',
			@dateFin =   '2014-04-25T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- OK');
		PRINT('Test 4 : "2014-04-20" -> "2014-04-25" réservation impossible'+char(13));
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
			@dateDebut = '2014-04-20T08:00:00',
			@dateFin =   '2014-05-02T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- OK');
		PRINT('Test 5 : "2014-04-20" -> "2014-05-02" réservation impossible'+char(13));
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
			@dateDebut = '2014-04-25T08:00:00',
			@dateFin =   '2014-04-27T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 6 -- OK');
		PRINT('Test 6 : "2014-04-25" -> "2014-04-27" réservation possible'+char(13));
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
