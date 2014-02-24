------------------------------------------------------------
-- Fichier     : Procedure_Modele
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO

-- Cette procedure permet de creer un nouveau modele

CREATE PROCEDURE TAuto.createModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@annee 					int,
	@prix 					money,
	@reduction 				tinyint,
	@portieres 				tinyint
AS
	INSERT INTO Modele(
		marque,
		serie,
		type_carburant,
		annee,
		prix,
		reduction,
		portieres,
		actif
	)
	VALUES (
		@marque,
		@serie,
		@type_carburant,
		@annee,
		@prix,
		@reduction,
		@portieres,
		DEFAULT
	);
	
GO

-- Cette procedure permet de modifier le prix d'un modele

CREATE PROCEDURE TAuto.updatePrixModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@prix 					money,
	@portieres 				tinyint
AS
	UPDATE Modele
	SET prix = @prix
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;

GO

-- Cette procedure permet de modifier le pourcentage de reduction du prix du modele

CREATE PROCEDURE TAuto.updateReductionModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@reduction 				tinyint,
	@portieres 				tinyint
AS
	UPDATE Modele
	SET reduction = @reduction
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;
		
GO

-- Cette procedure rend le modele inactif sans reellement le delete pour eviter la perte d'information

CREATE PROCEDURE TAuto.deleteModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@portieres 				tinyint
AS
	UPDATE Modele
	SET actif = 'false'
	WHERE marque = @marque AND serie = @serie AND type_carburant = @type_carburant AND portieres = @portieres;
GO