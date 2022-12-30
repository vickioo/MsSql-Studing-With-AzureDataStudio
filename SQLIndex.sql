select max(序号) [Number of Missing Indexes],max(不重复序号) [Tables with Missing Indexes] from
(select
d.[object_id],ROW_NUMBER() OVER(order by d.[object_id]) 序号,
DENSE_RANK() OVER( order by d.[object_id]) 不重复序号
from sys.dm_db_missing_index_groups g
    join sys.dm_db_missing_index_group_stats gs on gs.group_handle = g.index_group_handle
    join sys.dm_db_missing_index_details d on g.index_handle = d.index_handle
where  d.database_id =  d.database_id and d.object_id =  d.object_id
    AND gs.avg_total_user_cost * gs.avg_user_impact * (gs.user_seeks + gs.user_scans) > 10) u