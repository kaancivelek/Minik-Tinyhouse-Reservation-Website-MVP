USE [master]
GO
/****** Object:  Database [MinikDB]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[reservations]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetReservationsByUserIdFn]    Script Date: 10.06.2025 13:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetReservationsByUserIdFn] (@UserId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        user_id,
        tiny_house_id,
        total_price,
        status,
        check_in,
        check_out
    FROM 
        reservations
    WHERE 
        user_id = @UserId
);
GO
/****** Object:  Table [dbo].[locations]    Script Date: 10.06.2025 13:10:35 ******/
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
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 10.06.2025 13:10:35 ******/
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
 CONSTRAINT [PK__reviews__3213E83F037149A8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tiny_houses]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetTinyHouseDetailsById]    Script Date: 10.06.2025 13:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTinyHouseDetailsById]
(
    @Id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        T.id,
        T.name,
        T.description,
        T.location_id,
        T.price_per_night,
        T.max_guests,
        T.property_owner_id,
        T.amenities,
        L.city,
        L.country,
        (
            SELECT CEILING(AVG(CAST(rating AS FLOAT))) 
            FROM reviews 
            WHERE tiny_house_id = T.id
        ) AS average_rating
    FROM tiny_houses T
    JOIN locations L ON T.location_id = L.id
    WHERE T.id = @Id
);
GO
/****** Object:  Table [dbo].[availability]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[discounts]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[house_images]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[invoices]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[maintenance]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[messages]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[payment_schedule]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[payments]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[roles]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 10.06.2025 13:10:35 ******/
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
/****** Object:  Table [dbo].[wishlist]    Script Date: 10.06.2025 13:10:35 ******/
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

INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (1, 1, CAST(N'2025-06-09' AS Date), CAST(N'2026-01-31' AS Date), 1)
INSERT [dbo].[availability] ([id], [tiny_house_id], [available_from], [available_to], [is_available]) VALUES (2, 2, CAST(N'2025-06-01' AS Date), CAST(N'2025-07-31' AS Date), 1)
SET IDENTITY_INSERT [dbo].[availability] OFF
GO
SET IDENTITY_INSERT [dbo].[house_images] ON 

INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (1, 1, N'https://www.corumwebtv.com/wp-content/uploads/2022/03/erdogan.jpg')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (2, 2, N'https://lh3.googleusercontent.com/p/AF1QipPilHzLNd2xfeo39wVw_IRkrPp8HDd-pPkxsR9u=s294-w294-h220-n-k-no')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (3, 2, N'https://lh3.googleusercontent.com/p/AF1QipOxfF2lPw_5Tr8ckcaeJI5TSjwgt0GR6S69HBzt=s294-w294-h220-n-k-no')
INSERT [dbo].[house_images] ([id], [tiny_house_id], [image_url]) VALUES (4, 2, N'https://lh3.googleusercontent.com/p/AF1QipM3fx2WdTTiycpYvLMxbn4NSXpnzbD1awufnt3w=w243-h304-n-k-no-nu')
SET IDENTITY_INSERT [dbo].[house_images] OFF
GO
SET IDENTITY_INSERT [dbo].[locations] ON 

INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude], [user_id]) VALUES (1, N'Türkiye', N'Çanakkale', N'Boğazın Ortası', CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[locations] ([id], [country], [city], [address], [latitude], [longitude], [user_id]) VALUES (2, N'Türkiye', N'Çanakkale', N'Beyaz, Ahmetçe Sahil Yolu, Yalı Cd. No:47, 17862 Ahmetçe/Ayvacık/Çanakkale', CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)), 4)
SET IDENTITY_INSERT [dbo].[locations] OFF
GO
SET IDENTITY_INSERT [dbo].[maintenance] ON 

INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (1, 1, N'mock', CAST(N'0001-01-01' AS Date), N'completed')
INSERT [dbo].[maintenance] ([id], [tiny_house_id], [maintenance_type], [maintenance_date], [status]) VALUES (2, 2, N'undefined', CAST(N'0001-01-01' AS Date), N'completed')
SET IDENTITY_INSERT [dbo].[maintenance] OFF
GO
SET IDENTITY_INSERT [dbo].[reservations] ON 

INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (3, 3, 1, CAST(N'0001-01-01' AS Date), CAST(N'0001-01-02' AS Date), CAST(1.00 AS Decimal(10, 2)), N'confirmed')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (4, 2, 1, CAST(N'2025-06-26' AS Date), CAST(N'2025-06-29' AS Date), CAST(1199997.00 AS Decimal(10, 2)), N'confirmed')
INSERT [dbo].[reservations] ([id], [user_id], [tiny_house_id], [check_in], [check_out], [total_price], [status]) VALUES (5, 4, 2, CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(1.00 AS Decimal(10, 2)), N'completed')
SET IDENTITY_INSERT [dbo].[reservations] OFF
GO
INSERT [dbo].[roles] ([id], [name]) VALUES (3, N'admin')
INSERT [dbo].[roles] ([id], [name]) VALUES (1, N'customer')
INSERT [dbo].[roles] ([id], [name]) VALUES (2, N'propertyOwner')
GO
SET IDENTITY_INSERT [dbo].[tiny_houses] ON 

INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (1, N'Batan dünyanın malı! Çanakkale Köprüsü', N'Boğaz manzaralı Çanakkale köprüsü siz lüks özel müşterilerimize tabi ki özel deneyimi ile buluşuyor.', 1, CAST(399999.00 AS Decimal(10, 2)), 1, 4, N'rüzgar,yol,turnikedeki personel,demir korkuluk')
INSERT [dbo].[tiny_houses] ([id], [name], [description], [location_id], [price_per_night], [max_guests], [property_owner_id], [amenities]) VALUES (2, N'Concept Bungalow', N' Bir çok farklı konfor seçeneği rahat konaklama birimlerinin standart donanımını bütünlemektedir. Otel, restoran ve çamaşırhane gibi hoşa giden birçok hizmetle, rahat ve dinlendirici bir konaklama imkânı sunmaktadır. Ortak alanlardaki kablosuz internet bağlantısı sayesinde misafirler, (ücretsiz) dış dünya ile iletişimlerini sağlayabilirler. Gastronomi alanında hizmet veren bir plaj barı mevcuttur. Bunun yanı sıra, tesis dâhilinde bir bahçe bulunmaktadır. Özel araçlarıyla gelen misafirler, bunları tesisin açık otoparkına (ücretsiz) bırakabilirler. Misafirlere ayrıca ücretsiz taşıma hizmeti sağlanmaktadır.', 2, CAST(4317.00 AS Decimal(10, 2)), 4, 4, N'Kablosuz ağ, Ücretsiz kahvaltı, Ücretsiz park alanı, Havuz, Klimalı, Çamaşır yıkama hizmeti, Evcil hayvan kabul ediliyor, Plaj mevcut, Restoran, Spor salonu')
SET IDENTITY_INSERT [dbo].[tiny_houses] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (2, N'Kaan Civelek', N'kaancivelek17@gmail.com', N'$2a$11$QKMOdpliwZzEJhUMj1d6neWqOzUj17X2CsNAvyaO0HQgo8oEQ8GOm', 1, N'05397031329')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (3, N'Kaan Civelek', N'businesskaancivelek@gmail.com', N'$2a$11$rcd4G4yZ9UhxdiyCPmRbrexKv6ZutL8cPmM8CsLeOJ4mzpnh4dbZe', 3, N'05397031328')
INSERT [dbo].[users] ([id], [full_name], [email], [password_hash], [role_id], [phone_number]) VALUES (4, N'Kaan Civelek', N'kaancivelek17@hotmail.com', N'$2a$11$N4qUAgIjOEe0gIKHD96h4eJkZwG.jm6BEltjihVo6gRLQ2PVXlHR.', 2, N'05397031327')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__72E12F1B8AF8ECEF]    Script Date: 10.06.2025 13:10:35 ******/
ALTER TABLE [dbo].[roles] ADD  CONSTRAINT [UQ__roles__72E12F1B8AF8ECEF] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E61643ACBB5FD]    Script Date: 10.06.2025 13:10:35 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UQ__users__AB6E61643ACBB5FD] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[availability] ADD  CONSTRAINT [DF__availabil__is_av__68487DD7]  DEFAULT ((1)) FOR [is_available]
GO
ALTER TABLE [dbo].[reviews] ADD  CONSTRAINT [Df_rating]  DEFAULT ((0)) FOR [rating]
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
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [CK__reviews__rating__6754599E] CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [CK__reviews__rating__6754599E]
GO
/****** Object:  StoredProcedure [dbo].[getFullNameByUserId]    Script Date: 10.06.2025 13:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getFullNameByUserId] @userId int
AS

SELECT full_name
FROM users
WHERE id = @userId
/*Kaan Civelek*/
GO
/****** Object:  StoredProcedure [dbo].[getUserByUserId]    Script Date: 10.06.2025 13:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getUserByUserId] @userId int
AS

SELECT *
FROM users
WHERE id = @userId
/*Kaan Civelek*/
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAvailabilityStatus]    Script Date: 10.06.2025 13:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateAvailabilityStatus]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE availability
    SET is_available = CASE 
        WHEN available_from <= CAST(GETDATE() AS DATE) AND available_to >= CAST(GETDATE() AS DATE)
            THEN 1
        ELSE 0
    END;
END;
GO
USE [master]
GO
ALTER DATABASE [MinikDB] SET  READ_WRITE 
GO
