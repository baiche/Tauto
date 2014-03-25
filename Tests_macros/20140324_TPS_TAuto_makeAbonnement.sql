------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_makeAbonnement
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la création d'un abonnement
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
/* dbo.makeAbonnement
	@date_debut 						date,
	@duree 								int,
	@renouvellement_auto 				bit,
	@nom_typeabonnement 				nvarchar(50), -- FK
	@nom_compteabonne 					nvarchar(50), -- FK
	@prenom_compteabonne 				nvarchar(50), -- FK
	@date_naissance_compteabonne 		date 		  -- FK
*/

--Test 1
-- Creation d'un abonnement dans le cas nominal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la creation de l'abonnement
			IF ((SELECT COUNT(*) FROM Abonnement
			WHERE date_debut = '2015-03-25'
			AND duree = 90
			AND renouvellement_auto = 'false'
			AND nom_typeabonnement = '10vehicules'
			AND nom_compteabonne = 'De Finance'
			AND prenom_compteabonne = 'Boris'
			AND date_naissance_compteabonne = '1990-09-08') = 1)
				PRINT('------------------------------Test 1 - OK');
			ELSE
				PRINT('------------------------------Test 1 - abonnement non ajoute - KO');
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
--Test pour une date_debut NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = NULL,					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - abonnement ajoute - KO');
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
--Test pour une duree NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = NULL,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - abonnement ajoute - KO');
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
--Test pour un renouvellement_auto NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = NULL,
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - abonnement ajoute - KO');
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
--Test pour un nom_typeabonnement NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = NULL, 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - abonnement ajoute - KO');
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
--Test pour une nom_compteabonne NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	NULL,
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - abonnement ajoute - KO');
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
--Test pour une prenom_compteabonne NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = NULL, 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - abonnement ajoute - KO');
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
--Test pour une date_naissance_compteabonne NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - abonnement ajoute - KO');
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
