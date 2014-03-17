Pour l'utilisation de ces trois procédures :

DECLARE @FS int
DECLARE @FileID int

EXEC dbo.openFile 'C:SQLtest.txt', @FS OUTPUT, @FileID OUTPUT

EXEC dbo.writeFile @FileID, '1. ceci est un test'
EXEC dbo.writeFile @FileID, '2. ceci est un autre test'

EXEC dbo.closeFile @FS, @FileID