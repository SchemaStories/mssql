DECLARE @BackupFile nvarchar(4000) = '$(BACKUP_FILE)';
DECLARE @DbName sysname;

-- Infer DB name from filename
SET @DbName = REPLACE(
                RIGHT(@BackupFile, CHARINDEX('/', REVERSE(@BackupFile)) - 1),
                '.bak', ''
              );

PRINT 'Restoring database: ' + @DbName;
PRINT 'From backup: ' + @BackupFile;

DECLARE @sql nvarchar(max);

SET @sql = N'
RESTORE DATABASE [' + @DbName + ']
FROM DISK = N''' + @BackupFile + '''
WITH
  MOVE ''*'' TO ''/var/opt/mssql/data/' + @DbName + ''',
  REPLACE,
  RECOVERY;
';

-- NOTE: MOVE '*' requires SQL Server 2022+
EXEC (@sql);
