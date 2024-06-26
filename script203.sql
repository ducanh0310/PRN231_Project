Drop DATABASE [HouseRental]
/****** Object:  Database [HouseRental]    Script Date: 3/20/2024 11:36:07 AM ******/
CREATE DATABASE [HouseRental]
Use  [HouseRental]

GO
ALTER DATABASE [HouseRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HouseRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HouseRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HouseRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HouseRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [HouseRental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HouseRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HouseRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HouseRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HouseRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HouseRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HouseRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HouseRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HouseRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HouseRental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HouseRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HouseRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HouseRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HouseRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HouseRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HouseRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HouseRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HouseRental] SET RECOVERY FULL 
GO
ALTER DATABASE [HouseRental] SET  MULTI_USER 
GO
ALTER DATABASE [HouseRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HouseRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HouseRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HouseRental] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HouseRental] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HouseRental] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HouseRental', N'ON'
GO
ALTER DATABASE [HouseRental] SET QUERY_STORE = ON
GO
ALTER DATABASE [HouseRental] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HouseRental]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contract]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](255) NOT NULL,
	[description] [nvarchar](2048) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NOT NULL,
	[price] [float] NOT NULL,
	[filePath] [varchar](max) NOT NULL,
	[userId] [int] NOT NULL,
	[paymentId] [int] NOT NULL,
	[houseId] [int] NOT NULL,
 CONSTRAINT [PK_Contract] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[House]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[House](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[price] [float] NOT NULL,
	[userId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
	[description] [nvarchar](2048) NOT NULL,
	[isTenanted] [bit] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HouseService]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseService](
	[houseId] [int] NOT NULL,
	[serviceId] [int] NOT NULL,
 CONSTRAINT [PK_HouseService] PRIMARY KEY CLUSTERED 
(
	[houseId] ASC,
	[serviceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[amount] [float] NOT NULL,
	[tid] [varchar](255) NULL,
	[description] [varchar](255) NULL,
	[userId] [int] NOT NULL,
	[when] [datetime] NULL,
	[isPaid] [bit] NOT NULL,
 CONSTRAINT [PK_payments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](2048) NOT NULL,
	[userId] [int] NOT NULL,
	[status] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ROle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](2048) NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[Id] [int] NOT NULL,
	[Tid] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Amount] [decimal](18, 2) NULL,
	[CusumBalance] [decimal](18, 2) NULL,
	[When] [nvarchar](100) NULL,
	[BankSubAccId] [nvarchar](100) NULL,
	[SubAccId] [nvarchar](100) NULL,
	[VirtualAccount] [nvarchar](100) NULL,
	[VirtualAccountName] [nvarchar](100) NULL,
	[CorresponsiveName] [nvarchar](100) NULL,
	[CorresponsiveAccount] [nvarchar](100) NULL,
	[CorresponsiveBankId] [nvarchar](100) NULL,
	[CorresponsiveBankName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](255) NOT NULL,
	[lastName] [nvarchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[phoneNumber] [varchar](255) NOT NULL,
	[dob] [date] NOT NULL,
	[identificationNumber] [varchar](255) NOT NULL,
	[isActive] [bit] NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[refreshToken] [nvarchar](100) NULL,
	[refreshTokenExpiryTime] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 3/20/2024 11:36:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[userId] [int] NOT NULL,
	[roleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Categories] ([id], [name]) VALUES (1, N'Duplex')
INSERT [dbo].[Categories] ([id], [name]) VALUES (2, N'Single-Family Home')
INSERT [dbo].[Categories] ([id], [name]) VALUES (3, N'Multi-Family Home')
INSERT [dbo].[Categories] ([id], [name]) VALUES (4, N'2-story house')
GO
SET IDENTITY_INSERT [dbo].[House] ON 

INSERT [dbo].[House] ([id], [name], [price], [userId], [categoryId], [description], [isTenanted]) VALUES (1, N'P001', 125, 2, 1, N'The first house in 1st floor', 0)
SET IDENTITY_INSERT [dbo].[House] OFF
GO
SET IDENTITY_INSERT [dbo].[payments] ON 

INSERT [dbo].[payments] ([id], [name], [amount], [tid], [description], [userId], [when], [isPaid]) VALUES (2, N'T0324 U1 H1', 3000000, NULL, NULL, 1, CAST(N'2022-12-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[payments] ([id], [name], [amount], [tid], [description], [userId], [when], [isPaid]) VALUES (3, N'giao dich thu nghiem', 4500000, NULL, N'tien nha thang 12 1 2', 1, CAST(N'2024-03-20T03:33:03.140' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([id], [name]) VALUES (2, N'Tenant')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[Transaction] ([Id], [Tid], [Description], [Amount], [CusumBalance], [When], [BankSubAccId], [SubAccId], [VirtualAccount], [VirtualAccountName], [CorresponsiveName], [CorresponsiveAccount], [CorresponsiveBankId], [CorresponsiveBankName]) VALUES (0, N'MA_GIAO_DICH_THU_NGHIEM', N'giao dich thu nghiem', CAST(599000.00 AS Decimal(18, 2)), NULL, N'2024-03-20 03:33:00', NULL, N'88888888', N'', N'', N'NGUYEN VAN A', N'8888888888', N'970415', N'VietinBank')
INSERT [dbo].[Transaction] ([Id], [Tid], [Description], [Amount], [CusumBalance], [When], [BankSubAccId], [SubAccId], [VirtualAccount], [VirtualAccountName], [CorresponsiveName], [CorresponsiveAccount], [CorresponsiveBankId], [CorresponsiveBankName]) VALUES (6067875, N'FT24075900398068', N'NGUYEN VAN CAO KY Chuyen tien - Magiao dich/ Trace563622 Trace 563622', CAST(5000.00 AS Decimal(18, 2)), NULL, N'2024-03-15 05:23:04', NULL, N'0152345688888', N'', N'', N'', N'', N'', N'')
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [firstName], [lastName], [email], [phoneNumber], [dob], [identificationNumber], [isActive], [password], [username], [refreshToken], [refreshTokenExpiryTime]) VALUES (1, N'thanh', N'minh', N'thanh@gmail.com', N'123456789', CAST(N'2002-11-02' AS Date), N'123456546574', 1, N'123', N'mkboss', N'ESLis2z2NOJn0rU8ZruEdMc7KpgbqoOdJ7pm2ztjre+0qYnfzETflxNXjuxoBZrrgq3mTlPiM/ynLoyf1M4o7A==', CAST(N'2024-03-27T04:40:34.660' AS DateTime))
INSERT [dbo].[User] ([id], [firstName], [lastName], [email], [phoneNumber], [dob], [identificationNumber], [isActive], [password], [username], [refreshToken], [refreshTokenExpiryTime]) VALUES (2, N'viet', N'hoang', N'viet@gmail.com', N'123456789', CAST(N'2002-11-02' AS Date), N'123456546574', 1, N'123', N'viet', N'aK0U/URyHdqfJXpKD3A5+/IQOj9Yn19/dvb3sRC/Tw6mhcJ6eklegidU71TKb/kQ6y3H5oBQI9+S/4PhMQwApg==', CAST(N'2024-03-27T01:18:15.543' AS DateTime))
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [dbo].[UserRole] ([userId], [roleId]) VALUES (1, 1)
INSERT [dbo].[UserRole] ([userId], [roleId]) VALUES (2, 2)
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_House] FOREIGN KEY([houseId])
REFERENCES [dbo].[House] ([id])
GO
ALTER TABLE [dbo].[Contract] CHECK CONSTRAINT [FK_Contract_House]
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_payments] FOREIGN KEY([paymentId])
REFERENCES [dbo].[payments] ([id])
GO
ALTER TABLE [dbo].[Contract] CHECK CONSTRAINT [FK_Contract_payments]
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Contract] CHECK CONSTRAINT [FK_Contract_User]
GO
ALTER TABLE [dbo].[House]  WITH CHECK ADD  CONSTRAINT [FK_House_categories1] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[House] CHECK CONSTRAINT [FK_House_categories1]
GO
ALTER TABLE [dbo].[House]  WITH CHECK ADD  CONSTRAINT [FK_House_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[House] CHECK CONSTRAINT [FK_House_User]
GO
ALTER TABLE [dbo].[HouseService]  WITH CHECK ADD  CONSTRAINT [FK_HouseService_House] FOREIGN KEY([houseId])
REFERENCES [dbo].[House] ([id])
GO
ALTER TABLE [dbo].[HouseService] CHECK CONSTRAINT [FK_HouseService_House]
GO
ALTER TABLE [dbo].[HouseService]  WITH CHECK ADD  CONSTRAINT [FK_HouseService_Service] FOREIGN KEY([serviceId])
REFERENCES [dbo].[Service] ([id])
GO
ALTER TABLE [dbo].[HouseService] CHECK CONSTRAINT [FK_HouseService_Service]
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD  CONSTRAINT [FK_payments_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[payments] CHECK CONSTRAINT [FK_payments_User]
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_User]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO
USE [master]
GO
ALTER DATABASE [HouseRental] SET  READ_WRITE 
GO
