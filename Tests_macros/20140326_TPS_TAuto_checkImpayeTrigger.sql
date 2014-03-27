------------------------------------------------------------
-- Fichier     : 20140326_TPS_TAuto_checkImpayeTrigger.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test du trigger checkImpayeTrigger
------------------------------------------------------------

USE TAuto_IBDR;
GO

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int;
	DECLARE @NbRelance_av int;
	DECLARE @NbRelance_ap int;
	
	SELECT @NbRelance_av = COUNT(*) FROM RelanceDecouvert
	WHERE   nom_compteabonne = 'TASociety'
		AND prenom_compteabonne = 'TASociety'
		AND date_naissance_compteabonne = '2014-02-24'
		AND niveau = 0
		AND a_supprimer = 'false';
	
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896we',
		@date_apres = '2014-03-25T10:00:00',
		@km_apres = 15000,
		@fiche_apres = 'fichetest1',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	SELECT @NbRelance_ap = COUNT(*) FROM RelanceDecouvert
	WHERE   nom_compteabonne = 'TASociety'
		AND prenom_compteabonne = 'TASociety'
		AND date_naissance_compteabonne = '2014-02-24'
		AND niveau = 0
		AND a_supprimer = 'false';
	
	IF ( @ReturnValue = 7 AND
	     @NbRelance_av + 1 = @NbRelance_ap)
	BEGIN
		PRINT('------------------------------Test 1 -- OK');
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
	DECLARE @NbRelance int;
	DECLARE @estGris bit;
	EXEC dbo.checkImpayeTriggerRec;--4
	EXEC dbo.checkImpayeTriggerRec;--5
	EXEC dbo.checkImpayeTriggerRec;--gris
		
	SELECT @NbRelance = COUNT(*) FROM RelanceDecouvert
	WHERE date = '20140226 10:00:00'
		AND nom_compteabonne = 'PIndustrie'
		AND prenom_compteabonne = 'PIndustrie'
		AND date_naissance_compteabonne = '2014-02-17'
		AND niveau = 5
		AND a_supprimer = 'true';
		
	SELECT @estGris = liste_grise FROM CompteAbonne
	WHERE   nom = 'PIndustrie'
		AND prenom = 'PIndustrie'
		AND date_naissance = '2014-02-17';
	
	IF ( @NbRelance = 1 AND @estGris = 'true')
	BEGIN
		PRINT('------------------------------Test 2 -- OK');
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