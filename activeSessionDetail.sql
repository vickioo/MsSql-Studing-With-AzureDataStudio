SELECT
session_id AS [Active Sessions], login_time AS [Login Time], host_name AS [Host Name], program_name AS [Program Name], login_name AS [Login Name]
FROM sys.dm_exec_sessions
WHERE [status] = 'running'