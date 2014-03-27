@echo off
rem ------------------------------------------------------------
rem -- Fichier     : run_script_trigger.bat
rem -- Date        : 27/03/2014
rem -- Version     : 1.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  :
rem -- Testeurs     : 
rem -- Integrateur :
rem -- Commentaire : Met en place le systeme de tache planifiees
rem ------------------------------------------------------------

rem Parametrage des variables (a modifier par l'utilisateur)
set SERVERNAME=.\SQLEXPRESS
set DATABASENAME=TAuto_IBDR.dbo
set PATHTOBATCH=C:\Users\boris\Documents\IBDR\Repository\Scripts_SQL_finaux\script_taches_planifiees


rem Generation des scripts de lancement des procedure stockees
echo generation du fichier checkImpaye.bat
echo sqlcmd -E -S %SERVERNAME% -d master -Q "exec TAuto_IBDR.dbo.checkImpayeTriggerRec" > %PATHTOBATCH%"\checkImpaye.bat"
echo pause >> %PATHTOBATCH%"\checkImpaye.bat"

echo generation du fichier deleteTrigger.bat
echo sqlcmd -E -S %SERVERNAME% -d master -Q "exec TAuto_IBDR.dbo.deleteTrigger" > %PATHTOBATCH%"\deleteTrigger.bat"
echo pause >> %PATHTOBATCH%"\deleteTrigger.bat"

rem Generation du scripts de suppression des taches planifiees
echo  Generation du scripts de suppression des taches planifiees
echo schtasks /delete /TN "TAuto_IBDR_checkImpaye" /F >  %PATHTOBATCH%"\remove_scheduled_task.bat"
echo schtasks /delete /TN "TAuto_IBDR_deleteTrigger" /F >>  %PATHTOBATCH%"\remove_scheduled_task.bat"
echo del %PATHTOBATCH%"\checkImpaye.bat" >> %PATHTOBATCH%"\remove_scheduled_task.bat"
echo del %PATHTOBATCH%"\deleteTrigger.bat" >> %PATHTOBATCH%"\remove_scheduled_task.bat"
echo del %PATHTOBATCH%"\remove_scheduled_task.bat" >> %PATHTOBATCH%"\remove_scheduled_task.bat"

rem Ajout des taches planifiees
echo Ajouts des taches planifiees
schtasks /create /sc Minute /mo 1 /tn "TAuto_IBDR_checkImpaye" /tr %PATHTOBATCH%"\checkImpaye.bat" /F
schtasks /create /sc Minute /mo 1 /tn "TAuto_IBDR_deleteTrigger" /tr %PATHTOBATCH%"\deleteTrigger.bat" /F


if "%1"=="nopause" goto start
pause
:start