select * from sys.dm_os_sys_info

SELECT wait_type, wait_time_ms  
FROM sys.dm_os_wait_stats;


select * from sys.dm_db_file_space_usage
select * from sys.dm_db_log_space_usage
go
sp_MSindexspace 'ERPSale'
go
sp_MStablespace 'ERPSale'
go