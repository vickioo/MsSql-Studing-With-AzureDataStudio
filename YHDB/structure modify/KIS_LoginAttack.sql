/* 查验数据库服务器内账号安全设置
EXEC sp_configure 'show advanced options', 1;  
RECONFIGURE;  

EXEC sp_configure;
*/
/*****************************
 第一套数据：服务器受外网跟踪攻击信息跟踪备案Proc 
 *****************************/
-- 00 创建临时过渡表
IF OBJECT_ID('tempdb.dbo.#templog') IS NOT NULL
	DROP TABLE #templog
CREATE TABLE #templog
(
    LogDate     DATETIME,
    ProcessInfo NVARCHAR ( 20 ),
    Text        NVARCHAR ( 1000 ),
)
-- 01 检查日志最新记录/滚动截断情况
exec sys.xp_enumerrorlogs
-- 02 清理临时筛选表，放入最新/选定（第一参数按编号选择）日志文件内指定记录信息
Insert into #templog
    EXEC sp_readerrorlog 0, 1, 'Login', 'failed' 
SELECT * FROM #templog -- where LogDate > '2023-03-24 00:00'
-- 03 按条目时间戳增量追加至持久化攻击日志表，以供分析使用
INSERT INTO DBCControl.dbo.log_LoginAttack
SELECT * FROM #templog WHERE LogDate > (select /* TOP 1 */ max(LogDate) from DBCControl.dbo.log_LoginAttack /* group by ProcessInfo */)

/*****************************
 第二套数据：全量日志滚存 
 *****************************/
TRUNCATE TABLE #templog
Insert into #templog EXEC sp_readerrorlog 6, 1 -- , 'Login', 'failed' 
Insert into #templog EXEC sp_readerrorlog 5, 1
Insert into #templog EXEC sp_readerrorlog 4, 1
Insert into #templog EXEC sp_readerrorlog 3, 1
Insert into #templog EXEC sp_readerrorlog 2, 1
Insert into #templog EXEC sp_readerrorlog 1, 1
Insert into #templog
    EXEC sp_readerrorlog 0, 1

Begin
    DECLARE @lateStartTime datetime
    SELECT @lateStartTime = MIN(LogDate) FROM #templog
    SELECT count(*) FROM #templog -- where LogDate > '2023-03-24 00:00'
    
    -- 03 按条目时间戳增量追加至持久化攻击日志表，以供分析使用
    SELECT 'New lines: ' + convert(varchar, count(*)) FROM #templog WHERE LogDate > ( select max(LogDate) from DBCControl.dbo.log_Bak )
    INSERT INTO DBCControl.dbo.log_Bak
    SELECT * FROM #templog WHERE LogDate > ( select max(LogDate) from DBCControl.dbo.log_Bak )

    select MIN(LogDate), count(*), MAX(LogDate) /* delete */ from DBCControl.dbo.log_Bak where LogDate >= @lateStartTime
END
/* **************************** */
DROP TABLE #templog
/* 部分异常攻击记录
Login failed for user 'sa'. 原因: 密码与所提供的登录名不匹配。 [客户端: 183.214.245.212]
Login failed. The login is from an untrusted domain and cannot be used with Windows authentication. [客户端: 120.202.163.144]
Login failed for user 'sa'. 原因: 密码与所提供的登录名不匹配。 [客户端: 221.193.231.50]
*/

/* 2023-4-21查询的日志文件情况记录
0	04/14/2023  11:20	27975010
1	04/04/2023  17:44	2127088
2	04/04/2023  09:57	1599200
3	04/03/2023  14:06	238720
4	04/03/2023  14:01	1531890
5	04/03/2023  09:53	7058460
6	03/31/2023  16:07	1176218 */