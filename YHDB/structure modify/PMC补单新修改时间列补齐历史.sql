DISABLE TRIGGER [dbo].[tr_update_column] ON [dbo].[PMC钉钉补单]
GO

-- update pmc钉钉补单 set 更新时间 = 文件日期
-- where 更新时间 > '2023-04-02'
-- go

ENABLE TRIGGER [dbo].[tr_update_column] ON [dbo].[PMC钉钉补单]
go

SELECT * from PMC钉钉补单
order by 更新时间 desc

-- update PMC运营计划 set 更新时间 = 文件日期
-- where 更新时间 > '2023-04-02'
-- go