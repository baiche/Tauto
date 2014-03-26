set SERVERNAME=.\SQLEXPRESS
set DATABASENAME=TAuto_IBDR.dbo
sqlcmd -E -S %SERVERNAME% -d master -Q "exec TAuto_IBDR.dbo.checkImpayeTriggerRec"

set /p toto=press :