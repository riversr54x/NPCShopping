USE [master]
GO
/****** Object:  Database [NPCShopping]    Script Date: 3/15/2016 10:19:42 AM ******/
CREATE DATABASE [NPCShopping]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NPCShopping', FILENAME = N'C:\Users\rivers\NPCShopping.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NPCShopping_log', FILENAME = N'C:\Users\rivers\NPCShopping_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NPCShopping] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NPCShopping].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NPCShopping] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NPCShopping] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NPCShopping] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NPCShopping] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NPCShopping] SET ARITHABORT OFF 
GO
ALTER DATABASE [NPCShopping] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NPCShopping] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [NPCShopping] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NPCShopping] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NPCShopping] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NPCShopping] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NPCShopping] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NPCShopping] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NPCShopping] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NPCShopping] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NPCShopping] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NPCShopping] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NPCShopping] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NPCShopping] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NPCShopping] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NPCShopping] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NPCShopping] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NPCShopping] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NPCShopping] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NPCShopping] SET  MULTI_USER 
GO
ALTER DATABASE [NPCShopping] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NPCShopping] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NPCShopping] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NPCShopping] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [NPCShopping]
GO
/****** Object:  StoredProcedure [dbo].[checkLogin]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[checkLogin]
  @userName nvarchar(50),
  @password nvarchar(50)

  
as
begin
  Select ID from [dbo].[user] 
  where name = @userName and PWDCOMPARE(@password, password) = 1;
  end



GO
/****** Object:  StoredProcedure [dbo].[checkLogin1]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[checkLogin1]
  @userName nvarchar(50),
  @password nvarchar(50),
  @id int OUTPUT

  
as
begin
  select @id = ID from [dbo].[user] 
  where name = @userName and PWDCOMPARE(@password, password) = 1;
  end




GO
/****** Object:  StoredProcedure [dbo].[getLastTrans]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getLastTrans]
  

  
as
begin
  Select MAX(TransID) from [dbo].[Transactions] 
 
  end




GO
/****** Object:  Table [dbo].[Ads]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](50) NULL,
	[Width] [int] NULL,
	[Height] [int] NULL,
 CONSTRAINT [PK_Ads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[Image] [nvarchar](50) NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[Vendor] [int] NOT NULL,
	[Category] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ProdID] [int] NULL,
	[Date] [date] NULL,
	[ProdPrice] [decimal](18, 0) NULL,
	[Quanity] [int] NULL,
	[TransID] [int] NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 3/15/2016 10:19:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[role] [nvarchar](15) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[secretQuestion] [nvarchar](75) NOT NULL,
	[secretAnswer] [nvarchar](75) NOT NULL,
	[phone] [nvarchar](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Ads] ON 

INSERT [dbo].[Ads] ([ID], [ImageUrl], [Width], [Height]) VALUES (1, N'\productImages\widget.jpg', 100, 100)
INSERT [dbo].[Ads] ([ID], [ImageUrl], [Width], [Height]) VALUES (2, N'\productImages\gadget.jpg', 100, 100)
INSERT [dbo].[Ads] ([ID], [ImageUrl], [Width], [Height]) VALUES (3, N'\productImages\trinket.jpg', 100, 100)
SET IDENTITY_INSERT [dbo].[Ads] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (1, N'CScrap', N'This is all our scrap products')
INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (2, N'Junk', N'This is all our junk products')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name], [Description], [Image], [Price], [Vendor], [Category]) VALUES (1, N'Widget', N'Super Widget Description this is some random text to test the spacing on the shopping cart page', N'widget.jpg', CAST(10 AS Decimal(18, 0)), 100, 1)
INSERT [dbo].[Product] ([ID], [Name], [Description], [Image], [Price], [Vendor], [Category]) VALUES (2, N'Gadget', N'Super Gadget Description-this is some random text to test the spacing on the shopping cart page', N'gadget.jpg', CAST(20 AS Decimal(18, 0)), 200, 1)
INSERT [dbo].[Product] ([ID], [Name], [Description], [Image], [Price], [Vendor], [Category]) VALUES (1002, N'Trinket', N'Super Trinket', N'trinket.jpg', CAST(30 AS Decimal(18, 0)), 300, 2)
INSERT [dbo].[Product] ([ID], [Name], [Description], [Image], [Price], [Vendor], [Category]) VALUES (1004, N'sfsadf', N'asdfasf', N'asdfsa', CAST(1 AS Decimal(18, 0)), 1, 2)
INSERT [dbo].[Product] ([ID], [Name], [Description], [Image], [Price], [Vendor], [Category]) VALUES (2004, N'item100', N'item100', N'item100', CAST(100 AS Decimal(18, 0)), 0, 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Transactions] ON 

INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (1, 100, 2, CAST(0xBB3A0B00 AS Date), CAST(10 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (1007, 1004, 1, CAST(0xBD3A0B00 AS Date), CAST(0 AS Decimal(18, 0)), 2, 1)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (1008, 1004, 2, CAST(0xBD3A0B00 AS Date), CAST(0 AS Decimal(18, 0)), 3, 1)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (1009, 1004, 2, CAST(0xBD3A0B00 AS Date), CAST(0 AS Decimal(18, 0)), 5, 2)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (1010, 1004, 1, CAST(0xBD3A0B00 AS Date), CAST(0 AS Decimal(18, 0)), 5, 3)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (1011, 1004, 1, CAST(0xBD3A0B00 AS Date), CAST(10 AS Decimal(18, 0)), 3, 4)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (2002, 1004, 1, CAST(0xC23A0B00 AS Date), CAST(10 AS Decimal(18, 0)), 1, 5)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (2003, 1004, 2, CAST(0xC23A0B00 AS Date), CAST(20 AS Decimal(18, 0)), 1, 5)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (2004, 1004, 1, CAST(0xC23A0B00 AS Date), CAST(10 AS Decimal(18, 0)), 1, 6)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (2005, 1004, 2, CAST(0xC23A0B00 AS Date), CAST(20 AS Decimal(18, 0)), 1, 6)
INSERT [dbo].[Transactions] ([ID], [UserID], [ProdID], [Date], [ProdPrice], [Quanity], [TransID]) VALUES (3002, 1004, 1, CAST(0xCC3A0B00 AS Date), CAST(10 AS Decimal(18, 0)), 1, 7)
SET IDENTITY_INSERT [dbo].[Transactions] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [name], [password], [role], [email], [secretQuestion], [secretAnswer], [phone]) VALUES (2, N'Ivers', N'㾞ħ㗭ꅓﷃ鋛읓㛡ᐴ䛁葓랧진㐊属滸觽ㅭ﹣䏢ጟ넴㡹簯Ᵹ㦞⇼ᰶ⦑䔞솘㍱', N'User', N'rivers@np.edu', N'what is your favorite color', N'red', N'501-760-4251')
INSERT [dbo].[User] ([ID], [name], [password], [role], [email], [secretQuestion], [secretAnswer], [phone]) VALUES (1004, N'jedi', N'損얈풊ꀷ鄲宪㓮ꕓ䀆႖࠱⡍럱쾿㡸찅꯽㵗㥯Ί飯ᵜ熀澬蹋乒䏇떍妽掫✃', N'Normal User', N'jedi', N'jedi', N'jedi', NULL)
INSERT [dbo].[User] ([ID], [name], [password], [role], [email], [secretQuestion], [secretAnswer], [phone]) VALUES (1007, N'admin1', N'鎚భ颲而ꋶ柴哦祶踑敆㲽鄫㫰Ꙕ뿖⟦꟤₴鶕좑⿘ꎂ◽㝽觝萮᳴ӿ᠈', N'admin', N'admin', N'admin', N'admin', N'6666-666')
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([Category])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
USE [master]
GO
ALTER DATABASE [NPCShopping] SET  READ_WRITE 
GO
