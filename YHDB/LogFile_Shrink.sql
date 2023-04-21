

alter database YH107 set recovery simple
go
use YH107
dbcc shrinkfile('YH107_log', 1024)
go
-- 2022-12-16 按此脚本将YH100_log收缩至了1M大小……
alter database YH100 set recovery FULL
go
USE [YH108]
GO
DBCC SHRINKFILE (N'YH108_log' , 1024)
GO

/* 复查log文件大小排序后，调整了偏大的基础KIS对接库恢复类型 */
alter database YH103 set recovery simple
go
alter database YH104 set recovery simple
go
alter database YH105 set recovery simple
go
alter database YH115 set recovery simple
go
alter database YH106 set recovery simple
go
alter database YH102 set recovery simple
go
alter database YH113 set recovery simple
go
alter database YH313 set recovery simple
go