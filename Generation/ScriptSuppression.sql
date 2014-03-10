------------------------------------------------------------
-- Fichier     : ScriptSuppression
-- Date        : 17/02/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteurs  : Seyyid Ouir , Baiche
-- Testeurs     : Baiche, Seyyid Ouir
-- Integrateur : 
-- Commentaire : Supprimer toutes les tables si elle existent
------------------------------------------------------------

USE TAuto_IBDR
PRINT('Suppression des tables ');
PRINT('=======================');

GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CatalogueCategorie') 
BEGIN
DROP TABLE CatalogueCategorie;
PRINT('Table CatalogueCategorie supprim�e');
END
ELSE PRINT('La table CatalogueCategorie n''existe pas ');
 GO
 
GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ReservationVehicule') 
BEGIN
DROP TABLE ReservationVehicule;
PRINT('Table ReservationVehicule supprim�e');
END
ELSE PRINT('La table ReservationVehicule n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CategorieModele') 
BEGIN
DROP TABLE CategorieModele;
PRINT('Table CategorieModele supprim�e');
END
ELSE PRINT('La table CategorieModele n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ConducteurLocation') 
BEGIN
DROP TABLE ConducteurLocation;
PRINT('Table ConducteurLocation supprim�e');
END
ELSE PRINT('La table ConducteurLocation n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CompteAbonneConducteur') 
BEGIN
DROP TABLE CompteAbonneConducteur;
PRINT('Table CompteAbonneConducteur supprim�e');
END
ELSE PRINT('La table CompteAbonneConducteur n''existe pas ');
 GO


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Catalogue') 
BEGIN
DROP TABLE Catalogue;
PRINT('Table Catalogue supprim�e');
END
ELSE PRINT('La table Catalogue n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Categorie') 
BEGIN
DROP TABLE Categorie;
PRINT('Table Categorie supprim�e');
END
ELSE PRINT('La table Categorie n''existe pas ');
 GO


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='SousPermis') 
BEGIN
DROP TABLE SousPermis;
PRINT('Table SousPermis supprim�e');
END
ELSE PRINT('La table SousPermis n''existe pas ');
 GO


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Conducteur') 
BEGIN
DROP TABLE Conducteur;
PRINT('Table Conducteur supprim�e');
END
ELSE PRINT('La table Conducteur n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Permis') 
BEGIN
DROP TABLE Permis;
PRINT('Table Permis supprim�e');
END
ELSE PRINT('La table Permis n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Reservation') 
BEGIN
DROP TABLE Reservation;
PRINT('Table Reservation supprim�e');
END
ELSE PRINT('La table Reservation n''existe pas ');
 GO
 
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Infraction') 
BEGIN
DROP TABLE Infraction;
PRINT('Table Infraction supprim�e');
END
ELSE PRINT('La table Infraction n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Incident') 
BEGIN
DROP TABLE Incident;
PRINT('Table Incident supprim�e');
END
ELSE PRINT('La table Incident n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Retard') 
BEGIN
DROP TABLE Retard;
PRINT('Table Retard supprim�e');
END
ELSE PRINT('La table Retard n''existe pas ');
 GO
 


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Location') 
BEGIN
DROP TABLE Location;
PRINT('Table Location supprim�e');
END
ELSE PRINT('La table Location n''existe pas ');
 GO
 


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Vehicule') 
BEGIN
DROP TABLE Vehicule;
PRINT('Table Vehicule supprim�e');
END
ELSE PRINT('La table Vehicule n''existe pas ');
 GO



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Modele') 
BEGIN
DROP TABLE Modele;
PRINT('Table Modele supprim�e');
END
ELSE PRINT('La table Modele n''existe pas ');
 GO


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ContratLocation') 
BEGIN
DROP TABLE ContratLocation;
PRINT('Table ContratLocation supprim�e');
END
ELSE PRINT('La table ContratLocation n''existe pas ');
 GO
 


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Abonnement') 
BEGIN
DROP TABLE Abonnement;
PRINT('Table Abonnement supprim�e');
END
ELSE PRINT('La table Abonnement n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='TypeAbonnement') 
BEGIN
DROP TABLE TypeAbonnement;
PRINT('Table TypeAbonnement supprim�e');
END
ELSE PRINT('La table TypeAbonnement n''existe pas ');
 GO
 
 
 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='RelanceDecouvert') 
BEGIN
DROP TABLE RelanceDecouvert;
PRINT('Table RelanceDecouvert supprim�e');
END
ELSE PRINT('La table RelanceDecouvert n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Particulier') 
BEGIN
DROP TABLE Particulier;
PRINT('Table Particulier supprim�e');
END
ELSE PRINT('La table Particulier n''existe pas ');
 GO
 


 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Entreprise') 
BEGIN
DROP TABLE Entreprise;
PRINT('Table Entreprise supprim�e');
END
ELSE PRINT('La table Entreprise n''existe pas ');
 GO
 



 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='CompteAbonne') 
BEGIN
DROP TABLE CompteAbonne;
PRINT('Table CompteAbonne supprim�e');
END
ELSE PRINT('La table CompteAbonne n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Facturation') 
BEGIN
DROP TABLE Facturation;
PRINT('Table Facturation supprim�e');
END
ELSE PRINT('La table Facturation n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='Etat') 
BEGIN
DROP TABLE Etat;
PRINT('Table Etat supprim�e');
END
ELSE PRINT('La table Etat n''existe pas ');
 GO
 

 GO
IF  EXISTS (SELECT * FROM sys.tables t INNER join sys.schemas s on (t.schema_id = s.schema_id) WHERE s.name='dbo' and t.name='ListeNoire') 
BEGIN
DROP TABLE ListeNoire;
PRINT('Table ListeNoire supprim�e');
END
ELSE PRINT('La table ListeNoire n''existe pas ');
 GO
 

PRINT('
Suppression de l''assembly ');
PRINT('=======================');
GO
 
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[clrRegex]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
DROP FUNCTION [dbo].[clrRegex];
PRINT('Function clrRegex supprim�e');
END
ELSE PRINT('La function clrRegex n''existe pas ');
GO


IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'RegExFunc' and is_user_defined = 1)
BEGIN
DROP ASSEMBLY [RegExFunc]
PRINT('Assembly RegExFunc supprim�e');
END
ELSE PRINT('L''assembly RegExFunc n''existe pas ');
GO