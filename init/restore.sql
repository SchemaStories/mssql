-- Change these names to your DB name + logical file names inside the .bak
-- Tip: run RESTORE FILELISTONLY first to discover logical names.

IF DB_ID(N'AdventureWorks') IS NULL
BEGIN
    PRINT 'Restoring AdventureWorks...';

    RESTORE FILELISTONLY
    FROM DISK = N'/var/opt/mssql/backup/AdventureWorks2019.bak';

    -- After you run the FILELISTONLY once, update the logical names below.
    -- Example logical names often look like: AdventureWorks2022, AdventureWorks2022_log

    RESTORE DATABASE [AdventureWorks]
    FROM DISK = N'/var/opt/mssql/backup/AdventureWorks2019.bak'
    WITH
      MOVE N'AdventureWorks2019'     TO N'/var/opt/mssql/data/AdventureWorks.mdf',
      MOVE N'AdventureWorks2019_log' TO N'/var/opt/mssql/data/AdventureWorks_log.ldf',
      REPLACE,
      RECOVERY;

    PRINT 'Restore complete.';
END
ELSE
BEGIN
    PRINT 'AdventureWorks already exists. Skipping restore.';
END
GO
