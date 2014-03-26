------------------------------------------------------------
-- Fichier     : Procedure_createModele
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createModele
GO



-- Cette procedure permet de desactiver un modele

CREATE PROCEDURE dbo.createModele
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@annee					int,
	@prix					int,
	@reduction				int,
	@portieres 				tinyint
AS
	INSERT INTO Modele(
	marque,
	serie,
	type_carburant,
	annee,prix,reduction,
	portieres,
	a_supprimer
	)  
	VALUES(
	@marque,
	@serie,
	@type_carburant,
	@annee,
	@prix,
	@reduction,
	@portieres,
	'false'
	) ;
GO