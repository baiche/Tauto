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
			@iban = 'LU2800193006447500001234567',
			@courriel = 'blabla@mail.com',
			@telephone = '0324858889'
			
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de l'Ajout dans CompteAbonne
		IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'Bon'
			AND	prenom = 'Jean'
			AND date_naissance = '1951-05-21'
			AND iban = 'LU2800193006447500001234567'
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

--Test 3
-- Utilisation avec le paramètre prenom à NULL

--Test 4
-- Utilisation avec le paramètre date_naissance à NULL

--Test 5
-- Utilisation avec le paramètre iban à NULL