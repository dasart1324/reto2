USE [master]
GO
/****** Object:  Database [Reto2]    Script Date: 10/4/2021 11:16:33 AM ******/
CREATE DATABASE [Reto2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Reto2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DASART\MSSQL\DATA\Reto2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Reto2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DASART\MSSQL\DATA\Reto2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Reto2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Reto2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Reto2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Reto2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Reto2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Reto2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Reto2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Reto2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Reto2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Reto2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Reto2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Reto2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Reto2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Reto2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Reto2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Reto2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Reto2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Reto2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Reto2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Reto2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Reto2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Reto2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Reto2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Reto2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Reto2] SET RECOVERY FULL 
GO
ALTER DATABASE [Reto2] SET  MULTI_USER 
GO
ALTER DATABASE [Reto2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Reto2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Reto2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Reto2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Reto2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Reto2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Reto2', N'ON'
GO
ALTER DATABASE [Reto2] SET QUERY_STORE = OFF
GO
USE [Reto2]
GO
/****** Object:  Table [dbo].[libros]    Script Date: 10/4/2021 11:16:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libros](
	[codigo] [varchar](5) NOT NULL,
	[titulo] [varchar](40) NULL,
	[autor] [varchar](30) NULL,
	[editorial] [varchar](20) NULL,
	[precio] [decimal](5, 2) NULL,
	[cantidad] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[libros] ([codigo], [titulo], [autor], [editorial], [precio], [cantidad]) VALUES (N'0001', N'El codigo Da Vinci', N'Dan Brown', N'Planeta', CAST(200.00 AS Decimal(5, 2)), 20)
GO
INSERT [dbo].[libros] ([codigo], [titulo], [autor], [editorial], [precio], [cantidad]) VALUES (N'0002', N'Origen', N'Dan Brown', N'Planeta', CAST(300.00 AS Decimal(5, 2)), 40)
GO
INSERT [dbo].[libros] ([codigo], [titulo], [autor], [editorial], [precio], [cantidad]) VALUES (N'0003', N'Angeles y demonios', N'Dan Brown', N'Planeta', CAST(150.00 AS Decimal(5, 2)), 200)
GO
INSERT [dbo].[libros] ([codigo], [titulo], [autor], [editorial], [precio], [cantidad]) VALUES (N'0004', N'El simbolo perdido', N'Dan Brown ', N'Planeta', CAST(400.00 AS Decimal(5, 2)), 5)
GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_libros]    Script Date: 10/4/2021 11:16:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE proc [dbo].[sp_buscar_libros]
  @codigo varchar(5)
  as
  select codigo, titulo, autor, editorial, precio, cantidad from libros where codigo = @codigo
GO
/****** Object:  StoredProcedure [dbo].[sp_listar_libros]    Script Date: 10/4/2021 11:16:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create proc [dbo].[sp_listar_libros]
  as
  select * from libros order by codigo
GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimiento_libros]    Script Date: 10/4/2021 11:16:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  CREATE proc [dbo].[sp_mantenimiento_libros]
   @codigo varchar(5),
   @titulo varchar(40),
   @autor varchar(30),
   @editorial varchar(20),
   @precio int,
   @cantidad smallint,
   @accion varchar(50) output
   as
   if(@accion = '1')
   begin
	declare @codnuevo varchar(5), @codmax varchar(5)
	set @codmax = (select MAX(codigo) from libros)
	set @codmax = ISNULL(@codmax, '0000')
	set @codnuevo = RIGHT(RIGHT(@CODMAX,4)+10001,4)
	insert into libros(codigo,titulo,autor,editorial,precio,cantidad)
	values(@codnuevo,@titulo,@autor,@editorial,@precio,@cantidad)
	set @accion = 'Se genero el código: ' + @codnuevo
	end
	else if (@accion = '2')
	begin
		update libros set titulo = @titulo, autor = @autor, editorial = @editorial, precio = @precio, cantidad = @cantidad where codigo = @codigo
		set @accion = 'Se modifico el código: ' + @codigo
	end
	else if (@accion = '3')
	begin
	delete from libros where codigo = @codigo
	set @accion = 'Se ha eliminado el código: ' + @codigo
	end
GO
USE [master]
GO
ALTER DATABASE [Reto2] SET  READ_WRITE 
GO
