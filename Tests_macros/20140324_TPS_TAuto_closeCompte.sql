------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_modifyCompte
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de modification un 
--				compte
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
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
		@greyList =	'true'			
			
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
-- Test de la valeur NULL pour nom
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = NULL,
		@prenom = 'TACorp',				
		@date_naissance = '2014-02-24',		
		@nouveau_nom = 'Enterprise',		
		@nouveau_prenom	= 'Corp',	
		@iban =	'LU2800194006448545001234568',			
		@courriel =	'society@hotmail.fr',			
		@telephone = '0506038407',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromotionTA',		
		@greyList =	'false'			
			
	IF ( @ReturnValue = 1)
	BEGIN	
				PRINT('------------------------------Test 2 -acceptation d''un nom NULL -  KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - OK')
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO


--Test 3
-- Test de la valeur NULL pour prenom
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'TAEnterprise',
		@prenom = NULL,				
		@date_naissance = '2014-02-24',		
		@nouveau_nom = 'Enterprise',		
		@nouveau_prenom	= 'Corp',	
		@iban =	'LU2800194006448545001234568',			
		@courriel =	'society@hotmail.fr',			
		@telephone = '0506038407',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromotionTA',		
		@greyList =	'false'			
			
	IF ( @ReturnValue = 1)
	BEGIN	
				PRINT('------------------------------Test 3 - acceptation d''un prenom NULL - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - OK')
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO


--Test 4
-- Test de la valeur NULL pour date_naissance
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'TAEnterprise',
		@prenom = 'TACorp',				
		@date_naissance = NULL,		
		@nouveau_nom = 'Enterprise',		
		@nouveau_prenom	= 'Corp',	
		@iban =	'LU2800194006448545001234568',			
		@courriel =	'society@hotmail.fr',			
		@telephone = '0506038407',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromotionTA',		
		@greyList =	'false'			
			
	IF ( @ReturnValue = 1)
	BEGIN	
				PRINT('------------------------------Test 4 - acceptation d''une date_naissance NULL - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - OK')
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
-- Test de la modification d'un particulier 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'De Finance',
		@prenom = 'Boris',				
		@date_naissance = '1990-09-08',		
		@nouveau_nom = 'de Finance de Clairbois',		
		@nouveau_prenom	= 'Yves',	
		@iban =	NULL,			
		@courriel =	'bdefinance@mail.com',			
		@telephone = NULL,			
		@siret = NULL,				
		@nom_entreprise = NULL,		
		@greyList =	NULL			
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la modification du compte
			IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'de Finance de Clairbois'
			AND	prenom = 'Yves'
			AND date_naissance = '1990-09-08'
			AND iban = 'LU2800194006447500001234567'
			AND courriel = 'bdefinance@mail.com'
			AND	telephone = '0601020304'
			AND liste_grise = 'false') = 1)
		BEGIN
			--verification de la modification dans Particulier
			IF((SELECT COUNT(*) FROM Particulier
				WHERE nom_compte = 'de Finance de Clairbois'
				AND prenom_compte = 'Yves'
				AND date_naissance_compte = '1990-09-08'
) = 1)
			BEGIN
				PRINT('------------------------------Test 5 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 5 - Erreur de modification dans Particulier - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 5 - Erreur de modification dans CompteAbonne - KO');
		END
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO