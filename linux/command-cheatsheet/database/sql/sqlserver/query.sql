-- Database size
with fs
as
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
)
select 
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
from sys.databases db
where name like 'Stg-BigY%'

-- Get columns of a table
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'MT-Cart';


-- AVAILABILITY GROUP
-- Show databases and corresponding Availability Group
SELECT 
    ag.name AS AvailabilityGroupName,
    adc.database_name AS DatabaseName
FROM 
    sys.availability_groups ag
JOIN 
    sys.availability_databases_cluster adc ON ag.group_id = adc.group_id
ORDER BY 
    ag.name, adc.database_name;

-- Remove a database from an Availability Group
ALTER AVAILABILITY GROUP '52ba2b30-db39-497d-a196-cfddc1778dc4' REMOVE DATABASE [MT-saPickingUAT];  

-- CONNECTION
-- Show connections (Psid/Who/database)
SP_WHO;

-- Filter with SP_WHO columns (Shows connection id, running command, by who ?, ...)
DECLARE @Table TABLE(
        SPID INT,
        Status VARCHAR(MAX),
        LOGIN VARCHAR(MAX),
        HostName VARCHAR(MAX),
        BlkBy VARCHAR(MAX),
        DBName VARCHAR(MAX),
        Command VARCHAR(MAX),
        CPUTime INT,
        DiskIO INT,
        LastBatch VARCHAR(MAX),
        ProgramName VARCHAR(MAX),
        SPID_1 INT,
        REQUESTID INT
)

INSERT INTO @Table EXEC sp_who2;

SELECT  *
FROM    @Table
WHERE DBName like '%saPickingUAT%';

-- Delete all connections for a database

DECLARE @spid INT;
DECLARE spid_cursor CURSOR FOR 
    SELECT spid 
    FROM sys.sysprocesses 
    WHERE dbid = DB_ID('MT-saPickingUAT');

OPEN spid_cursor;

FETCH NEXT FROM spid_cursor INTO @spid;

WHILE @@FETCH_STATUS = 0 
BEGIN 
    EXEC('KILL ' + @spid); 
    FETCH NEXT FROM spid_cursor INTO @spid; 
END;

CLOSE spid_cursor;
DEALLOCATE spid_cursor;

-- Terminate connection
KILL <PSID>;

-- List all file (data + log) partition for a backup (.bak) file
RESTORE FILELISTONLY FROM DISK = 'D:\SQDECLARE @spid INT; DECLARE spid_cursor CURSOR FOR SELECT spid FROM sys.sysprocesses WHERE dbid = DB_ID('MT-saPickingUAT'); OPEN spid_cursor; FETCH NEXT FROM spid_cursor INTO @spid; WHILE @@FETCH_STATUS = 0 BEGIN EXEC('KILL ' + @spid); FETCH NEXT FROM spid_cursor INTO @spid; END; CLOSE spid_cursor; DEALLOCATE spid_cursor;LBackup\BigYProduction\BigYv6-DistributionCore\backup-20241115-114905.bak' 

-- Change data/log file name
ALTER DATABASE my_renamed_db SET OFFLINE;
ALTER DATABASE my_renamed_db MODIFY FILE (NAME='data_file_name', FILENAME='d:\dbs\data\my_renamed_db.mdf');
ALTER DATABASE my_renamed_db MODIFY FILE (NAME='log_file_name', FILENAME='d:\dbs\data\my_renamed_db.ldf');
ALTER DATABASE my_renamed_db SET ONLINE;

-- USER & ROLES
-- Change login user password
ALTER LOGIN [login_name] WITH PASSWORD = 'new_password';

-- Check current permission
SELECT * 
FROM fn_my_permissions(NULL, 'SERVER')  

-- Check server role
SELECT 
    ag.name AS AvailabilityGroupName,
    ar.replica_server_name AS ReplicaServerName,
    ar.role_desc AS ReplicaRole
FROM 
    sys.availability_groups ag
JOIN 
    sys.availability_replicas ar ON ag.group_id = ar.group_id;

-- Rename database
USE rdsadmin;
GO
ALTER DATABASE [MT-saPickingUAT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE [MT-saPickingUAT] MODIFY NAME = [MT-saPicking];
GO
ALTER DATABASE [MT-saPicking] SET MULTI_USER;
GO