------------------------------------------------------------
-- Fichier     : Procedure_createModele
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createModele
GO

-- Cette procedure permet de creer un nouveau modele

CREATE PROCEDURE dbo.createModele
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
<<<<<<< HEAD
		portieres,
		a_supprimer
=======
		portieres
>>>>>>> 40b334c4f066b4dcc2ed0e9590974cd10a6cf120
	)
	VALUES (
		@marque,
		@serie,
		@type_carburant,
		@annee,
		@prix,
		@reduction,
		@portieres
	);
	
GO

