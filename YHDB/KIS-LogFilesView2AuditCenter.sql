SELECT TOP (1000) [LogDate]
      ,[ProcessInfo]
      ,[Text]
  FROM [DBCControl].[dbo].[log_Bak]
  where Text not like '%succeeded%' 
    and Text not like '%no user action%'
    and Text not like '%Starting up%'
  order by LogDate desc

--   CHECKDB for database 'AIS20220826160609' finished without errors on 2016-05-08 00:21:27.217 (local time). This is an informational message only; no user action is required.
-- 错误: 3041，严重性: 16，状态: 1。BACKUP failed to complete the command BACKUP DATABASE AIS20210222101523. Check the backup application log for detailed messages.