------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_modifyAbonnement
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la suppression 
------------------------------------------------------------

USE TAuto_IBDR;

/*dbo.closeVehicule
	@matricule varchar(50)--PK
*/

--Test 1
-- test de la suppression d'un catalogue
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Catalogue
	SET a_supprimer = 'true'
	WHERE nom = 'automne 2014'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du vehicule
		IF ((SELECT COUNT(*) FROM Catalogue
			WHERE nom = 'automne 2014') <> 0)
		BEGIN
			PRINT('------------------------------Test 1 - erreur de suppression dans la table Catalogue -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM CatalogueCategorie
			WHERE nom_catalogue = 'automne 2014') <> 0  )
			BEGIN
				PRINT('------------------------------Test 1 - Erreur de suppression dans la table CatalogueCategorie - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
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