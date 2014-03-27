------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_modifyAbonnement
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la suppression 
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.closeVehicule
	@matricule varchar(50)--PK
*/

--Test 1
-- cas nominal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '1775896wy';
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du vehicule
		IF ((SELECT COUNT(*) FROM Vehicule
			WHERE matricule = '1775896wy'
			AND	a_supprimer= 'true') = 1)
		BEGIN
			PRINT('------------------------------Test 1 - OK');
		END
		ELSE 
		BEGIN
			PRINT('------------------------------Test 1 - Erreur de suppression du vehicule - KO');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- matricule NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = NULL;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO

--Test 3
-- matricule inexistant
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '1435896wy';
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO

--Test 4
--vehicule present dans des reservation non remplacable
BEGIN TRY
	--lie aux reservations 7,8,16 
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '0775896we';
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT COUNT(*) 
		FROM ReservationVehicule
		WHERE id_reservation = 7
		OR id_reservation = 8
		OR id_reservation = 16
		AND  matricule_vehicule = '0775896we') <> 0)
		BEGIN
			PRINT('------------------------------Test 4 - Erreur de remplacement - KO');
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 4 - OK');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
--vehicule present dans des reservations remplacable
BEGIN TRY
	--lie aux reservations 6,11
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '0775896wi';
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT COUNT(*) 
		FROM ReservationVehicule
		WHERE (id_reservation = 6
		OR id_reservation = 11)
		AND  matricule_vehicule = '0775896wi') <> 0)
		BEGIN
			PRINT('------------------------------Test 5 - Erreur de remplacement - KO');
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 5 - OK');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 5 - Ne drevrais pas etre accepte - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO