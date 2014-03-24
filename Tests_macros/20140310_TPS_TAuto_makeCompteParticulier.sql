------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeCompteParticulier
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'ajout d'un compte
--				pour un particulier
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.makeCompteParticulier
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50)
*/

--Test 1
-- Utilisation nominale 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Bon',
			@prenom = 'Jean', 		
			@date_naissance = '1951-05-21',
			@iban = 'LU2800194006447500001234567',
			@courriel = 'blabla@mail.com',
			@telephone = '0324858889'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de l'Ajout dans CompteAbonne
		IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'Bon'
			AND	prenom = 'Jean'
			AND date_naissance = '1951-05-21'
			AND iban = 'LU2800194006447500001234567'
			AND courriel = 'blabla@mail.com'
			AND	telephone = '0324858889') = 1)
		BEGIN
			--verification de l'insertion dans Particulier
			IF((SELECT COUNT(*) FROM Particulier
				WHERE nom_compte = 'Bon'
				AND prenom_compte = 'Jean'
				AND date_naissance_compte = '1951-05-21') = 1)
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
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = NULL,
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
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
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = NULL, 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
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
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = NULL,
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
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
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = NULL,
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
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
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = NULL,
			@telephone = '0324858789'
			
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
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = NULL
			
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

