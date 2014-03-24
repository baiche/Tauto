------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_modifyCompte
-- Date        : 23/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de modification un 
--				compte
------------------------------------------------------------

USE TAuto_IBDR;

/*dbo.modifyCompte
	@nom 					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date,		  -- PK
	@nouveau_nom			nvarchar(50), -- nullable
	@nouveau_prenom			nvarchar(50), -- nullable
	@iban 					nvarchar(50), -- nullable
	@courriel 				nvarchar(50), -- nullable
	@telephone 				nvarchar(50), -- nullable
	@siret 					nvarchar(50), -- nullable
	@nom_entreprise			nvarchar(50), -- nullable
	@greyList				bit, 		  -- nullable
	@renouvellement_auto	bit 		  -- nullable
*/

--Test 1
-- Utilisation de tous les champs 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'TASociety',
		@prenom = 'TASociety',				
		@date_naissance = '2014-02-24',		
		@nouveau_nom = 'TAEnterprise',		
		@nouveau_prenom	= 'TACorp',	
		@iban =	'LU2800194006447545001234568',			
		@courriel =	'tasociety@hotmail.fr',			
		@telephone = '0506038406',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromoTA',		
		@greyList =	'true',			
		@renouvellement_auto = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la modification du compte
			IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'TAEnterprise'
			AND	prenom = 'TACorp'
			AND date_naissance = '2014-02-24'
			AND iban = 'LU2800194006447545001234568'
			AND courriel = 'tasociety@hotmail.fr'
			AND	telephone = '0506038406'
			AND liste_grise = 'true') = 1)
		BEGIN
			--verification de la modification dans Particulier
			IF((SELECT COUNT(*) FROM Entreprise
				WHERE nom_compte = 'TAEnterprise'
				AND prenom_compte = 'TACorp'
				AND date_naissance_compte = '2014-02-24'
				AND siret = '73282932014786'
				AND nom = 'PromoTA') = 1)
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 1 - Erreur de modification dans Entreprise - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 1 - Erreur de modification dans Particulier - KO');
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
-- Test des nulls nullable et non nullable ...
/*
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC dbo.makeCompteEntreprise
			@nom = NULL,
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - La fonction accepte un nom NULL - KO')
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
*/

