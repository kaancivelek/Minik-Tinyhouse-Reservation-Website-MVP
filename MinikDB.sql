USE [master]
GO
/****** Object:  Database [MinikDB]    Script Date: 5.05.2025 00:24:07 ******/
CREATE DATABASE [MinikDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MinikDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MinikDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MinikDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MinikDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MinikDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MinikDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MinikDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MinikDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MinikDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MinikDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MinikDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MinikDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MinikDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MinikDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MinikDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MinikDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MinikDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MinikDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MinikDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MinikDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MinikDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MinikDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MinikDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MinikDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MinikDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MinikDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MinikDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MinikDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MinikDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MinikDB] SET  MULTI_USER 
GO
ALTER DATABASE [MinikDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MinikDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MinikDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MinikDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MinikDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MinikDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MinikDB', N'ON'
GO
ALTER DATABASE [MinikDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [MinikDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MinikDB]
GO
/****** Object:  Table [dbo].[availability]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[availability](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tiny_house_id] [int] NOT NULL,
	[available_from] [date] NOT NULL,
	[available_to] [date] NOT NULL,
	[is_available] [bit] NULL,
 CONSTRAINT [PK__availabi__3213E83FD4DE4E76] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[discounts]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[discounts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tiny_house_id] [int] NOT NULL,
	[discount_percentage] [int] NOT NULL,
	[valid_from] [date] NOT NULL,
	[valid_until] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[house_images]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[house_images](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tiny_house_id] [int] NOT NULL,
	[image_url] [nvarchar](755) NOT NULL,
 CONSTRAINT [PK__house_im__3213E83F331E9B7C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[invoices]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[payment_id] [int] NOT NULL,
	[invoice_number] [varchar](50) NOT NULL,
	[payment_date] [date] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[locations]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[country] [varchar](100) NOT NULL,
	[city] [varchar](100) NOT NULL,
	[address] [varchar](255) NOT NULL,
	[latitude] [decimal](9, 6) NOT NULL,
	[longitude] [decimal](9, 6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[maintenance]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[maintenance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tiny_house_id] [int] NOT NULL,
	[maintenance_type] [varchar](100) NOT NULL,
	[maintenance_date] [date] NOT NULL,
	[status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sender_user_id] [int] NOT NULL,
	[receiver_user_id] [int] NOT NULL,
	[content] [text] NOT NULL,
	[sent_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_schedule]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_schedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reservation_id] [int] NOT NULL,
	[due_date] [date] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reservation_id] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[payment_method] [varchar](50) NOT NULL,
	[payment_date] [datetime] NOT NULL,
	[payment_status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reservations]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[tiny_house_id] [int] NOT NULL,
	[check_in] [date] NOT NULL,
	[check_out] [date] NOT NULL,
	[total_price] [decimal](10, 2) NOT NULL,
	[status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[tiny_house_id] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[comment] [text] NOT NULL,
	[review_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] NOT NULL,
	[name] [varchar](15) NOT NULL,
 CONSTRAINT [PK__roles__3213E83F27221C14] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tiny_houses]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tiny_houses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [text] NOT NULL,
	[location_id] [int] NOT NULL,
	[price_per_night] [decimal](10, 2) NOT NULL,
	[max_guests] [int] NOT NULL,
	[property_owner_id] [int] NOT NULL,
	[amenities] [varchar](255) NOT NULL,
 CONSTRAINT [PK__tiny_hou__3213E83F7D3D2DCD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[role_id] [int] NOT NULL,
	[phone_number] [varchar](15) NOT NULL,
 CONSTRAINT [PK__users__3213E83FDBEC1396] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 5.05.2025 00:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wishlist](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[tiny_house_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[availability] ON 

INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (3, 3, CAST(N'2025-05-05' AS Date), CAST(N'2025-05-08' AS Date), 0)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (4, 4, CAST(N'2025-04-28' AS Date), CAST(N'2025-05-02' AS Date), 1)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (5, 5, CAST(N'2025-04-30' AS Date), CAST(N'2025-05-05' AS Date), 0)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (6, 6, CAST(N'2025-05-01' AS Date), CAST(N'2025-05-10' AS Date), 1)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (7, 7, CAST(N'2025-04-25' AS Date), CAST(N'2025-04-29' AS Date), 1)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (8, 8, CAST(N'2025-05-05' AS Date), CAST(N'2025-05-09' AS Date), 0)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (9, 9, CAST(N'2025-04-27' AS Date), CAST(N'2025-05-03' AS Date), 1)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (10, 10, CAST(N'2025-04-26' AS Date), CAST(N'2025-05-01' AS Date), 1)
SET IDENTITY_INSERT [dbo].[availability] OFF
GO
SET IDENTITY_INSERT [dbo].[discounts] ON 

INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (3, 3, 5, CAST(N'2025-04-20' AS Date), CAST(N'2025-04-30' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (4, 4, 20, CAST(N'2025-05-01' AS Date), CAST(N'2025-05-20' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (5, 5, 10, CAST(N'2025-04-25' AS Date), CAST(N'2025-05-05' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (6, 6, 12, CAST(N'2025-05-01' AS Date), CAST(N'2025-05-15' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (7, 7, 8, CAST(N'2025-04-22' AS Date), CAST(N'2025-04-30' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (8, 8, 18, CAST(N'2025-05-05' AS Date), CAST(N'2025-05-15' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (9, 9, 10, CAST(N'2025-04-20' AS Date), CAST(N'2025-05-01' AS Date))
INSERT [dbo].[discounts] ([id], [tiny_house_id], [discount_percentage], [valid_from], [valid_until]) VALUES (10, 10, 15, CAST(N'2025-04-25' AS Date), CAST(N'2025-05-10' AS Date))
SET IDENTITY_INSERT [dbo].[discounts] OFF
GO
SET IDENTITY_INSERT [dbo].[house_images] ON 

INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (203, 3, N'')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (204, 3, N'')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (205, 4, N'https://images.unsplash.com/photo-1512917774080-9991f1c4c750')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (206, 4, N'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (207, 5, N'https://images.unsplash.com/photo-1560518883-ce09059eeffa')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (208, 5, N'https://images.unsplash.com/photo-1600585154340-be6161a56a0c')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (209, 6, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (210, 6, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (211, 7, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (212, 7, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (213, 8, N'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (214, 8, N'https://images.unsplash.com/photo-1512917774080-9991f1c4c750')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (215, 9, N'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (216, 9, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (217, 10, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (218, 10, N'https://images.unsplash.com/photo-1600585154340-be6161a56a0c')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (219, 12, N'https://images.unsplash.com/photo-1518621736915-f3b1c41bfd00')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (220, 12, N'https://images.unsplash.com/photo-1523693918350-938c1d5e1e1b')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (221, 13, N'https://images.unsplash.com/photo-1512917774080-9991f1c4c750')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (222, 13, N'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (223, 14, N'https://images.unsplash.com/photo-1533873984035-25970ab07461')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (224, 14, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (225, 15, N'https://images.unsplash.com/photo-1512917774080-9991f1c4c750')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (226, 15, N'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (227, 16, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (228, 16, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (229, 17, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (230, 17, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (231, 18, N'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (232, 18, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (233, 19, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (234, 19, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (235, 20, N'https://images.unsplash.com/photo-1512917774080-9991f1c4c750')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (236, 20, N'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (237, 21, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (238, 21, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (239, 22, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (240, 22, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (241, 23, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (242, 23, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (243, 24, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (244, 24, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (245, 25, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (246, 25, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (247, 26, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (248, 26, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (249, 27, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (250, 27, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (251, 28, N'https://images.unsplash.com/photo-1533873984035-25970ab07461')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (252, 28, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (253, 29, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (254, 29, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (255, 30, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (256, 30, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (257, 31, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (258, 31, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (259, 32, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (260, 32, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (261, 33, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (262, 33, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (263, 34, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (264, 34, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (265, 35, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (266, 35, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (267, 36, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (268, 36, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (269, 37, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (270, 37, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (271, 38, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (272, 38, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (273, 39, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (274, 39, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (275, 40, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (276, 40, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (277, 41, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (278, 41, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (279, 42, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (280, 42, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (281, 43, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (282, 43, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (283, 44, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (284, 44, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (285, 45, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (286, 45, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (287, 46, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (288, 46, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (289, 47, N'https://images.unsplash.com/photo-1600566752355-35792bedcfea')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (290, 47, N'https://images.unsplash.com/photo-1580587771525-78b9dba3b914')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (291, 48, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (292, 48, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (293, 49, N'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (294, 49, N'https://images.unsplash.com/photo-1493809842364-78817add7ffb')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (295, 50, N'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (296, 50, N'https://images.unsplash.com/photo-1484154218962-a197022b5858')
SET IDENTITY_INSERT [dbo].[house_images] OFF
GO
SET IDENTITY_INSERT [dbo].[invoices] ON 

INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (1, 1, N'INV-2025-001', CAST(N'2025-04-20' AS Date), CAST(2200.00 AS Decimal(10, 2)), N'paid')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (2, 2, N'INV-2025-002', CAST(N'2025-04-21' AS Date), CAST(2500.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (4, 4, N'INV-2025-004', CAST(N'2025-04-23' AS Date), CAST(4800.00 AS Decimal(10, 2)), N'cancelled')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (6, 6, N'INV-2025-006', CAST(N'2025-04-22' AS Date), CAST(1350.00 AS Decimal(10, 2)), N'paid')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (7, 7, N'INV-2025-007', CAST(N'2025-04-22' AS Date), CAST(3900.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (8, 8, N'INV-2025-008', CAST(N'2025-04-23' AS Date), CAST(2300.00 AS Decimal(10, 2)), N'paid')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (9, 9, N'INV-2025-009', CAST(N'2025-04-23' AS Date), CAST(4350.00 AS Decimal(10, 2)), N'paid')
INSERT [dbo].[invoices] ([id], [payment_id], [invoice_number], [payment_date], [amount], [status]) VALUES (10, 10, N'INV-2025-010', CAST(N'2025-04-24' AS Date), CAST(4200.00 AS Decimal(10, 2)), N'pending')
SET IDENTITY_INSERT [dbo].[invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[locations] ON 

INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (1, N'Türkiye', N'İzmir', N'Foça Mah. 123 Sok. No:5', CAST(38.666100 AS Decimal(9, 6)), CAST(26.760400 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (2, N'Türkiye', N'Antalya', N'Kaş Mah. 789 Sok. No:3', CAST(36.201200 AS Decimal(9, 6)), CAST(29.637200 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (3, N'Türkiye', N'Muğla', N'Datça Yolu Üzeri, No:23', CAST(37.003000 AS Decimal(9, 6)), CAST(27.430300 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (4, N'Türkiye', N'Balıkesir', N'Ayvalık Sahil Caddesi No:10', CAST(39.311000 AS Decimal(9, 6)), CAST(26.689600 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (5, N'Türkiye', N'Çanakkale', N'Bozcaada Merkez Sokak No:7', CAST(39.835400 AS Decimal(9, 6)), CAST(26.069100 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (6, N'Türkiye', N'Aydın', N'Kuşadası Mevkii, Zeytin Sok. No:8', CAST(37.855600 AS Decimal(9, 6)), CAST(27.256400 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (7, N'Türkiye', N'Artvin', N'Borçka Karagöl Yolu No:2', CAST(41.390000 AS Decimal(9, 6)), CAST(41.670600 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (8, N'Türkiye', N'Nevşehir', N'Ürgüp Bağ Yolu No:12', CAST(38.631100 AS Decimal(9, 6)), CAST(34.912000 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (9, N'Türkiye', N'Mersin', N'Silifke Taşucu Mah. No:17', CAST(36.312300 AS Decimal(9, 6)), CAST(33.957200 AS Decimal(9, 6)))
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude]) VALUES (10, N'Türkiye', N'Sakarya', N'Sapanca Göl Kenarı Sok. No:9', CAST(40.691000 AS Decimal(9, 6)), CAST(30.267400 AS Decimal(9, 6)))
SET IDENTITY_INSERT [dbo].[locations] OFF
GO
SET IDENTITY_INSERT [dbo].[maintenance] ON 

INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (3, 3, N'Boya Bakımı', CAST(N'2025-04-23' AS Date), N'completed')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (4, 4, N'Pencere Değişimi', CAST(N'2025-04-22' AS Date), N'completed')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (5, 5, N'Klima Bakımı', CAST(N'2025-04-21' AS Date), N'completed')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (6, 6, N'Yol Bakımı', CAST(N'2025-04-23' AS Date), N'pending')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (7, 7, N'Şömine Temizliği', CAST(N'2025-04-24' AS Date), N'pending')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (8, 8, N'Balkon Tamiri', CAST(N'2025-04-20' AS Date), N'completed')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (9, 9, N'Su Tesisatı Bakımı', CAST(N'2025-04-23' AS Date), N'pending')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (10, 10, N'Isıtma Sistemi Bakımı', CAST(N'2025-04-22' AS Date), N'completed')
SET IDENTITY_INSERT [dbo].[maintenance] OFF
GO
SET IDENTITY_INSERT [dbo].[messages] ON 

INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (1, 1, 2, N'Merhaba, Lavanta Evi hakkında daha fazla bilgi alabilir miyim?', CAST(N'2025-04-20T10:15:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (2, 3, 4, N'Saklı Vadi için rezervasyon yapmak istiyorum. Uygun musunuz?', CAST(N'2025-04-21T14:25:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (3, 5, 6, N'Begonvil Evi’ni 3 gece için rezerve ettim. Giriş saati hakkında bilgi verir misiniz?', CAST(N'2025-04-22T09:40:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (4, 7, 8, N'Deniz Kabuğu hakkında detaylı bilgi alabilir miyim?', CAST(N'2025-04-22T16:10:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (5, 9, 10, N'Orman Evi için ödeme yapmayı unutmuşum. Nasıl ilerlemem gerek?', CAST(N'2025-04-23T11:50:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (6, 2, 3, N'Sizinle iletişimde olmak güzel, Lavanta Evi’ni rezerve etmeyi düşünüyorum.', CAST(N'2025-04-21T12:00:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (7, 4, 5, N'Zeytin Bahçesi hakkında daha fazla fotoğraf gönderir misiniz?', CAST(N'2025-04-22T17:30:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (8, 6, 7, N'Ahşap Yuvam ile ilgili sorularım vardı, yardımcı olabilir misiniz?', CAST(N'2025-04-23T18:00:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (9, 8, 9, N'Çamlık Ev için fiyatı netleştirebilir miyiz?', CAST(N'2025-04-24T07:20:00.000' AS DateTime))
INSERT [dbo].[messages] ([id], [sender_user_id], [receiver_user_id], [content], [sent_at]) VALUES (10, 10, 1, N'Gökçeada Kaçamağı’nda kalmayı düşünüyorum, her şey dahil fiyat nedir?', CAST(N'2025-04-24T13:10:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[messages] OFF
GO
SET IDENTITY_INSERT [dbo].[payment_schedule] ON 

INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (1, 1, CAST(N'2025-04-20' AS Date), CAST(1100.00 AS Decimal(10, 2)), N'paid')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (2, 1, CAST(N'2025-04-30' AS Date), CAST(1100.00 AS Decimal(10, 2)), N'paid')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (3, 2, CAST(N'2025-04-25' AS Date), CAST(1250.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (4, 2, CAST(N'2025-05-02' AS Date), CAST(1250.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (5, 4, CAST(N'2025-04-24' AS Date), CAST(2400.00 AS Decimal(10, 2)), N'cancelled')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (6, 4, CAST(N'2025-05-01' AS Date), CAST(2400.00 AS Decimal(10, 2)), N'cancelled')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (9, 10, CAST(N'2025-04-24' AS Date), CAST(2100.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[payment_schedule] ([id], [reservation_id], [due_date], [amount], [status]) VALUES (10, 10, CAST(N'2025-05-02' AS Date), CAST(2100.00 AS Decimal(10, 2)), N'pending')
SET IDENTITY_INSERT [dbo].[payment_schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[payments] ON 

INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (1, 1, CAST(2200.00 AS Decimal(10, 2)), N'credit_card', CAST(N'2025-04-20T14:00:00.000' AS DateTime), N'paid')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (2, 2, CAST(2500.00 AS Decimal(10, 2)), N'bank_transfer', CAST(N'2025-04-21T16:30:00.000' AS DateTime), N'pending')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (4, 4, CAST(4800.00 AS Decimal(10, 2)), N'paypal', CAST(N'2025-04-23T10:00:00.000' AS DateTime), N'cancelled')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (6, 6, CAST(1350.00 AS Decimal(10, 2)), N'cash', CAST(N'2025-04-22T11:00:00.000' AS DateTime), N'paid')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (7, 7, CAST(3900.00 AS Decimal(10, 2)), N'bank_transfer', CAST(N'2025-04-22T17:45:00.000' AS DateTime), N'pending')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (8, 8, CAST(2300.00 AS Decimal(10, 2)), N'paypal', CAST(N'2025-04-23T14:00:00.000' AS DateTime), N'paid')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (9, 9, CAST(4350.00 AS Decimal(10, 2)), N'credit_card', CAST(N'2025-04-23T12:00:00.000' AS DateTime), N'paid')
INSERT [dbo].[payments] ([id], [reservation_id], [amount], [payment_method], [payment_date], [payment_status]) VALUES (10, 10, CAST(4200.00 AS Decimal(10, 2)), N'credit_card', CAST(N'2025-04-24T08:30:00.000' AS DateTime), N'pending')
SET IDENTITY_INSERT [dbo].[payments] OFF
GO
SET IDENTITY_INSERT [dbo].[reservations] ON 

INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (1, 1, 3, CAST(N'2025-05-01' AS Date), CAST(N'2025-05-03' AS Date), CAST(2200.00 AS Decimal(10, 2)), N'confirmed')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (2, 2, 5, CAST(N'2025-05-04' AS Date), CAST(N'2025-05-06' AS Date), CAST(2500.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (4, 4, 6, CAST(N'2025-05-07' AS Date), CAST(N'2025-05-10' AS Date), CAST(4800.00 AS Decimal(10, 2)), N'cancelled')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (6, 6, 4, CAST(N'2025-05-05' AS Date), CAST(N'2025-05-06' AS Date), CAST(1350.00 AS Decimal(10, 2)), N'confirmed')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (7, 7, 9, CAST(N'2025-05-10' AS Date), CAST(N'2025-05-13' AS Date), CAST(3900.00 AS Decimal(10, 2)), N'pending')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (8, 8, 7, CAST(N'2025-05-02' AS Date), CAST(N'2025-05-04' AS Date), CAST(2300.00 AS Decimal(10, 2)), N'confirmed')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (9, 9, 8, CAST(N'2025-05-03' AS Date), CAST(N'2025-05-06' AS Date), CAST(4350.00 AS Decimal(10, 2)), N'confirmed')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (10, 10, 10, CAST(N'2025-05-01' AS Date), CAST(N'2025-05-04' AS Date), CAST(4200.00 AS Decimal(10, 2)), N'pending')
SET IDENTITY_INSERT [dbo].[reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[reviews] ON 

INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (1, 1, 3, 5, N'Harika bir tatil deneyimi, kesinlikle tekrar geleceğim!', CAST(N'2025-04-22' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (2, 2, 5, 4, N'Ev çok güzeldi, sadece klima biraz zayıftı.', CAST(N'2025-04-21' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (4, 4, 6, 3, N'Ev güzeldi ama beklediğimiz gibi değildi.', CAST(N'2025-04-20' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (6, 6, 4, 5, N'Saklı Vadi tam istediğimiz gibi bir yerdi.', CAST(N'2025-04-23' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (7, 7, 9, 4, N'Lav Evi oldukça fotojenik ama biraz daha bakımlı olabilirdi.', CAST(N'2025-04-24' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (8, 8, 7, 5, N'Orman Evi mükemmeldi, doğa ile iç içe çok güzel bir deneyim!', CAST(N'2025-04-23' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (9, 9, 8, 5, N'Çamlık Ev’i çok beğendik, sessiz ve huzurlu bir yerdi.', CAST(N'2025-04-22' AS Date))
INSERT [dbo].[reviews] ([id], [user_id], [tiny_house_id], [rating], [comment], [review_date]) VALUES (10, 10, 10, 4, N'Gökçeada Kaçamağı çok güzeldi, ancak odanın büyüklüğü beklediğimiz gibi değildi.', CAST(N'2025-04-21' AS Date))
SET IDENTITY_INSERT [dbo].[reviews] OFF
GO
INSERT [dbo].[roles] ([id], [name]) VALUES (0, N'admin')
INSERT [dbo].[roles] ([id], [name]) VALUES (1, N'customer')
INSERT [dbo].[roles] ([id], [name]) VALUES (2, N'Property Owner')
GO
SET IDENTITY_INSERT [dbo].[tiny_houses] ON 

INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (3, N'Zeytin Bahçesi', N'Zeytin ağaçları arasında huzurlu bir kaçamak.', 3, CAST(1100.00 AS Decimal(10, 2)), 2, 7, N'wifi,şömine,mutfak')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (4, N'Saklı Vadi', N'Doğayla iç içe, sessiz ve sakin bir ev.', 4, CAST(1350.00 AS Decimal(10, 2)), 4, 7, N'wifi,klima,jakuzi')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (5, N'Ahşap Yuvam', N'Rustik tasarımlı sevimli bir tiny house.', 5, CAST(1250.00 AS Decimal(10, 2)), 2, 8, N'wifi,barbekü')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (6, N'Deniz Kabuğu', N'Denize sıfır, romantik bir tatil evi.', 6, CAST(1600.00 AS Decimal(10, 2)), 3, 7, N'wifi,jakuzi,mutfak')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (7, N'Orman Evi', N'Ağaçlar arasında doğal yaşam deneyimi.', 7, CAST(1150.00 AS Decimal(10, 2)), 2, 8, N'wifi,şömine,klima')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (8, N'Gökçeada Kaçamağı', N'Ada havasında farklı bir deneyim.', 8, CAST(1450.00 AS Decimal(10, 2)), 2, 9, N'wifi,mutfak,klima')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (9, N'Lav Evi', N'Lav tarlalarının ortasında fotoğraflık bir tiny house.', 9, CAST(1300.00 AS Decimal(10, 2)), 3, 7, N'wifi,jakuzi,barbekü')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (10, N'Çamlık Ev', N'Çam ormanları içinde kuş sesleriyle uyan.', 10, CAST(1400.00 AS Decimal(10, 2)), 4, 7, N'wifi,şömine,klima')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (12, N'Çiçek Bahçesi', N'Renkli çiçeklerle çevrili huzurlu bir tiny house.', 1, CAST(1250.00 AS Decimal(10, 2)), 2, 11, N'wifi,klima,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (13, N'Gizli Vaha', N'Doğanın kalbinde, yalnız başına keyif yapabileceğiniz bir ev.', 2, CAST(1300.00 AS Decimal(10, 2)), 3, 9, N'wifi,şömine,klima')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (14, N'Yıldızlı Gece', N'Yıldızları seyretmek için mükemmel bir tiny house.', 3, CAST(1200.00 AS Decimal(10, 2)), 2, 9, N'wifi,balcony,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (15, N'Huzur Köşesi', N'Şehir gürültüsünden uzak, tamamen sessiz bir ortam.', 4, CAST(1150.00 AS Decimal(10, 2)), 2, 9, N'wifi,şömine,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (16, N'Tropikal Cennet', N'Tropikal iklimin tadını çıkarabileceğiniz benzersiz bir tiny house.', 5, CAST(1450.00 AS Decimal(10, 2)), 3, 9, N'wifi,air conditioning,pool')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (17, N'Doğa Evi', N'Ormanın derinliklerinde keyifli bir konaklama.', 6, CAST(1100.00 AS Decimal(10, 2)), 2, 9, N'wifi,barbekü,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (18, N'Ada Evi', N'Küçük bir adada yalnız başına konaklayın.', 7, CAST(1600.00 AS Decimal(10, 2)), 2, 7, N'wifi,balcony,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (19, N'Yelkenli Ev', N'Deniz kenarında, deniz havası alabileceğiniz bir tiny house.', 8, CAST(1350.00 AS Decimal(10, 2)), 3, 8, N'wifi,jacuzzi,barbecue')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (20, N'Sarı Rüya', N'Gün batımını izleyebileceğiniz sarı renklerle dekore edilmiş bir tiny house.', 9, CAST(1400.00 AS Decimal(10, 2)), 4, 8, N'wifi,balcony,smart tv')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (21, N'Fırtına Evi', N'Fırtınalı havalarda bile güvenle kalabileceğiniz bir tiny house.', 10, CAST(1500.00 AS Decimal(10, 2)), 3, 7, N'wifi,fireplace,ac')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (22, N'Beyaz Perde', N'Doğanın beyaz örtüsünü görebileceğiniz dağ evi.', 1, CAST(1300.00 AS Decimal(10, 2)), 2, 7, N'wifi,fireplace,pool')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (23, N'Kumsal Evi', N'Beyaz kumlarla çevrili bir tiny house.', 2, CAST(1600.00 AS Decimal(10, 2)), 4, 11, N'wifi,barbecue,beach access')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (24, N'Dağ Zirvesi', N'Dağların zirvesinde manzaralı bir tiny house.', 3, CAST(1450.00 AS Decimal(10, 2)), 3, 8, N'wifi,sauna,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (25, N'Gökkuşağı Evi', N'Bütün renklerin birleştiği, çok renkli bir tiny house.', 4, CAST(1250.00 AS Decimal(10, 2)), 3, 7, N'wifi,balcony,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (26, N'Sonsuz Huzur', N'Sonsuz bir huzur içinde kaybolabileceğiniz bir tiny house.', 5, CAST(1400.00 AS Decimal(10, 2)), 2, 9, N'wifi,air conditioning,sauna')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (27, N'Gizli Orman', N'Kendinizi doğada kaybolmuş hissedeceğiniz orman evi.', 6, CAST(1100.00 AS Decimal(10, 2)), 2, 8, N'wifi,sauna,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (28, N'Ay Işığı', N'Gece boyunca ay ışığının parladığı bir tiny house.', 7, CAST(1200.00 AS Decimal(10, 2)), 2, 8, N'wifi,air conditioning,sauna')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (29, N'Fırtına Gölü', N'Göletin ortasında rüzgarlı bir ev deneyimi.', 8, CAST(1300.00 AS Decimal(10, 2)), 3, 7, N'wifi,sauna,pool')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (30, N'Beyaz Efsane', N'Beyaz duvarlar, sıcak bir iç mekan ile eviniz.', 9, CAST(1350.00 AS Decimal(10, 2)), 2, 8, N'wifi,smart tv,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (31, N'Kış Bahçesi', N'Kar manzaralı, sıcacık bir tiny house.', 10, CAST(1450.00 AS Decimal(10, 2)), 4, 11, N'wifi,fireplace,sauna')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (32, N'Kaya Evi', N'Kaya ve doğal taşlar arasında kurulu bir tiny house.', 1, CAST(1250.00 AS Decimal(10, 2)), 2, 11, N'wifi,barbecue,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (33, N'Rüya Yolu', N'Gizli bir yolun sonundaki bu evde huzurlu bir tatil sizi bekliyor.', 2, CAST(1400.00 AS Decimal(10, 2)), 3, 9, N'wifi,sauna,pool')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (34, N'Gizli Göl', N'Bir göl kenarında izole bir yaşam deneyimi.', 3, CAST(1150.00 AS Decimal(10, 2)), 2, 8, N'wifi,balcony,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (35, N'Serin Kuyu', N'Yeraltı sularının bulunduğu doğal bir tiny house.', 4, CAST(1200.00 AS Decimal(10, 2)), 3, 11, N'wifi,air conditioning,smart tv')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (36, N'Dağ Evi', N'Dağ eteklerinde bir köyde huzurlu bir tiny house.', 5, CAST(1350.00 AS Decimal(10, 2)), 4, 7, N'wifi,fireplace,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (37, N'Kuş Evi', N'Kuş sesleriyle uyanabileceğiniz sessiz bir tiny house.', 6, CAST(1100.00 AS Decimal(10, 2)), 2, 7, N'wifi,barbecue,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (38, N'Efsane Yıl', N'Yeni yıl gecesi kutlamaları için mükemmel bir tiny house.', 7, CAST(1600.00 AS Decimal(10, 2)), 3, 11, N'wifi,fireplace,pool')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (39, N'İzole Cennet', N'Şehirden uzakta, tamamen izole bir tiny house.', 8, CAST(1500.00 AS Decimal(10, 2)), 2, 7, N'wifi,sauna,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (40, N'Uzak Vadi', N'Vadinin derinliklerine kurulmuş bir tiny house.', 9, CAST(1400.00 AS Decimal(10, 2)), 4, 8, N'wifi,barbecue,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (41, N'Beyaz Bahçe', N'Bahçenizin içinde doğa ile iç içe bir tiny house.', 10, CAST(1300.00 AS Decimal(10, 2)), 3, 9, N'wifi,fireplace,sauna')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (42, N'Kum Yolu', N'Beyaz kumlu yolda keyifli bir tiny house.', 1, CAST(1250.00 AS Decimal(10, 2)), 2, 8, N'wifi,sauna,air conditioning')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (43, N'Yüksek Tepeler', N'Dağ zirvelerinden manzaralı bir tiny house.', 2, CAST(1500.00 AS Decimal(10, 2)), 3, 7, N'wifi,pool,balcony')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (44, N'Zümrüt Ormanı', N'Doğal bir ormanda zümrüt yeşili içinde bir tiny house.', 3, CAST(1450.00 AS Decimal(10, 2)), 4, 11, N'wifi,fireplace,sauna')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (45, N'Sonsuz Okyanus', N'Okyanus kenarında bir tiny house.', 4, CAST(1600.00 AS Decimal(10, 2)), 4, 9, N'wifi,balcony,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (46, N'Rüzgar Evi', N'Rüzgarla dans eden bir tiny house.', 5, CAST(1200.00 AS Decimal(10, 2)), 3, 11, N'wifi,air conditioning,smart tv')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (47, N'Gizli Kır', N'Kır hayatının tüm güzelliklerini barındıran bir tiny house.', 6, CAST(1150.00 AS Decimal(10, 2)), 2, 9, N'wifi,sauna,garden')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (48, N'Deniz Feneri', N'Deniz manzaralı ve deniz fenerine yakın bir tiny house.', 7, CAST(1300.00 AS Decimal(10, 2)), 3, 11, N'wifi,fireplace,sauna')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (49, N'Kış Masalı', N'Beyaz karlar içinde bir tiny house.', 8, CAST(1400.00 AS Decimal(10, 2)), 2, 9, N'wifi,air conditioning,fireplace')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (50, N'Çöl Evi', N'Çölde huzurlu bir tiny house deneyimi.', 9, CAST(1250.00 AS Decimal(10, 2)), 2, 9, N'wifi,sauna,pool')
SET IDENTITY_INSERT [dbo].[tiny_houses] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (1, N'Ali Yılmaz', N'ali.yilmaz@example.com', N'hashed_pw_1', 0, N'05531234567')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (2, N'Ayşe Demir', N'ayse.demir@example.com', N'hashed_pw_2', 1, N'05539876543')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (3, N'Mehmet Koç', N'mehmet.koc@example.com', N'hashed_pw_3', 1, N'05537654321')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (4, N'Elif Aydın', N'elif.aydin@example.com', N'hashed_pw_4', 1, N'05534561234')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (5, N'Burak Çelik', N'burak.celik@example.com', N'hashed_pw_5', 1, N'05538901234')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (6, N'Zeynep Uçar', N'zeynep.ucar@example.com', N'hashed_pw_6', 1, N'05536549876')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (7, N'Hakan Şahin', N'hakan.sahin@example.com', N'hashed_pw_7', 2, N'05533445566')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (8, N'Ceren Kılıç', N'ceren.kilic@example.com', N'hashed_pw_8', 2, N'05534343434')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (9, N'Mert Arslan', N'mert.arslan@example.com', N'hashed_pw_9', 2, N'05531239876')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (10, N'Selin Kaya', N'selin.kaya@example.com', N'hashed_pw_10', 0, N'05536789012')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (11, N'Kaan Civelek', N'kaancivelek17@gmail.com', N'hashed_pw_11', 2, N'0533333333')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[wishlist] ON 

INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (1, 1, 3)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (2, 2, 5)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (3, 3, 7)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (4, 4, 6)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (5, 5, 9)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (6, 6, 8)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (8, 8, 4)
INSERT [dbo].[wishlist] ([id], [user_id], [tiny_house_id]) VALUES (9, 9, 10)
SET IDENTITY_INSERT [dbo].[wishlist] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__72E12F1B8AF8ECEF]    Script Date: 5.05.2025 00:24:08 ******/
ALTER TABLE [dbo].[roles] ADD  CONSTRAINT [UQ__roles__72E12F1B8AF8ECEF] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E61643ACBB5FD]    Script Date: 5.05.2025 00:24:08 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UQ__users__AB6E61643ACBB5FD] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[availability] ADD  CONSTRAINT [DF__availabil__is_av__68487DD7]  DEFAULT ((1)) FOR [is_available]
GO
ALTER TABLE [dbo].[availability]  WITH CHECK ADD  CONSTRAINT [FK__availabil__tiny___693CA210] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[availability] CHECK CONSTRAINT [FK__availabil__tiny___693CA210]
GO
ALTER TABLE [dbo].[discounts]  WITH CHECK ADD  CONSTRAINT [FK__discounts__tiny___5812160E] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
GO
ALTER TABLE [dbo].[discounts] CHECK CONSTRAINT [FK__discounts__tiny___5812160E]
GO
ALTER TABLE [dbo].[house_images]  WITH CHECK ADD  CONSTRAINT [FK__house_ima__tiny___4CA06362] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[house_images] CHECK CONSTRAINT [FK__house_ima__tiny___4CA06362]
GO
ALTER TABLE [dbo].[invoices]  WITH CHECK ADD FOREIGN KEY([payment_id])
REFERENCES [dbo].[payments] ([id])
GO
ALTER TABLE [dbo].[maintenance]  WITH CHECK ADD  CONSTRAINT [FK__maintenan__tiny___5AEE82B9] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
GO
ALTER TABLE [dbo].[maintenance] CHECK CONSTRAINT [FK__maintenan__tiny___5AEE82B9]
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD  CONSTRAINT [FK__messages__receiv__440B1D61] FOREIGN KEY([receiver_user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[messages] CHECK CONSTRAINT [FK__messages__receiv__440B1D61]
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD  CONSTRAINT [FK__messages__sender__4316F928] FOREIGN KEY([sender_user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[messages] CHECK CONSTRAINT [FK__messages__sender__4316F928]
GO
ALTER TABLE [dbo].[payment_schedule]  WITH CHECK ADD FOREIGN KEY([reservation_id])
REFERENCES [dbo].[reservations] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([reservation_id])
REFERENCES [dbo].[reservations] ([id])
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD  CONSTRAINT [FK__reservati__tiny___403A8C7D] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
GO
ALTER TABLE [dbo].[reservations] CHECK CONSTRAINT [FK__reservati__tiny___403A8C7D]
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD  CONSTRAINT [FK__reservati__user___3F466844] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[reservations] CHECK CONSTRAINT [FK__reservati__user___3F466844]
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [FK__reviews__tiny_ho__5165187F] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [FK__reviews__tiny_ho__5165187F]
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [FK__reviews__user_id__5070F446] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [FK__reviews__user_id__5070F446]
GO
ALTER TABLE [dbo].[tiny_houses]  WITH CHECK ADD  CONSTRAINT [FK__tiny_hous__locat__3C69FB99] FOREIGN KEY([location_id])
REFERENCES [dbo].[locations] ([id])
GO
ALTER TABLE [dbo].[tiny_houses] CHECK CONSTRAINT [FK__tiny_hous__locat__3C69FB99]
GO
ALTER TABLE [dbo].[tiny_houses]  WITH CHECK ADD  CONSTRAINT [FK_tiny_houses_users] FOREIGN KEY([property_owner_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[tiny_houses] CHECK CONSTRAINT [FK_tiny_houses_users]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_roles]
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD  CONSTRAINT [FK__wishlist__tiny_h__5535A963] FOREIGN KEY([tiny_house_id])
REFERENCES [dbo].[tiny_houses] ([id])
GO
ALTER TABLE [dbo].[wishlist] CHECK CONSTRAINT [FK__wishlist__tiny_h__5535A963]
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD  CONSTRAINT [FK__wishlist__user_i__5441852A] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[wishlist] CHECK CONSTRAINT [FK__wishlist__user_i__5441852A]
GO
ALTER TABLE [dbo].[payment_schedule]  WITH CHECK ADD CHECK  (([status]='cancelled' OR [status]='overdue' OR [status]='paid' OR [status]='pending'))
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [MinikDB] SET  READ_WRITE 
GO
