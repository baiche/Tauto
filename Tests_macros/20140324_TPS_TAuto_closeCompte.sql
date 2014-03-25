------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_modifyCompte
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de fermeture d'un 
--				compte
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
/* dbo.closeCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
*/

--Test 1
-- Desactivation d'un compte utilisateur actif
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la modification du compte
			IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'De Finance'
			AND	prenom = 'Boris'
			AND date_naissance = '1990-09-08'
			AND actif = 'false') = 1)
				PRINT('------------------------------Test 1 - OK');
			ELSE
				PRINT('------------------------------Test 1 - KO');
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
-- Desactivation d'un compte utilisateur inactif
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 2 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
	IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'De Finance'
			AND	prenom = 'Boris'
			AND date_naissance = '1990-09-08'
			AND actif = 'false') = 1)
				PRINT('------------------------------Test 2 - OK');
			ELSE
				PRINT('------------------------------Test 2 - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO

--Test3
--Fermeture d'un compte qui n'existe pas
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'DeFinance',
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 3 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
	IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'DeFinance'
			AND	prenom = 'Boris'
			AND date_naissance = '1990-09-08'
			AND actif = 'false') = 0)
				PRINT('------------------------------Test 3 - OK');
			ELSE
				PRINT('------------------------------Test 3 - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO

--Test 4
--Test d'un nom NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = NULL,
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 4 - Erreur valeur de retour - KO');
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
--Test d'un prenom NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = NULL,
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');
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
--Test d'une date_naissance NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = 'Boris',
	@date_naissance = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 6 - Erreur valeur de retour - KO');
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