USE [master]
GO
/****** Object:  Database [VMS]    Script Date: 12/18/2020 8:58:21 AM ******/
CREATE DATABASE [VMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VMS', FILENAME = N'C:\Users\user\VMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VMS_log', FILENAME = N'C:\Users\user\VMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [VMS] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [VMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VMS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VMS] SET  MULTI_USER 
GO
ALTER DATABASE [VMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VMS] SET QUERY_STORE = OFF
GO
USE [VMS]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [VMS]
GO
/****** Object:  Table [dbo].[Quotation]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quotation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VisitorId] [int] NULL,
	[VehicleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VehicleId] [int] NULL,
	[UserId] [int] NULL,
	[DateOfPurchase] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialNumber] [nvarchar](50) NULL,
	[CompanyName] [nvarchar](50) NULL,
	[ModelName] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[ShowroomPrice] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Visitor]    Script Date: 12/18/2020 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visitor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DateOfVisit] [datetime] NULL,
	[City] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Quotation] ON 

INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (1, 2, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (2, 3, 4)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (3, 4, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (4, 5, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (5, 6, 6)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (7, 7, 6)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (8, 8, 8)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (10, 10, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (12, 12, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (13, 13, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (14, 14, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (15, 14, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (16, 15, 6)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (17, 15, 6)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (18, 16, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (19, 17, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (20, 17, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (21, 18, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (22, 19, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (23, 20, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (24, 21, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (25, 22, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (26, 22, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (27, 23, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (28, 23, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (29, 24, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (30, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (31, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (32, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (33, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (34, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (35, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (36, 25, 5)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (37, 29, 4)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (3002, 3002, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (3003, 3003, 2)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (3004, 3004, 3)
INSERT [dbo].[Quotation] ([Id], [VisitorId], [VehicleId]) VALUES (4002, 4002, 7)
SET IDENTITY_INSERT [dbo].[Quotation] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([Id], [RoleName]) VALUES (2, N'Client')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Sale] ON 

INSERT [dbo].[Sale] ([Id], [VehicleId], [UserId], [DateOfPurchase]) VALUES (4, 3, 2, CAST(N'2020-12-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Sale] ([Id], [VehicleId], [UserId], [DateOfPurchase]) VALUES (1002, 4, 4, CAST(N'2020-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Sale] ([Id], [VehicleId], [UserId], [DateOfPurchase]) VALUES (1003, 6, 1002, CAST(N'2020-12-03T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Sale] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoleMapping] ON 

INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId]) VALUES (1, 1, 1)
INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId]) VALUES (2, 2, 2)
INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId]) VALUES (4, 4, 2)
INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId]) VALUES (1002, 1002, 2)
INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId]) VALUES (5002, 5002, 2)
SET IDENTITY_INSERT [dbo].[UserRoleMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Name], [City], [Email]) VALUES (1, N'dinesh', N'123', N'dinesh', N'Nashik', N'dinesh@gmail.com')
INSERT [dbo].[Users] ([Id], [Username], [Password], [Name], [City], [Email]) VALUES (2, N'kiara', N'123', N'kiara', N'Mumbai', N'kiara@gmail.com')
INSERT [dbo].[Users] ([Id], [Username], [Password], [Name], [City], [Email]) VALUES (4, N'hrithik', N'123', N'hrithik', N'Jaipur', N'hritik@gmail.com')
INSERT [dbo].[Users] ([Id], [Username], [Password], [Name], [City], [Email]) VALUES (1002, N'john', N'123', N'john', N'New York', N'john@gmail.com')
INSERT [dbo].[Users] ([Id], [Username], [Password], [Name], [City], [Email]) VALUES (5002, N'Kiara', N'123', N'john', N'New York', N'john@gmail.com')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Vehicle] ON 

INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (2, N'ODE12', N'Ferrari', N'Italia', CAST(N'2020-10-08T00:00:00.000' AS DateTime), N'908976', N'Fast car')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (3, N'FDC34', N'Lamborghini', N'Aventador', CAST(N'2020-10-23T00:00:00.000' AS DateTime), N'8768796', N'Nice')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (4, N'FDE8', N'Honda', N'Civic', CAST(N'2020-09-09T00:00:00.000' AS DateTime), N'109090', N'cool')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (5, N'VFD9', N'Honda', N'City', CAST(N'2020-07-22T00:00:00.000' AS DateTime), N'1209090', N'cool')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (6, N'LOK89', N'Alfa Romeo', N'Phantom', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'3243543', N'cool')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (7, N'NHU76', N'Tata', N'Manza', CAST(N'2020-12-04T00:00:00.000' AS DateTime), N'102909', N'Nice')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (8, N'JHB65', N'Tata', N'Indica', CAST(N'2020-08-11T00:00:00.000' AS DateTime), N'709090', N'Fast car')
INSERT [dbo].[Vehicle] ([Id], [SerialNumber], [CompanyName], [ModelName], [AddedOn], [ShowroomPrice], [Description]) VALUES (11, N'NJH564', N'Ford', N'Mustang', CAST(N'2020-09-07T00:00:00.000' AS DateTime), N'10909084', N'cool car')
SET IDENTITY_INSERT [dbo].[Vehicle] OFF
GO
SET IDENTITY_INSERT [dbo].[Visitor] ON 

INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (1, N'jake', CAST(N'2020-12-12T00:00:00.000' AS DateTime), N'New York', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (2, N'waye', CAST(N'2020-12-14T00:00:00.000' AS DateTime), N'Lima', N'wayne@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (3, N'Kyle', CAST(N'2020-12-13T00:00:00.000' AS DateTime), N'Bridgetown', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (4, N'john', CAST(N'2020-12-07T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (5, N'jake', CAST(N'2020-12-07T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (6, N'john', CAST(N'2020-12-08T00:00:00.000' AS DateTime), N'Lima', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (7, N'john', CAST(N'2020-12-13T00:00:00.000' AS DateTime), N'Lima', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (8, N'jake', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (9, N'jake', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (10, N'jake', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'New York', N'wayne@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (11, N'a', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (12, N'john', CAST(N'2020-12-03T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (13, N'john', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (14, N'Dinesh', CAST(N'2020-12-14T00:00:00.000' AS DateTime), N'Nashik', N'dinesh@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (15, N'jake', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (16, N'john', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (17, N'john', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (18, N'john', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (19, N'john', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (20, N'jake', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (21, N'jake', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (22, N'jake', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (23, N'john', CAST(N'2020-12-07T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (24, N'john', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (25, N'waye', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'Lima', N'wayne@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (26, N'john', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (27, N'jake', CAST(N'2020-12-08T00:00:00.000' AS DateTime), N'New York', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (28, N'waye', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'Lima', N'jahn@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (29, N'waye', CAST(N'2020-12-10T00:00:00.000' AS DateTime), N'Lima', N'dinesh@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (30, N'jake', CAST(N'2020-12-08T00:00:00.000' AS DateTime), N'Lima', N'dinesh@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (1002, N'jake', CAST(N'2020-12-09T00:00:00.000' AS DateTime), N'Bridgetown', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (2002, N'jake', CAST(N'2020-12-16T00:00:00.000' AS DateTime), N'Lima', N'wayne@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (3002, N'john', CAST(N'2020-12-15T00:00:00.000' AS DateTime), N'New York', N'wayne@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (3003, N'john', CAST(N'2020-12-02T00:00:00.000' AS DateTime), N'Bridgetown', N'wayne@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (3004, N'waye', CAST(N'2020-12-14T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
INSERT [dbo].[Visitor] ([Id], [Name], [DateOfVisit], [City], [Email]) VALUES (4002, N'john', CAST(N'2020-12-01T00:00:00.000' AS DateTime), N'New York', N'john@gmail.com')
SET IDENTITY_INSERT [dbo].[Visitor] OFF
GO
ALTER TABLE [dbo].[Quotation]  WITH CHECK ADD FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicle] ([Id])
GO
ALTER TABLE [dbo].[Quotation]  WITH CHECK ADD FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitor] ([Id])
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicle] ([Id])
GO
ALTER TABLE [dbo].[UserRoleMapping]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRoleMapping]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
USE [master]
GO
ALTER DATABASE [VMS] SET  READ_WRITE 
GO
