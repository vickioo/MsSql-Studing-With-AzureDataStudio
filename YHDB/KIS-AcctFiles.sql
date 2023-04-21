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
    (select convert(decimal(10,2), sum(size)) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeGB,
    (select CAST(sum(size) AS decimal(10,2)) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeGB
    , FAcctNumber, FAcctName
from sys.databases db
left join kis on name= FDBName
where database_id > 4
-- and name = 'AIS20210222101523'
order by DataFileSizeGB desc


