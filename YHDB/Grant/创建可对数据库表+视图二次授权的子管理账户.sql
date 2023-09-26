USE master; -- 切换到 master 数据库
GO

-- 创建登录账号
CREATE LOGIN [DATABASE\bom01] WITH PASSWORD = 'Password';  -- 注意密码更替，最好加上官方推荐的Policy验证等，以遵循系统管理员、数据库管理员设定的或者默认的基本复杂度约定，避免被攻击
GO
-- 授予 "[DATABASE\bom01]" 用户 ALTER ANY LOGIN 权限
GRANT ALTER ANY LOGIN TO [DATABASE\bom01];

USE YH100;
GO
---- 创建管理用户
CREATE USER [DATABASE\bom01] FOR LOGIN [DATABASE\bom01];
-- 授予 "[DATABASE\bom01]" 用户 ALTER ANY USER 权限
GRANT ALTER ANY USER TO [DATABASE\bom01];
-- 授予 "[DATABASE\bom01]" 用户对 "temp01" 表的 CONTROL 权限
GRANT CONTROL ON OBJECT::temPrice TO [DATABASE\bom01];  -- 此项只能授予其自己控制，但不能二级分发

-- 单表二级分发权限授权与收回
GRANT SELECT ON [temPrice] TO [DATABASE\bom01] WITH GRANT OPTION -- 只有这个特殊分发权限可以进行二级授权
REVOKE REFERENCES ON [temPrice] TO [DATABASE\bom01] CASCADE  -- 收回带有二级分发权限的grant时，需要带上这个CASCADE语句
GO
/* 批量进行上面的WithGrantOption管理授权，请参考./YHDB/Enumerate_Grant_Select@WithGrantOption .sql 
   思路为使用动态语句拼接执行，以避免如 sp_MSForEachTable 无法如预期授权的问题 */

-- ------------------------------
-- 开始利用子管理账号（具备特定的数据库-表、视图等对象的特定权限二级分发许可，即with grant option权限）进行终端用户的权限分发
USE YH100;
GO
-- 切换到具有足够权限的账号
execute as LOGIN='DATABASE\bom01'; -- 替换为具有足够权限的账号
	create login yc with password=N'123'
	-- 创建用户账号 "yc2"
	CREATE USER yc2 FOR LOGIN [yc];
	-- 授予 "yc2" 用户对 "temp01" 表的 SELECT、INSERT、UPDATE 和 DELETE 权限
	GRANT SELECT ON temPrice TO yc2;

	USE master; -- 切换到 master 数据库
	GO
	-- 授予 "yc2" 用户登录权限
	ALTER LOGIN yc2 ENABLE;

-- 切换回原始会话的上下文
REVERT;
-- ------------------------------


/* 查询确认在目标数据库中，授予给子管理账号、终端用户账号的权限情况 */
USE YH100; -- 替换为您的数据库名称
GO

-- 查询登录账号权限，并包含更多细节
SELECT 
    pr.[permission_name], 
    pr.[state_desc],
    pr.[class_desc],
    OBJECT_NAME(pr.major_id) AS [object_name],
    USER_NAME(grantor_principal_id) AS [grantor],
    dp.[name] AS [grantee]
    -- pr.[permission_state_desc],
    -- pr.[is_grantable],
    -- pr.[create_date],
    -- pr.[modify_date]
    -- select top 1 * 
FROM 
    sys.database_permissions pr
JOIN 
    sys.database_principals dp ON pr.grantee_principal_id = dp.principal_id
JOIN 
    sys.database_principals gp ON pr.grantor_principal_id = gp.principal_id
WHERE 
    dp.[name] = 'DATABASE\bom01'
    -- dp.[name] like '%'
ORDER BY 
    [object_name], [permission_name];
