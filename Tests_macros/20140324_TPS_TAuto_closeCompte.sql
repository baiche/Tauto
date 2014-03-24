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
-- Utilisation de tous les champs 
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
