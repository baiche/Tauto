------------------------------------------------------------
-- Fichier     : 20140316_TPS_TAuto_isDisponible1
-- Date        : 16/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "isDisponible1"
------------------------------------------------------------

USE TAuto_IBDR;


PRINT('----- Contexte :');
PRINT('----------------'+char(13));

PRINT('Le vehicule "0775896we" est reservé pour les dates suivantes :');
PRINT('Réservation1 : "2014-04-07 10:00" -> "2014-04-24 18:00"');
PRINT('Réservation2 : "2014-04-28 08:00" -> "2014-05-05 17:00"'+char(13));

PRINT('Le vehicule "0775896wr" est loué et reservé pour les dates suivantes :');
PRINT('Location :    "2014-03-07 09:00" -> "2014-04-01 19:00"');
PRINT('Réservation : "2014-04-07 10:00" -> "2014-04-24 18:00"'+char(13));

PRINT('Le vehicule "0775896wu" est "Perdu"'+char(13));

PRINT('Le vehicule "0775896wx" est "En panne"'+char(13));

PRINT('-----------------------------------------------------------------------'+char(13));


--Test 1
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896we',
			@dateDebut = '2014-03-28T08:00:00', -- GETDATE() le jour de la soutenance
			@dateFin =   '2014-04-04T09:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 -- OK');
		PRINT('Test 1 : "2014-03-28" -> "2014-04-04" Véhicule disponible'+char(13));
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
	EXEC @ReturnValue = dbo.isDisponible1 
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
		PRINT('Test 2 : "2014-04-01" -> "2014-04-10" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
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
		PRINT('Test 3 : "2014-04-10" -> "2014-04-20" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


--Test 4
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
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
		PRINT('Test 4 : "2014-04-20" -> "2014-04-25" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO


--Test 5
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
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
		PRINT('Test 5 : "2014-04-20" -> "2014-05-02" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896we',
			@dateDebut = '2014-04-25T08:00:00',
			@dateFin =   '2014-04-27T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 6 -- OK');
		PRINT('Test 6 : "2014-04-25" -> "2014-04-27" Véhicule disponible'+char(13));
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


--Test 7
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896we',
			@dateDebut = '2014-04-01T08:00:00',
			@dateFin =   '2014-04-26T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- OK');
		PRINT('Test 7 : "2014-04-01" -> "2014-04-26" réservation impossible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


--Test 8
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896wu',
			@dateDebut = '2014-04-01T08:00:00',
			@dateFin =   '2014-04-10T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 8 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 -- OK');
		PRINT('Test 8 : Véhicule perdu -> Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - - NOT OK');
END CATCH
GO


--Test 9
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896wx',
			@dateDebut = '2014-04-01T08:00:00',
			@dateFin =   '2014-04-10T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 9 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 9 -- OK');
		PRINT('Test 9 : Véhicule en panne -> Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - - NOT OK');
END CATCH
GO


--Test 10
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896wr',
			@dateDebut = '2014-03-29T08:00:00',
			@dateFin =   '2014-03-31T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 10 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 10 -- OK');
		PRINT('Test 10 : "2014-03-29" -> "2014-03-31" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - - NOT OK');
END CATCH
GO


--Test 11
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896wr',
			@dateDebut = '2014-03-29T08:00:00',
			@dateFin =   '2014-04-02T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 11 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 11 -- OK');
		PRINT('Test 11 : "2014-03-29" -> "2014-04-02" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 11 - - NOT OK');
END CATCH
GO


--Test 12
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896wr',
			@dateDebut = '2014-03-29T08:00:00',
			@dateFin =   '2014-04-10T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 12 -- NOT OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 12 -- OK');
		PRINT('Test 12 : "2014-03-29" -> "2014-04-10" Véhicule indisponible'+char(13));
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 12 - - NOT OK');
END CATCH
GO


--Test 13
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.isDisponible1 
			@matricule = '0775896wr',
			@dateDebut = '2014-04-02T08:00:00',
			@dateFin =   '2014-04-06T08:00:00'
	IF ( @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 13 -- OK');
		PRINT('Test 13 : "2014-04-02" -> "2014-04-06" Véhicule disponible'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 13 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 13 - - NOT OK');
END CATCH
GO
