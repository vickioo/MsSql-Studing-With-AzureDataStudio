USE [master]
GO
/*原始登陆会频繁锁定的SA账户设定*/
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [sa]    Script Date: 2023-03-17 14:29:07 ******/
CREATE LOGIN [sa] WITH PASSWORD=N'6U÷ñ%ÊñÈ*y?®ñøpÝDäÌìUÎÈÒÙë', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[简体中文], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

ALTER LOGIN [sa] DISABLE
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [sa]
GO

/*运行金蝶分公司提供的去验证语句，解锁登陆/试错限制*/
ALTER LOGIN sa ENABLE ;
GO 
ALTER LOGIN sa WITH PASSWORD = 'sa' unlock, check_policy = off, check_expiration = off ; 
GO

/*除了接触掉锁定外，多调整了Policy检查策略*/
USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [sa]    Script Date: 2023-03-17 16:06:36 ******/
CREATE LOGIN [sa] WITH PASSWORD=N'/Ogó?Z²Õ¨;9''saxrjñÄC¨^ø', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[简体中文], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [sa] DISABLE
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [sa]
GO


