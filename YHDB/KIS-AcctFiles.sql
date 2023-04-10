with fs
as
(
    select database_id, type, size * 8.0 / 1024/1024 size
    from sys.master_files
)
,
kis as (select --*
FAcctNumber, FAcctName, FDBName
 from [AcctCtl_KEE].[dbo].[t_ad_kdAccount_gl]
)
select top 100
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
    , FAcctNumber, FAcctName
from sys.databases db
left join kis on name= FDBName
where database_id > 4
order by DataFileSizeMB desc


