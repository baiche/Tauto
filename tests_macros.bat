@echo off
rem ----------------------------------------------------------------------------
rem -- Fichier     : tests_contrainte.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : La base est censé être créé et vide au lancement des tests
rem ----------------------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

@echo on
cd Tests_macros

echo Debut des tests des macro-procedures > ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt


rem declareConducteur
echo Test declareConducteur >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_Conducteur_declareConducteur.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem endContratLocation
echo Test endContratLocation >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_endContratLocation.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem endEtat
echo Test endEtat >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_endEtat.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem makeCatalogue
echo Test makeCatalogue >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_makeCatalogue.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem makeCompteParticulier
echo Test makeCompteParticulier >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_makeCompteParticulier.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem makeEtat
echo Test makeEtat >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_makeEtat.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem makeTypeAbonnement
echo Test makeTypeAbonnement >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_makeTypeAbonnement.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem turnReservationIntoContratLocation
echo Test turnReservationIntoContratLocation >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_turnReservationIntoContratLocation.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem makeCompteEntreprise
echo Test makeCompteEntreprise >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140323_TPS_TAuto_makeCompteEntreprise.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem modifyCompte
echo Test modifyCompte >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140323_TPS_TAuto_modifyCompte.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem closeCompte
echo Test closeCompte >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140324_TPS_TAuto_closeCompte.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem makeAbonnement
echo Test makeAbonnement >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140324_TPS_TAuto_makeAbonnement.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

rem searchVehicule
echo Test searchVehicule >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140324_TPS_TAuto_searchVehicule.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

echo.
echo _________________________________________
echo Rapport genere : rapport_tests_macros.txt
echo _________________________________________

cd ..
if "%1"=="nopause" goto start
pause
:start