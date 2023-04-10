SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_ERPplan_update_time]
ON [dbo].[PMC运营计划]
FOR UPDATE
AS
begin
     update [dbo].[PMC运营计划] set 更新时间 = GETDATE() WHERE 订单编号 IN (SELECT DISTINCT 订单编号 FROM inserted)
  end
GO
ALTER TABLE [dbo].[PMC运营计划] ENABLE TRIGGER [tr_ERPplan_update_time]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录行修改时间戳' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PMC运营计划', @level2type=N'TRIGGER',@level2name=N'tr_ERPplan_update_time'
GO
