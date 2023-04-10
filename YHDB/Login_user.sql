/* 数据库成功登陆日志 */
SELECT (sd.Name)'数据库',sp.* FROM 
[Master].[dbo].[SYSPROCESSES] sp,[Master].[dbo].[SYSDATABASES] sd
order by login_time desc