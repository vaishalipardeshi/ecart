USE [master]
GO
/****** Object:  Database [ecart1]    Script Date: 04-03-2022 11:11:35 ******/
CREATE DATABASE [ecart1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ecart1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\ecart1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ecart1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\ecart1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ecart1] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ecart1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ecart1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ecart1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ecart1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ecart1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ecart1] SET ARITHABORT OFF 
GO
ALTER DATABASE [ecart1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ecart1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ecart1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ecart1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ecart1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ecart1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ecart1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ecart1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ecart1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ecart1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ecart1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ecart1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ecart1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ecart1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ecart1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ecart1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ecart1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ecart1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ecart1] SET  MULTI_USER 
GO
ALTER DATABASE [ecart1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ecart1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ecart1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ecart1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ecart1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ecart1] SET QUERY_STORE = OFF
GO
USE [ecart1]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ecart1]
GO
/****** Object:  Table [dbo].[order_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_tab](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_no] [int] NULL,
	[quantity] [int] NULL,
	[order_date] [date] NULL,
	[order_status_id] [int] NULL,
	[payment_mode_id] [int] NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
 CONSTRAINT [PK_order_tab] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_tab](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nchar](20) NULL,
	[product_img] [nchar](20) NULL,
	[description] [nchar](30) NULL,
	[is_active] [int] NULL,
	[product_code] [nchar](10) NULL,
	[price] [float] NULL,
	[pro_cat_id] [int] NULL,
	[available_quantity] [int] NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_tab](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](20) NULL,
	[email] [nchar](20) NULL,
	[password] [nchar](50) NULL,
	[gender_id] [int] NULL,
	[role_id] [int] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[OrderOnDate]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[OrderOnDate](@StartDate date,@EndDate date)
returns table
as
return select u.name,p.product_name,o.order_date from order_tab as o inner join product_tab as p on o.product_id=p.product_id inner join
[ecart1].[dbo].[user_tab] as u on u.user_id=o.user_id
where order_date between @StartDate and @EndDate;
GO
/****** Object:  Table [dbo].[address_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address_tab](
	[add_id] [int] IDENTITY(1,1) NOT NULL,
	[landmark] [nchar](10) NULL,
	[street_name] [nchar](10) NULL,
	[pincode] [int] NULL,
	[user_id] [int] NULL,
	[city] [nchar](20) NULL,
	[address_type_id] [int] NULL,
 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED 
(
	[add_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[userinfoview]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   view [dbo].[userinfoview]
as select c.user_id, c.name,c.email,ad.pincode,ad.city 
from user_tab as c,address_tab as ad 
where c.user_id=ad.user_id;
GO
/****** Object:  Table [dbo].[address_type_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address_type_tab](
	[address_type_id] [int] IDENTITY(1,1) NOT NULL,
	[address_type] [nchar](10) NULL,
 CONSTRAINT [PK_address_type] PRIMARY KEY CLUSTERED 
(
	[address_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_tab](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[quantity] [int] NULL,
	[product_id] [int] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_cart_table] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gender_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gender_tab](
	[gender_id] [int] IDENTITY(1,1) NOT NULL,
	[gender_name] [nchar](10) NULL,
 CONSTRAINT [PK_gender] PRIMARY KEY CLUSTERED 
(
	[gender_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mobile_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mobile_tab](
	[phone_id] [int] IDENTITY(1,1) NOT NULL,
	[phone_no] [bigint] NOT NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_mobile_table] PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_status_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_status_tab](
	[order_status_id] [int] IDENTITY(1,1) NOT NULL,
	[status_code] [nchar](10) NULL,
 CONSTRAINT [PK_order_status] PRIMARY KEY CLUSTERED 
(
	[order_status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[paymentmode_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paymentmode_tab](
	[pay_mode_id] [int] IDENTITY(1,1) NOT NULL,
	[payment_mode_type] [nchar](20) NULL,
 CONSTRAINT [PK_paymentmode] PRIMARY KEY CLUSTERED 
(
	[pay_mode_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_category_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_category_tab](
	[prod_cat_id] [int] NOT NULL,
	[category_name] [nchar](20) NULL,
 CONSTRAINT [PK_product_category] PRIMARY KEY CLUSTERED 
(
	[prod_cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_rating_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_rating_tab](
	[pro_rating_id] [int] IDENTITY(1,1) NOT NULL,
	[pro_star] [int] NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
 CONSTRAINT [PK_product_rating] PRIMARY KEY CLUSTERED 
(
	[pro_rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_tab]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_tab](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nchar](10) NULL,
 CONSTRAINT [PK_roletable] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[address_tab] ON 

INSERT [dbo].[address_tab] ([add_id], [landmark], [street_name], [pincode], [user_id], [city], [address_type_id]) VALUES (1, N'mchotel   ', N'mainraod  ', 425405, 1, N'jalgoan             ', 1)
INSERT [dbo].[address_tab] ([add_id], [landmark], [street_name], [pincode], [user_id], [city], [address_type_id]) VALUES (4, N'dmart     ', N'sainagar  ', 425406, 2, N'mumbai              ', 2)
INSERT [dbo].[address_tab] ([add_id], [landmark], [street_name], [pincode], [user_id], [city], [address_type_id]) VALUES (5, N'bank      ', N'nationroad', 411001, 3, N'nashik              ', 3)
INSERT [dbo].[address_tab] ([add_id], [landmark], [street_name], [pincode], [user_id], [city], [address_type_id]) VALUES (6, N'fcjunction', N'fcroad    ', 411004, 4, N'pune                ', 2)
INSERT [dbo].[address_tab] ([add_id], [landmark], [street_name], [pincode], [user_id], [city], [address_type_id]) VALUES (7, N'dmart     ', N'mainroad  ', 425484, 5, N'nagpur              ', 1)
SET IDENTITY_INSERT [dbo].[address_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[address_type_tab] ON 

INSERT [dbo].[address_type_tab] ([address_type_id], [address_type]) VALUES (1, N'home      ')
INSERT [dbo].[address_type_tab] ([address_type_id], [address_type]) VALUES (2, N'office    ')
INSERT [dbo].[address_type_tab] ([address_type_id], [address_type]) VALUES (3, N'business  ')
SET IDENTITY_INSERT [dbo].[address_type_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[cart_tab] ON 

INSERT [dbo].[cart_tab] ([cart_id], [quantity], [product_id], [user_id]) VALUES (1, 1, 3, 2)
INSERT [dbo].[cart_tab] ([cart_id], [quantity], [product_id], [user_id]) VALUES (2, 2, 2, 2)
INSERT [dbo].[cart_tab] ([cart_id], [quantity], [product_id], [user_id]) VALUES (3, 3, 2, 1)
INSERT [dbo].[cart_tab] ([cart_id], [quantity], [product_id], [user_id]) VALUES (4, 4, 1, 3)
INSERT [dbo].[cart_tab] ([cart_id], [quantity], [product_id], [user_id]) VALUES (5, 5, 4, 4)
SET IDENTITY_INSERT [dbo].[cart_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[gender_tab] ON 

INSERT [dbo].[gender_tab] ([gender_id], [gender_name]) VALUES (1, N'male      ')
INSERT [dbo].[gender_tab] ([gender_id], [gender_name]) VALUES (2, N'female    ')
SET IDENTITY_INSERT [dbo].[gender_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[mobile_tab] ON 

INSERT [dbo].[mobile_tab] ([phone_id], [phone_no], [user_id]) VALUES (1, 8978675, 1)
INSERT [dbo].[mobile_tab] ([phone_id], [phone_no], [user_id]) VALUES (2, 7654455, 4)
INSERT [dbo].[mobile_tab] ([phone_id], [phone_no], [user_id]) VALUES (3, 5322234, 2)
INSERT [dbo].[mobile_tab] ([phone_id], [phone_no], [user_id]) VALUES (4, 456554, 3)
INSERT [dbo].[mobile_tab] ([phone_id], [phone_no], [user_id]) VALUES (5, 654333, 2)
INSERT [dbo].[mobile_tab] ([phone_id], [phone_no], [user_id]) VALUES (6, 7897, 5)
SET IDENTITY_INSERT [dbo].[mobile_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[order_status_tab] ON 

INSERT [dbo].[order_status_tab] ([order_status_id], [status_code]) VALUES (1, N'shipped   ')
INSERT [dbo].[order_status_tab] ([order_status_id], [status_code]) VALUES (2, N'packed    ')
INSERT [dbo].[order_status_tab] ([order_status_id], [status_code]) VALUES (3, N'in-transit')
INSERT [dbo].[order_status_tab] ([order_status_id], [status_code]) VALUES (4, N'delievered')
INSERT [dbo].[order_status_tab] ([order_status_id], [status_code]) VALUES (5, N'cancel    ')
INSERT [dbo].[order_status_tab] ([order_status_id], [status_code]) VALUES (6, N'return    ')
SET IDENTITY_INSERT [dbo].[order_status_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[order_tab] ON 

INSERT [dbo].[order_tab] ([order_id], [order_no], [quantity], [order_date], [order_status_id], [payment_mode_id], [user_id], [product_id]) VALUES (1, 1, 1, CAST(N'2022-02-24' AS Date), 1, 1, 1, 1)
INSERT [dbo].[order_tab] ([order_id], [order_no], [quantity], [order_date], [order_status_id], [payment_mode_id], [user_id], [product_id]) VALUES (2, 2, 4, CAST(N'2022-02-15' AS Date), 3, 1, 2, 1)
INSERT [dbo].[order_tab] ([order_id], [order_no], [quantity], [order_date], [order_status_id], [payment_mode_id], [user_id], [product_id]) VALUES (3, 3, 3, CAST(N'2022-02-17' AS Date), 2, 2, 2, 2)
INSERT [dbo].[order_tab] ([order_id], [order_no], [quantity], [order_date], [order_status_id], [payment_mode_id], [user_id], [product_id]) VALUES (4, 4, 4, CAST(N'2022-02-14' AS Date), 4, 3, 3, 3)
INSERT [dbo].[order_tab] ([order_id], [order_no], [quantity], [order_date], [order_status_id], [payment_mode_id], [user_id], [product_id]) VALUES (5, 5, 2, CAST(N'2022-02-19' AS Date), 3, 4, 4, 2)
SET IDENTITY_INSERT [dbo].[order_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[paymentmode_tab] ON 

INSERT [dbo].[paymentmode_tab] ([pay_mode_id], [payment_mode_type]) VALUES (1, N'cod                 ')
INSERT [dbo].[paymentmode_tab] ([pay_mode_id], [payment_mode_type]) VALUES (2, N'credit card         ')
INSERT [dbo].[paymentmode_tab] ([pay_mode_id], [payment_mode_type]) VALUES (3, N'debit card          ')
INSERT [dbo].[paymentmode_tab] ([pay_mode_id], [payment_mode_type]) VALUES (4, N'upi                 ')
INSERT [dbo].[paymentmode_tab] ([pay_mode_id], [payment_mode_type]) VALUES (5, N'online banking      ')
SET IDENTITY_INSERT [dbo].[paymentmode_tab] OFF
GO
INSERT [dbo].[product_category_tab] ([prod_cat_id], [category_name]) VALUES (1, N'mobile              ')
INSERT [dbo].[product_category_tab] ([prod_cat_id], [category_name]) VALUES (2, N'tv                  ')
INSERT [dbo].[product_category_tab] ([prod_cat_id], [category_name]) VALUES (3, N'laptop              ')
INSERT [dbo].[product_category_tab] ([prod_cat_id], [category_name]) VALUES (4, N'earbud              ')
INSERT [dbo].[product_category_tab] ([prod_cat_id], [category_name]) VALUES (5, N'pendrive            ')
GO
SET IDENTITY_INSERT [dbo].[product_rating_tab] ON 

INSERT [dbo].[product_rating_tab] ([pro_rating_id], [pro_star], [user_id], [product_id]) VALUES (1, 4, 1, 1)
INSERT [dbo].[product_rating_tab] ([pro_rating_id], [pro_star], [user_id], [product_id]) VALUES (2, 3, 2, 2)
INSERT [dbo].[product_rating_tab] ([pro_rating_id], [pro_star], [user_id], [product_id]) VALUES (3, 5, 3, 3)
INSERT [dbo].[product_rating_tab] ([pro_rating_id], [pro_star], [user_id], [product_id]) VALUES (4, 4, 4, 4)
INSERT [dbo].[product_rating_tab] ([pro_rating_id], [pro_star], [user_id], [product_id]) VALUES (6, 5, 5, 4)
SET IDENTITY_INSERT [dbo].[product_rating_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[product_tab] ON 

INSERT [dbo].[product_tab] ([product_id], [product_name], [product_img], [description], [is_active], [product_code], [price], [pro_cat_id], [available_quantity]) VALUES (1, N'samsung             ', N'samsung.jpg         ', N'brand product                 ', 1, N'sm_101    ', 10000, 1, 1)
INSERT [dbo].[product_tab] ([product_id], [product_name], [product_img], [description], [is_active], [product_code], [price], [pro_cat_id], [available_quantity]) VALUES (2, N'mi                  ', N'mi.png              ', N'world best                    ', 0, N'mi_102    ', 20000, 2, 5)
INSERT [dbo].[product_tab] ([product_id], [product_name], [product_img], [description], [is_active], [product_code], [price], [pro_cat_id], [available_quantity]) VALUES (3, N'oneplus             ', N'one.jpg             ', N'no.1 product                  ', 1, N'one_103   ', 30000, 2, 6)
INSERT [dbo].[product_tab] ([product_id], [product_name], [product_img], [description], [is_active], [product_code], [price], [pro_cat_id], [available_quantity]) VALUES (4, N'realme              ', N'realme.png          ', N'smartphone                    ', 1, N'realme_104', 20000, 3, 10)
INSERT [dbo].[product_tab] ([product_id], [product_name], [product_img], [description], [is_active], [product_code], [price], [pro_cat_id], [available_quantity]) VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[product_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[role_tab] ON 

INSERT [dbo].[role_tab] ([role_id], [role_name]) VALUES (1, N'admin     ')
INSERT [dbo].[role_tab] ([role_id], [role_name]) VALUES (2, N'customer  ')
SET IDENTITY_INSERT [dbo].[role_tab] OFF
GO
SET IDENTITY_INSERT [dbo].[user_tab] ON 

INSERT [dbo].[user_tab] ([user_id], [name], [email], [password], [gender_id], [role_id]) VALUES (1, N'vaishali            ', N'vaishali@bbd        ', N'123                                               ', 2, 2)
INSERT [dbo].[user_tab] ([user_id], [name], [email], [password], [gender_id], [role_id]) VALUES (2, N'pritesh             ', N'pritesh@bbd         ', N'234                                               ', 1, 2)
INSERT [dbo].[user_tab] ([user_id], [name], [email], [password], [gender_id], [role_id]) VALUES (3, N'apurva              ', N'apurva@bbd          ', N'654                                               ', 2, 2)
INSERT [dbo].[user_tab] ([user_id], [name], [email], [password], [gender_id], [role_id]) VALUES (4, N'tejashree           ', N'tejashree@bbd       ', N'567                                               ', 2, 2)
INSERT [dbo].[user_tab] ([user_id], [name], [email], [password], [gender_id], [role_id]) VALUES (5, N'prince              ', N'prince@bbd          ', N'123                                               ', 1, 2)
SET IDENTITY_INSERT [dbo].[user_tab] OFF
GO
ALTER TABLE [dbo].[address_tab]  WITH CHECK ADD  CONSTRAINT [FK_address_address_type] FOREIGN KEY([address_type_id])
REFERENCES [dbo].[address_type_tab] ([address_type_id])
GO
ALTER TABLE [dbo].[address_tab] CHECK CONSTRAINT [FK_address_address_type]
GO
ALTER TABLE [dbo].[address_tab]  WITH CHECK ADD  CONSTRAINT [FK_address_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_tab] ([user_id])
GO
ALTER TABLE [dbo].[address_tab] CHECK CONSTRAINT [FK_address_user]
GO
ALTER TABLE [dbo].[cart_tab]  WITH CHECK ADD  CONSTRAINT [FK_cart_table_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product_tab] ([product_id])
GO
ALTER TABLE [dbo].[cart_tab] CHECK CONSTRAINT [FK_cart_table_product]
GO
ALTER TABLE [dbo].[cart_tab]  WITH CHECK ADD  CONSTRAINT [FK_cart_table_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_tab] ([user_id])
GO
ALTER TABLE [dbo].[cart_tab] CHECK CONSTRAINT [FK_cart_table_user]
GO
ALTER TABLE [dbo].[mobile_tab]  WITH CHECK ADD  CONSTRAINT [FK_mobile_table_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_tab] ([user_id])
GO
ALTER TABLE [dbo].[mobile_tab] CHECK CONSTRAINT [FK_mobile_table_user]
GO
ALTER TABLE [dbo].[order_tab]  WITH CHECK ADD  CONSTRAINT [FK_order_tab_order_status] FOREIGN KEY([order_status_id])
REFERENCES [dbo].[order_status_tab] ([order_status_id])
GO
ALTER TABLE [dbo].[order_tab] CHECK CONSTRAINT [FK_order_tab_order_status]
GO
ALTER TABLE [dbo].[order_tab]  WITH CHECK ADD  CONSTRAINT [FK_order_tab_paymentmode] FOREIGN KEY([payment_mode_id])
REFERENCES [dbo].[paymentmode_tab] ([pay_mode_id])
GO
ALTER TABLE [dbo].[order_tab] CHECK CONSTRAINT [FK_order_tab_paymentmode]
GO
ALTER TABLE [dbo].[order_tab]  WITH CHECK ADD  CONSTRAINT [FK_order_tab_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product_tab] ([product_id])
GO
ALTER TABLE [dbo].[order_tab] CHECK CONSTRAINT [FK_order_tab_product]
GO
ALTER TABLE [dbo].[order_tab]  WITH CHECK ADD  CONSTRAINT [FK_order_tab_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_tab] ([user_id])
GO
ALTER TABLE [dbo].[order_tab] CHECK CONSTRAINT [FK_order_tab_user]
GO
ALTER TABLE [dbo].[product_rating_tab]  WITH CHECK ADD  CONSTRAINT [FK_product_rating_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product_tab] ([product_id])
GO
ALTER TABLE [dbo].[product_rating_tab] CHECK CONSTRAINT [FK_product_rating_product]
GO
ALTER TABLE [dbo].[product_rating_tab]  WITH CHECK ADD  CONSTRAINT [FK_product_rating_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_tab] ([user_id])
GO
ALTER TABLE [dbo].[product_rating_tab] CHECK CONSTRAINT [FK_product_rating_user]
GO
ALTER TABLE [dbo].[product_tab]  WITH CHECK ADD  CONSTRAINT [FK_product_product_category] FOREIGN KEY([pro_cat_id])
REFERENCES [dbo].[product_category_tab] ([prod_cat_id])
GO
ALTER TABLE [dbo].[product_tab] CHECK CONSTRAINT [FK_product_product_category]
GO
ALTER TABLE [dbo].[user_tab]  WITH CHECK ADD  CONSTRAINT [FK_user_gender] FOREIGN KEY([gender_id])
REFERENCES [dbo].[gender_tab] ([gender_id])
GO
ALTER TABLE [dbo].[user_tab] CHECK CONSTRAINT [FK_user_gender]
GO
ALTER TABLE [dbo].[user_tab]  WITH CHECK ADD  CONSTRAINT [FK_user_roletable] FOREIGN KEY([role_id])
REFERENCES [dbo].[role_tab] ([role_id])
GO
ALTER TABLE [dbo].[user_tab] CHECK CONSTRAINT [FK_user_roletable]
GO
/****** Object:  StoredProcedure [dbo].[getUserByPincode]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getUserByPincode] @PostalCode int
AS
DECLARE @user_id int

select @user_id=user_id from address_tab WHERE pincode = @PostalCode;
SELECT user_id,name,email,gender_name,role_name FROM [ecart1].[dbo].[user_tab]
inner join gender_tab on user_tab.gender_id=gender_tab.gender_id
inner join role_tab on user_tab.role_id=role_tab.role_id
WHERE user_id = @user_id
GO
/****** Object:  StoredProcedure [dbo].[login_pro]    Script Date: 04-03-2022 11:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [dbo].[login_pro]

(

        @UserName varchar(50),

        @Password varchar(50),
		@Role varchar(10),
		@Status int out

)

as


if exists(select * from user_tab inner join role_tab on user_tab.role_id=role_tab.role_id where email=@UserName and password=@Password and role_tab.role_name=@Role )
begin
       set @status=1
	   print('valid user')
 end  

else
  begin
       set @status=0
	   print('invalid user')

  end
	  
GO
USE [master]
GO
ALTER DATABASE [ecart1] SET  READ_WRITE 
GO
