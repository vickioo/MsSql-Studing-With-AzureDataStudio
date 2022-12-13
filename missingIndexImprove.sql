select
    CONVERT (varchar(30), getdate(), 126) AS runtime,
    db_name(d.database_id) dbname, object_name(d.object_id) tablename, d.index_handle,
    d.equality_columns, d.inequality_columns, d.included_columns, d.statement as fully_qualified_object,
    -- 根据平均时间耗费与索引添加后的影响，计算评估排序
    CONVERT (decimal (28, 1), gs.avg_total_user_cost * gs.avg_user_impact * (gs.user_seeks + gs.user_scans) ) AS improvement_measure,
    -- 参考索引优化语句，注意应用前进行合并项考察
    'CREATE INDEX [missing_index_' + CONVERT (varchar, g.index_group_handle) + '_' + CONVERT (varchar, d.index_handle)
        + '_' + LEFT (PARSENAME(d.statement, 1), 32) + ']'  -- 相比官方示例多在索引名中添加了表名
        + ' ON ' + d.statement
        + ' (' + ISNULL (d.equality_columns,'')
            + CASE WHEN d.equality_columns IS NOT NULL AND d.inequality_columns IS NOT NULL THEN ',' ELSE '' END
            + ISNULL (d.inequality_columns, '')
        + ')'
        + ISNULL (' INCLUDE (' + d.included_columns + ')', '') AS create_index_statement
    , gs.*, d.database_id, d.[object_id]
-- into #temp1
from sys.dm_db_missing_index_groups g
    join sys.dm_db_missing_index_group_stats gs on gs.group_handle = g.index_group_handle
    join sys.dm_db_missing_index_details d on g.index_handle = d.index_handle
where  d.database_id =  d.database_id and d.object_id =  d.object_id
    --    and object_name(d.object_id) = 'ERPSale'
    AND gs.avg_total_user_cost * gs.avg_user_impact * (gs.user_seeks + gs.user_scans) > 10
ORDER BY improvement_measure DESC