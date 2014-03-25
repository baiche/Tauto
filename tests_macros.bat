@echo off
rem ----------------------------------------------------------------------------
rem -- Fichier     : tests_contrainte.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : La base est censé être créé et vide au lancement des tests
rem ----------------------------------------------------------------------------

SET mssqlInstanceName=".\"

@echo on
cd Tests_macros

echo Debut des tests des macro-procedures > ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

echo Test makeCatalogue >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_makeCatalogue.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

echo Test makeParticulier >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_makeCompteParticulier.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

echo Test turnReservationIntoContratLocation >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt
cd ..
call .\run_peuplement.bat nopause
cd Tests_macros
sqlcmd -S %mssqlInstanceName% -i 20140310_TPS_TAuto_turnReservationIntoContratLocation.sql >> ..\rapport_tests_macros.txt
echo. >> ..\rapport_tests_macros.txt

echo.
echo _________________________________________
echo Rapport genere : rapport_tests_macros.txt
echo _________________________________________

cd ..
if "%1"=="nopause" goto start
pause
:start