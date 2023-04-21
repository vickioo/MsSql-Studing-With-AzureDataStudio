/* 批量对数据库中表+视图对象，授予二级授权权限语句 */
USE YH100;
GO

DECLARE @TableName NVARCHAR(128);
DECLARE @SqlStatement NVARCHAR(MAX);

DECLARE table_cursor CURSOR FOR
SELECT QUOTENAME(s.name) + '.' + QUOTENAME(o.name) AS TableName
FROM sys.objects o
INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE o.type IN ('U', 'V') -- 只选择用户表和视图
ORDER BY s.name, o.name;
/* 请确认此处即将授权的表单明细，默认包含所有表+视图 */
OPEN table_cursor;

FETCH NEXT FROM table_cursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SqlStatement = 'GRANT SELECT ON ' + @TableName + ' TO [DATABASE\TestAdmin]'
     + 'WITH GRANT OPTION;'  --重要二级授权权限
     ;
    print @SqlStatement;
    EXEC sp_executesql @SqlStatement;
    print '已授权';

    FETCH NEXT FROM table_cursor INTO @TableName;
END;

CLOSE table_cursor;
DEALLOCATE table_cursor;
