/* 标准恢复库附加操作语句 */
--USE [master]
--GO
--CREATE DATABASE [YH101] ON 
--( FILENAME = N'/mnt/0009DC270007488C/DBDATA/YH101.mdf' ),
--( FILENAME = N'/mnt/0009DC270007488C/DBDATA/YH101_log.ldf' )
-- FOR ATTACH
--GO
/* 联查可用库vsKIS库名单 */
--select --database_id,
--name, SName
--from ( select 
--			case when id is null then 'YH' + cast(KCode as varchar) else id end as Code,SName
--		from [database].YH100.dbo.t_zt
--		where KCode <100 or KCode >300
--	) as zt
--full join [database].master.sys.databases on Code=name
----where Code is not null
--order by Code
--GO

/* ----------------
  完整文件附加恢复数据库过程 */
declare @t datetime, @t2 datetime
declare @code nvarchar(8), @name nvarchar(10)
declare curs insensitive cursor for
select 
	case when id is null then 'YH' + cast(KCode as varchar) else id end as Code,SName
from [database].YH100.dbo.t_zt
--where KCode <100 or KCode >300
;

set @t = GETDATE()
open curs
fetch next from curs
into @code, @name
while @@FETCH_STATUS=0
begin
	--SET STATISTICS TIME ON
	--if @code > 'YH102' and @code < 'YH300'
	--if @code > 'YH300'
	if @code > 'YH110' and @code < 'YH300'
	begin
		print '当前处理的是 ' + @code + '数据库: ' + @name + '账套, T-SQL语句为：'
		print 'CREATE DATABASE [' + @code + '] ON'
		print '  ( FILENAME = ''/mnt/0009DC270007488C/DBDATA/' + @code + '.mdf''),'
		print '  ( FILENAME = ''/mnt/0009DC270007488C/DBDATA/' + @code + '_log.ldf'')'
		print 'FOR ATTACH'
		EXEC ( 'CREATE DATABASE [' + @code + '] ON'
			+ '  ( FILENAME = N''/mnt/0009DC270007488C/DBDATA/' + @code + '.mdf''),'
			+ '  ( FILENAME = N''/mnt/0009DC270007488C/DBDATA/' + @code + '_log.ldf'')'
			+ 'FOR ATTACH' )
		print '--执行耗时：' + cast(datediff(ms, @t, getdate()) as varchar) + ' ms'
		set @t = getdate()
		print ''
	end
	--SET STATISTICS TIME OFF
	fetch next from curs into @code, @name
end
close curs
deallocate curs

/* ---------------- 
  手工处理、数字构造 */
CREATE DATABASE [YHRBB_DB] ON 
( FILENAME = N'/mnt/0009DC270007488C/DBDATA/YHRBB_DB.mdf' ),
( FILENAME = N'/mnt/0009DC270007488C/DBDATA/YHRBB_DB_log.ldf' )
 FOR ATTACH
GO
/* 简易循环处理demo */
declare @i int
set @i = 1

while @i < 9
begin
print '目标数据库：YH10' + cast(@i as varchar)
	-- CREATE DATABASE [YH103] ON 
	-- ( FILENAME = N'/mnt/0009DC270007488C/DBDATA/YH103.mdf' ),
	-- ( FILENAME = N'/mnt/0009DC270007488C/DBDATA/YH103_log.ldf' )
	--  FOR ATTACH
set @i = @i + 1
end