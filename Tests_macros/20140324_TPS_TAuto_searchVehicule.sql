------------------------------------------------------------
-- Fichier     : 20140324_TPS_TAuto_searchVehicule
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure recherche d'un
--				 véhicule
------------------------------------------------------------

USE TAuto_IBDR;
SET NOCOUNT ON
DECLARE @msg VARCHAR(4000)
/*dbo.searchVehicule
	@nom_categorie			nvarchar(50), -- nullable
	@marque 				nvarchar(50), -- nullable
	@serie 					nvarchar(50), -- nullable
	@type_carburant 		nvarchar(50), -- nullable
	@portieres 				tinyint, -- nullable
	@prix_max 				money, -- nullable
	@prix_min 				money, -- nullable
	@date_debut 			date, -- nullable
	@date_fin 				date -- nullable
*/

--Test 1
-- Utilisation de tous les champs 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.searchVehicule
		@nom_categorie = 'Vehicule Simple',
		@marque 	   = 'BMW',
		@serie 		   = '5 F10 M5',
		@type_carburant= 'Diesel',
		@portieres 	   = 5,
		@prix_max 	   = 1000,
		@prix_min 	   = 0,
		@date_debut    = '2014-03-29',
		@date_fin 	   = '2014-03-31';
END TRY
BEGIN CATCH
	SET @msg = ERROR_MESSAGE();
	PRINT('------------------------------Test 1 - Exception leve - KO');
	PRINT(@msg);
END CATCH
GO
