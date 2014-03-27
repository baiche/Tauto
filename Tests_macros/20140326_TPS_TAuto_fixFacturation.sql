------------------------------------------------------------
-- Fichier     : 26140325_TPS_TAuto_fixFacturation
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la de l'inscription du paiement 
-- de la facture. 
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON

/*
	dbo.fixFacturation
	@id_contrat					nvarchar(50),	-- PK
	@matricule 					nvarchar(50),	-- PK
	@date_reception				date			-- nullable
*/

--Test 1
-- cas ou la date indique precede la date de creation de la facturation
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = '2014-03-20'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
--cas ou la date indique est dans le future
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = '2019-03-25'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Erreur valeur de retour - KO');
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
--cas ou la facture a deja ete regle
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 6,		
		@matricule		= '0775896wi',
		@date_reception = '2014-03-25'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Erreur valeur de retour - KO');
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
--cas nominal 
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = '2014-03-25'
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = 9
						AND matricule_vehicule = '2775896wi')) IS NULL)
			BEGIN
				PRINT('------------------------------Test 4 - La facturation n''a pas ete regle - KO')
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 4 - OK');
			END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - Erreur valeur de retour - KO');	
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
--cas ou l'argument date_reception est null
BEGIN TRY
	UPDATE Facturation
	SET date_reception = NULL
	WHERE id = (SELECT id_facturation 
				FROM Location
				WHERE id_contratLocation = 9
				AND matricule_vehicule = '2775896wi')

	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = NULL
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = 9
						AND matricule_vehicule = '2775896wi')) IS NULL)
			BEGIN
				PRINT('------------------------------Test 5 - La facturation n''a pas ete regle - KO')
			END
			ELSE
			BEGIN
				IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = 9
						AND matricule_vehicule = '2775896wi')) <> CAST(GETDATE() As Date))
				BEGIN
					PRINT('------------------------------Test 5 - Mauvaise date inseree - KO')
				END
				ELSE
				BEGIN		
					PRINT('------------------------------Test 5 - OK');
				END
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