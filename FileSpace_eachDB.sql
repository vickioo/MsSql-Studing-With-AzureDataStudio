/* 数据库空间 */

EXEC sp_spaceused @objname=null, @updateusage = 'FALSE'
GO

/* 遍历所有数据库文件使用情况 */
-- exec sp_MSforeachdb "EXEC sp_spaceused "

-- 表行数遍历慢速统计
-- EXEC sp_MSforeachtable 'SELECT ''?'' TableName, Count(1) NumRecords FROM ?'

-- 数据库文件存储管理信息
-- SELECT file_id, name, type_desc, physical_name, size, max_size FROM sys.database_files;  

/* 单库 表依赖关系 */
use YH101
SELECT OBJECT_NAME(referencing_id) AS refName, *, OBJECT_NAME(referenced_id) AS refedName
FROM sys.sql_expression_dependencies
WHERE ISNULL(OBJECT_NAME(referencing_id),'') + ISNULL(OBJECT_NAME(referenced_id),'') like '%%'
--AND referencing_class <>1