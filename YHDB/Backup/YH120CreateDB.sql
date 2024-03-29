USE [master]
GO

/****** Object:  Database [YH120]    Script Date: 2023/9/8 13:12:40 ******/
CREATE DATABASE [YH120]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YH120', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\YH120.mdf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'YH120_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\YH120_log.ldf' , SIZE = 1024KB , MAXSIZE = 10264576KB , FILEGROWTH = 10%)
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YH120].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [YH120] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [YH120] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [YH120] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [YH120] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [YH120] SET ARITHABORT OFF 
GO

ALTER DATABASE [YH120] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [YH120] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [YH120] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [YH120] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [YH120] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [YH120] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [YH120] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [YH120] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [YH120] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [YH120] SET  DISABLE_BROKER 
GO

ALTER DATABASE [YH120] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [YH120] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [YH120] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [YH120] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [YH120] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [YH120] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [YH120] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [YH120] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [YH120] SET  MULTI_USER 
GO

ALTER DATABASE [YH120] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [YH120] SET DB_CHAINING OFF 
GO

ALTER DATABASE [YH120] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [YH120] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [YH120] SET  READ_WRITE 
GO


