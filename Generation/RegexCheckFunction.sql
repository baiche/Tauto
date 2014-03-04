USE TAuto_IBDR;
GO

sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

CREATE ASSEMBLY RegExFunc FROM 'C:\Users\allan.STARWARS\Desktop\SQLServerCLR\SQLServerCLR\bin\Debug\SQLServerCLR.dll'
GO

CREATE FUNCTION dbo.clrRegex  
(  
 @pattern as nvarchar(200),
 @matchString as nvarchar(200)  
)   
RETURNS bit 
AS EXTERNAL NAME RegExFunc.[SQLServerCLR.RegExCompiled].RegExCompiledMatch
GO