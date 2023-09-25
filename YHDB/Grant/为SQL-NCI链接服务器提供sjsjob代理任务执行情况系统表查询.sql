use [msdb]
GO
/* [42000] [Microsoft][ODBC Driver 17 for SQL Server][SQL Server]链接服务器 "databasei" 的 OLE DB 访问接口 "SQLNCLI11" 不包含表 ""msdb"."dbo"."sysjobs""。该表不存在，或者当前用户没有访问该表的权限。 (7314)
为解决上述报错添加链接服务器公用账户授权  */
GRANT SELECT ON [dbo].[sysjobs] TO [public]
GO
GRANT SELECT ON [dbo].[sysjobsteps] TO [public]
GRANT SELECT ON [dbo].[sysjobhistory] TO [public]
GO
GRANT SELECT ON [dbo].[sysjobservers] TO [public]
GO
--use [msdb]
--GO
--REVOKE SELECT ON [dbo].[sysjobs] TO [public] AS [dbo]
--GO
