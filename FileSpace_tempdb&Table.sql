/* 临时表数据库空间使用情况 */
USE tempdb;  
GO  
SELECT SUM(unallocated_extent_page_count) AS [free pages],   
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB],
SUM(user_object_reserved_page_count) AS [user object pages used],  
(SUM(user_object_reserved_page_count)*1.0/128) AS [user object space in MB]  
FROM sys.dm_db_file_space_usage;
GO

/* 数据库表文件空间使用情况 */
USE YH100
GO
--判断临时表是否存在，存在则删除重建
if exists(select 1 from tempdb..sysobjects where id=object_id('tempdb..#tabName') and xtype='u')
drop table #tabName
go
create table #tabName(
tabname varchar(100),
rowsNum varchar(100),
reserved varchar(100),
data varchar(100),
index_size varchar(100),
unused_size varchar(100)
)
 
declare @name varchar(100)
declare cur cursor for
select name from sysobjects where xtype='u' order by name
open cur
fetch next from cur into @name
while @@fetch_status=0
begin
    insert into #tabName
    exec sp_spaceused @name
    --print @name
 
    fetch next from cur into @name
end
close cur
deallocate cur

select tabname as '表名',rowsNum as '表数据行数',reserved as '保留大小',data as '数据大小',index_size as '索引大小',unused_size as '未使用大小'
from #tabName
--where tabName not like 't%'
order by cast(rowsNum as int) desc