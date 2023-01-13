SELECT sj.name AS 作业名称,
    description 描述,
    date_created 创建时间,
    date_modified 修改时间,
    sjs.database_name 数据库名称,
    sjs.subsystem 类型,
    sjs.step_id 步骤顺序,
    sjs.step_name 作业步骤,
    command SQL语句,
    CASE WHEN sjs.last_run_time>95959
        THEN DATETIMEFROMPARTS(
            LEFT(CAST(sjs.last_run_date AS VARCHAR), 4),
            SUBSTRING(CAST(sjs.last_run_date AS VARCHAR), 5, 2), 
            RIGHT(CAST(sjs.last_run_date AS VARCHAR), 2),
            LEFT(CAST(sjs.last_run_time AS VARCHAR), 2),
            SUBSTRING(CAST(sjs.last_run_time AS VARCHAR), 3, 2),
            RIGHT(CAST(sjs.last_run_time AS VARCHAR), 2),
            0) 
        ELSE DATETIMEFROMPARTS(
            LEFT(CAST(sjs.last_run_date AS VARCHAR), 4),
            SUBSTRING(CAST(sjs.last_run_date AS VARCHAR), 5, 2), 
            RIGHT(CAST(sjs.last_run_date AS VARCHAR), 2),
            '0'+LEFT(CAST(sjs.last_run_time AS VARCHAR), 1),
            SUBSTRING(CAST(sjs.last_run_time AS VARCHAR), 2, 2),
            RIGHT(CAST(sjs.last_run_time AS VARCHAR), 2),
            0) 
    END AS 最后运行时间,
    CASE run_status WHEN 0 THEN '失败'
        WHEN 1 THEN '成功'
        WHEN 2 THEN '重试'
        WHEN 3 THEN '取消'
        WHEN 4 THEN '正在进行中'
        ELSE CAST(run_status AS VARCHAR)
    END AS 状态,
    message 提示信息,
    CASE
        WHEN sjh.run_duration > 235959
        THEN CAST((CAST(LEFT(CAST(sjh.run_duration AS VARCHAR), LEN(CAST(sjh.run_duration AS VARCHAR)) - 4) AS INT) / 24) AS VARCHAR) 
            + '.' + RIGHT('00' + CAST(CAST(LEFT(CAST(sjh.run_duration AS VARCHAR), LEN(CAST(sjh.run_duration AS VARCHAR)) - 4) AS INT) % 24 AS VARCHAR), 2) 
            + ':' + STUFF(CAST(RIGHT(CAST(sjh.run_duration AS VARCHAR), 4) AS VARCHAR(6)), 3, 0, ':')
        ELSE STUFF(STUFF(RIGHT(REPLICATE('0', 6) + CAST(sjh.run_duration AS VARCHAR(6)), 6), 3, 0, ':'), 6, 0, ':')
    END AS [运行时长(HH:MM:SS)]
FROM msdb.dbo.sysjobs sj
    LEFT JOIN msdb.dbo.sysjobsteps sjs ON sj.job_id=sjs.job_id
    LEFT JOIN msdb.dbo.sysjobhistory sjh ON sj.job_id =sjh.job_id AND sjs.step_name=sjh.step_name AND sjs.last_run_date=sjh.run_date AND sjs.last_run_time =sjh.run_time