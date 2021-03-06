/****** Object:  Database Library    Script Date: 5/1/2007 12:10:26 PM ******/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Library')
	DROP DATABASE [Library]
GO

CREATE DATABASE [Library]  ON (NAME = N'Library_Data', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL\data\Library_Data.MDF' , SIZE = 1, FILEGROWTH = 10%) LOG ON (NAME = N'Library_Log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL\data\Library_Log.LDF' , SIZE = 1, FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO

exec sp_dboption N'Library', N'autoclose', N'false'
GO

exec sp_dboption N'Library', N'bulkcopy', N'false'
GO

exec sp_dboption N'Library', N'trunc. log', N'false'
GO

exec sp_dboption N'Library', N'torn page detection', N'true'
GO

exec sp_dboption N'Library', N'read only', N'false'
GO

exec sp_dboption N'Library', N'dbo use', N'false'
GO

exec sp_dboption N'Library', N'single', N'false'
GO

exec sp_dboption N'Library', N'autoshrink', N'false'
GO

exec sp_dboption N'Library', N'ANSI null default', N'false'
GO

exec sp_dboption N'Library', N'recursive triggers', N'false'
GO

exec sp_dboption N'Library', N'ANSI nulls', N'false'
GO

exec sp_dboption N'Library', N'concat null yields null', N'false'
GO

exec sp_dboption N'Library', N'cursor close on commit', N'false'
GO

exec sp_dboption N'Library', N'default to local cursor', N'false'
GO

exec sp_dboption N'Library', N'quoted identifier', N'false'
GO

exec sp_dboption N'Library', N'ANSI warnings', N'false'
GO

exec sp_dboption N'Library', N'auto create statistics', N'true'
GO

exec sp_dboption N'Library', N'auto update statistics', N'true'
GO

use [Library]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Lib_Book_Details_Lib_Book_Categories]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Lib_Book_Details] DROP CONSTRAINT FK_Lib_Book_Details_Lib_Book_Categories
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Lib_Book_Issue_Details_Lib_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Lib_Book_Issue_Details] DROP CONSTRAINT FK_Lib_Book_Issue_Details_Lib_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Lib_Book_Issue_Details_Lib_Book_Details]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Lib_Book_Issue_Details] DROP CONSTRAINT FK_Lib_Book_Issue_Details_Lib_Book_Details
GO

/****** Object:  Table [dbo].[Lib_Book_Issue_Details]    Script Date: 5/1/2007 12:10:27 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Lib_Book_Issue_Details]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Lib_Book_Issue_Details]
GO

/****** Object:  Table [dbo].[Lib_Book_Details]    Script Date: 5/1/2007 12:10:27 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Lib_Book_Details]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Lib_Book_Details]
GO

/****** Object:  Table [dbo].[Lib_Book_Categories]    Script Date: 5/1/2007 12:10:27 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Lib_Book_Categories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Lib_Book_Categories]
GO

/****** Object:  Table [dbo].[Lib_Users]    Script Date: 5/1/2007 12:10:27 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Lib_Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Lib_Users]
GO

/****** Object:  Table [dbo].[Lib_Book_Categories]    Script Date: 5/1/2007 12:10:29 PM ******/
CREATE TABLE [dbo].[Lib_Book_Categories] (
	[Category_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Category_Name] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Lib_Users]    Script Date: 5/1/2007 12:10:30 PM ******/
CREATE TABLE [dbo].[Lib_Users] (
	[User_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[User_Name] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[User_Password] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[User_Is_System] [bit] NOT NULL ,
	[User_Created_Date] [datetime] NOT NULL ,
	[Number_Of_Books_Issued] [int] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Lib_Book_Details]    Script Date: 5/1/2007 12:10:30 PM ******/
CREATE TABLE [dbo].[Lib_Book_Details] (
	[Lib_Book_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Lib_Book_Title] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Lib_Book_Category] [int] NOT NULL ,
	[Lib_Book_Author_Name] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Lib_Book_Issue_Status] [bit] NULL ,
	[Lib_Book_In_Inventory] [bit] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Lib_Book_Issue_Details]    Script Date: 5/1/2007 12:10:30 PM ******/
CREATE TABLE [dbo].[Lib_Book_Issue_Details] (
	[Lib_Book_Issue_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Lib_Book_ID] [int] NOT NULL ,
	[Lib_Book_Issued_On] [datetime] NOT NULL ,
	[Lib_Book_Issued_To] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Lib_Book_Returned_On] [datetime] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Lib_Book_Categories] WITH NOCHECK ADD 
	CONSTRAINT [PK_Lib_Book_Categories] PRIMARY KEY  CLUSTERED 
	(
		[Category_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Lib_Users] WITH NOCHECK ADD 
	CONSTRAINT [PK_Lib_Users] PRIMARY KEY  CLUSTERED 
	(
		[User_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Lib_Book_Details] WITH NOCHECK ADD 
	CONSTRAINT [PK_Lib_Book_Details] PRIMARY KEY  CLUSTERED 
	(
		[Lib_Book_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Lib_Book_Issue_Details] WITH NOCHECK ADD 
	CONSTRAINT [PK_Lib_Book_Issue_Details] PRIMARY KEY  CLUSTERED 
	(
		[Lib_Book_Issue_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Lib_Users] WITH NOCHECK ADD 
	CONSTRAINT [DF_Lib_Users_User_Is_System] DEFAULT (0) FOR [User_Is_System],
	CONSTRAINT [DF_Lib_Users_User_Created_Date] DEFAULT (getdate()) FOR [User_Created_Date],
	CONSTRAINT [DF_Lib_Users_Number_Of_Books_Issued] DEFAULT (0) FOR [Number_Of_Books_Issued],
	CONSTRAINT [IX_Lib_Users] UNIQUE  NONCLUSTERED 
	(
		[User_Name]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Lib_Book_Details] WITH NOCHECK ADD 
	CONSTRAINT [DF_Lib_Book_Details_Lib_Book_Issue_Status] DEFAULT (0) FOR [Lib_Book_Issue_Status],
	CONSTRAINT [DF_Lib_Book_Details_Lib_Book_In_Inventory] DEFAULT (1) FOR [Lib_Book_In_Inventory]
GO

ALTER TABLE [dbo].[Lib_Book_Issue_Details] WITH NOCHECK ADD 
	CONSTRAINT [DF_Lib_Book_Issue_Details_Lb_Book_Issued_On] DEFAULT (getdate()) FOR [Lib_Book_Issued_On]
GO

ALTER TABLE [dbo].[Lib_Book_Details] ADD 
	CONSTRAINT [FK_Lib_Book_Details_Lib_Book_Categories] FOREIGN KEY 
	(
		[Lib_Book_Category]
	) REFERENCES [dbo].[Lib_Book_Categories] (
		[Category_ID]
	)
GO

ALTER TABLE [dbo].[Lib_Book_Issue_Details] ADD 
	CONSTRAINT [FK_Lib_Book_Issue_Details_Lib_Book_Details] FOREIGN KEY 
	(
		[Lib_Book_ID]
	) REFERENCES [dbo].[Lib_Book_Details] (
		[Lib_Book_ID]
	),
	CONSTRAINT [FK_Lib_Book_Issue_Details_Lib_Users] FOREIGN KEY 
	(
		[Lib_Book_Issued_To]
	) REFERENCES [dbo].[Lib_Users] (
		[User_Name]
	)
GO


insert into Lib_Users (user_name,user_password,user_is_system)values('admin','YWRtaW4=',1)