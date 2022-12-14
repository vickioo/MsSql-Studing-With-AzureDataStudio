/* 表空间 */
if exists(select 1 from tempdb..sysobjects where id=object_id('tempdb..#test') and xtype='u')
drop table #test
go
create table #test
(
    name       varchar(50),
    rows       int,
    reserved   varchar(20),
    data       varchar(20),
    index_size varchar(20),
    unused     varchar(20)
)
 
insert into #test 
exec sp_MSforeachtable "exec sp_spaceused '?'"
select * from  #test   order by cast(replace(reserved,'KB','') as int) desc 