/* ----------
  数据库创建时的初始文件：逻辑名称 重命名
*/
USE [YY400]
GO
ALTER DATABASE [YY400] MODIFY FILE (NAME=N'YY01', NEWNAME=N'YY400')
GO
USE [YY400]
GO
ALTER DATABASE [YY400] MODIFY FILE (NAME=N'YY01_log', NEWNAME=N'YY400_log')
GO

/* ----------
  参数化新即时备份，.bak文件命名
*/
DECLARE @t datetime, @time Nvarchar(30), @name Nvarchar(100), @file NVARCHAR(200)
SET @t = GETDATE()
select @time = REPLACE(REPLACE(CONVERT(NVARCHAR(19), @t, 120),' ','_'),':','-')
set @name = N'YY400_LogBackup_'+ @time
set @file = N'/var/opt/mssql/data/YY400_LogBackup_'+ @time +N'.bak'
PRINT '时间戳：' + @time + char(10) + @file + char(10) + @name

USE [master]
ALTER DATABASE [YY400] SET SINGLE_USER /*OFFLINE */
--WITH ROLLBACK IMMEDIATE 不可滥用，需配合近端完整备份+周期间隔的事务备份来执行
--否则会产生数据退回至某一备份版本？
-- 自动生成时间戳-备份文件名：N'YY400_LogBackup_2023-08-28_15-47-15'
BACKUP LOG [YY400] TO  DISK = @file WITH NOFORMAT, NOINIT,  
NAME = @name, NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
--/var/opt/mssql/data\YY400.bak
RESTORE DATABASE [YY400] FROM  DISK = N'/mnt/0009DC270007488C/Kbak/YY400/YY400.bak' WITH  FILE = 6,  
MOVE N'YY400' TO N'/var/opt/mssql/data/YY400.mdf',  
MOVE N'YY400_log' TO N'/mnt/0009DC270007488C/DBDATA/YY400_log.ldf',  NOUNLOAD,  STATS = 5
-- 恢复访问
ALTER DATABASE [YY400] SET MULTI_USER /*ONLINE */
GO

/* ----------
  查询DB逻辑文件名、存放地址
*/
USE [YY400]
SELECT df.[name],
      df.physical_name,
      df.[size],
      df.growth,
      f.[name][filegroup],
      f.is_default
FROM sys.database_files df JOIN sys.filegroups f
ON df.data_space_id = f.data_space_id

