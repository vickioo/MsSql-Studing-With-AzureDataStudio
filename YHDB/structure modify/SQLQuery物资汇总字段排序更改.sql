/*
YH100 的部署脚本

此代码由工具生成。
如果重新生成此代码，则对此文件的更改可能导致
不正确的行为并将丢失。
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "YH100"
:setvar DefaultFilePrefix "YH100"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
请检测 SQLCMD 模式，如果不支持 SQLCMD 模式，请禁用脚本执行。
要在启用 SQLCMD 模式后重新启用脚本，请执行:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'要成功执行此脚本，必须启用 SQLCMD 模式。';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'正在禁用所有 DDL triggers...'
GO
DISABLE TRIGGER ALL ON DATABASE
GO

IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
BEGIN TRANSACTION
GO
PRINT N'正在开始重新生成表 [dbo].[T_剩余计划物资汇总]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_T_剩余计划物资汇总] (
    [工厂]     NVARCHAR (MAX)  NULL,
    [类别]     VARCHAR (255)   NULL,
    [分类码]    VARCHAR (10)    NULL,
    [ERP代码]  VARCHAR (8000)  NULL,
    [子项代码]   VARCHAR (80)    NULL,
    [子项名称]   VARCHAR (255)   NULL,
    [子项基本单位] VARCHAR (80)    NULL,
    [全量]     FLOAT (53)      NULL,
    [批量]     FLOAT (53)      NULL,
    [淘系]     FLOAT (53)      NULL,
    [请购数量]   FLOAT (53)      NULL,
    [采购数量]   FLOAT (53)      NULL,
    [入库数量]   FLOAT (53)      NULL,
    [已定未下]   FLOAT (53)      NULL,
    [采购在途]   FLOAT (53)      NULL,
    [材料日用量]  DECIMAL (18, 2) NULL,
    [交期]     INT             NULL,
    [安全库存]   DECIMAL (18, 2) NULL,
    [当前库存]   DECIMAL (18, 2) NULL,
    [工厂库存]   DECIMAL (18, 2) NULL,
    [剩余库存]   FLOAT (53)      NULL,
    [数据更新时间] DATETIME        NULL
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[T_剩余计划物资汇总])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_T_剩余计划物资汇总] ([工厂], [类别], [分类码], [ERP代码], [子项代码], [子项名称], [子项基本单位], [全量], [批量], [淘系], [材料日用量], [交期], [安全库存], [当前库存], [请购数量], [采购数量], [入库数量], [已定未下], [采购在途], [剩余库存], [数据更新时间], [工厂库存])
        SELECT [工厂],
               [类别],
               [分类码],
               [ERP代码],
               [子项代码],
               [子项名称],
               [子项基本单位],
               [全量],
               [批量],
               [淘系],
               [材料日用量],
               [交期],
               [安全库存],
               [当前库存],
               [请购数量],
               [采购数量],
               [入库数量],
               [已定未下],
               [采购在途],
               [剩余库存],
               [数据更新时间],
               [工厂库存]
        FROM   [dbo].[T_剩余计划物资汇总];
    END

DROP TABLE [dbo].[T_剩余计划物资汇总];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_T_剩余计划物资汇总]', N'T_剩余计划物资汇总';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF OBJECT_ID(N'tempdb..#tmpErrors') IS NULL
    CREATE TABLE [#tmpErrors] (
        Error INT
    );

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO

IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT N'数据库更新的事务处理部分成功。'
COMMIT TRANSACTION
END
ELSE PRINT N'数据库更新的事务处理部分失败。'
GO
IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
GO
PRINT N'正在重新启用 DDL triggers...'
GO
ENABLE TRIGGER [Trig_DBVersionController] ON DATABASE
GO
PRINT N'更新完成。';


GO
