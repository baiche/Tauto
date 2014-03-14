------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_endContratLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de fin de contrat de location
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.endContratLocation
		@id	= 3
			
	IF ( @ReturnValue = 1 AND (SELECT kilometrage FROM Vehicule WHERE matricule='0775896wr') = 25000 ) -- 25000
	BEGIN
		PRINT('------------------------------Test 1 - Tuples modifiés');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuples non modifiés');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id	= 3 AND
			date_fin_effective = CONVERT(date, GETDATE())
		) = 1 AND
			(SELECT COUNT (*) FROM Vehicule WHERE
			matricule = '0775896wr' AND
			kilometrage = 25000
		) = 1)
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK - aucune méthode pour mettre fin à la location avec les bons km pour le moment');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.endContratLocation 
		@id	= 4
	IF ( @ReturnValue = 1 AND (SELECT kilometrage FROM Vehicule WHERE matricule='0775896wt') = 35000 )
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non modifié');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple modifié');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id = 4 AND
			date_fin_effective IS NOT NULL
		) = 1 AND
			(SELECT COUNT (*) FROM Vehicule WHERE
			matricule = '0775896wt' AND
			kilometrage = 35000
		) = 1)
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO
