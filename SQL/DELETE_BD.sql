USE master;
ALTER DATABASE priemka
SET SINGLE_USER;
GO
EXEC sp_detach_db 'priemka', 'true';
GO
DROP login [admin]
GO
DROP login backupscr
GO
DROP login userZ
GO
DROP login clerk
GO
DROP login [NoNAuth]
GO
