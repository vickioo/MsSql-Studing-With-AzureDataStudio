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
PRINT N'正在开始重新生成表 [dbo].[安全库存]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_安全库存] (
    [账套名]      NVARCHAR (MAX)  NULL,
    [账套个数]     INT             NULL,
    [子项代码]     VARCHAR (80)    NULL,
    [子项名称]     VARCHAR (255)   NULL,
    [单位]       VARCHAR (80)    NULL,
    [当前库存]     DECIMAL (18, 2) NULL,
    [煜宠库存]     DECIMAL (18, 2) NULL,
    [煜韩库存]     DECIMAL (18, 2) NULL,
    [在途量]      DECIMAL (18, 2) NULL,
    [交期]       INT             NOT NULL,
    [起订量]      NUMERIC (18)    NOT NULL,
    [材料日用量]    DECIMAL (18, 2) NULL,
    [安全库存]     DECIMAL (18, 2) NULL,
    [原料计量单位]   VARCHAR (80)    NULL,
    [领料数量]     FLOAT (53)      NULL,
    [供应链材料日用量] FLOAT (53)      NULL,
    [供应链安全库存]  FLOAT (53)      NULL,
    [数据更新时间]   DATETIME        NULL
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[安全库存])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_安全库存] ([账套名], [账套个数], [子项代码], [子项名称], [单位], [当前库存], [在途量], [交期], [起订量], [材料日用量], [安全库存], [原料计量单位], [领料数量], [供应链材料日用量], [供应链安全库存], [数据更新时间], [煜宠库存], [煜韩库存])
        SELECT [账套名],
               [账套个数],
               [子项代码],
               [子项名称],
               [单位],
               [当前库存],
               [在途量],
               [交期],
               [起订量],
               [材料日用量],
               [安全库存],
               [原料计量单位],
               [领料数量],
               [供应链材料日用量],
               [供应链安全库存],
               [数据更新时间],
               [煜宠库存],
               [煜韩库存]
        FROM   [dbo].[安全库存];
    END

DROP TABLE [dbo].[安全库存];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_安全库存]', N'安全库存';

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
