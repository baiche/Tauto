------------------------------------------------------------
-- Fichier     : 20140327_TPS_TAuto_fixVehicule.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "fixVehicule"
------------------------------------------------------------

USE TAuto_IBDR;
GO

--Test 1 : Le matricule du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = NULL,
			@statut_future = 'Disponible'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 1 -- OK'+char(13));
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

USE TAuto_IBDR;
GO


--Test 2 : Vehicule inexistant

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0999999we',
			@statut_future = 'Disponible'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 2 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3 : Le status souhaite du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896we',
			@statut_future = NULL
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


--Test 4 : Status inconnu

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896we',
			@statut_future = 'ecrase'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 4 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO



--Test 5 : Le vehicule a deja ce status !

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896we';

	EXEC @ReturnValue = dbo.fixVehicule
		@matricule = '0775896we',
		@statut_future = 'Disponible'
		
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896we';
	
	IF ( @ReturnValue = -1 AND @Status_avant = 'Disponible' AND @Status_apres = @Status_avant)
	BEGIN
		PRINT('------------------------------Test 5 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6 : 'En panne' -> 'Disponible'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wx';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wx',
			@statut_future = 'Disponible'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wx';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'En panne' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 6 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wx';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO


--Test 7 : 'Perdue' -> 'Disponible'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wu';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wu',
			@statut_future = 'Disponible'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wu';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'Perdue' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 7 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wu';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


--Test 8 : 'Disponible' -> 'En panne'

-- '0775896wi' est reserve pour les periodes suivantes :

--      - Reservation1  : 2014-04-06 -> 2014-04-10 
--      (d'autres vehicules disponibles pour ces dates : 2775896wi)

--      - Reservation2 : 2014-07-11 -> 2014-09-22 
--      (d'autres vehicules disponibles pour ces dates : 0775896wt ou 2775896wi)

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50),
	        @marque_modele nvarchar(50), @serie_modele nvarchar(50),
	        @portieres_modele tinyint, @type_carburant_modele nvarchar(50),
			@IdReservation1 int, @IdReservation2 int, 
			@Matricule_Reservation1_apres nvarchar(50), @Matricule_Reservation2_apres nvarchar(50),
			@Reservation1_date_debut datetime, @Reservation1_date_fin datetime,
			@Reservation2_date_debut datetime, @Reservation2_date_fin datetime,
			@matricule_boucle nvarchar(50), @isDispo int;

	CREATE TABLE #DispoPrReservation1(matricule nvarchar(50));
	CREATE TABLE #DispoPrReservation2(matricule nvarchar(50));

	-- pre ***********************
	
	SELECT @Status_avant = statut, @marque_modele = marque_modele, @serie_modele = serie_modele, 
	       @portieres_modele = portieres_modele, @type_carburant_modele = type_carburant_modele
	FROM Vehicule 
	WHERE matricule = '0775896wi';
	
	-- Reservation 1
	
	SET @Reservation1_date_debut = '2014-04-06T13:00:00';
	SET @Reservation1_date_fin = '2014-04-10T18:00:00';
	
	SELECT @IdReservation1 = r.id 
	FROM Reservation r
	INNER JOIN ReservationVehicule rv ON r.id = rv.id_reservation
	WHERE rv.matricule_vehicule = '0775896wi' AND 
	      r.date_debut = @Reservation1_date_debut AND r.date_fin = @Reservation1_date_fin;

	-- Reservation 2
	
	SET @Reservation2_date_debut = '2014-07-11T09:00:00';
	SET @Reservation2_date_fin = '2014-09-22T17:00:00';
	
	SELECT @IdReservation2 = r.id 
	FROM Reservation r
	INNER JOIN ReservationVehicule rv ON r.id = rv.id_reservation
	WHERE rv.matricule_vehicule = '0775896wi' AND 
	      r.date_debut = @Reservation2_date_debut AND r.date_fin = @Reservation2_date_fin;

	-- remplir les 2 tables : #DispoPrReservation1 et #DispoPrReservation2
	
	DECLARE curseur_matricule CURSOR FOR
				SELECT matricule 
				FROM Vehicule 
				WHERE marque_modele = @marque_modele AND
					  serie_modele = @serie_modele AND 
					  type_carburant_modele = @type_carburant_modele AND 
					  portieres_modele = @portieres_modele AND 
					  matricule <> '0775896wi';
									   
	OPEN curseur_matricule
	FETCH NEXT FROM curseur_matricule INTO @matricule_boucle
	
	WHILE @@FETCH_STATUS = 0
	BEGIN

		EXEC @isDispo = dbo.isDisponible1 @matricule_boucle, @Reservation1_date_debut, @Reservation1_date_fin

		IF( @isDispo = 1)
		BEGIN
			INSERT INTO #DispoPrReservation1 VALUES (@matricule_boucle);
		END

		EXEC @isDispo = dbo.isDisponible1 @matricule_boucle, @Reservation2_date_debut, @Reservation2_date_fin

		IF( @isDispo = 1)
		BEGIN
			INSERT INTO #DispoPrReservation2 VALUES (@matricule_boucle);
		END
		
		FETCH NEXT FROM curseur_matricule INTO @matricule_boucle
	END
	CLOSE curseur_matricule
	DEALLOCATE curseur_matricule
	       
	-- test ***********************

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wi',
			@statut_future = 'En panne'

	-- post ***********************
	
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wi';
	
	-- le matricule qui est associe a la reservation 1 apres l'execution de la procedure
	SELECT @Matricule_Reservation1_apres = matricule_vehicule 
	FROM ReservationVehicule 
	WHERE id_reservation = @IdReservation1;
	
	-- le matricule qui est associe a la reservation 2 apres l'execution de la procedure
	SELECT @Matricule_Reservation2_apres = matricule_vehicule 
	FROM ReservationVehicule 
	WHERE id_reservation = @IdReservation2;
	
	
	-- verification ***********************

	IF ( @ReturnValue = 1 AND 
	     @Status_avant = 'Disponible' AND @Status_apres = 'En panne' AND
	     @Matricule_Reservation1_apres IN (SELECT matricule FROM #DispoPrReservation1) AND
	     @Matricule_Reservation2_apres IN (SELECT matricule FROM #DispoPrReservation2) AND
	     not exists (SELECT 1 FROM ReservationVehicule WHERE id_reservation = @IdReservation1 AND matricule_vehicule = '0775896wi') AND
	     not exists (SELECT 1 FROM ReservationVehicule WHERE id_reservation = @IdReservation2 AND matricule_vehicule = '0775896wi')
	   )
	BEGIN
		PRINT('------------------------------Test 8 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 -- NOT OK');
	END


	DROP Table #DispoPrReservation1;
	DROP Table #DispoPrReservation2;

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - - NOT OK');
END CATCH
GO


