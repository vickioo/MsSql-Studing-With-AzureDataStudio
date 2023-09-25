

USE [msdb]
GO
CREATE USER [hwz] FOR LOGIN [hwz]
GO
USE [msdb]
GO
ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [hwz]
GO
USE [msdb]
GO
ALTER ROLE [SQLAgentReaderRole] ADD MEMBER [hwz]
GO
USE [msdb]
GO
ALTER ROLE [SQLAgentUserRole] ADD MEMBER [hwz]
GO
