SELECT COUNT(session_id) AS [Active Sessions]
FROM sys.dm_exec_sessions
WHERE [status] = 'running'