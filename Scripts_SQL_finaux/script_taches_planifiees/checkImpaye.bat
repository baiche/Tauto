call .\set_metadata.bat
sqlcmd -E -S %SERVERNAME% -d master -Q "exec TAuto_IBDR.dbo.checkImpayeTriggerRec"

set /p toto=press :