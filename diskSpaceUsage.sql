--======================================================================
--View disk space usage for database files
WITH T1 AS (
SELECT DISTINCT
REPLACE(vs.volume_mount_point,':\','') AS Drive_Name ,
CAST(vs.total_bytes / 1024.0 / 1024 / 1024 AS NUMERIC(18,2)) AS Total_Space_GB ,
CAST(vs.available_bytes / 1024.0 / 1024 / 1024  AS NUMERIC(18,2)) AS Free_Space_GB
FROM    sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id) AS vs
)
SELECT
Drive_Name,
-- Total_Space_GB,
Total_Space_GB-Free_Space_GB AS Used_Space_GB,
Free_Space_GB,
CAST(Free_Space_GB*100/Total_Space_GB AS NUMERIC(18,2)) AS Free_Space_Percent
FROM T1