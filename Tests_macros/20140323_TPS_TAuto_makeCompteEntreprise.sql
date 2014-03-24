------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_makeCompteEntreprise
-- Date        : 23/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'ajout d'un compte
--				pour une entreprise
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.makeCompteEntreprise
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50),
	@siret 				nvarchar(50),
	@nom_entreprise		nvarchar(50)
*/

--Test 1
-- Utilisation nominale 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de l'Ajout dans CompteAbonne
		IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'Pierre'
			AND	prenom = 'Louis'
			AND date_naissance = '1911-01-16'
			AND iban = 'LU2800194006447508901234567'
			AND courriel = 'ta2014@mail.com'
			AND	telephone = '0324858889') = 1)
		BEGIN
			--verification de l'insertion dans Particulier
			IF((SELECT COUNT(*) FROM Entreprise
				WHERE nom_compte = 'Pierre'
				AND prenom_compte = 'Louis'
				AND date_naissance_compte = '1911-01-16'
				AND siret = '56321478569587'
				AND nom = 'TA') = 1)
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 1 - Erreur insertion dans Particulier - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 1 - Erreur insertion dans CompteAbonne - KO');
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
-- Utilisation avec le paramètre nom à NULL

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


--Test 3
-- Utilisation avec le paramètre prenom à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = NULL, 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - La fonction accepte un prenom NULL - KO')
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
-- Utilisation avec le paramètre date_naissance à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = NULL,
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - La fonction accepte une date de naissance NULL - KO')
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
-- Utilisation avec le paramètre iban à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue =dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = NULL,
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - La fonction accepte un iban NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test 6
-- Utilisation avec le paramètre courriel à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = NULL,
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - La fonction accepte un courriel NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO

--Test 7
-- Utilisation avec le paramètre telephone à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = NULL,
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - Exception leve - KO');
END CATCH
GO

--Test 8
-- Utilisation avec le paramètre siret à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = NULL,
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - Exception leve - KO');
END CATCH
GO

--Test 9
-- Utilisation avec le paramètre nom_entreprise à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - Exception leve - KO');
END CATCH
GO


-- Test 10
-- Entrer un numéro siret plus pour voir si le numero est tronqué automatiquement,
-- si oui rajouter le test dans la méthode.

BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Aude',
			@prenom = 'Chloe', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587789',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - La fonction accepte un numero siret trop long - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - Exception leve - KO');
END CATCH
GO
