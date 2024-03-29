CREATE TABLE #FileSize
(
    dbName        NVARCHAR(128),
    FileName      NVARCHAR(128),
    type_desc     NVARCHAR(128),
    CurrentSizeMB DECIMAL(10,2),
    FreeSpaceMB   DECIMAL(10,2),
    FileId        INT,
    MaxSize       INT,
    Path          NVARCHAR(250)
);

INSERT INTO #FileSize
    (dbName, FileName, type_desc, CurrentSizeMB, FreeSpaceMB, FileId, MaxSize, Path)
exec sp_msforeachdb 
'use [?]; 
 SELECT DB_NAME() AS DbName, 
        name AS FileName, 
        type_desc,
        size/128.0 AS CurrentSizeMB,  
        size/128.0 - CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT)/128.0 AS FreeSpaceMB
        , file_id, max_size, physical_name
FROM sys.database_files
WHERE type IN (0,1);';

SELECT *
FROM #FileSize
WHERE dbName NOT IN ('distribution', 'master', 'model', 'msdb')
    AND FreeSpaceMB > 1
ORDER BY [FileName];

DROP TABLE #FileSize;