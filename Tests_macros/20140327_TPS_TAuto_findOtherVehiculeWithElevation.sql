------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_findOtherVehiculeWithElevation
-- Date        : 10/03/2014
-- Version     : 1.0 
-- Auteur      : Neti Mohamed & Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON

BEGIN TRY

	DECLARE @ReturnValue int,
	
			@nbReservationVehicule_Avant int,
			@nbContratLocation_Avant int,
			
			@nbReservationVehicule_Apres int,
			@nbContratLocation_Apres int,
			
			@tmp_ReservationVehicule_Avant int,
			@tmp_ContratLocation_Avant int,
			
			@tmp_ReservationVehicule_Apres int,
			@tmp_ContratLocation_Apres int;
			
/*			
--Test 1 si le matricule est bien renseigne
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= NULL,
			@itMustBeDone			= NULL,
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - KO');
	END

--Test 2 s'il existe bien un vehicule pour le matricule renseigne	
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0000000zz',
			@itMustBeDone			= NULL,
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - KO');
	END
	
--Test 3 si la date de fin est bien renseigner pour une demande d'extention de location
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896we',
			@itMustBeDone			= 'false',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - KO');
	END
	
--Test 4 si la date de fin est coherente : 	@date_fin < GETDATE()
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896we',
			@itMustBeDone			= 'false',
			@date_fin				= '2008-12-03'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - KO');
	END
	
--Test 5 si il existe bien une location en cours pour la demande d'extension de location
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896wx',
			@itMustBeDone			= 'false',
			@date_fin				= '2016-12-03'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - KO');
	END
	
--Test 6	
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896wr',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-03-30T00:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - KO');
	END
	*/
------tout vider et inserer
DELETE FROM ReservationVehicule;
DELETE FROM Reservation;
DELETE FROM ConducteurLocation;
DELETE FROM Retard;
DELETE FROM Incident; 
DELETE FROM Infraction;
DELETE FROM Location;
DELETE FROM Facturation;
DELETE FROM Etat;
DELETE FROM ContratLocation;
DELETE FROM Vehicule;
DECLARE @id_facturation int,
		@id_contratLocation int,
		@id_etat int,
		@idAbonnementDavid int,
		@idReservation int;
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-580-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');

INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2013-03-27','2014-03-28','15.35');

SET @id_facturation = SCOPE_IDENTITY();
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
		('2014-03-07T09:00:00', '2014-04-01T19:00:00', null, 0, 2);
SET @id_contratLocation = SCOPE_IDENTITY();
INSERT INTO Etat(date_avant,km_avant,fiche_avant,date_apres,km_apres,fiche_apres) VALUES
		('2013-03-07T08:00:00',300,'0005','20130328 10:00:00',400,'0006');
SET @id_etat = SCOPE_IDENTITY();
INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('AX-580-VT',@id_facturation,@id_etat,@id_contratLocation);

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-04-15T08:00:00', '2014-04-26T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-15T08:00:00' AND date_fin = '2014-04-26T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-02T08:00:00', '2014-05-08T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-08T17:00:00';
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-26T08:00:00', '2014-06-01T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-26T08:00:00' AND date_fin = '2014-06-01T17:00:00'; 
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');		
----------------------
/*	
--Test 7 si le vehicule es dispo pour la prolongation
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-04-04T19:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 7 - KO');
	END
	
--Test 8 si le vehicule n'es pas dispo pour la prolongation
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-04-16T19:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - KO');
	END
*/	
--Test 9 test ki remplace le cehicule endomager  pour les reservations concerné
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-581-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-582-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-04-17T08:00:00', '2014-04-22T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-17T08:00:00' AND date_fin = '2014-04-22T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-04T08:00:00', '2014-05-27T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-04T08:00:00' AND date_fin = '2014-05-27T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-582-VT'); 

		
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'true',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 9 - KO');
	END
	
--Test 10 test ou le remplacement ne peut satisfaire toute les reservations
DELETE FROM ReservationVehicule;
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-15T08:00:00' AND date_fin = '2014-04-26T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-08T17:00:00';
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-26T08:00:00' AND date_fin = '2014-06-01T17:00:00'; 
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-17T08:00:00' AND date_fin = '2014-04-22T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-04T08:00:00' AND date_fin = '2014-05-27T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-582-VT');		
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-02T08:00:00', '2014-05-10T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-10T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
		
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'true',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - KO');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test NOT -- OKI');
END CATCH
GO



			