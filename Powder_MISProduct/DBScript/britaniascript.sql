USE [master]
GO
/****** Object:  Database [GEA-Britania]    Script Date: 1/28/2022 11:05:32 AM ******/
CREATE DATABASE [GEA-Britania]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GEA-Britania', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\GEA-Britania.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GEA-Britania_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\GEA-Britania_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [GEA-Britania] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GEA-Britania].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GEA-Britania] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GEA-Britania] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GEA-Britania] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GEA-Britania] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GEA-Britania] SET ARITHABORT OFF 
GO
ALTER DATABASE [GEA-Britania] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GEA-Britania] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GEA-Britania] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GEA-Britania] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GEA-Britania] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GEA-Britania] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GEA-Britania] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GEA-Britania] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GEA-Britania] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GEA-Britania] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GEA-Britania] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GEA-Britania] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GEA-Britania] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GEA-Britania] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GEA-Britania] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GEA-Britania] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GEA-Britania] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GEA-Britania] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GEA-Britania] SET  MULTI_USER 
GO
ALTER DATABASE [GEA-Britania] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GEA-Britania] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GEA-Britania] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GEA-Britania] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GEA-Britania] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GEA-Britania] SET QUERY_STORE = OFF
GO
USE [GEA-Britania]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitBigInt]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnSplitBigInt] 

(

    -- Add the parameters for the function here

    @input nvarchar(4000)

)

RETURNS @retBigint TABLE 

(

    [Value] [bigint] NOT NULL

)

AS

BEGIN

    DECLARE @bigint nvarchar(100)

    DECLARE @pos int

    SET @input = LTRIM(RTRIM(@input))+ ',' -- TRIMMING THE BLANK SPACES

    SET @pos = CHARINDEX(',', @input, 1) -- OBTAINING THE STARTING POSITION OF COMMA IN THE GIVEN STRING

    IF REPLACE(@input, ',', '') <> '' -- CHECK IF THE STRING EXIST FOR US TO SPLIT

    BEGIN

        WHILE @pos > 0

        BEGIN

            SET @bigint = LTRIM(RTRIM(LEFT(@input, @pos - 1))) -- GET THE 1ST INT VALUE TO BE INSERTED

            IF @bigint <> ''

            BEGIN

                INSERT INTO @retBigint (Value) 

                VALUES (CAST(@bigint AS bigint)) 

            END

            SET @input = RIGHT(@input, LEN(@input) - @pos) -- RESETTING THE INPUT STRING BY REMOVING THE INSERTED ONES

            SET @pos = CHARINDEX(',', @input, 1) -- OBTAINING THE STARTING POSITION OF COMMA IN THE RESETTED NEW STRING

        END

    END    

    RETURN

    

END



GO
/****** Object:  Table [dbo].[ChemicalConsumption]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChemicalConsumption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[Acid] [float] NULL,
	[Lye] [float] NULL,
 CONSTRAINT [PK_ChemicalConsumption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CIPRecipe]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIPRecipe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[PLCValue] [real] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CIPRoutes]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIPRoutes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RouteNo] [int] NULL,
	[RouteName] [nvarchar](500) NULL,
	[PLCValue] [real] NULL,
	[Description] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompressedAirTag]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompressedAirTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_CompressedAirTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompressorLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompressorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[U3TT01] [real] NULL,
	[U3TT02] [real] NULL,
	[U3PT01] [real] NULL,
	[U3TT03] [real] NULL,
	[U3TT04] [real] NULL,
	[U3FT01] [real] NULL,
	[U3FT02] [real] NULL,
	[U31FT01] [real] NULL,
	[U31PT01] [real] NULL,
 CONSTRAINT [PK_CompressorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConcfeedTankStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConcfeedTankStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NOT NULL,
	[F11T01TypesofMilk] [int] NOT NULL,
	[F11T01TankStatus] [bit] NOT NULL,
	[F11T01Qty] [float] NOT NULL,
	[F11T01AgeingTimer] [bigint] NOT NULL,
	[F11T01DirtyTime] [bigint] NOT NULL,
	[F12T01TypesofMilk1] [int] NOT NULL,
	[F12T01TankStatus1] [bit] NOT NULL,
	[F12T01Qty1] [float] NOT NULL,
	[F12T01AgeingTimer1] [bigint] NOT NULL,
	[F12T01DirtyTime1] [bigint] NOT NULL,
	[F13T01TypesofMilk11] [int] NOT NULL,
	[F13T01TankStatus11] [bit] NOT NULL,
	[F13T01Qty11] [float] NOT NULL,
	[F13T01Temp] [float] NULL,
	[F13T01AgeingTimer11] [bigint] NOT NULL,
	[F13T01DirtyTime11] [bigint] NOT NULL,
	[F19T01TypesofMilk11] [int] NOT NULL,
	[F19T01TankStatus11] [bit] NOT NULL,
	[F19T01Qty11] [float] NOT NULL,
	[F19T01AgeingTimer11] [bigint] NOT NULL,
	[F19T01DirtyTime11] [bigint] NOT NULL,
 CONSTRAINT [PK_ConcfeedTankSZZtatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CPLLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CPLLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[StartTrigger] [bit] NULL,
	[PasteurizerStatus] [int] NULL,
	[Source] [int] NULL,
	[Destination] [int] NULL,
	[Flow] [float] NULL,
	[BatchTotalizer] [float] NULL,
	[TransferedQty] [float] NULL,
	[HeatingFDVStatus] [bit] NULL,
	[ChillingFDVStatus] [bit] NULL,
	[Heating] [float] NULL,
	[Cooling] [float] NULL,
	[HotWaterPHEInlet] [float] NULL,
	[RegenerationEfficiency] [float] NULL,
 CONSTRAINT [PK_CPLLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreamBufferTank_Status]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreamBufferTank_Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[TypesofMilk] [int] NULL,
	[TankStatus] [bit] NULL,
	[Qty] [float] NULL,
	[Temp] [float] NULL,
	[AgeingTimer] [bigint] NULL,
	[DirtyTime] [bigint] NULL,
 CONSTRAINT [PK_CreamBufferTank_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreamTank_Status]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreamTank_Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[TypesofMilk] [int] NULL,
	[TankStatus] [bit] NULL,
	[Qty] [float] NULL,
	[Temp] [float] NULL,
	[AgeingTimer] [bigint] NULL,
	[DirtyTime] [bigint] NULL,
	[CreamdispatchQty] [float] NULL,
 CONSTRAINT [PK_CreamTank_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CrystallizationTankStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CrystallizationTankStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[C11T01TypesOfWhey] [int] NULL,
	[C11T01TankStatus] [bit] NULL,
	[C11T01Qty] [float] NULL,
	[C11T01CrystallizationTankTemp] [float] NULL,
	[C11T01CrystallizationTankJacketCoolingwatertemp] [float] NULL,
	[C11T01ForwardPumpspeed] [float] NULL,
	[C11T01InitialTanktemp] [float] NULL,
	[C11T01FinalTanktemp] [float] NULL,
	[C11T01BatchTime] [int] NULL,
	[C11T01AgeingTimer] [int] NULL,
	[C11T01DirtyTime] [int] NULL,
	[C12T01TypesofWhey] [int] NULL,
	[C12T01TankStatus] [bit] NULL,
	[C12T01Qty] [float] NULL,
	[C12T01CrystallizationTankTemp] [float] NULL,
	[C12T01CrystallizationTankJacketCoolingwatertemp] [float] NULL,
	[C12T01ForwardPumpspeed] [float] NULL,
	[C12T01InitialTanktemp] [float] NULL,
	[C12T01FinalTanktemp] [float] NULL,
	[C12T01BatchTime] [int] NULL,
	[C12T01AgeingTimer] [int] NULL,
	[C12T01DirtyTime] [int] NULL,
	[C13T01TypesofWhey1] [int] NULL,
	[C13T01TankStatus1] [bit] NULL,
	[C13T01Qty1] [float] NULL,
	[C13T01CrystallizationTankTemp1] [float] NULL,
	[C13T01CrystallizationTankJacketCoolingwatertemp1] [float] NULL,
	[C13T01ForwardPumpspeed1] [float] NULL,
	[C13T01InitialTanktemp1] [float] NULL,
	[C13T01FinalTanktemp1] [float] NULL,
	[C13T01BatchTime1] [int] NULL,
	[C13T01AgeingTimer1] [int] NULL,
	[C13T01DirtyTime1] [int] NULL,
	[C14T01TypesofWhey1] [int] NULL,
	[C14T01TankStatus1] [bit] NULL,
	[C14T01Qty1] [float] NULL,
	[C14T01CrystallizationTankTemp1] [float] NULL,
	[C14T01CrystallizationTankJacketCoolingwatertemp1] [float] NULL,
	[C14T01ForwardPumpspeed1] [float] NULL,
	[C14T01InitialTanktemp1] [float] NULL,
	[C14T01FinalTanktemp1] [float] NULL,
	[C14T01BatchTime1] [int] NULL,
	[C14T01AgeingTimer1] [int] NULL,
	[C14T01DirtyTime1] [int] NULL,
 CONSTRAINT [PK_CrystallizationTankStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DailyActivity]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyActivity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[MilkProcessEvap1] [float] NULL,
	[MilkProcessEvap2] [float] NULL,
	[MilkProcessTotal] [float] NULL,
	[SuerSilo1] [float] NULL,
	[SuerSilo2] [float] NULL,
	[PowderSilo1] [float] NULL,
	[PowderSilo2] [float] NULL,
	[PowderSilo3] [float] NULL,
	[PowderSilo4] [float] NULL,
	[MilkSiloLevel1] [float] NULL,
	[MilkSiloLevel2] [float] NULL,
	[MilkSiloLevel3] [float] NULL,
	[MilkSiloLevel4] [float] NULL,
	[AcidTank1] [float] NULL,
	[LyeTank] [float] NULL,
	[SoftWater] [float] NULL,
	[RawWater] [float] NULL,
	[SteamConsumption] [float] NULL,
	[PowerConsumption1] [float] NULL,
	[PowerConsumption2] [float] NULL,
	[ROWaterGeneration] [float] NULL,
	[NZGeneration] [float] NULL,
	[AirConsumption] [float] NULL,
 CONSTRAINT [PK_DailyActivity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesiccantLog1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesiccantLog1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[D11DPT01] [real] NULL,
	[D11DPT02] [real] NULL,
	[D11DPT06] [real] NULL,
	[D11DPT03] [real] NULL,
	[D11DPT04] [real] NULL,
	[D11DPT05] [real] NULL,
	[D11TT01] [real] NULL,
	[D11TT02] [real] NULL,
	[D11MT01] [real] NULL,
	[D11MT02] [real] NULL,
	[D11F02] [real] NULL,
	[D11PT02] [real] NULL,
	[D11TT03] [real] NULL,
	[D11TT04] [real] NULL,
	[D11F03] [real] NULL,
	[D11PT11] [real] NULL,
	[D11VGC11] [real] NULL,
 CONSTRAINT [PK_DesiccantLog1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesiccantLog2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesiccantLog2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[D11DPT07] [real] NULL,
	[D11DPT08] [real] NULL,
	[D11DPT12] [real] NULL,
	[D11DPT09] [real] NULL,
	[D11DPT10] [real] NULL,
	[D11DPT11] [real] NULL,
	[D11TT05] [real] NULL,
	[D11TT06] [real] NULL,
	[D11MT03] [real] NULL,
	[D11MT04] [real] NULL,
	[D11F04] [real] NULL,
	[D11PT03] [real] NULL,
	[D11TT07] [real] NULL,
	[D11TT08] [real] NULL,
	[D11F05] [real] NULL,
	[D11PT21] [real] NULL,
	[D11VGC21] [real] NULL,
 CONSTRAINT [PK_DesiccantLog2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesiccantTag1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesiccantTag1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_DesiccantTag1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesiccantTag2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesiccantTag2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_DesiccantTag2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceMaster]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Type] [int] NULL,
	[Description] [varchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_DeviceMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DryerDataLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DryerDataLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[StartTrigger] [bit] NULL,
	[PlantStatus] [int] NULL,
	[AtomiserVibrationMonitoring] [float] NULL,
	[AtomizerRotationalSpeed] [float] NULL,
	[AtomizeroilPressure] [bit] NULL,
	[AtomizeroilCircuilation] [bit] NULL,
	[Atomizerrunninghour] [float] NULL,
	[HomogenizerInletPressure] [float] NULL,
	[HomogenizerFreq] [float] NULL,
	[HomogenizeroutletPressure] [float] NULL,
	[DryerfeedFlow] [float] NULL,
	[DryerFeedTemp] [float] NULL,
	[AirIntakePressuare] [float] NULL,
	[DryingChamberVaccum] [float] NULL,
	[VibroVacacum] [float] NULL,
	[Mainairsupplyflow] [float] NULL,
	[SFBFlow] [float] NULL,
	[VFFlow] [float] NULL,
	[Airdispersertemp] [float] NULL,
	[MozzleCoolingTemp] [float] NULL,
	[Mainairsupplytemp] [float] NULL,
	[SFBAirsupplytemp] [float] NULL,
	[Wallsweepairtemp] [float] NULL,
	[VF1Airsupplytemp] [float] NULL,
	[VF2Chillingtemp] [float] NULL,
	[VF2Heatingtemp] [float] NULL,
	[Sifterinlettemp] [float] NULL,
	[Chamberoutlettemp] [float] NULL,
	[VFOutlettemp] [float] NULL,
	[Dryerexhausttemp] [float] NULL,
	[SFBDPT] [float] NULL,
	[Cyclone1dpt] [float] NULL,
	[RootsBlowerpressure] [float] NULL,
	[RootsBlowerTemp] [float] NULL,
	[Recoverytankqnt] [float] NULL,
 CONSTRAINT [PK_DryerDataLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](300) NULL,
	[Code] [nvarchar](50) NULL,
	[BranchId] [int] NULL,
	[OrganisationId] [int] NULL,
	[RoleId] [int] NULL,
	[DepartmentId] [int] NULL,
	[DesignationId] [int] NULL,
	[ReportingToId] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[ContactNo] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[IsUser] [int] NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[JoinDate] [varchar](50) NULL,
	[BirthDate] [varchar](50) NULL,
	[MarriageDate] [varchar](50) NULL,
	[AllowAccountAccess] [int] NULL,
	[IsResigned] [int] NULL,
	[ResignationDate] [varchar](50) NULL,
	[LastWorkingDate] [varchar](50) NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentMaster]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](100) NULL,
	[Name] [varchar](max) NULL,
	[Remarks] [varchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_EquipmentMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EvaporatorDataLogSheet]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvaporatorDataLogSheet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[StartTrigger] [bit] NULL,
	[PlantStatus] [int] NULL,
	[EvapBalanceTank] [float] NULL,
	[FeedFlow] [float] NULL,
	[FeedConductivity] [float] NULL,
	[FeedPreheatertmp] [float] NULL,
	[PCDTemp] [float] NULL,
	[FV1Heatingtemp] [float] NULL,
	[FV2Heatingtemp] [float] NULL,
	[DSITemp] [float] NULL,
	[FV1regenerationtemp] [float] NULL,
	[FV2regenerationtemp] [float] NULL,
	[Cal1Temp] [float] NULL,
	[Cal2Temp] [float] NULL,
	[Cal3Temp] [float] NULL,
	[Cal4Temp] [float] NULL,
	[CondenserCWInTemp] [float] NULL,
	[CondenserCWOutTemp] [float] NULL,
	[CondenserTemp] [float] NULL,
	[PlantVaccum] [float] NULL,
	[PCDTVRPressure] [float] NULL,
	[CalTVRPressure] [float] NULL,
	[DSIBackPressure] [float] NULL,
	[DSISteamSupplyPressure] [float] NULL,
	[DSIOutletTemp] [float] NULL,
	[CondensateCond] [float] NULL,
	[Ejector1SteamPressure] [float] NULL,
	[Ejector2SteamPressure] [float] NULL,
	[ConcFlow] [float] NULL,
	[FinalConcDensity] [float] NULL,
	[FinalConcFlow] [float] NULL,
	[FinalConcTemp] [float] NULL,
 CONSTRAINT [PK_EvaporatorDataLogSheet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EvaporatorLog2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvaporatorLog2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[E2DIB1P02] [float] NULL,
	[E2FIB1P02-T02] [float] NULL,
	[E2FICB1K02] [float] NULL,
	[E2LTB1K01-T01] [float] NULL,
	[E2SCB1G01-T01] [float] NULL,
	[E2TT-E1P01] [float] NULL,
	[E2TTK1K01-T01] [float] NULL,
	[E2TI-E2P01] [float] NULL,
	[E2J1Q90] [float] NULL,
	[E2J1K01_T01] [float] NULL,
	[E2TI-E3P01] [float] NULL,
	[E2TTS1K01-T01] [float] NULL,
	[E2JICK1K03] [float] NULL,
	[E2STK1G01-T02] [float] NULL,
	[E2TTK1G01-T03] [float] NULL,
	[E2TTK1G01-T04] [float] NULL,
	[E2TTK1G01-T05] [float] NULL,
	[E2TTK1G01-T06] [float] NULL,
	[E2TTK1G01-T08] [float] NULL,
	[E2TTK1G01-T10] [float] NULL,
	[E2TTK1G01-T11] [float] NULL,
	[E2TTK1G01-T12] [float] NULL,
	[E2TTK1G03-T04] [float] NULL,
	[E2E2Q90] [float] NULL,
	[E2K11Q90] [float] NULL,
	[E2C1Q60] [float] NULL,
	[E2TTC1K01-T01] [float] NULL,
	[E2TTD3P02-T01] [float] NULL,
	[E2TTD3P03-T01] [float] NULL,
	[E2TTD4P02-T01] [float] NULL,
	[E2TTD4P03-T01] [float] NULL,
	[E2TTD1K02-T01] [float] NULL,
	[E2PTD1K01-T01] [float] NULL,
	[E2PICD1K01] [float] NULL,
	[E2TTD5P02-T01] [float] NULL,
	[E2PTD5K01-T01] [float] NULL,
	[E2PICD5K01] [float] NULL,
	[E2LTC1K02-T01] [float] NULL,
	[E2C1P03-B01] [float] NULL,
	[E2TTC1P04-T01] [float] NULL,
	[E2C2Q90] [float] NULL,
	[S11LT01] [float] NULL,
	[S11TT01] [float] NULL,
	[S12LT01] [float] NULL,
	[S12TT01] [float] NULL,
	[S13LT01] [float] NULL,
	[S13TT01] [float] NULL,
	[S14LT01] [float] NULL,
	[S14TT01] [float] NULL,
	[70LO020-01] [float] NULL,
	[70LO030-01] [float] NULL,
	[U42PT01] [float] NULL,
	[U2PT03] [float] NULL,
	[U2PT02] [float] NULL,
	[U31PT01] [float] NULL,
	[E2B1P03T01] [float] NULL,
	[E2B1P01T01] [float] NULL,
	[E2C1G03T04] [float] NULL,
	[E2D3K01T01] [float] NULL,
	[E2PICD3K01] [float] NULL,
	[E2B1P02T01] [float] NULL,
	[E2B1P02T02] [float] NULL,
	[E2TTS1P02-T01] [float] NULL,
	[E2TTS1P03-T01] [float] NULL,
	[E2JICK1K03_1] [float] NULL,
	[E2CTL1P01_T01] [float] NULL,
	[E2E1P02_T02] [float] NULL,
	[E2E1P02_T01] [float] NULL,
	[E2K10P01_T01] [float] NULL,
	[E2B1P03_T01] [float] NULL,
	[E2D1P01_T01] [float] NULL,
	[E2E1P01_T01] [float] NULL,
	[E2K1G01_Hz] [float] NULL,
	[E2S1P01_T01] [float] NULL,
	[E2K1G01_T09] [float] NULL,
 CONSTRAINT [PK_EvaporatorLog2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EvaporatorTag]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvaporatorTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[Index] [int] NULL,
 CONSTRAINT [PK_EvaporatorTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EvaporatorTag2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvaporatorTag2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[Index] [int] NULL,
 CONSTRAINT [PK_Evaporator2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FaultRemarks]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaultRemarks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Type] [int] NULL,
	[FaultId] [int] NULL,
	[Remarks] [varchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_FaultRemarks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedLineStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedLineStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PLCValue] [int] NULL,
	[Status] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [nvarchar](50) NULL,
	[Itemdesc] [nvarchar](50) NULL,
	[MakeType] [nvarchar](50) NULL,
	[BatchNumber] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryGhee]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryGhee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Op_RMS1_Qty] [float] NULL,
	[Op_RMS1_AgingTime] [float] NULL,
	[Op_RMS1_Temp] [float] NULL,
	[Op_RMS2_Qty] [float] NULL,
	[Op_RMS2_AgingTime] [float] NULL,
	[Op_RMS2_Temp] [float] NULL,
	[Op_RMS3_Qty] [float] NULL,
	[Op_RMS3_AgingTime] [float] NULL,
	[Op_RMS3_Temp] [float] NULL,
	[Op_RMS4_Qty] [float] NULL,
	[Op_RMS4_AgingTime] [float] NULL,
	[Op_RMS4_Temp] [float] NULL,
	[Op_RMS5_Qty] [float] NULL,
	[Op_RMS5_AgingTime] [float] NULL,
	[Op_RMS5_Temp] [float] NULL,
	[Op_PMS1_Qty] [float] NULL,
	[Op_PMS1_AgingTime] [float] NULL,
	[Op_PMS1_Temp] [float] NULL,
	[Op_PMS2_Qty] [float] NULL,
	[Op_PMS2_AgingTime] [float] NULL,
	[Op_PMS2_Temp] [float] NULL,
	[Op_PMS3_Qty] [float] NULL,
	[Op_PMS3_AgingTime] [float] NULL,
	[Op_PMS3_Temp] [float] NULL,
	[Op_PMS4_Qty] [float] NULL,
	[Op_PMS4_AgingTime] [float] NULL,
	[Op_PMS4_Temp] [float] NULL,
	[Op_PMS5_Qty] [float] NULL,
	[Op_PMS5_AgingTime] [float] NULL,
	[Op_PMS5_Temp] [float] NULL,
	[Op_PMS6_Qty] [float] NULL,
	[Op_PMS6_AgingTime] [float] NULL,
	[Op_PMS6_Temp] [float] NULL,
	[Op_PMS7_Qty] [float] NULL,
	[Op_PMS7_AgingTime] [float] NULL,
	[Op_PMS7_Temp] [float] NULL,
	[Op_PMS8_Qty] [float] NULL,
	[Op_PMS8_AgingTime] [float] NULL,
	[Op_PMS8_Temp] [float] NULL,
	[Op_PMS9_Qty] [float] NULL,
	[Op_PMS9_AgingTime] [float] NULL,
	[Op_PMS9_Temp] [float] NULL,
	[Op_PMS10_Qty] [float] NULL,
	[Op_PMS10_AgingTime] [float] NULL,
	[Op_PMS10_Temp] [float] NULL,
	[Op_PMS11_Qty] [float] NULL,
	[Op_PMS11_AgingTime] [float] NULL,
	[Op_PMS11_Temp] [float] NULL,
	[Op_SMS1_AgingTime] [float] NULL,
	[Op_SMS1_Temp] [float] NULL,
	[Op_SMS2_Qty] [float] NULL,
	[Op_SMS2_AgingTime] [float] NULL,
	[Op_SMS2_Temp] [float] NULL,
	[Op_SMS3_Qty] [float] NULL,
	[Op_SMS3_AgingTime] [float] NULL,
	[Op_SMS3_Temp] [float] NULL,
	[Op_SMS4_Qty] [float] NULL,
	[Op_SMS4_AgingTime] [float] NULL,
	[Op_SMS4_Temp] [float] NULL,
	[Op_SMS5_Qty] [float] NULL,
	[Op_SMS5_AgingTime] [float] NULL,
	[Op_SMS5_Temp] [float] NULL,
	[Op_RC1_Qty] [float] NULL,
	[Op_RC1_AgingTime] [float] NULL,
	[Op_RC1_Temp] [float] NULL,
	[Op_RC2_Qty] [float] NULL,
	[Op_RC2_AgingTime] [float] NULL,
	[Op_RC2_Temp] [float] NULL,
	[Op_PCBM1_Qty] [float] NULL,
	[Op_PCBM1_AgingTime] [float] NULL,
	[Op_PCBM1_Temp] [float] NULL,
	[Op_PCBM2_Qty] [float] NULL,
	[Op_PCBM2_AgingTime] [float] NULL,
	[Op_PCBM2_Temp] [float] NULL,
	[Op_Idmc_Qty] [float] NULL,
	[Op_Idmc_AgingTime] [float] NULL,
	[Op_Idmc_Temp] [float] NULL,
	[Op_PastRec_Qty] [float] NULL,
	[Op_PastRec_AgingTime] [float] NULL,
	[Op_PastRec_Temp] [float] NULL,
	[Op_UnPastRec_Qty] [float] NULL,
	[Op_UnPastRec_AgingTime] [float] NULL,
	[Op_UnPastRec_Temp] [float] NULL,
	[Op_ROTank1_Qty] [float] NULL,
	[Op_ROTank1_AgingTime] [float] NULL,
	[Op_ROTank1_Temp] [float] NULL,
	[Op_ROTank2_Qty] [float] NULL,
	[Op_ROTank2_AgingTime] [float] NULL,
	[Op_ROTank2_Temp] [float] NULL,
	[Op_LipidTank_Qty] [float] NULL,
	[Op_LipidTank_AgingTime] [float] NULL,
	[Op_LipidTank_Temp] [float] NULL,
	[Op_GheeStorage1_Qty] [float] NULL,
	[Op_GheeStorage1_AgingTime] [float] NULL,
	[Op_GheeStorage1_Temp] [float] NULL,
	[Op_GheeStorage2_Qty] [float] NULL,
	[Op_GheeStorage2_AgingTime] [float] NULL,
	[Op_GheeStorage2_Temp] [float] NULL,
	[Op_GheeBoiler1_Qty] [float] NULL,
	[Op_GheeBoiler1_AgingTime] [float] NULL,
	[Op_GheeBoiler1_Temp] [float] NULL,
	[Op_GheeBoiler2_Qty] [float] NULL,
	[Op_GheeBoiler2_AgingTime] [float] NULL,
	[Op_GheeBoiler2_Temp] [float] NULL,
	[Op_GheeBoiler3_Qty] [float] NULL,
	[Op_GheeBoiler3_AgingTime] [float] NULL,
	[Op_GheeBoiler3_Temp] [float] NULL,
	[Op_GheeBoiler4_Qty] [float] NULL,
	[Op_GheeBoiler4_AgingTime] [float] NULL,
	[Op_GheeBoiler4_Temp] [float] NULL,
	[Op_GheeBoiler5_Qty] [float] NULL,
	[Op_GheeBoiler5_AgingTime] [float] NULL,
	[Op_GheeBoiler5_Temp] [float] NULL,
	[Op_GheeProdRecovery_Qty] [float] NULL,
	[Op_GheeProdRecovery_AgingTime] [float] NULL,
	[Op_GheeProdRecovery_Temp] [float] NULL,
	[Op_NewAPSSilo1_Qty] [float] NULL,
	[Op_NewAPSSilo1_AgingTime] [float] NULL,
	[Op_NewAPSSilo1_Temp] [float] NULL,
	[Op_NewAPSSilo2_Qty] [float] NULL,
	[Op_NewAPSSilo2_AgingTime] [float] NULL,
	[Op_NewAPSSilo2_Temp] [float] NULL,
	[Op_CurdMilkSilo1_Qty] [float] NULL,
	[Op_CurdMilkSilo1_AgingTime] [float] NULL,
	[Op_CurdMilkSilo1_Temp] [float] NULL,
	[Op_CurdMilkSilo2_Qty] [float] NULL,
	[Op_CurdMilkSilo2_AgingTime] [float] NULL,
	[Op_CurdMilkSilo2_Temp] [float] NULL,
	[Np_RMS6_Qty] [float] NULL,
	[Np_RMS6_Agt] [float] NULL,
	[Np_RMS6_Temp] [float] NULL,
	[Np_RMS7_Qty] [float] NULL,
	[Np_RMS7_Agt] [float] NULL,
	[Np_RMS7_Temp] [float] NULL,
	[Np_RMS8_Qty] [float] NULL,
	[Np_RMS8_Agt] [float] NULL,
	[Np_RMS8_Temp] [float] NULL,
	[Np_RMS9_Qty] [float] NULL,
	[Np_RMS9_Agt] [float] NULL,
	[Np_RMS9_Temp] [float] NULL,
	[Np_PMS6_Qty] [float] NULL,
	[Np_PMS6_Agt] [float] NULL,
	[Np_PMS6_Temp] [float] NULL,
	[Np_PMS7_Qty] [float] NULL,
	[Np_PMS7_Agt] [float] NULL,
	[Np_PMS7_Temp] [float] NULL,
	[Np_SMS6_Qty] [float] NULL,
	[Np_SMS6_Agt] [float] NULL,
	[Np_SMS6_Temp] [float] NULL,
	[Np_SMS7_Qty] [float] NULL,
	[Np_SMS7_Agt] [float] NULL,
	[Np_SMS7_Temp] [float] NULL,
	[Np_SMS8_Qty] [float] NULL,
	[Np_SMS8_Agt] [float] NULL,
	[Np_SMS8_Temp] [float] NULL,
	[Np_SMS9_Qty] [float] NULL,
	[Np_SMS9_Agt] [float] NULL,
	[Np_SMS9_Temp] [float] NULL,
	[Np_SMS10_Qty] [float] NULL,
	[Np_SMS10_Agt] [float] NULL,
	[Np_SMS10_Temp] [float] NULL,
	[Np_SMS11_Qty] [float] NULL,
	[Np_SMS11_Agt] [float] NULL,
	[Np_SMS11_Temp] [float] NULL,
	[Np_SMS12_Qty] [float] NULL,
	[Np_SMS12_Agt] [float] NULL,
	[Np_SMS12_Temp] [float] NULL,
	[Np_SMS13_Qty] [float] NULL,
	[Np_SMS13_Agt] [float] NULL,
	[Np_SMS13_Temp] [float] NULL,
	[Np_CRBT1_Qty] [float] NULL,
	[Np_CRBT1_Agt] [float] NULL,
	[Np_CRBT1_Temp] [float] NULL,
	[Np_CRBT2_Qty] [float] NULL,
	[Np_CRBT2_Agt] [float] NULL,
	[Np_CRBT2_Temp] [float] NULL,
	[Np_CRST1_Qty] [float] NULL,
	[Np_CRST1_Agt] [float] NULL,
	[Np_CRST1_Temp] [float] NULL,
	[Np_CRST2_Qty] [float] NULL,
	[Np_CRST2_Agt] [float] NULL,
	[Np_CRST2_Temp] [float] NULL,
	[Np_CRST3_Qty] [float] NULL,
	[Np_CRST3_Agt] [float] NULL,
	[Np_CRST3_Temp] [float] NULL,
	[Np_CRST4_Qty] [float] NULL,
	[Np_CRST4_Agt] [float] NULL,
	[Np_CRST4_Temp] [float] NULL,
	[Np_CRST5_Qty] [float] NULL,
	[Np_CRST5_Agt] [float] NULL,
	[Np_CRST5_Temp] [float] NULL,
	[Np_CRST6_Qty] [float] NULL,
	[Np_CRST6_Agt] [float] NULL,
	[Np_CRST6_Temp] [float] NULL,
	[Np_BMST1_Qty] [float] NULL,
	[Np_BMST1_Agt] [float] NULL,
	[Np_BMST1_Temp] [float] NULL,
	[Np_BMST2_Qty] [float] NULL,
	[Np_BMST2_Agt] [float] NULL,
	[Np_BMST2_Temp] [float] NULL,
	[Np_ReconPrep1_Qty] [float] NULL,
	[Np_ReconPrep1_Agt] [float] NULL,
	[Np_ReconPrep1_Temp] [float] NULL,
	[Np_ReconPrep2_Qty] [float] NULL,
	[Np_ReconPrep2_Agt] [float] NULL,
	[Np_ReconPrep2_Temp] [float] NULL,
	[Np_ReconSto1_Qty] [float] NULL,
	[Np_ReconSto1_Agt] [float] NULL,
	[Np_ReconSto1_Temp] [float] NULL,
	[Np_ReconSto2_Qty] [float] NULL,
	[Np_ReconSto2_Agt] [float] NULL,
	[Np_ReconSto2_Temp] [float] NULL,
	[NpGhee_CreamTank1_Qty] [float] NULL,
	[NpGhee_CreamTank1_Agt] [float] NULL,
	[NpGhee_CreamTank1_Temp] [float] NULL,
	[NpGhee_CreamTank2_Qty] [float] NULL,
	[NpGhee_CreamTank2_Agt] [float] NULL,
	[NpGhee_CreamTank2_Temp] [float] NULL,
	[NpGhee_BmTank1_Qty] [float] NULL,
	[NpGhee_BmTank1_Agt] [float] NULL,
	[NpGhee_BmTank1_Temp] [float] NULL,
	[NpGhee_BmTank2_Qty] [float] NULL,
	[NpGhee_BmTank2_Agt] [float] NULL,
	[NpGhee_BmTank2_Temp] [float] NULL,
	[NpGhee_LipidTank_Qty] [float] NULL,
	[NpGhee_LipidTank_Agt] [float] NULL,
	[NpGhee_LipidTank_Temp] [float] NULL,
	[NpGhee_GheeTank1_Qty] [float] NULL,
	[NpGhee_GheeTank1_Agt] [float] NULL,
	[NpGhee_GheeTank1_Temp] [float] NULL,
	[NpGhee_GheeTank2_Qty] [float] NULL,
	[NpGhee_GheeTank2_Agt] [float] NULL,
	[NpGhee_GheeTank2_Temp] [float] NULL,
	[NpAPS_A11_Qty] [float] NULL,
	[NpAPS_A11_Agt] [float] NULL,
	[NpAPS_A11_Temp] [float] NULL,
	[NpAPS_A12_Qty] [float] NULL,
	[NpAPS_A12_Agt] [float] NULL,
	[NpAPS_A12_Temp] [float] NULL,
	[NpAPS_A13_Qty] [float] NULL,
	[NpAPS_A13_Agt] [float] NULL,
	[NpAPS_A13_Temp] [float] NULL,
	[NpAPS_A14_Qty] [float] NULL,
	[NpAPS_A14_Agt] [float] NULL,
	[NpAPS_A14_Temp] [float] NULL,
	[NpAPS_A15_Qty] [float] NULL,
	[NpAPS_A15_Agt] [float] NULL,
	[NpAPS_A15_Temp] [float] NULL,
	[NpAPS_A16_Qty] [float] NULL,
	[NpAPS_A16_Agt] [float] NULL,
	[NpAPS_A16_Temp] [float] NULL,
	[NpAPS_A17_Qty] [float] NULL,
	[NpAPS_A17_Agt] [float] NULL,
	[NpAPS_A17_Temp] [float] NULL,
	[NpAPS_A18_Qty] [float] NULL,
	[NpAPS_A18_Agt] [float] NULL,
	[NpAPS_A18_Temp] [float] NULL,
 CONSTRAINT [PK_InventoryGhee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[S11LT01] [real] NULL,
	[S12LT01] [real] NULL,
	[S13LT01] [real] NULL,
	[S14LT01] [real] NULL,
	[S21LT01] [real] NULL,
	[S22LT01] [real] NULL,
	[E1C1K02_T01] [real] NULL,
	[E2C1K02_T01] [real] NULL,
	[W51LT01] [real] NULL,
	[W52LT01] [real] NULL,
	[C11LT01] [real] NULL,
	[C12LT01] [real] NULL,
	[E1B1K01_T01] [real] NULL,
	[E2B1K01_T01] [real] NULL,
	[F11LT01] [real] NULL,
	[F12LT01] [real] NULL,
	[F13LT01] [real] NULL,
	[F14LT01] [real] NULL,
	[70LO020_01] [real] NULL,
	[70LO030_01] [real] NULL,
	[73LO100_01] [real] NULL,
	[73LO110_01] [real] NULL,
	[73LO120_01] [real] NULL,
	[73LO130_01] [real] NULL,
	[CD11LT01] [real] NULL,
	[CD12LT01] [real] NULL,
	[Evap-1] [real] NULL,
	[Evap-2] [real] NULL,
	[Dryer] [real] NULL,
	[FeedLine] [real] NULL,
 CONSTRAINT [PK_InventoryLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryTag]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_InventoryTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lab]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lab](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [nvarchar](50) NULL,
	[TypeofPowder] [nvarchar](50) NULL,
	[Time] [time](7) NULL,
	[SampleId] [nvarchar](50) NULL,
	[BatchNo] [nvarchar](50) NULL,
	[BagNo] [nvarchar](50) NULL,
	[Weight] [nvarchar](50) NULL,
	[TempOC] [nvarchar](50) NULL,
	[Fat] [nvarchar](50) NULL,
	[SNF] [nvarchar](50) NULL,
	[Acidity] [nvarchar](50) NULL,
	[Moisture] [nvarchar](50) NULL,
	[Sugar] [nvarchar](50) NULL,
	[SolIndex] [nvarchar](50) NULL,
	[Coffetest] [nvarchar](50) NULL,
	[Particleontop] [nvarchar](50) NULL,
	[ParticleonBottom] [nvarchar](50) NULL,
	[Sendiments] [nvarchar](50) NULL,
	[BulkDensity] [nvarchar](50) NULL,
	[Scorchedparticle] [nvarchar](50) NULL,
	[Wettability] [nvarchar](50) NULL,
	[Dispersibility] [nvarchar](50) NULL,
	[FreeFat] [nvarchar](50) NULL,
	[TotalPlatecount] [nvarchar](50) NULL,
	[Coliform] [nvarchar](50) NULL,
	[YestMould] [nvarchar](50) NULL,
	[Ecoli] [nvarchar](50) NULL,
	[Salmonella] [nvarchar](50) NULL,
	[Saureus] [nvarchar](50) NULL,
	[Anerobicsporecount] [nvarchar](50) NULL,
	[Listeriamonocytogen] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
	[Remarks] [nvarchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Lab_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabReport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LabDate] [varchar](10) NULL,
	[VehicleCode] [varchar](50) NULL,
	[VehicleId] [int] NULL,
	[RouteId] [int] NULL,
	[ProductId] [int] NULL,
	[OT] [int] NULL,
	[Temp] [real] NULL,
	[Fat] [real] NULL,
	[SNF] [real] NULL,
	[Acidity] [real] NULL,
	[COB] [varchar](3) NULL,
	[AlcoholNo] [varchar](50) NULL,
	[Neutralizer] [varchar](3) NULL,
	[Urea] [varchar](3) NULL,
	[Salt] [varchar](3) NULL,
	[Startch] [varchar](3) NULL,
	[FPD] [varchar](50) NULL,
	[Status] [int] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Lab] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Thread] [varchar](255) NULL,
	[Level] [varchar](50) NULL,
	[Logger] [varchar](255) NULL,
	[Message] [varchar](4000) NULL,
	[Exception] [varchar](2000) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maintainance]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maintainance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [nvarchar](50) NULL,
	[EquipmentTagNo] [varchar](50) NULL,
	[EquipmentName] [varchar](50) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[PartNo] [varchar](50) NULL,
	[Area] [varchar](50) NULL,
	[ProblemDetails] [varchar](max) NULL,
	[ActionTaken] [varchar](max) NULL,
	[RectifiedBy] [varchar](50) NULL,
	[Remark] [varchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Maintainance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceType]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[DepartMentId] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_MaintenanceType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MassBalance]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MassBalance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[TotalTS] [float] NULL,
	[TotalTSKG] [float] NULL,
	[TotalQuantity] [float] NULL,
	[TSReverted] [float] NULL,
	[TSToDryer] [float] NULL,
	[PowderQuantity] [float] NULL,
	[TS] [float] NULL,
	[RecoveredPowder] [float] NULL,
	[TotalPowder] [float] NULL,
	[TotalTsPowder] [float] NULL,
	[DeltaTSKG] [float] NULL,
	[DeltaTS] [float] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_MassBalance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MassBalanceAmul]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MassBalanceAmul](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[PMST_1_E1_StartTrigger] [bit] NULL,
	[PMST_1_E1_Quantity] [float] NULL,
	[PMST_2_E1_StartTrigger] [bit] NULL,
	[PMST_2_E1_Quantity] [float] NULL,
	[PMST_3_E1_StartTrigger] [bit] NULL,
	[PMST_3_E1_Quantity] [float] NULL,
	[PMST_4_E1_StartTrigger] [bit] NULL,
	[PMST_4_E1_Quantity] [float] NULL,
	[PMST_1_E2_StartTrigger] [bit] NULL,
	[PMST_1_E2_Quantity] [float] NULL,
	[PMST_2_E2_StartTrigger] [bit] NULL,
	[PMST_2_E2_Quantity] [float] NULL,
	[PMST_3_E2_StartTrigger] [bit] NULL,
	[PMST_3_E2_Quantity] [float] NULL,
	[PMST_4_E2_StartTrigger] [bit] NULL,
	[PMST_4_E2_Quantity] [float] NULL,
	[Fat] [varchar](10) NULL,
	[SNF] [varchar](10) NULL,
 CONSTRAINT [PK_MassBalanceAmul] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MassBalancePowderProduction]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MassBalancePowderProduction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AvaPackQty] [float] NULL,
	[Bosch1Qty] [float] NULL,
	[Bosch2Qty] [float] NULL,
	[Bosch3Qty] [float] NULL,
	[Bosch4Qty] [float] NULL,
	[Bosch5Qty] [float] NULL,
	[Bosch6Qty] [float] NULL,
	[Bosch7Qty] [float] NULL,
	[HassiaQty] [float] NULL,
	[IsDeleted] [float] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_MassBalancePowderProduction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MilkAnalysis]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MilkAnalysis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[SiloId] [int] NULL,
	[ProductType] [varchar](50) NULL,
	[SampleId] [varchar](50) NULL,
	[FAT] [float] NULL,
	[SNF] [float] NULL,
	[Sugar] [float] NULL,
	[TS] [float] NULL,
	[Acidity] [varchar](50) NULL,
	[Temp] [float] NULL,
	[OT] [varchar](50) NULL,
	[UserId] [int] NULL,
	[Remark] [varchar](max) NULL,
	[IsDeleted] [int] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_MilkAnalysis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NFWhey_StorageStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NFWhey_StorageStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[W41T01Typesofwhey] [varchar](50) NULL,
	[W41T01TankStatus] [bit] NULL,
	[W41T01Qty] [float] NULL,
	[W41T01Temp] [float] NULL,
	[W41T01AgeingTimer] [bigint] NULL,
	[W41T01DirtyTime] [bigint] NULL,
	[W42T01Typesofwhey1] [varchar](50) NULL,
	[W42T01TankStatus1] [bit] NULL,
	[W42T01Qty1] [float] NULL,
	[W42T01Temp1] [float] NULL,
	[W42T01AgeingTimer1] [bigint] NULL,
	[W42T01DirtyTime1] [bigint] NULL,
	[W43T01Typesofwhey1] [varchar](50) NULL,
	[W43T01TankStatus1] [bit] NULL,
	[W43T01Qty1] [float] NULL,
	[W43T01Temp1] [float] NULL,
	[W43T01AgeingTimer1] [bigint] NULL,
	[W43T01DirtyTime1] [bigint] NULL,
 CONSTRAINT [PK_NFWhey_StorageStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organisation]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisation](
	[Id] [int] NOT NULL,
	[Name] [varchar](max) NULL,
	[Address] [varchar](max) NULL,
	[LogoURL] [varchar](max) NULL,
	[ContactNo] [varchar](50) NULL,
	[EmailId] [varchar](50) NULL,
	[LoginBGImg] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingEntryMaster]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingEntryMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[ShiftId] [int] NULL,
	[TotalQuantity] [float] NULL,
	[TotalTs] [float] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_PackingEntryMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingEntryTransation]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingEntryTransation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlantMasterId] [int] NULL,
	[SKU] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[PackedQuantity] [float] NULL,
	[TS] [float] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_PackingEntryTransation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineBosch]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineBosch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Tag1] [float] NULL,
	[Tag1Speed] [float] NULL,
	[Tag1EmptyBags] [float] NULL,
	[Tag2] [float] NULL,
	[Tag2Speed] [float] NULL,
	[Tag2EmptyBags] [float] NULL,
	[Tag3] [float] NULL,
	[Tag3Speed] [float] NULL,
	[Tag3EmptyBags] [float] NULL,
	[Tag4] [float] NULL,
	[Tag4Speed] [float] NULL,
	[Tag4EmptyBags] [float] NULL,
	[Tag5] [float] NULL,
	[Tag5Speed] [float] NULL,
	[Tag5EmptyBags] [float] NULL,
	[Tag6] [float] NULL,
	[Tag6Speed] [float] NULL,
	[Tag6EmptyBags] [float] NULL,
	[Tag7] [float] NULL,
	[Tag7Speed] [float] NULL,
	[Tag7EmptyBags] [float] NULL,
	[Hassia] [float] NULL,
	[Xpert] [float] NULL,
	[Tag8] [float] NULL,
	[Tag8Speed] [float] NULL,
	[Tag8EmptyBags] [float] NULL,
	[Tag9] [float] NULL,
	[Tag9Speed] [float] NULL,
	[Tag9EmptyBags] [float] NULL,
	[Tag10] [float] NULL,
	[Tag10Speed] [float] NULL,
	[Tag10EmptyBags] [float] NULL,
	[Tag11] [float] NULL,
	[Tag11Speed] [float] NULL,
	[Tag11EmptyBags] [float] NULL,
	[Tag12] [float] NULL,
	[Tag12Speed] [float] NULL,
	[Tag12EmptyBags] [float] NULL,
	[Tag13] [float] NULL,
	[Tag13Speed] [float] NULL,
	[Tag13EmptyBags] [float] NULL,
	[Tag14] [float] NULL,
	[Tag14Speed] [float] NULL,
	[Tag14EmptyBags] [float] NULL,
	[Tag15] [float] NULL,
	[Tag15Speed] [float] NULL,
	[Tag15EmptyBags] [float] NULL,
 CONSTRAINT [PK_PackingMachineBosch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineBoschTag]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineBoschTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[Index] [int] NULL,
 CONSTRAINT [PK_PackingMachineBoschTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Tag1] [float] NULL,
	[Tag2] [float] NULL,
	[Tag3] [float] NULL,
	[Tag4] [float] NULL,
	[Tag5] [float] NULL,
	[Tag6] [float] NULL,
	[Tag7] [float] NULL,
	[Tag8] [float] NULL,
	[Tag9] [float] NULL,
	[Tag10] [float] NULL,
	[Tag11] [float] NULL,
	[Tag12] [float] NULL,
 CONSTRAINT [PK_PackingMachineLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineMassBalanceAvapack]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineMassBalanceAvapack](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Tag1] [float] NULL,
 CONSTRAINT [PK_PackingMachineMassBalanceAvapack] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineMassBalanceBosch]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineMassBalanceBosch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Tag1] [float] NULL,
	[Tag2] [float] NULL,
	[Tag3] [float] NULL,
	[Tag4] [float] NULL,
	[Tag5] [float] NULL,
	[Tag6] [float] NULL,
	[Tag7] [float] NULL,
 CONSTRAINT [PK_PackingMachineMassBalanceBosch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineMassBalanceHassia]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineMassBalanceHassia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Tag1] [float] NULL,
 CONSTRAINT [PK_PackingMachineMassBalanceHassia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingMachineTag]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingMachineTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagNo] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PackingMachineTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingSKUMaster]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingSKUMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SkuName] [varchar](50) NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_PackingSKUMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PastWhey_StorageStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PastWhey_StorageStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[W21T01TypesofMilk] [int] NULL,
	[W21T01TankStatus] [bit] NULL,
	[W21T01Qty] [float] NULL,
	[W21T01Temp] [float] NULL,
	[W21T01AgeingTimer] [bigint] NULL,
	[W21T01DirtyTime] [bigint] NULL,
	[W22T01TypesofMilk1] [int] NULL,
	[W22T01TankStatus1] [bit] NULL,
	[W22T01Qty1] [float] NULL,
	[W22T01Temp1] [float] NULL,
	[W22T01AgeingTimer1] [bigint] NULL,
	[W22T01DirtyTime1] [bigint] NULL,
 CONSTRAINT [PK_PastWhey_StorageStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCIPLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCIPLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[StartTriggerT1] [bit] NULL,
	[StartTriggerT2] [bit] NULL,
	[StartTriggerT3] [bit] NULL,
	[SterilizationTrigger1] [bit] NULL,
	[FinalTrigger1] [bit] NULL,
	[AcidTrigger1] [bit] NULL,
	[IntermediateTrigger1] [bit] NULL,
	[LyeTrigger1] [bit] NULL,
	[PreRinseTrigger1] [bit] NULL,
	[RinsewithRecWaterTrigger1] [bit] NULL,
	[SterilizationTrigger2] [bit] NULL,
	[FinalTrigger2] [bit] NULL,
	[AcidTrigger2] [bit] NULL,
	[IntermediateTrigger2] [bit] NULL,
	[LyeTrigger2] [bit] NULL,
	[PreRinseTrigger2] [bit] NULL,
	[LineNumber1] [int] NULL,
	[LineNumber2] [int] NULL,
	[RinsewithRecWaterTrigger2] [int] NULL,
	[SterilizationTrigger3] [bit] NULL,
	[FinalTrigger3] [bit] NULL,
	[AcidTrigger3] [bit] NULL,
	[IntermediateTrigger3] [bit] NULL,
	[LyeTrigger3] [bit] NULL,
	[PreRinseTrigger3] [bit] NULL,
	[LineNumber3] [bit] NULL,
	[RinsewithRecWaterTrigger3] [int] NULL,
	[RouteNo] [int] NULL,
	[RecipeNo] [int] NULL,
	[Flow] [float] NULL,
	[PreRinseStepTime] [float] NULL,
	[PreRinseEffectiveCircuilationTime] [float] NULL,
	[PreConductivity] [float] NULL,
	[LYEStepTime] [float] NULL,
	[LyeFlow] [float] NULL,
	[LYEReturnTemp] [float] NULL,
	[LYEReturnCond] [float] NULL,
	[LyeEffectiveCircuilationTime] [int] NULL,
	[ACIDStepTime] [float] NULL,
	[ACIDFlow] [float] NULL,
	[ACIDReturnTemp] [float] NULL,
	[ACIDReturnCond] [float] NULL,
	[AcidEffectiveCircuilationTime] [int] NULL,
	[INTERMEDIATEStepTime] [float] NULL,
	[INTERMEDIATEFlow] [float] NULL,
	[INTERMEDIATEReturnTemp] [float] NULL,
	[INTERMEDIATEReturnCond] [float] NULL,
	[INTERMEDIATEEffectiveCircuilationTime] [int] NULL,
	[FINALStepTime] [float] NULL,
	[FINALFlow] [float] NULL,
	[FINALReturnTemp] [float] NULL,
	[FINALReturnCond] [float] NULL,
	[FinalEffectiveCircuilationTime] [int] NULL,
	[STERILIZATIONStepTime] [float] NULL,
	[STERILIZATIONFlow] [float] NULL,
	[STERILIZATIONReturnTemp] [float] NULL,
	[STERILIZATIONReturncond] [float] NULL,
	[STERILIZATIONEffectiveCircuilationTime] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_PCIPLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[StartTriggerT1] [bit] NULL,
	[StartTriggerT2] [bit] NULL,
	[PlantId] [int] NULL,
	[Quantity] [decimal](18, 2) NULL,
	[PlantStatus] [int] NULL,
	[Remarks] [varchar](max) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PlantStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantStatusDryer]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantStatusDryer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[PlantStatusId] [int] NULL,
	[Quantity] [decimal](18, 2) NULL,
	[Remark] [varchar](200) NULL,
 CONSTRAINT [PK_PlantStatusDryer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantStatusEvap1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantStatusEvap1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[PlantStatusId] [real] NULL,
	[Quantity] [real] NULL,
	[Remark] [varchar](200) NULL,
 CONSTRAINT [PK_PlantStatusEvap1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantStatusEvap2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantStatusEvap2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[PlantStatusId] [real] NULL,
	[Quantity] [real] NULL,
	[Remark] [varchar](200) NULL,
 CONSTRAINT [PK_PlantStatusEvap2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantStatusEvaporator]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantStatusEvaporator](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[PLCValue] [real] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PowderSiloOpeningClosing]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PowderSiloOpeningClosing](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Quantity1] [float] NULL,
	[Quantity2] [float] NULL,
	[Quantity3] [float] NULL,
	[Quantity4] [float] NULL,
 CONSTRAINT [PK_PowderSiloOpeningClosing] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PowderTraceability]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PowderTraceability](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProcessDateTime] [datetime] NULL,
	[StartTrigger] [bit] NULL,
	[SiloId] [int] NULL,
	[QuantityT1] [float] NULL,
	[QuantityT2] [float] NULL,
	[QuantityT3] [float] NULL,
	[QuantityT4] [float] NULL,
 CONSTRAINT [PK_PodwerTraceability] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RO_1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RO_1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[F03_FT01] [float] NULL,
	[F03_SC] [float] NULL,
	[PRESSURE] [float] NULL,
	[PH] [float] NULL,
	[L1_FLOW] [float] NULL,
	[L2_FLOW] [float] NULL,
	[L2_TEMP] [float] NULL,
	[RETENTATE_FLOW] [float] NULL,
	[PERMEATE_CONDUCTIVITY] [float] NULL,
 CONSTRAINT [PK_RO_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RO_2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RO_2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[F03_FT01] [float] NULL,
	[F03_SC] [float] NULL,
	[PRESSURE] [float] NULL,
	[PH] [float] NULL,
	[L1_FLOW] [float] NULL,
	[L2_FLOW] [float] NULL,
	[L2_TEMP] [float] NULL,
	[RETENTATE_FLOW] [float] NULL,
	[PERMEATE_CONDUCTIVITY] [float] NULL,
 CONSTRAINT [PK_RO_2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RO_3]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RO_3](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[F03_FT01] [float] NULL,
	[F03_SC] [float] NULL,
	[PRESSURE] [float] NULL,
	[PH] [float] NULL,
	[L1_FLOW] [float] NULL,
	[L2_FLOW] [float] NULL,
	[L2_TEMP] [float] NULL,
	[RETENTATE_FLOW] [float] NULL,
	[PERMEATE_CONDUCTIVITY] [float] NULL,
 CONSTRAINT [PK_RO_3] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RO_CIP_New]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RO_CIP_New](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[Ro1StepNo] [int] NULL,
	[Ro2StepNo] [int] NULL,
	[Ro3StepNo] [int] NULL,
	[F03-FT01_Flow] [float] NULL,
	[F03-PT01_Pressure] [float] NULL,
	[PH] [float] NULL,
	[Loop1_Flow] [float] NULL,
	[Loop2_Flow] [float] NULL,
	[Loop2_Temp] [float] NULL,
	[Retentate] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RO_Permeate_Status]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RO_Permeate_Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[TypesofMilk] [int] NULL,
	[TankStatus] [bit] NULL,
	[Qty] [float] NULL,
	[Temp] [float] NULL,
	[QtyofwatertoCIPKichen] [float] NULL,
	[AgeingTimer] [bigint] NULL,
	[DirtyTime] [bigint] NULL,
 CONSTRAINT [PK_RO_Permeate_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RO_Production]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RO_Production](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[R1_Feed_TOT] [float] NULL,
	[R1_Permeate_TOT] [float] NULL,
	[R1_Retentate_TOT] [float] NULL,
	[R1_ON_Product] [bit] NULL,
	[R2_Feed_TOT] [float] NULL,
	[R2_Permeate_TOT] [float] NULL,
	[R2_Retentate_TOT] [float] NULL,
	[R2_ON_Product] [bit] NULL,
	[R3_Feed_TOT] [float] NULL,
	[R3_Permeate_TOT] [float] NULL,
	[R3_Retentate_TOT] [float] NULL,
	[R3_ON_Product] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROCIP]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROCIP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[StepNoCIP1] [int] NULL,
	[StepNoCIP2] [int] NULL,
	[StepNoCIP3] [int] NULL,
	[Trigger] [bit] NULL,
	[F03-SC-01/02] [float] NULL,
	[F03_PT01] [float] NULL,
	[F03_FT01] [float] NULL,
	[L01_FT01] [float] NULL,
	[L02_FT01] [float] NULL,
	[R01-MT03] [float] NULL,
	[L02-TT01] [float] NULL,
	[Ph] [float] NULL,
 CONSTRAINT [PK_ROCIP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[OrganisationId] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleRights]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleRights](
	[RoleRightsId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[ScreenId] [int] NULL,
 CONSTRAINT [PK_RoleRights] PRIMARY KEY CLUSTERED 
(
	[RoleRightsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RWST_Storage]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RWST_Storage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Datetime] [datetime] NULL,
	[W11T01Typesofwhey] [int] NULL,
	[W11T01TankStatus] [bit] NULL,
	[W11T01Qty] [float] NULL,
	[W11T01Temp] [float] NULL,
	[W11T01AgeingTimer] [bigint] NULL,
	[W11T01DirtyTime] [bigint] NULL,
	[W12T01Typesofwhey1] [int] NULL,
	[W12T01TankStatus1] [bit] NULL,
	[W12T01Qty1] [float] NULL,
	[W12T01Temp1] [float] NULL,
	[W12T01AgeingTimer1] [bigint] NULL,
	[W12T01DirtyTime1] [bigint] NULL,
 CONSTRAINT [PK_RWST_Storage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Screen]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Screen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScreenName] [varchar](max) NULL,
	[DisplayName] [varchar](max) NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Screen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[ShiftId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[FromTime] [time](7) NULL,
	[ToTime] [time](7) NULL,
	[IsDeleted] [int] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
	[CreatedDate] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED 
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SILO]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SILO](
	[SILOID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[PLCValue] [real] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_SILO] PRIMARY KEY CLUSTERED 
(
	[SILOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SourceDestination]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceDestination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SiloName] [varchar](200) NULL,
	[PLCValue] [int] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_SourceDestination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SprayDryer]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SprayDryer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[D29DPT11] [float] NULL,
	[D29DPT12] [float] NULL,
	[D29TT14] [float] NULL,
	[D22PT11] [float] NULL,
	[D29EXF01_CURRENT] [float] NULL,
	[D29EXF01_HZ] [float] NULL,
	[D22TT11] [float] NULL,
	[D22TT12] [float] NULL,
	[D22DPT21] [float] NULL,
	[D22TT22] [float] NULL,
	[F11LT01] [float] NULL,
	[F12LT01] [float] NULL,
	[F13LT01] [float] NULL,
	[F19P21] [float] NULL,
	[F19P22] [float] NULL,
	[D11PT01] [float] NULL,
	[D10F01_CURRENT] [float] NULL,
	[D10F01_HZ] [float] NULL,
	[D11PT04] [float] NULL,
	[D3VGC12] [float] NULL,
	[D3F11] [float] NULL,
	[D3TT12] [float] NULL,
	[D20FT91] [float] NULL,
	[D20TT92] [float] NULL,
	[D20F91_CURRENT] [float] NULL,
	[D20F91_HZ] [float] NULL,
	[D20VGC92] [float] NULL,
	[D20FT21] [float] NULL,
	[D20TT21] [float] NULL,
	[D20F21_CURRENT] [float] NULL,
	[D20F21_HZ] [float] NULL,
	[D20TIC21_MV] [float] NULL,
	[D20FT31] [float] NULL,
	[D20TT32] [float] NULL,
	[D20F31_CURRENT] [float] NULL,
	[D20F31_HZ] [float] NULL,
	[D20VGC32] [float] NULL,
	[D20TT42] [float] NULL,
	[D20F41_CURRENT] [float] NULL,
	[D20F41_HZ] [float] NULL,
	[D20VGC42] [float] NULL,
	[D20TT52] [float] NULL,
	[D20F51_CURRENT] [float] NULL,
	[D20F51_HZ] [float] NULL,
	[D20VGC52] [float] NULL,
	[D20TT62] [float] NULL,
	[D20F61_CURRENT] [float] NULL,
	[D20F61_HZ] [float] NULL,
	[D20VGC62] [float] NULL,
	[D22TT41] [float] NULL,
	[D22TT31] [float] NULL,
	[D22PT31] [float] NULL,
	[D22MO41] [float] NULL,
	[D21TT81] [float] NULL,
	[D21PT81] [float] NULL,
	[D21TT82] [float] NULL,
	[D21PT82] [float] NULL,
	[D21TT83] [float] NULL,
	[D21PT83] [float] NULL,
	[D21DPT01] [float] NULL,
	[D21DPT02] [float] NULL,
	[D23DPT01] [float] NULL,
	[D23DPT02] [float] NULL,
	[F19TT02] [float] NULL,
	[F19TT03] [float] NULL,
	[D19VGC03] [float] NULL,
	[F19TT05] [float] NULL,
	[F19TT06] [float] NULL,
	[D19VGC05] [float] NULL,
	[F19PT02] [float] NULL,
	[F19PT03] [float] NULL,
	[F19PT04] [float] NULL,
	[F19FT02] [float] NULL,
	[F19P01_HZ] [float] NULL,
	[F19PT06] [float] NULL,
	[F19PT07] [float] NULL,
	[F19PT08] [float] NULL,
	[F19FT03] [float] NULL,
	[F19P04_HZ] [float] NULL,
	[D10TT01] [float] NULL,
	[D10TT02] [float] NULL,
	[D10TT03] [float] NULL,
	[D10TT04] [float] NULL,
	[D10TT05] [float] NULL,
	[D20TT25] [float] NULL,
	[D20TT26] [float] NULL,
	[D20TT22] [float] NULL,
	[D20TT23] [float] NULL,
	[D20TT24] [float] NULL,
	[D29TT15] [float] NULL,
	[D29TT16] [float] NULL,
	[D29TT12] [float] NULL,
	[D29TT13] [float] NULL,
	[D29TT17] [float] NULL,
	[D20VT21] [float] NULL,
	[D20VT22] [float] NULL,
	[D20VT23] [float] NULL,
	[D20VT24] [float] NULL,
	[D20VT25] [float] NULL,
	[D20VT26] [float] NULL,
	[D20VT27] [float] NULL,
	[D20VT28] [float] NULL,
	[D29VT11] [float] NULL,
	[D29VT12] [float] NULL,
	[D29VT13] [float] NULL,
	[D29VT14] [float] NULL,
	[D29VT15] [float] NULL,
	[D29VT16] [float] NULL,
	[D29VT17] [float] NULL,
	[D29VT18] [float] NULL,
	[D10MT01] [float] NULL,
	[D11MT02] [float] NULL,
	[D29HT11] [float] NULL,
	[73LO100_01] [float] NULL,
	[73LO110_01] [float] NULL,
	[73LO120_01] [float] NULL,
	[73LO130_01] [float] NULL,
	[U41PT01] [float] NULL,
	[U11PT01] [float] NULL,
	[U11TT01] [float] NULL,
	[U11TT02] [float] NULL,
	[U2PT01] [float] NULL,
	[N2PT01] [float] NULL,
	[Oxygen Content] [float] NULL,
	[D20FT91-1] [float] NULL,
	[D22TT21] [float] NULL,
	[D20FT61] [float] NULL,
	[F19PT09] [float] NULL,
	[F19PT10] [float] NULL,
	[D20F71_H3] [float] NULL,
	[D20F71_Current] [float] NULL,
	[D20TT71] [float] NULL,
	[D20TT72] [float] NULL,
	[D20VGC71] [float] NULL,
	[D20VGC72] [float] NULL,
	[D29FT11] [float] NULL,
	[D29PT01] [float] NULL,
	[FDLN_1Filter] [float] NULL,
	[FDLN_2Filter] [float] NULL,
	[D20FT41] [float] NULL,
	[D20FT51] [float] NULL,
	[CO_Value] [float] NULL,
	[D3PT01] [float] NULL,
	[F19FT02_Density] [float] NULL,
	[F19FT03_Density] [float] NULL,
	[D11MT04] [float] NULL,
 CONSTRAINT [PK_SprayDryer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SugarSyrup]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SugarSyrup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[FillingTriggerT1] [bit] NULL,
	[DosingTriggerT1] [bit] NULL,
	[CirculationTriggerT1] [bit] NULL,
	[SugarSilo] [int] NULL,
	[QtyWaterTakenT1] [decimal](18, 2) NULL,
	[SugarQtyTakenT1] [decimal](18, 2) NULL,
	[SugarQtyTakenT2] [decimal](18, 2) NULL,
	[BatchTempT1] [decimal](18, 2) NULL,
	[FillingTriggerT2] [bit] NULL,
	[DosingTriggerT2] [bit] NULL,
	[CirculationTriggerT2] [bit] NULL,
 CONSTRAINT [PK_SugarSyrup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierId] [int] IDENTITY(1,1) NOT NULL,
	[SupplierCode] [int] NULL,
	[SupplierName] [varchar](100) NULL,
	[Location] [varchar](50) NULL,
	[Address] [varchar](500) NULL,
	[City] [varchar](50) NULL,
	[District] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[CSTNo] [varchar](50) NULL,
	[SSTNo] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[SSTDate] [varchar](50) NULL,
	[AcNo] [varchar](50) NULL,
	[ContactPerson1] [varchar](100) NULL,
	[ContactPerson2] [varchar](100) NULL,
	[Remarks] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TankerDispatch]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TankerDispatch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[StartTrigger1] [bit] NULL,
	[TankerNo] [varchar](50) NULL,
	[TankerId] [varchar](50) NULL,
	[source] [nvarchar](50) NULL,
	[Product] [nvarchar](50) NULL,
	[DispatchChillingtemp] [float] NULL,
	[WeighbridgeQty] [float] NULL,
	[QtyReceived] [float] NULL,
 CONSTRAINT [PK_TankerDispatch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempTable]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transfer]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transfer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[StartTriggerT1] [bit] NULL,
	[QuantityT1] [float] NULL,
	[SourceT1] [int] NULL,
	[DestinationT1] [int] NULL,
	[Status] [int] NULL,
	[FAT] [float] NULL,
	[SNF] [float] NULL,
	[StartTriggerT2] [bit] NULL,
	[QuantityT2] [float] NULL,
	[SourceT2] [int] NULL,
	[DestinationT2] [int] NULL,
	[Status2] [int] NULL,
	[Fat2] [float] NULL,
	[SNF2] [float] NULL,
	[StartTriggerT3] [bit] NULL,
	[QuantityT3] [float] NULL,
	[SourceT3] [int] NULL,
	[DestinationT3] [int] NULL,
	[Status3] [int] NULL,
	[Fat3] [float] NULL,
	[SNF3] [float] NULL,
	[StartTriggerT4] [bit] NULL,
	[QuantityT4] [float] NULL,
	[SourceT4] [int] NULL,
	[DestinationT4] [int] NULL,
	[Status4] [int] NULL,
	[Fat4] [float] NULL,
	[SNF4] [float] NULL,
	[StartTriggerT5] [bit] NULL,
	[QuantityT5] [float] NULL,
	[SourceT5] [int] NULL,
	[DestinationT5] [int] NULL,
	[Status5] [int] NULL,
	[Fat5] [float] NULL,
	[SNF5] [float] NULL,
	[StartTriggerT6] [bit] NULL,
	[QuantityT6] [float] NULL,
	[SourceT6] [int] NULL,
	[DestinationT6] [int] NULL,
	[Status6] [int] NULL,
	[Fat6] [float] NULL,
	[SNF6] [float] NULL,
	[StartTriggerT7] [bit] NULL,
	[QuantityT7] [float] NULL,
	[SourceT7] [int] NULL,
	[DestinationT7] [int] NULL,
	[Status7] [int] NULL,
	[Fat7] [float] NULL,
	[SNF7] [float] NULL,
	[StartTriggerT8] [bit] NULL,
	[QuantityT8] [float] NULL,
	[SourceT8] [int] NULL,
	[DestinationT8] [int] NULL,
	[Status8] [int] NULL,
	[Fat8] [float] NULL,
	[snf8] [float] NULL,
	[StartTriggerT9] [bit] NULL,
	[QuantityT9] [float] NULL,
	[SourceT9] [int] NULL,
	[DestinationT9] [int] NULL,
	[Status9] [int] NULL,
	[Fat9] [float] NULL,
	[snf9] [float] NULL,
	[StartTriggerT20] [bit] NULL,
	[QuantityT20] [float] NULL,
	[SourceT20] [int] NULL,
	[DestinationT20] [int] NULL,
	[Status20] [int] NULL,
	[Fat20] [float] NULL,
	[snf20] [float] NULL,
	[StartTriggerT11] [bit] NULL,
	[QuantityT11] [float] NULL,
	[SourceT11] [int] NULL,
	[DestinationT11] [int] NULL,
	[StartTriggerT12] [bit] NULL,
	[QuantityT12] [float] NULL,
	[SourceT12] [int] NULL,
	[DestinationT12] [int] NULL,
	[StartTriggerT13] [bit] NULL,
	[QuantityT13] [float] NULL,
	[SourceT13] [int] NULL,
	[DestinationT13] [int] NULL,
	[StartTriggerT14] [bit] NULL,
	[QuantityT14] [float] NULL,
	[SourceT14] [int] NULL,
	[DestinationT14] [int] NULL,
	[StartTriggerT15] [bit] NULL,
	[QuantityT15] [float] NULL,
	[SourceT15] [int] NULL,
	[DestinationT15] [int] NULL,
	[StartTriggerT16] [bit] NULL,
	[QuantityT16] [float] NULL,
	[SourceT16] [int] NULL,
	[DestinationT16] [int] NULL,
	[StartTriggerT17] [bit] NULL,
	[QuantityT17] [float] NULL,
	[SourceT17] [int] NULL,
	[DestinationT17] [int] NULL,
	[StartTriggerT18] [bit] NULL,
	[QuantityT18] [float] NULL,
	[SourceT18] [int] NULL,
	[DestinationT18] [int] NULL,
 CONSTRAINT [PK_Transfer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UtilityConsumption]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UtilityConsumption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [int] NULL,
	[Date] [datetime] NULL,
	[MCC1WheyProcesses] [float] NULL,
	[MCC2Evaporator] [float] NULL,
	[MCC3Dryer] [float] NULL,
	[MCC4SCM] [float] NULL,
	[SteamConsumptioninWheyPlant] [float] NULL,
	[SteamConsumptioninEvaporator] [float] NULL,
	[HPSteamConsumptioninDryer] [float] NULL,
	[SteamConsumptionindryerothers] [float] NULL,
	[ChilledWaterinWheyProcessing] [float] NULL,
	[ChilledWaterinpowderplant] [float] NULL,
	[Chilledwaterinlettemp] [float] NULL,
	[ChilledwaterOutlettemp] [float] NULL,
	[SoftWater] [float] NULL,
	[ROWater] [float] NULL,
	[CompressedAir] [float] NULL,
	[RawWater] [float] NULL,
	[Remarks] [nvarchar](50) NULL,
 CONSTRAINT [PK_UtilityConsumption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UtilityConsumptionCost]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UtilityConsumptionCost](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChilledWaterCost] [float] NULL,
	[RawWaterCost] [float] NULL,
	[SoftWaterCost] [float] NULL,
	[SteamCost] [float] NULL,
	[AirCost] [float] NULL,
	[PowerCost] [float] NULL,
	[AcidCost] [float] NULL,
	[LyeCost] [float] NULL,
 CONSTRAINT [PK_UtilityConsumptionCost] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UtilityGeneration]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UtilityGeneration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Raw] [decimal](18, 2) NULL,
	[SOFT] [decimal](18, 2) NULL,
	[ChilledPressure] [decimal](18, 2) NULL,
	[Flow] [decimal](18, 2) NULL,
	[SupplyTemprature] [decimal](18, 2) NULL,
	[ReturnTemprature] [decimal](18, 2) NULL,
	[MainHPSteamHeaderPressure] [decimal](18, 2) NULL,
	[EvaporatorSteamPressure] [decimal](18, 2) NULL,
	[LPSteam] [decimal](18, 2) NULL,
	[AirPressure] [decimal](18, 2) NULL,
	[NitrogenPressure] [decimal](18, 2) NULL,
	[OxygenContent] [decimal](18, 2) NULL,
	[RawWaterGeneration] [decimal](18, 2) NULL,
	[NitrogenGeneration] [decimal](18, 2) NULL,
	[BoilerGeneration] [decimal](18, 2) NULL,
	[EvaporatorGeneration] [decimal](18, 2) NULL,
 CONSTRAINT [PK_UtilityGeneration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeighBridge]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeighBridge](
	[WeighBridgeId] [int] IDENTITY(1,1) NOT NULL,
	[TerminalId] [int] NULL,
	[VehicleId] [int] NULL,
	[ContractorId] [int] NULL,
	[ChallanNo] [varchar](50) NULL,
	[Destination] [varchar](50) NULL,
	[Purpose] [varchar](50) NULL,
	[SupplierId] [int] NULL,
	[ProductGroupId] [int] NULL,
	[ProductId] [int] NULL,
	[RouteId] [int] NULL,
	[WeighMode] [varchar](20) NULL,
	[TareWeight] [varchar](50) NULL,
	[GrossWeight] [varchar](50) NULL,
	[NetWeight] [varchar](50) NULL,
	[TWTDate] [varchar](50) NULL,
	[GWTDate] [varchar](50) NULL,
	[TWTTime] [varchar](50) NULL,
	[GWTTime] [varchar](50) NULL,
	[CIPStatus] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [varchar](50) NULL,
	[IsDeleted] [int] NULL,
	[WeighType] [int] NULL,
	[Type] [int] NULL,
 CONSTRAINT [PK_WeighBridge] PRIMARY KEY CLUSTERED 
(
	[WeighBridgeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WheyAnalysis]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WheyAnalysis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [nvarchar](50) NULL,
	[SampleName] [nvarchar](50) NULL,
	[SampleNo] [nvarchar](50) NULL,
	[ProductName] [nvarchar](50) NULL,
	[OT] [nvarchar](50) NULL,
	[Temp] [nvarchar](50) NULL,
	[Fat] [decimal](18, 2) NULL,
	[SNF] [decimal](18, 2) NULL,
	[Acidity] [decimal](18, 2) NULL,
	[COB] [nvarchar](50) NULL,
	[AlcholTest65] [nvarchar](50) NULL,
	[AlcholTest] [nvarchar](50) NULL,
	[Blactumantibiotictest] [nvarchar](50) NULL,
	[MineralOilTest] [nvarchar](50) NULL,
	[AnyOtherTest01] [nvarchar](50) NULL,
	[AnyOtherTest02] [nvarchar](50) NULL,
	[AnyOtherTest03] [nvarchar](50) NULL,
	[AnyOtherTest04] [nvarchar](50) NULL,
	[Neutrilize] [nvarchar](50) NULL,
	[Urea] [nvarchar](50) NULL,
	[Salt] [nvarchar](50) NULL,
	[Startch] [nvarchar](50) NULL,
	[FPD] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_WheyAnalysis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WPLLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WPLLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[StartTrigger] [bit] NULL,
	[PasteurizerStatus] [int] NULL,
	[Source] [int] NULL,
	[Destination] [int] NULL,
	[CreamDestination] [int] NULL,
	[Flow] [float] NULL,
	[CreamFlow] [float] NULL,
	[BatchTotalizer] [float] NULL,
	[TransferedQty] [float] NULL,
	[CreamGenerationQty] [float] NULL,
	[HeatingFDVStatus] [bit] NULL,
	[ChillingFDVStatus] [bit] NULL,
	[Heating] [float] NULL,
	[Cooling] [float] NULL,
	[HotWaterPHEInlet] [float] NULL,
	[RegenerationEfficiency] [float] NULL,
	[SeparatorInletTemp] [float] NULL,
	[SeparatorInlineBypassed] [bit] NULL,
	[BRCInletTemp] [float] NULL,
	[BRCInlineBypassed] [bit] NULL,
 CONSTRAINT [PK_WPLLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CIPRoutes] ADD  CONSTRAINT [DF_Routes_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Inventory_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Maintainance]
	--WHERE
	--

	Update 
		Inventory
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id and 
		IsDeleted = 0




GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Inventory_Insert]
(
	@Id int,
	@Date nvarchar(50) = NULL,
	@Itemdesc nvarchar(50) = NULL,
	@MakeType nvarchar(50) = NULL,
	@BatchNumber nvarchar(50) = NULL,
	@Quantity float = NULL,
	@Remarks nvarchar(max) = NULL,
	@CreatedBy int = NULL,
	@IsDeleted bit,
	@CreatedDate datetime = NULL

)
AS
	--SET NOCOUNT ON

	INSERT INTO [Inventory]
	(
		[Date],	
      Itemdesc,	
      MakeType,	
      BatchNumber,	
      Quantity,	    
      Remarks,	        	
		[CreatedBy],
		[CreatedDate],
		[IsDeleted]



	)
	VALUES
	(	
		@Date,
		@Itemdesc,
		@MakeType,
		@BatchNumber,
		@Quantity,
		@Remarks,	
		@CreatedBy,
		@CreatedDate,
		@IsDeleted

		
	)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Inventory_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
	*
		FROM   
			Inventory M 
			where
	Id = @Id
	
	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Inventory_SelectAll]

AS
	--SET NOCOUNT ON
	
	select * from Inventory
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_SelectAll_Details]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Inventory_SelectAll_Details]
@FromDate nvarchar(50),
@ToDate nvarchar(50)
AS
	--SET NOCOUNT ON
	
	select  
	ROW_NUMBER() over (order by [Date]) as 'SrNo',
	 convert(varchar(20),[Date],103)Date,
	--convert(varchar(8),[Date],108) Time,
	Itemdesc,
	MakeType,
	BatchNumber,
	Quantity,
	Remarks
	 from Inventory
	WHERE
	  IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Inventory_Update]
(
	@Id int,
	@Date nvarchar(50) = NULL,
	@Itemdesc nvarchar(50) = NULL,
	@MakeType nvarchar(50) = NULL,
	@BatchNumber nvarchar(50) = NULL,
	@Quantity float = NULL,
	@Remarks nvarchar(max) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL

)
AS
	--SET NOCOUNT ON
	
	UPDATE [Inventory]
	SET


	
		[Date] = @Date,
		Itemdesc = @Itemdesc,
		MakeType = @MakeType,
		BatchNumber = @BatchNumber,
		Quantity = @Quantity,
		Remarks = @Remarks,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
		
	WHERE 
		Id = @Id

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Lab_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Lab_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Maintainance]
	--WHERE
	--

	Update 
		[Lab]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id and 
		IsDeleted = 0




GO
/****** Object:  StoredProcedure [dbo].[usp_Lab_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Lab_Insert]
(
	@Id int = NULL OUTPUT,
	@Date nvarchar(50) = NULL,
	@TypeofPowder varchar(50) = NULL,
	@Time time(7) = NULL,
	@SampleId nvarchar(50) = NULL,
	@BatchNo nvarchar(50) = NULL,
	@BagNo nvarchar(50) = NULL,
	@Weight nvarchar(50) = NULL,
	@TempOC nvarchar(50) = NULL,
	@Fat nvarchar(50) = NULL,
	@SNF nvarchar(50) = NULL,
	@Acidity nvarchar(50) = NULL,
	@Moisture nvarchar(50) = NULL,
	@Sugar nvarchar(50) = NULL,
	@SolIndex nvarchar(50) = NULL,
	@Coffetest nvarchar(50) = NULL,
	@Particleontop nvarchar(50) = NULL,
	@ParticleonBottom nvarchar(50) = NULL,
	@Sendiments nvarchar(50) = NULL,
	@BulkDensity nvarchar(50) = NULL,
	@Scorchedparticle nvarchar(50) = NULL,
	@Wettability nvarchar(50) = NULL,
	@Dispersibility nvarchar(50) = NULL,
	@FreeFat nvarchar(50) = NULL,
	@TotalPlatecount nvarchar(50) = NULL,
	@Coliform nvarchar(50) = NULL,
	@YestMould nvarchar(50) = NULL,
	@Ecoli nvarchar(50) = NULL,
	@Salmonella nvarchar(50) = NULL,
	@Saureus nvarchar(50) = NULL,
	@Anerobicsporecount nvarchar(50) = NULL,
	@Listeriamonocytogen nvarchar(50) = NULL,
	@Username nvarchar(50) = NULL,
	@Remarks nvarchar(50) = NULL,
	@IsDeleted bit = NULL

)
AS
	--SET NOCOUNT ON

	INSERT INTO [Lab]
	(
		Date,	
      TypeofPowder,	
      Time,	
      SampleId,	
      BatchNo,	    
      BagNo,	    
      Weight,	    
      TempOC,	
      Fat,
      SNF	,
       Acidity	,
		Moisture,
		Sugar,
		SolIndex,
		Coffetest,
		Particleontop,
		ParticleonBottom,
		Sendiments,
		BulkDensity,
		Scorchedparticle,
		Wettability,
		Dispersibility,
		FreeFat,
		TotalPlatecount,
		Coliform,
		YestMould,
		Ecoli,
		Salmonella,
		Saureus,
		Anerobicsporecount,
		Listeriamonocytogen,
		Username,
		Remarks,
		IsDeleted




	)
	VALUES
	(	
	@Date ,
	@TypeofPowder ,
	@Time ,
	@SampleId ,
	@BatchNo ,
	@BagNo ,
	@Weight ,
	@TempOC ,
	@Fat ,
	@SNF ,
	@Acidity ,
	@Moisture ,
	@Sugar ,
	@SolIndex ,
	@Coffetest ,
	@Particleontop ,
	@ParticleonBottom ,
	@Sendiments ,
	@BulkDensity ,
	@Scorchedparticle ,
	@Wettability ,
	@Dispersibility ,
	@FreeFat ,
	@TotalPlatecount ,
	@Coliform ,
	@YestMould ,
	@Ecoli ,
	@Salmonella ,
	@Saureus ,
	@Anerobicsporecount ,
	@Listeriamonocytogen ,
	@Username ,
	@Remarks ,
	@IsDeleted


		
	)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Lab_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Lab_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
	*
		FROM   
			[Lab] M 
			where
	Id = @Id
	
	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Lab_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Lab_SelectAll]
--(
	--@Type int
--)
AS
	--SET NOCOUNT ON
	
	select * from Lab
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_Lab_SelectAll_Details]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Lab_SelectAll_Details]
@FromDate datetime,
@ToDate datetime
AS
	--SET NOCOUNT ON
	
	select  
	ROW_NUMBER() over (order by [Date]) as 'SrNo',
	  convert(varchar(20),[Date],103)Date,
	--convert(varchar(8),[Date],114) Time,
	  TypeofPowder,	
      Time,	
      SampleId,	
      BatchNo,	    
      BagNo,	    
      Weight,	    
      TempOC,	
      Fat,
      SNF	,
       Acidity	,
		Moisture,
		Sugar,
		SolIndex,
		Coffetest,
		Particleontop,
		ParticleonBottom,
		Sendiments,
		BulkDensity,
		Scorchedparticle,
		Wettability,
		Dispersibility,
		FreeFat,
		TotalPlatecount,
		Coliform,
		YestMould,
		Ecoli,
		Salmonella,
		Saureus,
		Anerobicsporecount,
		Listeriamonocytogen,
		Username,
		Remarks
	 from Lab
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_Lab_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Lab_Update]
(
	@Id int,
	@Date nvarchar(50) = NULL,
	@TypeofPowder nvarchar(50) = NULL,
	@Time time(7) = NULL,
	@SampleId nvarchar(50) = NULL,
	@BatchNo nvarchar(50) = NULL,
	@BagNo nvarchar(50) = NULL,
	@Weight nvarchar(50) = NULL,
	@TempOC nvarchar(50) = NULL,
	@Fat nvarchar(50) = NULL,
	@SNF nvarchar(50) = NULL,
	@Acidity nvarchar(50) = NULL,
	@Moisture nvarchar(50) = NULL,
	@Sugar nvarchar(50) = NULL,
	@SolIndex nvarchar(50) = NULL,
	@Coffetest nvarchar(50) = NULL,
	@Particleontop nvarchar(50) = NULL,
	@ParticleonBottom nvarchar(50) = NULL,
	@Sendiments nvarchar(50) = NULL,
	@BulkDensity nvarchar(50) = NULL,
	@Scorchedparticle nvarchar(50) = NULL,
	@Wettability nvarchar(50) = NULL,
	@Dispersibility nvarchar(50) = NULL,
	@FreeFat nvarchar(50) = NULL,
	@TotalPlatecount nvarchar(50) = NULL,
	@Coliform nvarchar(50) = NULL,
	@YestMould nvarchar(50) = NULL,
	@Ecoli nvarchar(50) = NULL,
	@Salmonella nvarchar(50) = NULL,
	@Saureus nvarchar(50) = NULL,
	@Anerobicsporecount nvarchar(50) = NULL,
	@Listeriamonocytogen nvarchar(50) = NULL,
	@Username nvarchar(50) = NULL,
	@Remarks nvarchar(50) = NULL,
	@IsDeleted bit = NULL
)
AS
	--SET NOCOUNT ON
	
	UPDATE [Lab]
	SET
	  Date = @Date,
      TypeofPowder = @TypeofPowder ,
      Time = @Time ,
      SampleId = @SampleId ,
      BatchNo =@BatchNo ,    
      BagNo	 = @BagNo ,
      Weight = @Weight ,   
      TempOC = @TempOC ,	
      Fat = @Fat ,
      SNF = @SNF ,
       Acidity	= @Acidity ,
		Moisture = @Moisture ,
		Sugar = @Sugar ,
		SolIndex = @SolIndex ,
		Coffetest = @Coffetest ,
		Particleontop = @Particleontop ,
		ParticleonBottom = @ParticleonBottom ,
		Sendiments = @Sendiments ,
		BulkDensity = @BulkDensity ,
		Scorchedparticle = @Scorchedparticle ,
		Wettability = @Wettability ,
		Dispersibility = @Dispersibility ,
		FreeFat = @FreeFat ,
		TotalPlatecount = @TotalPlatecount ,
		Coliform = @Coliform ,
		YestMould = @YestMould ,
		Ecoli =@Ecoli ,
		Salmonella =@Salmonella ,
		Saureus =@Saureus ,
		Anerobicsporecount =@Anerobicsporecount ,
		Listeriamonocytogen =@Listeriamonocytogen ,
		Username =@Username ,
		Remarks = @Remarks ,
		IsDeleted = @IsDeleted
	WHERE 
		Id = @Id

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_LabReport_DateWise]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_LabReport_DateWise] '01/12/2015','31/12/2015'
CREATE PROCEDURE [dbo].[usp_LabReport_DateWise]
	@FromDate varchar(50),
	@ToDate varchar(50)
AS
BEGIN
	Select 
		Id,
		LabDate,
		VehicleCode,
		VehicleNumber,
		RouteNo,
		ProductName,
		Case When OT = -1 Then '' Else Case When OT = 1 then 'Ok' Else 'Not Ok' End End as OT,
		Case When Temp = 0 Then '' Else Temp End as Temp,
		Case When Fat = 0 Then '' Else Fat End as Fat,
		Case When SNF = 0 Then '' Else SNF End as SNF,
		Case When Acidity = 0 Then '' Else Acidity End as Acidity,
		Case When COB = '-1' Then '' Else COB End as COB,
		AlcoholNo,
		Case When Neutralizer = '-1' Then '' Else Neutralizer End as Neutralizer,
		Case When Urea = '-1' Then '' Else Urea End as Urea,
		Case when Salt = '-1' Then '' Else Salt End as Salt,
		Case When Startch = '-1' Then '' Else Startch End as Startch,
		FPD,
		Case When Status = 1 Then 'Accepted' Else 'Rejected' End as Status,
		Name
	From
	(Select
		LR.Id, 
		LR.LabDate,
		LR.VehicleCode,
		V.VehicleNumber,
		V.RouteNo,
		P.ProductName,
		OT,
		Temp,
		Fat,
		SNF,
		Acidity,
		COB,
		AlcoholNo,
		Neutralizer,
		Urea,
		Salt,
		Startch,
		FPD,
		Status,
		E.Name
	from 
		LabReport LR Inner Join Vehicle V on
			LR.VehicleId = V.VehicleId Inner Join Product P on
					P.ProductId = LR.ProductId Inner Join Employee E on
						E.Id = LR.CreatedBy
	Where
		LR.IsDeleted = 0
		and V.IsDeleted = 0
		and P.IsDeleted = 0
		and Convert(date, LabDate, 103) Between Convert(date, @FromDate, 103) and Convert(date, @ToDate, 103))t
END



GO
/****** Object:  StoredProcedure [dbo].[usp_Maintainance_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Maintainance_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Maintainance]
	--WHERE
	--

	Update 
		[Maintainance]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id and 
		IsDeleted = 0




GO
/****** Object:  StoredProcedure [dbo].[usp_Maintainance_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Maintainance_Insert]
(
	@Id int = NULL OUTPUT,
	@Date nvarchar(50) = NULL,
	@EquipmentTagNo varchar(50) = NULL,
	@EquipmentName varchar(50) = NULL,
	@StartTime time(7) = NULL,
	@EndTime time(7) = NULL,
	@PartNo varchar(50) = NULL,
	@Area varchar(50) = NULL,
	@ProblemDetails varchar(MAX) = NULL,
	@ActionTaken varchar(MAX) = NULL,
	@RectifiedBy varchar(50) = NULL,
	@Remark varchar(MAX) = NULL,
	@CreatedBy int = NULL,
	@IsDeleted bit,
	@CreatedDate datetime = NULL

)
AS
	--SET NOCOUNT ON

	INSERT INTO [Maintainance]
	(
		Date,	
      EquipmentTagNo,	
      EquipmentName,	
      StartTime,	
      EndTime,	    
      PartNo,	    
      Area,	    
      ProblemDetails,	
      ActionTaken,
      RectifiedBy	,
       Remark	,
		[IsDeleted],
		[CreatedBy],
		[CreatedDate]




	)
	VALUES
	(	
		@Date,
		@EquipmentTagNo,
		@EquipmentName,
		@StartTime,
		@EndTime,
		@PartNo,
		@Area,
		@ProblemDetails,
		@ActionTaken,
		@RectifiedBy,
		@Remark,
		@IsDeleted,
		@CreatedBy,
		@CreatedDate

		
	)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Maintainance_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Maintainance_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
	*
		FROM   
			[Maintainance] M 
			where
	Id = @Id
	
	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Maintainance_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Maintainance_SelectAll]
--(
	--@Type int
--)
AS
	--SET NOCOUNT ON
	
	select * from Maintainance
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_Maintainance_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_Maintainance_Update]
(
	@Id int,
	@Date nvarchar(50) = NULL,
	@EquipmentTagNo varchar(50) = NULL,
	@EquipmentName varchar(50) = NULL,
	@StartTime time(7) = NULL,
	@EndTime time(7) = NULL,
	@PartNo varchar(50) = NULL,
	@Area varchar(50) = NULL,
	@ProblemDetails varchar(MAX) = NULL,
	@ActionTaken varchar(MAX) = NULL,
	@RectifiedBy varchar(50) = NULL,
	@Remark varchar(MAX) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL

)
AS
	--SET NOCOUNT ON
	
	UPDATE [Maintainance]
	SET


	
		[Date] = @Date,
		[EquipmentTagNo] = @EquipmentTagNo,
		[EquipmentName] = @EquipmentName,
		[StartTime] = @StartTime,
		[EndTime] = @EndTime,
		[PartNo] = @PartNo,
		[Area] = @Area,
		ProblemDetails =  @ActionTaken,
		[ActionTaken] = @ActionTaken,
		[RectifiedBy] = @RectifiedBy,
		[Remark] = @Remark,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
		
	WHERE 
		Id = @Id

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_Maintenance_SelectAll_Details]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Maintenance_SelectAll_Details]
@FromDate datetime,
@ToDate datetime
AS
	--SET NOCOUNT ON
	
	select  
	ROW_NUMBER() over (order by [Date]) as 'SrNo',
	  convert(varchar(20),[Date],103)Date,
	convert(varchar(8),[Date],108) Time,
	EquipmentTagNo,
	EquipmentName,
	StartTime,
	EndTime,
	PartNo,
	Area,
	ProblemDetails,
	ActionTaken,
	RectifiedBy,
	Remark
	 from Maintainance
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_Routes_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec [dbo].[usp_tbl_Route_SelectAll]
CREATE PROCEDURE [dbo].[usp_Routes_SelectAll]
AS

select * from CIPRoutes where IsDeleted=0;

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_CIPLOGReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_CIPLOGReport] '07/11/2019','07/12/2019',-1
CREATE procedure [dbo].[usp_rpt_CIPLOGReport]
	@FromDateTime datetime,
	@ToDateTime datetime,
	@LineNo int
AS

Create table #temp1(n int IDENTITY(1,1),Id int,Date datetime,StartTriggerT1 int,StartTriggerT2 int,StartTriggerT3 int,LineNumber int,
	RouteNo int,RecipeNo int,FlowSp float,LYEForwardTemp float,LYETemp float,LYECond float,LYEStepTime float,ACIDForwardTemp float,ACIDTemp float,ACIDCond float,ACIDStepTime float,
	FINALCond float,STERILIZATIONForwardTemp float,STERILIZATIONTemp float,STERILIZATIONStepTime float,[Status] bit)

If(@LineNo = -1)
Begin

	Insert into #temp1
		(Id,Date,StartTriggerT1,StartTriggerT2,StartTriggerT3,LineNumber,
		RouteNo,RecipeNo,FlowSp,[LYEForwardTemp],LYETemp,LYECond,LYEStepTime,[AcidForwardTemp],ACIDTemp,ACIDCond,ACIDStepTime,
		FINALCond,[STERILIZATIONForwardTemp],STERILIZATIONTemp,STERILIZATIONStepTime,[Status]) 
	(Select 
		t.* --into #temp1 
	from 
		CIPLogReport t 
	where 
		(StartTriggerT1 = 0 or StartTriggerT2 = 0 or StartTriggerT3 = 0) and [Date] between @FromDateTime and @ToDateTime) 

	
End
Else if(@LineNo = 1)
Begin
	Insert into #temp1
		(Id,Date,StartTriggerT1,StartTriggerT2,StartTriggerT3,LineNumber,
		RouteNo,RecipeNo,FlowSp,[LYEForwardTemp],LYETemp,LYECond,LYEStepTime,[AcidForwardTemp],ACIDTemp,ACIDCond,ACIDStepTime,
		FINALCond,[STERILIZATIONForwardTemp],STERILIZATIONTemp,STERILIZATIONStepTime,[Status]) 
	(Select 
		t.* --into #temp1 
	from 
		CIPLogReport t 
	where 
		(StartTriggerT1 = 0) and [Date] between @FromDateTime and @ToDateTime)
End
Else if(@LineNo = 2)
Begin
	Insert into #temp1
		(Id,Date,StartTriggerT1,StartTriggerT2,StartTriggerT3,LineNumber,
		RouteNo,RecipeNo,FlowSp,[LYEForwardTemp],LYETemp,LYECond,LYEStepTime,[AcidForwardTemp],ACIDTemp,ACIDCond,ACIDStepTime,
		FINALCond,[STERILIZATIONForwardTemp],STERILIZATIONTemp,STERILIZATIONStepTime,[Status]) 
	(Select 
		t.* --into #temp1 
	from 
		CIPLogReport t 
	where 
		(StartTriggerT2 = 0) and [Date] between @FromDateTime and @ToDateTime)
End
Else if(@LineNo = 3)
Begin
	Insert into #temp1
		(Id,Date,StartTriggerT1,StartTriggerT2,StartTriggerT3,LineNumber,
		RouteNo,RecipeNo,FlowSp,[LYEForwardTemp],LYETemp,LYECond,LYEStepTime,[AcidForwardTemp],ACIDTemp,ACIDCond,ACIDStepTime,
		FINALCond,[STERILIZATIONForwardTemp],STERILIZATIONTemp,STERILIZATIONStepTime,[Status]) 
	(Select 
		t.* --into #temp1 
	from 
		CIPLogReport t 
	where 
		(StartTriggerT3 = 0) and [Date] between @FromDateTime and @ToDateTime) 
End

--Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1 
--	from CIPLogReport t 
--		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0 or StartTriggerT3 = 0) and [Date] between @FromDateTime and @ToDateTime 
----select * from #temp1
declare @a int = 1
declare @count int = (select count(*) from #temp1)
--select @count
--drop table #temp1 
Create table #tmpCIPLOGReport (Id int IDENTITY(1,1),[Date] varchar(10),StartTime varchar(8),StopTime varchar(8),TotalTimeInCIP varchar(8),
								[LineNo] varchar(10), RouteNo int,RouteName varchar(100),ReceipeNo varchar(1000),FlowSP decimal(18,2),LYEForwardTemp float,LYETemp decimal(18,2),
								LYECond decimal(18,2),LYEStepTime decimal(18),ACIDForwardTemp float,ACIDTemp decimal(18,2),ACIDCond decimal(18,2),ACIDStepTime decimal(18),
								STERILIZATIONForwardTemp float,STERILIZATIONTemp decimal(18,2),STERILIZATIONStepTime decimal(18),FINALCond decimal(18,2),[Status] varchar(8))

while (@a <= @count)
begin

	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId1 int = null
			set @ProcessId1 = (select Id from #temp1 where n = @a)
			Declare @tempId1 int
		    
			
			

			Select 
				row_number() OVER (ORDER BY id) [row],* into #tempCIPLOGReport1 
			from 
				CIPLogReport
			where 
				StartTriggerT1 between 0 and 30
				and [Date] between @FromDateTime and @ToDateTime 
			--select * from #tmpCreamRow
			Declare @Row1 int = null
			set @Row1 = (Select [row] from #tempCIPLOGReport1 where id = @ProcessId1)
			--select @Row1

			while ((Select Id from #tempCIPLOGReport1 where StartTriggerT1 != 0 and [Row] = @Row1 -1) != 0)
			begin
					set @tempId1 = (Select Id from #tempCIPLOGReport1 where StartTriggerT1 != 0 and [Row] = @Row1 -1)
					set @Row1 = @Row1 - 1
			end
			--select @tempId1
			Declare @FlowPV1 float=0
			set @FlowPV1= (select avg(a.FlowSp) from #tempCIPLOGReport1 a where Id between @tempId1 and (select Id from #temp1 where n = @a) )

			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tempCIPLOGReport1 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tempCIPLOGReport1 where id = (select Id from #tempCIPLOGReport1 where Id = @tempId1)) as [Date],
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInCIP,
				'C3F1'as LineNumber,
				RouteNo,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = ((Select RouteNo from #tempCIPLOGReport1 where Id = @tempId1))) as 'RouteName',
				(Select Name from CIPRecipe where IsDeleted = 0 and PLCValue = ((Select RecipeNo from #tempCIPLOGReport1 where Id = @tempId1))) as RecipeNo,
				-- Avg (FlowSP)as FlowSP ,
				@FlowPV1 as FlowSP ,

				(Select LYEForwardTemp from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 2 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as LYEForwardTemp,
				(Select LYETemp from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 2 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as LYETemp,
				(Select LYECond from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 2 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as LYECond,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 2 and Id between @tempId1 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 2 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1))) as LYEStepTime,
				
				(Select AcidForwardTemp from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 5 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as AcidForwardTemp,
				(Select ACIDTemp from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 5 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as ACIDTemp,
				(Select ACIDCond from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 5 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as ACIDCond,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 5 and Id between @tempId1 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 5 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1))) as ACIDStepTime,
				
				(Select STERILIZATIONForwardTemp from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 7 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as STERILIZATIONForwardTemp,
				(Select STERILIZATIONTemp from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 7 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as STERILIZATIONTemp,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 7 and Id between @tempId1 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 7 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1))) as STERILIZATIONStepTime,
				 (Select FINALCond from #tempCIPLOGReport1 where row = (Select max(row) from #tempCIPLOGReport1 where StartTriggerT1 = 6 and Id between @tempId1 and (select Id from #temp1 where n = @a)) + 1) as FINALCond,
				(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempCIPLOGReport1 where id = (select Id from #temp1 where n = @a)) as [Status]
			into 
				#tempProcess1
			from 
				#tempCIPLOGReport1
			where 
				Id between @tempId1 and (select Id from #temp1 where n = @a)
			
			--select * from #tempProcess
			Insert into #tmpCIPLOGReport 
				(StartTime,StopTime,[Date],TotalTimeInCIP,
				[LineNo],RouteNo,RouteName,ReceipeNo,FlowSP,LYEForwardTemp,LYETemp,LYECond,LYEStepTime,AcidForwardTemp,ACIDTemp,ACIDCond,ACIDStepTime,STERILIZATIONForwardTemp,STERILIZATIONTemp,
				STERILIZATIONStepTime,FINALCond,[Status])
			(Select * from #tempProcess1)

		drop table #tempCIPLOGReport1,#tempProcess1
	end
	else if((Select StartTriggerT2 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId2 int = null
			set @ProcessId2 = (select Id from #temp1 where n = @a)
			Declare @tempId2 int
		
			Select 
				row_number() OVER (ORDER BY id) [row],* into #tempCIPLOGReport2 
			from 
				CIPLogReport
			where 
				StartTriggerT2 between 0 and 30
				and [Date] between @FromDateTime and @ToDateTime 
			--select * from #tmpCreamRow
			Declare @Row2 int = null
			set @Row2 = (Select [row] from #tempCIPLOGReport2 where id = @ProcessId2)
			--select @Row2

			while ((Select Id from #tempCIPLOGReport2 where StartTriggerT2 != 0 and [Row] = @Row2 -1) != 0)
			begin
					set @tempId2 = (Select Id from #tempCIPLOGReport2 where StartTriggerT2 != 0 and [Row] = @Row2 -1)
					set @Row2 = @Row2 - 1
			end
			--select @tempId2
			Declare @FlowPV2 float=0
			set @FlowPV2= (select avg(a.FlowSp) from #tempCIPLOGReport2 a where Id between @tempId2 and (select Id from #temp1 where n = @a) )

			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tempCIPLOGReport2 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tempCIPLOGReport2 where id = (select Id from #tempCIPLOGReport2 where Id = @tempId2)) as [Date],
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport2 where id between @tempId2 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport2 where id between @tempId2 and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport2 where id between @tempId2 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport2 where id between @tempId2 and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport2 where id between @tempId2 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport2 where id between @tempId2 and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInCIP,
				'C3F2'as LineNumber,
				RouteNo,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = ((Select RouteNo from #tempCIPLOGReport2 where Id = @tempId2))) as 'RouteName',
				(Select Name from CIPRecipe where IsDeleted = 0 and PLCValue = ((Select RecipeNo from #tempCIPLOGReport2 where Id = @tempId2))) as RecipeNo,
				--Avg (FlowSP)as FlowSP,
				@FlowPV2 as FlowSP,
				(Select LYEForwardTemp from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 2 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as LYEForwardTemp,
				(Select LYETemp from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 2 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as LYETemp,
				(Select LYECond from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 2 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as LYECond,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 2 and Id between @tempId2 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 2 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1))) as LYEStepTime,
				
				(Select AcidForwardTemp from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 5 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as AcidForwardTemp,
				(Select ACIDTemp from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 5 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as ACIDTemp,
				(Select ACIDCond from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 5 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as ACIDCond,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 5 and Id between @tempId2 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 5 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1))) as ACIDStepTime,
				
				(Select STERILIZATIONForwardTemp from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 7 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as STERILIZATIONForwardTemp,
				(Select STERILIZATIONTemp from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 7 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as STERILIZATIONTemp,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 7 and Id between @tempId2 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 7 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1))) as STERILIZATIONStepTime,
				 (Select FINALCond from #tempCIPLOGReport2 where row = (Select max(row) from #tempCIPLOGReport2 where StartTriggerT2 = 6 and Id between @tempId2 and (select Id from #temp1 where n = @a)) + 1) as FINALCond,
				(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempCIPLOGReport2 where id = (select Id from #temp1 where n = @a)) as [Status]
			into 
				#tempProcess2
			from 
				#tempCIPLOGReport2
			where 
				Id between @tempId2 and (select Id from #temp1 where n = @a)
			
			--select * from #tempProcess
			Insert into #tmpCIPLOGReport 
				(StartTime,StopTime,[Date],TotalTimeInCIP,
				[LineNo],RouteNo,RouteName,ReceipeNo,FlowSP,LYEForwardTemp,LYETemp,LYECond,LYEStepTime,AcidForwardTemp,ACIDTemp,ACIDCond,ACIDStepTime,STERILIZATIONForwardTemp,STERILIZATIONTemp,
				STERILIZATIONStepTime,FINALCond,[Status])
			(Select * from #tempProcess2)

		drop table #tempCIPLOGReport2,#tempProcess2
	end
	else if((Select StartTriggerT3 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId3 int = null
			set @ProcessId3 = (select Id from #temp1 where n = @a)
			Declare @tempId3 int
		
			Select 
				row_number() OVER (ORDER BY id) [row],* into #tempCIPLOGReport3 
			from 
				CIPLogReport
			where 
				StartTriggerT3 between 0 and 30 
				and [Date] between @FromDateTime and @ToDateTime 
			--select * from #tmpCreamRow
			Declare @Row3 int = null
			set @Row3 = (Select [row] from #tempCIPLOGReport3 where id = @ProcessId3)
			--select @Row3

			while ((Select Id from #tempCIPLOGReport3 where StartTriggerT3 != 0 and [Row] = @Row3 -1) != 0)
			begin
					set @tempId3 = (Select Id from #tempCIPLOGReport3 where StartTriggerT3 != 0 and [Row] = @Row3 -1)
					set @Row3 = @Row3 - 1
			end
			--select @tempId3
				Declare @FlowPV3 float=0
			set @FlowPV3= (select avg(a.FlowSp) from #tempCIPLOGReport3 a where Id between @tempId3 and (select Id from #temp1 where n = @a) )


			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tempCIPLOGReport3 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tempCIPLOGReport3 where id = (select Id from #tempCIPLOGReport3 where Id = @tempId3)) as [Date],
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInCIP,
				'C3F2'as LineNumber,
				RouteNo,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = ((Select RouteNo from #tempCIPLOGReport3 where Id = @tempId3))) as 'RouteName',
				(Select Name from CIPRecipe where IsDeleted = 0 and PLCValue = ((Select RecipeNo from #tempCIPLOGReport3 where Id = @tempId3))) as RecipeNo,
				--Avg (FlowSP)as FlowSP,
				@FlowPV3 as  FlowSP,
				(Select LYEForwardTemp from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 2 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as LYEForwardTemp,
				(Select LYETemp from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 2 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as LYETemp,
				(Select LYECond from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 2 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as LYECond,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 2 and Id between @tempId3 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 2 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1))) as LYEStepTime,
				
				(Select AcidForwardTemp from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 5 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as AcidForwardTemp,
				(Select ACIDTemp from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 5 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as ACIDTemp,
				(Select ACIDCond from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 5 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as ACIDCond,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 5 and Id between @tempId3 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 5 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1))) as ACIDStepTime,
				
				(Select STERILIZATIONForwardTemp from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 7 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as STERILIZATIONForwardTemp,
				(Select STERILIZATIONTemp from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 7 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as STERILIZATIONTemp,
				(Select top 1 DATEDIFF(ss,(Select [Date] from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 7 and Id between @tempId3 and (select Id from #temp1 where n = @a)))
				,(Select Date from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 7 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1))) as STERILIZATIONStepTime,
				 (Select FINALCond from #tempCIPLOGReport3 where row = (Select max(row) from #tempCIPLOGReport3 where StartTriggerT3 = 6 and Id between @tempId3 and (select Id from #temp1 where n = @a)) + 1) as FINALCond,
				(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempCIPLOGReport3 where id = (select Id from #temp1 where n = @a)) as [Status]
			into 
				#tempProcess3
			from 
				#tempCIPLOGReport3
			where 
				Id between @tempId3 and (select Id from #temp1 where n = @a)
			
			--select * from #tempProcess
			Insert into #tmpCIPLOGReport 
				(StartTime,StopTime,[Date],TotalTimeInCIP,
				[LineNo],RouteNo,RouteName,ReceipeNo,FlowSP,LYEForwardTemp,LYETemp,LYECond,LYEStepTime,AcidForwardTemp,ACIDTemp,ACIDCond,ACIDStepTime,STERILIZATIONForwardTemp,STERILIZATIONTemp,
				STERILIZATIONStepTime,FINALCond,[Status])
			(Select * from #tempProcess3)

		drop table #tempCIPLOGReport3,#tempProcess3
	end
	set @a = @a + 1
	
end

select 
	Id as SrNo,
	[Date],StartTime,StopTime,TotalTimeInCIP,
				[LineNo],--RouteNo,
				ReceipeNo,RouteName,
				FlowSP,Convert(decimal(18,2),LYEForwardTemp) as LYEForwardTemp,LYETemp,LYECond,LYEStepTime,
				Convert(decimal(18,2),ACIDForwardTemp) as ACIDForwardTemp,ACIDTemp,ACIDCond,ACIDStepTime,
				Convert(decimal(18,2),STERILIZATIONForwardTemp) as STERILIZATIONForwardTemp,STERILIZATIONTemp,
				STERILIZATIONStepTime,FINALCond,[Status]
from
	#tmpCIPLOGReport

drop table #temp1,#tmpCIPLOGReport


GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_CompressorAir]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_CompressorAir] '05/12/2018' , -1
CREATE PROCEDURE [dbo].[usp_rpt_CompressorAir]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and c.object_id = OBJECT_ID('dbo.CompressorLog')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTableCompressor') IS NOT NULL DROP TABLE ##TempTableCompressor
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from CompressedAirTag FT where FT.TagNo = Tags and IsDeleted = 0) as CompressorAirTag
		into ##TempTableCompressor
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						CompressorLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from CompressedAirTag FT where FT.TagNo = Tags and IsDeleted = 0) as CompressorAirTag
		into ##TempTableCompressor
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						CompressorLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableCompressor group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		from
			##TempTableCompressor
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_Concfeed_Tankstatus_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_Concfeed_Tankstatus_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_Concfeed_Tankstatus_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin
		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when F11T01TypesofMilk = 0 then 'None'
					when F11T01TypesofMilk = 1 then 'Raw Whey'
					when F11T01TypesofMilk =2 then 'Past Whey'
					when F11T01TypesofMilk = 3 then 'Mozzerella Cheese Whey'
					when F11T01TypesofMilk = 4 then 'Panner Whey'
					when F11T01TypesofMilk = 5 then 'Raw Cream'
					when F11T01TypesofMilk = 6 then 'Past. Cream'
					when F11T01TypesofMilk = 7 then 'NF Whey'
					when F11T01TypesofMilk = 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when F11T01TankStatus = 0 then 'Unclean'
				  when F11T01TankStatus = 1 then 'Clean'end as TankStatus,
				  cast(M1.F11T01Qty as decimal (18,2)) as Qty,
				  M1.F11T01AgeingTimer,
				  M1.F11T01DirtyTime,
			   case when F12T01TypesofMilk1 = 0 then 'None'
					when F12T01TypesofMilk1 = 1 then 'Raw Whey'
					when F12T01TypesofMilk1 =2 then 'Past Whey'
					when F12T01TypesofMilk1 = 3 then 'Mozzerella Cheese Whey'
					when F12T01TypesofMilk1 = 4 then 'Panner Whey'
					when F12T01TypesofMilk1 = 5 then 'Raw Cream'
					when F12T01TypesofMilk1 = 6 then 'Past. Cream'
					when F12T01TypesofMilk1 = 7 then 'NF Whey'
					when F12T01TypesofMilk1 = 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when F12T01TankStatus1 = 0 then 'Unclean'
				  when F12T01TankStatus1 = 1 then 'Clean'end as TankStatus,
				  cast(M1.F12T01Qty1 as decimal (18,2)) as Qty,
				  M1.F12T01AgeingTimer1,
				  M1.F12T01DirtyTime1,
			  case when  F13T01TypesofMilk11 = 0 then 'None'
					when F13T01TypesofMilk11 = 1 then 'Raw Whey'
					when F13T01TypesofMilk11 =2 then 'Past Whey'
					when F13T01TypesofMilk11 = 3 then 'Mozzerella Cheese Whey'
					when F13T01TypesofMilk11 = 4 then 'Panner Whey'
					when F13T01TypesofMilk11 = 5 then 'Raw Cream'
					when F13T01TypesofMilk11 = 6 then 'Past. Cream'
					when F13T01TypesofMilk11 = 7 then 'NF Whey'
					when F13T01TypesofMilk11 = 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when F13T01TankStatus11 = 0 then 'Unclean'
				  when F13T01TankStatus11 = 1 then 'Clean'end as TankStatus,
				  cast(M1.F13T01Qty11 as decimal (18,2)) as Qty,
				  M1.F13T01Temp,
				  M1.F13T01AgeingTimer11,
				  M1.F13T01DirtyTime11,
               case when F19T01TypesofMilk11 = 0 then 'None'
					when F19T01TypesofMilk11 = 1 then 'Raw Whey'
					when F19T01TypesofMilk11 =2 then 'Past Whey'
					when F19T01TypesofMilk11 = 3 then 'Mozzerella Cheese Whey'
					when F19T01TypesofMilk11 = 4 then 'Panner Whey'
					when F19T01TypesofMilk11= 5 then 'Raw Cream'
					when F19T01TypesofMilk11= 6 then 'Past. Cream'
					when F19T01TypesofMilk11= 7 then 'NF Whey'
					when F19T01TypesofMilk11= 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when F19T01TankStatus11 = 0 then 'Unclean'
				  when F19T01TankStatus11 = 1 then 'Clean'end as TankStatus,
				  cast(M1.F19T01Qty11 as decimal (18,2)) as Qty,
				  M1.F19T01AgeingTimer11,
				  M1.F19T01DirtyTime11
				 
					
					
	from ConcfeedTankStatus M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_CreamBufferTank_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_CreamBufferTank_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_CreamBufferTank_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when TypesofMilk = 0 then 'None'
					when TypesofMilk = 1 then 'Raw Whey'
					when TypesofMilk =2 then 'Past Whey'
					when TypesofMilk = 3 then 'Mozzerella Cheese Whey'
					when TypesofMilk = 4 then 'Panner Whey'
					when TypesofMilk = 5 then 'Raw Cream'
					when TypesofMilk = 6 then 'Past. Cream'
					when TypesofMilk = 7 then 'NF Whey'
					when TypesofMilk = 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when TankStatus = 0 then 'Unclean'
				  when TankStatus = 1 then 'Clean'end as TankStatus,
				  cast(M1.Qty as decimal (18,2)) as Qty,
				  cast(M1.Temp as decimal (18,2))as Temp ,
				  M1.AgeingTimer,
				  M1.DirtyTime
				 
						
					
					
	from CreamBufferTank_Status M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_CreamTank_Status_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_CreamTank_Status_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_CreamTank_Status_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when TypesofMilk = 0 then 'None'
					when TypesofMilk = 1 then 'Raw Whey'
					when TypesofMilk =2 then 'Past Whey'
					when TypesofMilk = 3 then 'Mozzerella Cheese Whey'
					when TypesofMilk = 4 then 'Panner Whey'
					when TypesofMilk = 5 then 'Raw Cream'
					when TypesofMilk = 6 then 'Past. Cream'
					when TypesofMilk = 7 then 'NF Whey'
					when TypesofMilk = 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when TankStatus = 0 then 'Unclean'
				  when TankStatus = 1 then 'Clean'end as TankStatus,
				  cast(M1.Qty as decimal (18,2)) as Qty,
				  cast(M1.Temp as decimal (18,2))as Temp ,
				  M1.AgeingTimer,
				  M1.DirtyTime,
				  CreamdispatchQty
				 	
					
	from CreamTank_Status M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_Crystallization_Tankstatus_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_Concfeed_Tankstatus_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_Crystallization_Tankstatus_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin
		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[DateTime],103)Date,
				  convert(varchar(8),M1.[DateTime],108) Time,
				    case when C11T01TypesOfWhey = 0 then 'None'
					when C11T01TypesOfWhey = 1 then 'Raw Whey'
					when C11T01TypesOfWhey =2 then 'Past Whey'
					when C11T01TypesOfWhey = 3 then 'Mozzerella Cheese Whey'
					when C11T01TypesOfWhey = 4 then 'Panner Whey'
					when C11T01TypesOfWhey= 5 then 'Raw Cream'
					when C11T01TypesOfWhey= 6 then 'Past. Cream'
					when C11T01TypesOfWhey= 7 then 'NF Whey'
					when C11T01TypesOfWhey= 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when C11T01TankStatus = 0 then 'Unclean'
				  when C11T01TankStatus = 1 then 'Clean'end as TankStatus,
				  cast(M1.C11T01Qty as decimal (18,2)) as Qty,
				  cast(M1.C11T01CrystallizationTankTemp as decimal (18,2)) as C11T01CrystallizationTankTemp,
				  cast(M1.C11T01CrystallizationTankJacketCoolingwatertemp as decimal (18,2)) as C11T01CrystallizationTankJacketCoolingwatertemp,
				  cast(M1.C11T01ForwardPumpspeed as decimal (18,2)) as C11T01ForwardPumpspeed,
				  cast(M1.C11T01InitialTanktemp as decimal (18,2)) as C11T01InitialTanktemp,
				    cast(M1.C11T01FinalTanktemp as decimal (18,2)) as C11T01FinalTanktemp,
				  M1.C11T01BatchTime,
				  M1.C11T01AgeingTimer,
				  M1.C11T01DirtyTime,
			   case when C12T01TypesofWhey = 0 then 'None'
					when C12T01TypesofWhey = 1 then 'Raw Whey'
					when C12T01TypesofWhey =2 then 'Past Whey'
					when C12T01TypesofWhey = 3 then 'Mozzerella Cheese Whey'
					when C12T01TypesofWhey = 4 then 'Panner Whey'
					when C12T01TypesofWhey= 5 then 'Raw Cream'
					when C12T01TypesofWhey= 6 then 'Past. Cream'
					when C12T01TypesofWhey= 7 then 'NF Whey'
					when C12T01TypesofWhey= 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when C12T01TankStatus = 0 then 'Unclean'
				       when C12T01TankStatus = 1 then 'Clean'end as TankStatus,
				  cast(M1.C12T01Qty as decimal (18,2)) as Qty,
				  cast(M1.C12T01CrystallizationTankTemp as decimal (18,2)) as C12T01CrystallizationTankTemp,
				  cast(M1.C12T01CrystallizationTankJacketCoolingwatertemp as decimal (18,2)) as C12T01CrystallizationTankJacketCoolingwatertemp,
				  cast(M1.C12T01ForwardPumpspeed as decimal (18,2)) as C12T01ForwardPumpspeed,
				  cast(M1.C12T01InitialTanktemp as decimal (18,2)) as C12T01InitialTanktemp,
				    cast(M1.C12T01FinalTanktemp as decimal (18,2)) as C12T01FinalTanktemp,
				  M1.C12T01BatchTime,
				  M1.C12T01AgeingTimer,
				  M1.C12T01DirtyTime,
			  case when  C13T01TypesofWhey1 = 0 then 'None'
					when C13T01TypesofWhey1 = 1 then 'Raw Whey'
					when C13T01TypesofWhey1 =2 then 'Past Whey'
					when C13T01TypesofWhey1 = 3 then 'Mozzerella Cheese Whey'
					when C13T01TypesofWhey1 = 4 then 'Panner Whey'
					when C13T01TypesofWhey1= 5 then 'Raw Cream'
					when C13T01TypesofWhey1= 6 then 'Past. Cream'
					when C13T01TypesofWhey1= 7 then 'NF Whey'
					when C13T01TypesofWhey1= 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when C13T01TankStatus1 = 0 then 'Unclean'
				  when C13T01TankStatus1 = 1 then 'Clean'end as TankStatus,
				  cast(M1.C13T01Qty1 as decimal (18,2)) as Qty,
				   cast(M1.C13T01CrystallizationTankTemp1 as decimal (18,2)) as C13T01CrystallizationTankTemp1,
				  cast(M1.C13T01CrystallizationTankJacketCoolingwatertemp1 as decimal (18,2)) as C13T01CrystallizationTankJacketCoolingwatertemp1,
				  cast(M1.C13T01ForwardPumpspeed1 as decimal (18,2)) as C13T01ForwardPumpspeed1,
				  cast(M1.C13T01InitialTanktemp1 as decimal (18,2)) as C13T01InitialTanktemp1,
				    cast(M1.C13T01FinalTanktemp1 as decimal (18,2)) as C13T01FinalTanktemp1,
				  M1.C13T01BatchTime1,
				  M1.C13T01AgeingTimer1,
				  M1.C13T01DirtyTime1,
               case when C14T01TypesofWhey1 = 0 then 'None'
					when C14T01TypesofWhey1 = 1 then 'Raw Whey'
					when C14T01TypesofWhey1 =2 then 'Past Whey'
					when C14T01TypesofWhey1 = 3 then 'Mozzerella Cheese Whey'
					when C14T01TypesofWhey1 = 4 then 'Panner Whey'
					when C14T01TypesofWhey1= 5 then 'Raw Cream'
					when C14T01TypesofWhey1= 6 then 'Past. Cream'
					when C14T01TypesofWhey1= 7 then 'NF Whey'
					when C14T01TypesofWhey1= 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when C14T01TankStatus1 = 0 then 'Unclean'
				  when C14T01TankStatus1 = 1 then 'Clean'end as TankStatus,
				  cast(M1.C14T01Qty1 as decimal (18,2)) as Qty,
				   cast(M1.C14T01CrystallizationTankTemp1 as decimal (18,2)) as C14T01CrystallizationTankTemp1,
				  cast(M1.C14T01CrystallizationTankJacketCoolingwatertemp1 as decimal (18,2)) as C14T01CrystallizationTankJacketCoolingwatertemp1,
				  cast(M1.C14T01ForwardPumpspeed1 as decimal (18,2)) as C14T01ForwardPumpspeed1,
				  cast(M1.C14T01InitialTanktemp1 as decimal (18,2)) as C14T01InitialTanktemp1,
				    cast(M1.C14T01FinalTanktemp1 as decimal (18,2)) as C14T01FinalTanktemp1,
				  M1.C14T01BatchTime1,
				  M1.C14T01AgeingTimer1,
				  M1.C14T01DirtyTime1
				 
					
					
	from CrystallizationTankStatus M1 
	where
	[DateTime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_DailyActivityReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_rpt_DailyActivityReport]
	@FromDate varchar(50)
AS

--Declare @FromDate varchar(50) = '08/03/2019'
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and c.object_id = OBJECT_ID('dbo.DailyActivity')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTableDailActivity') IS NOT NULL DROP TABLE ##TempTableDailActivity

set @query 
	  = 'select 
			row_number() OVER (ORDER BY [DateTime]) Id,
			Tags, 
			Round(Value,2) as Value
		into 
			##TempTableDailActivity
				from
				(
					Select 
						*
					from
						DailyActivity
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
			'
--Select @query
exec(@query)

--Select * from ##TempTableDailActivity

Declare @PreviousPowerConsumption decimal(18,2) = (Select ISNULL([PowerConsumption1],0)+ISNULL([PowerConsumption2],0) from DailyActivity where Convert(date, DateTime, 103) = DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
--Select @PreviousPowerConsumption
Declare @Count int = (Select Count(*) from ##TempTableDailActivity)
Declare @a int = 1
----------------------------------- Create Temp Table --------------------------
Create table #tempDailActivity (Id int IDENTITY(1,1),Name varchar(100),Unit varchar(8),Quantity decimal(18,2))
Create table #tempDailActivityReport (Id int IDENTITY(1,1),Name varchar(100),Unit varchar(8),Quantity decimal(18,2))
----------------------------------

While(@a <= @Count)
Begin
	if(@a = 1)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'C11LT01 Acid Tank Level','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 2)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Air Consumption','NM3',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 3)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'C12LT01 Lye Tank Level','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 4)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Milk Processed in Evaporator 1','Kg',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 5)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Milk Processed in Evaporator 2','Kg',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 6)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Total Milk Processed','Kg',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 7)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Milk Silo Level - S11LT01','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 8)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Milk Silo Level - S12LT01','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 9)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Milk Silo Level - S13LT01','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 10)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Milk Silo Level - S14LT01','Ltr',Value from ##TempTableDailActivity where Id = @a)

			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 
				'Total',
				'Ltr',
				(Select Value from ##TempTableDailActivity where Id = 7) + 
				(Select Value from ##TempTableDailActivity where Id = 8) + 
				(Select Value from ##TempTableDailActivity where Id = 9) + 
				(Select Value from ##TempTableDailActivity where Id = 10) 
			 )
		End
	if(@a = 11)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'NZ Generation','Nm3',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 12)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Powder Silo-1','MT',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 13)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Powder Silo-2','MT',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 14)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Powder Silo-3','MT',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 15)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Powder Silo-4','MT',Value from ##TempTableDailActivity where Id = @a)
			
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 
				'Total',
				'MT',
				(Select Value from ##TempTableDailActivity where Id = 12) + 
				(Select Value from ##TempTableDailActivity where Id = 13) + 
				(Select Value from ##TempTableDailActivity where Id = 14) + 
				(Select Value from ##TempTableDailActivity where Id = 15) 
			 )
		End
	--if(@a = 16)
	--	Begin
	--		Insert into #tempDailActivity (Name,Unit,Quantity)
	--		(Select 'Power Consumption','Kw',Value from ##TempTableDailActivity where Id = @a)
	--	End
	if(@a = 17)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Power Consumption','Kw',
			ABS((Select Value from ##TempTableDailActivity where Id = 16) + 
				(Select Value from ##TempTableDailActivity where Id = 17) - @PreviousPowerConsumption)
			 )
		End
	if(@a = 18)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Raw Water Consumption','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 19)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'RO Water Generation','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 20)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Soft Water Consumption','Ltr',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 21)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Steam Consumption','Kg',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 22)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Suger Silo-1','Kg',Value from ##TempTableDailActivity where Id = @a)
		End
	if(@a = 23)
		Begin
			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 'Suger Silo-2','Kg',Value from ##TempTableDailActivity where Id = @a)

			Insert into #tempDailActivity (Name,Unit,Quantity)
			(Select 
				'Total',
				'Kg',
				(Select Value from ##TempTableDailActivity where Id = 21) + 
				(Select Value from ##TempTableDailActivity where Id = 22) 
			 )
		End

Set @a = @a + 1
End
if(@Count > 0)
Begin

Declare @TotalAvaQty decimal(18,2) = 0

Select 
	row_number() OVER (ORDER BY id) as 'row1',*
into 
	#temp
from 
	PackingMachineMassBalanceAvapack where Convert(date,[DateTime],103) = Convert(date,@FromDate,103)

--Select * from #temp
Declare @Count1 int= (Select COUNT(*) from #temp) 
Declare @a1 int = 1
While(@a1 <= @Count1)
Begin
	Declare @FirstValue decimal(18,2) = 1
	Declare @SecondValue decimal(18,2) = 1
	Set @FirstValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:01.1000000' and '00:00:59.1000000')
	Set @SecondValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:35.1000000' and '23:59:59.1000000')

	Set @TotalAvaQty = @TotalAvaQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
	Set @a1 = @a1 + 1
End
	Set @TotalAvaQty = @TotalAvaQty * (Select AvaPackQty from [MassBalancePowderProduction] where IsDeleted = 0) 
Drop table #temp

Declare @PreviousBoschQty decimal(18,2) = 0
Declare @CurrentBoschQty decimal(18,2) = 0
Declare @TotalBoschQty decimal(18,2) = 0
Set @PreviousBoschQty = (Select 
	Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
from 
	PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))


Set @CurrentBoschQty = (Select 
	Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
	Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
from 
	PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) = Convert(date,@FromDate,103))

Set @TotalBoschQty =  @CurrentBoschQty - @PreviousBoschQty

Declare @PreviousHassiaQty decimal(18,2) = 0
Declare @CurrentHassiaQty decimal(18,2) = 0
Declare @TotalHassiaQty decimal(18,2) = 0
Set @PreviousHassiaQty = (Select 
	Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0)
from 
	PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))


Set @CurrentHassiaQty = (Select 
	Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0) 
from 
	PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = Convert(date,@FromDate,103))

Set @TotalHassiaQty =  @CurrentHassiaQty - @PreviousHassiaQty

Declare @TotalPowderQty decimal(18,2) = 0
Set @TotalPowderQty = (Select top 1
							Quantity1 - LEAD(Quantity1,1) Over (Order By Date) +
						Quantity2 -	LEAD(Quantity2,1) Over (Order By Date)+
						Quantity3 -	LEAD(Quantity3,1) Over (Order By Date)+
						Quantity4 -	LEAD(Quantity4,1) Over (Order By Date) 
						from 
							[PowderSiloOpeningClosing] 
						where 
							Convert(date,[Date],103) = Convert(date,@FromDate,103))

--Select * from #temp
Declare @ProducuedQuantity float= (Select IsNull(Sum([TotalQuantity]),0)
								from 
									[PackingEntryMaster] 
								where 
									Convert(date,[Date],103) = Convert(date,@FromDate,103) 
									and IsDeLeted = 0)
Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)
	
Insert into #tempDailActivity (Name,Unit,Quantity)
(Select 'Total Powder Produced','MT',ABS(ISNULL(@TotalPowderQty,0)))

Insert into #tempDailActivity (Name,Unit,Quantity)
(Select 'Ava Pack Produced Quantity','KG',ISNULL(@TotalAvaQty,0))

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 1 Produced Quantity','KG',
	(Select Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 2 Produced Quantity','KG',
	(Select Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 3 Produced Quantity','KG',
	(Select Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 4 Produced Quantity','KG',
	(Select Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 5 Produced Quantity','KG',
	(Select Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 6 Produced Quantity','KG',
	(Select Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)

Insert into #tempDailActivity (Name,Unit,Quantity)
(
	Select 'Bosch 7 Produced Quantity','KG',
	(Select Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  Convert(date,@FromDate,103)) -
	(Select Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) from PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDate,103)))
)


Insert into #tempDailActivity (Name,Unit,Quantity)
(Select 'Hassia Produced Quantity','KG', ISNULL(@TotalHassiaQty,0))
--Select ISNULL(@TotalAvaQty,0) + ISNULL(@TotalBoschQty,0) + ISNULL(@TotalHassiaQty,0) as 'PowderQuantity'
End
--Select * from #tempDailActivity
Declare @Count10 int  = (Select COUNT(*) from #tempDailActivity)
Declare @i int = 1
Begin
	While(@i <= 1)
	Begin
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 7)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 8)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 9)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 10)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 11)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 13)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 14)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 15)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 16)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 17)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 1)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 3)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 23)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 24)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 25)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 4)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 5)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 6)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 2)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 18)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 21)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 22)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 20)
	
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 12)

	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 20)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 26)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 27)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 28)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 29)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 30)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 31)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 32)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 33)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 34)
	Insert into #tempDailActivityReport (Name,Unit,Quantity)
	(Select Name,Unit,Quantity from #tempDailActivity where Id = 35)
	Set @i = @i + 1
	End
End

Select * from #tempDailActivityReport
Drop table #tempDailActivity,#tempDailActivityReport


GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_DesiccantLog1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_DesiccantLog1] '01/03/2019' , 1
CREATE PROCEDURE [dbo].[usp_rpt_DesiccantLog1]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from DesiccantTag1 where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.DesiccantLog1')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTableDesiccant1') IS NOT NULL DROP TABLE ##TempTableDesiccant1
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from DesiccantTag1 DT where DT.TagNo = Tags and IsDeleted = 0) as DesiccantPlantStatus
		into ##TempTableDesiccant1
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						DesiccantLog1
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from DesiccantTag1 DT where DT.TagNo = Tags and IsDeleted = 0) as DesiccantPlantStatus
		into ##TempTableDesiccant1
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						DesiccantLog1
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableDesiccant1 group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		from
			##TempTableDesiccant1
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_DesiccantLog2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_DesiccantLog2] '21/12/2018' , -1
CREATE PROCEDURE [dbo].[usp_rpt_DesiccantLog2]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from DesiccantTag2 where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.DesiccantLog2')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTableDesiccant2') IS NOT NULL DROP TABLE ##TempTableDesiccant2
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from DesiccantTag2 DT where DT.TagNo = Tags and IsDeleted = 0) as DesiccantPlantStatus
		into ##TempTableDesiccant2
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						DesiccantLog2
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
		CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from DesiccantTag2 DT where DT.TagNo = Tags and IsDeleted = 0) as DesiccantPlantStatus
		into ##TempTableDesiccant2
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						DesiccantLog2
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableDesiccant2 group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		from
			##TempTableDesiccant2
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)

GO
/****** Object:  StoredProcedure [dbo].[Usp_rpt_Dispatch]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [Usp_rpt_Dispatch] '12/27/2020 10:05:05' ,'12/30/2020 15:50:32.657'
CREATE Procedure [dbo].[Usp_rpt_Dispatch]

  @FromDatetime datetime,
  @ToDatetime datetime
 -- @TransferName int,
 -- @Shift int

  As
  begin
    Select ROW_NUMBER() over (order by([Datetime])) n, * into #temp  from [dbo].[TankerDispatch]
   where (StartTrigger1 = 0 ) and [Datetime] between @FromDateTime and @ToDateTime

   declare  @a int =1

   declare @count int= (select COUNT(*) from #temp)

   Create table #tempDispatch(Id int identity(1,1),[Date] Datetime,Shift varchar(50),StartTime varchar(30),StopTime varchar(30),TransferTime varchar(20),TankerId varchar(50),TankerNo varchar(50),
                               Source int,Product int,Chillingtemp float,QtyReceived float,WeighbridgeQty float,EndId int)
while(@a <= @count)
  begin
     if((select StartTrigger1 from #temp where n = @a) = 0)
	 begin
	    declare @ProcessId int = null
		set @ProcessId = (select id from #temp where n= @a)
		declare @tempId int

		select 
		    ROW_NUMBER() over (order by(Id)) [row],* into #Dispatch
		from
		    TankerDispatch
		where 
		    StartTrigger1 in (1,0)
			and [Datetime] between @FromDateTime and @ToDateTime


		declare @row int = null
		declare @previousQuantity int =null
		declare @tempIdrow int = null
		declare @PreviousProcessId int =null
		set @row = (select [row] from #Dispatch where Id = @ProcessId)

		  while((select Id from #Dispatch where StartTrigger1 != 0 and [row] = @row - 1) != 0)
		  begin
		   set @tempId = (select Id from #Dispatch where StartTrigger1 != 0 and  [row] = @row-1)
		  set @row = @row-1
		  end
		  set @tempIdrow = (select [row] from #Dispatch where Id = @tempId)

		  while((select Id from #Dispatch where StartTrigger1 != 1 and [row] = @tempIdrow - 1) != 0)
		  begin
		   set @PreviousProcessId = (select Id from #Dispatch where StartTrigger1 != 1 and  [row] = @tempIdrow-1)
		  set @tempIdrow = @tempIdrow-1
		  end

		  --set @previousQuantity = (select QtyD1 from #Dispatch where Id = @PreviousProcessId)
		select
		    top 1 
			(case when ((select convert(varchar(20),[Datetime],108) from #Dispatch where Id = @tempId) between (select FromTime from Shift where ShiftId =3) and (select ToTime from Shift where ShiftId =3 ))
			     then 'Shift-1'
			     when ((select convert(varchar(20),[Datetime],108) from #Dispatch where Id = @tempId) between (select FromTime from Shift where ShiftId=2 ) and (select ToTime from Shift where ShiftId = 2))
				 then 'Shift-2'
                 when((select convert(varchar(20),[Datetime],108) from #Dispatch where Id = @tempId) between (Select FromTime from Shift where ShiftId = 1) and (Select ToTime from Shift where ShiftId = 1))
				 then 'Shift-3'  
				 end ) as [shift],
				( select [Datetime] from #Dispatch where Id = (select Id from #Dispatch where Id = @tempId)) as [Date], --convert(varchar(20),[Datetime],103)
		     (select convert(varchar(30),[Datetime],108) from #Dispatch where Id = @tempId) as StartTime,
			(select convert(varchar(30),[Datetime],108) from #Dispatch where Id = @ProcessId) as StopTime,
			(select convert(varchar(5),DateDiff(MINUTE, (select top 1 [Datetime] from #Dispatch where id between @tempId and (select Id from #temp where n = @a)), (select top 1 [Datetime] from #Dispatch where id between @tempId and (select Id from #temp where n = @a) order by id desc)))+':'+
									convert(varchar(5),(DateDiff(SECOND, (select top 1 [Datetime] from #Dispatch where id between @tempId and (select Id from #temp where n = @a)), (select top 1 [Datetime] from #Dispatch where id between @tempId and (select Id from #temp where n = @a) order by id desc))%3600%60))) as TransferTime,
             
			  TankerId,
			  TankerNo,
			 Source,
			 Product,
			 DispatchChillingtemp,
			 QtyReceived,
			 WeighbridgeQty,
			(select Id from #Dispatch where Id = @ProcessId) as 'EndId'
		  into
		    #tempProcess
		  from
		    #Dispatch
		 where 
		    Id between @tempId and (select Id from #temp where n = @a)
			Insert into #tempDispatch( Shift ,[Date] ,StartTime ,StopTime,TransferTime,TankerId ,TankerNo ,
                               source ,Product,Chillingtemp,QtyReceived,WeighbridgeQty ,EndId)
						
					(Select * from #tempProcess)

					drop table #tempProcess
					drop table #Dispatch
		
			end

  --    if((select StartTriggerD2 from #temp where n = @a) = 0)
	 --begin
	 --   declare @ProcessId2 int = null
		--set @ProcessId2 = (select id from #temp where n= @a)
		--declare @tempId2 int

		--select 
		--    ROW_NUMBER() over (order by(Id)) [row],* into #Dispatch2
		--from
		--    DispatchUdupi
		--where 
		--    StartTriggerD2 in (1,0)
		--	and DateTime between @FromDateTime and @ToDateTime


		--declare @row2 int = null
		--declare @previousQuantity2 int =null
		--declare @tempIdrow2 int = null
		--declare @PreviousProcessId2 int =null

		--set @row2 = (select [row] from #Dispatch2 where Id = @ProcessId2)

		--  while((select Id from #Dispatch2 where StartTriggerD2 != 0 and [row] = @row2 - 1) != 0)
		--  begin
		--   set @tempId2 = (select Id from #Dispatch2 where StartTriggerD2 != 0 and  [row] = @row2-1)
		--  set @row2 = @row2-1
		--  end

		--    set @tempIdrow2 = (select [row] from #Dispatch2 where Id = @tempId2)

		--  while((select Id from #Dispatch2 where StartTriggerD2 != 1 and [row] = @tempIdrow2 - 1) != 0)
		--  begin
		--   set @PreviousProcessId2 = (select Id from #Dispatch2 where StartTriggerD2 != 1 and  [row] = @tempIdrow2-1)
		--  set @tempIdrow2 = @tempIdrow2-1
		--  end

		--  set @previousQuantity2 = (select QtyD2 from #Dispatch2 where Id = @PreviousProcessId2)
		
		--select
		--    top 1 
		--	(case when ((select convert(varchar(20),[DateTime],108) from #Dispatch2 where Id = @tempId2) between (select FromTime from Shift where ShiftId =3) and (select ToTime from Shift where ShiftId =3 ))
		--	     then 'Shift-1'
		--	     when ((select convert(varchar(20),[DateTime],108) from #Dispatch2 where Id = @tempId2) between (select FromTime from Shift where ShiftId=2 ) and (select ToTime from Shift where ShiftId = 2))
		--		 then 'Shift-2'
  --               when((select convert(varchar(20),[DateTime],108) from #Dispatch2 where Id = @tempId2) between (Select FromTime from Shift where ShiftId = 1) and (Select ToTime from Shift where ShiftId = 1))
		--		 then 'Shift-3'  
		--		 end ) as [shift],
		--		( select [DateTime] from #Dispatch2 where Id = (select Id from #Dispatch2 where Id = @tempId2)) as [Date], --convert(varchar(20),[Datetime],103)
		--     (select [DateTime] from #Dispatch2 where Id = @tempId2) as StartTime,
		--	(select [DateTime] from #Dispatch2 where Id = @ProcessId2) as StopTime,
		--	(select convert(varchar(5),DateDiff(MINUTE, (select top 1 [DateTime] from #Dispatch2 where id between @tempId2 and (select Id from #temp where n = @a)), (select top 1 [DateTime] from #Dispatch2 where id between @tempId2 and (select Id from #temp where n = @a) order by id desc)))+':'+
		--							convert(varchar(5),(DateDiff(SECOND, (select top 1 [DateTime] from #Dispatch2 where id between @tempId2 and (select Id from #temp where n = @a)), (select top 1 [DateTime] from #Dispatch2 where id between @tempId2 and (select Id from #temp where n = @a) order by id desc))%3600%60))) as TransferTime,
             
		--	  TankerIdD2,
		--	  (select VehicleNo from WeighBridge where TankerIdD2 = VehicleId) as 'TankerNo',
		--	 'PMSTToTankerDispatch' as 'TransferName',
		--	  SiloNoD2,
		--	  case when SiloNoD2 = 1001 then 'RMST-01'
		--	       when SiloNoD2 = 1002 then 'RMST-02'
		--		   when SiloNoD2 = 1003 then 'RMST-03'
		--		   when SiloNoD2 = 1004 then 'RMST-04'
		--		   when SiloNoD2 = 1011 then 'PMST-01'
		--		   when SiloNoD2 = 1012 then 'PMST-02'
		--		   when SiloNoD2 = 1013 then 'PMST-03'
		--		  -- wheSiloNoD2T1 = 1014 then ''
		--		   when SiloNoD2 = 1021 then 'Cream Buffer Tank'
		--		   when SiloNoD2 = 1022 then 'Past. Cream Storage-01'
		--		   when SiloNoD2 = 1023 then 'Past. Cream Storage-02'
		--		   when SiloNoD2 = 1024 then 'RMST-01'
		--		   when SiloNoD2 = 1031 then 'Milk HMST-01'
		--		   when SiloNoD2 = 1032 then 'Milk HMST-02'
		--		   when SiloNoD2 = 1033 then 'Milk HMST-03'
		--		   when SiloNoD2 = 1034 then 'Milk HMST-04'
		--		   when SiloNoD2 = 1041 then 'Curd HMST-01'
		--		   when SiloNoD2 = 1042 then 'Curd HMST-02'
		--		   when SiloNoD2 = 1043 then 'Curd HMST-03'
		--		   when SiloNoD2 = 1044 then 'Curd HMST-04'
		--		   when SiloNoD2 = 1045 then 'Curd HMST-05'
		--		   when SiloNoD2 = 1046 then 'Curd HMST-06'
		--		   when SiloNoD2 = 1047 then 'Sugar Storage'
		--		   when SiloNoD2 = 1051 then 'Rinse Milk Recovery'
		--		   when SiloNoD2 = 1052 then 'Rinse Milk Storage'
		--		   when SiloNoD2 = 1101 then 'L1A1A16MP04'
  --                 when SiloNoD2 = 1201 then 'Tanker Dispatch'
		--		   when SiloNoD2 = 1301 then 'L1G1G01BM001'
		--		   when SiloNoD2 = 1401 then 'L1M1M03TK001'
		--		end as 'SiloName',
		--		ProductD2,
		--	  case when ProductD2 =0 then 'Water'
		--	     when ProductD2=1 then 'Raw Milk'
		--		 when ProductD2=11 then 'Past Milk'
		--		 when ProductD2=21 then 'Cream'
		--		 when ProductD2=31 then 'Past Water'
		--		 when ProductD2=41 then 'Curd'
		--		 when ProductD2=51 then 'Sugar'
		--		 when ProductD2=61 then 'Rinse Milk'
		--	end as 'ProductName',
		--	BitD2,
		--	(select case when BitD2 = 1 and StartTriggerD2 = 0 then (select QtyD2 from #Dispatch2 where Id = @ProcessId2) - @previousQuantity2
		--	else
		--	(select (QtyD2) from #Dispatch2 where id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0) end from #Dispatch2 where Id = (select Id from #temp where n = @a)) as 'Quantity',
		--	--(select (QtyD2) from #Dispatch2 where id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0)  as 'Quantity',
		--	--(select NetWeight from WeighBridge where TankerIdD2 = VehicleCode) as 'WeighBridgeQty',
		--	--(select SupplierOT from WeighBridge where TankerIdD2 = VehicleCode) as 'WeighBridgeOT',
		--	--(select SupplierTemp from WeighBridge where TankerIdD2 = VehicleCode) as 'WeighBridgeTemp',
		--	--(select SupplierFat from WeighBridge where TankerIdD2 = VehicleCode) as 'WeighBridgeFat',
		--	--(select SupplierSNF from WeighBridge where TankerIdD2 = VehicleCode) as 'WeighBridgeSNF',
		--	--(select SupplierAcidity from WeighBridge where TankerIdD2 = VehicleCode) as 'WeighBridgeAcidity',
		--	(select isnull(OT,0) from #Dispatch2 where Id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0) as 'OT',
		--	(select isnull(Temp2,0) from #Dispatch2 where Id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0) as 'Temp',
		--	(select isnull(Fat,0) from #Dispatch2 where Id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0) as 'Fat',
		--	(select isnull(SNF,0) from #Dispatch2 where Id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0) as 'SNF',
		--	(select isnull(Acidity,0) from #Dispatch2 where Id between @tempId2 and @ProcessId2 and StartTriggerD2 = 0) as 'Acidity',
		--	(select Id from #Dispatch2 where Id = @ProcessId2) as 'EndId'
		--  into
		--    #tempProcess2
		--  from
		--    #Dispatch2
		-- where 
		--    Id between @tempId2 and (select Id from #temp where n = @a)
		--	Insert into #tempDispatch( Shift ,[Date] ,StartTime ,StopTime,TransferTime,TankerId ,TankerNo ,TransferName ,
  --                             SiloNo ,SiloName ,Product,ProductName,QtyBit,Quantity ,OT ,Temp ,Fat ,SNF ,Acidity ,EndId)
						
		--			(Select * from #tempProcess2)

		--			drop table #tempProcess2
		--			drop table #Dispatch2
		
		--	end
			 set @a=@a+1
  end

  --declare @Transfer varchar(100)
  --declare @ShiftName varchar(50)
  --set @ShiftName = '-1'
  --set @Transfer='-1'
 


--If(@TransferName != '-1' and @Shift  != '-1')
--begin
--    set @Transfer=  ( select Name from DispatchWise a where Id=@TransferName)
--	set @ShiftName = (select Name from Shift where ShiftId = @Shift)
	select 
	
			row_number() OVER (ORDER BY Id) as SrNo,
			Shift ,
			[Date],
			StartTime,
			StopTime,
			TransferTime,
			TankerId ,
			TankerNo ,
			source,
			Product,
			Chillingtemp,
			QtyReceived,
			WeighbridgeQty ,
			EndId
			--EndId
		from #tempDispatch 
		--where TransferName = @Transfer and 
		--      Shift = @ShiftName
		--order by 
		 --[Date], StartTime 
--end

--else If(@TransferName != '-1' and @Shift  = '-1')
--begin
--    set @Transfer=  ( select Name from DispatchWise a where Id=@TransferName )
--	set @ShiftName = (select Name from Shift where ShiftId = @Shift)
--	select 
	
--			row_number() OVER (ORDER BY Id) as SrNo,
--			Shift ,
--			[Date],
--			StartTime,
--			StopTime,
--			TransferTime,
--			TankerId ,
--			TankerNo ,
--			TransferName ,
--            SiloNo ,
--			SiloName ,
--			Product,
--			ProductName,
--			QtyBit,
--			Quantity ,
--			WeighBridgeQty,
--			WeighBridgeOT ,
--			WeighBridgeTemp ,
--			WeighBridgeFat ,
--			WeighBridgeSNF ,
--			WeighBridgeAcidity ,
--			OT ,
--			Temp ,
--			Fat ,
--			SNF ,
--			Acidity ,
--			EndId
--			--EndId
--		from #tempDispatch 
--		where TransferName = @Transfer 
--		order by 
--		  [Date], StartTime 
--end

--else If(@TransferName = '-1' and @Shift  != '-1')
--begin
--    set @Transfer=  ( select Name from DispatchWise a where Id=@TransferName )
--	set @ShiftName = (select Name from Shift where ShiftId = @Shift)
--	select 
	
--			row_number() OVER (ORDER BY Id) as SrNo,
--			Shift ,
--			[Date],
--			StartTime,
--			StopTime,
--			TransferTime,
--			TankerId ,
--			TankerNo ,
--			TransferName ,
--            SiloNo ,
--			SiloName ,
--			Product,
--			ProductName,
--			QtyBit,
--			Quantity ,
--			WeighBridgeQty,
--			WeighBridgeOT ,
--			WeighBridgeTemp ,
--			WeighBridgeFat ,
--			WeighBridgeSNF ,
--			WeighBridgeAcidity ,
--			OT ,
--			Temp ,
--			Fat ,
--			SNF ,
--			Acidity ,
--			EndId
--			--EndId
--		from #tempDispatch 
--		where Shift = @ShiftName
--		order by 
--		  [Date], StartTime 
--end

--else If(@TransferName = '-1' and @Shift  = '-1')
--begin
--    set @Transfer=  ( select Name from DispatchWise a where Id=@TransferName )
--	set @ShiftName = (select Name from Shift where ShiftId = @Shift)
--	select 
	
--			row_number() OVER (ORDER BY Id) as SrNo,
--			Shift ,
--			[Date],
--			StartTime,
--			StopTime,
--			TransferTime,
--			TankerId ,
--			TankerNo ,
--			TransferName ,
--            SiloNo ,
--			SiloName ,
--			Product,
--			ProductName,
--			QtyBit,
--			Quantity ,
--			WeighBridgeQty,
--			WeighBridgeOT ,
--			WeighBridgeTemp ,
--			WeighBridgeFat ,
--			WeighBridgeSNF ,
--			WeighBridgeAcidity ,
--			OT ,
--			Temp ,
--			Fat ,
--			SNF ,
--			Acidity ,
--			EndId
--			--EndId
--		from #tempDispatch 
--		order by 
--		  [Date], StartTime 
--end

-- select * from #tempDispatch
drop table #temp,#tempDispatch
end




GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_DryerDatalog_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_Concfeed_Tankstatus_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

Create  PROCEDURE [dbo].[usp_rpt_DryerDatalog_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin
		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[DateTime],103)Date,
				  convert(varchar(8),M1.[DateTime],108) Time,
				   PlantStatus,
				   cast(M1.AtomiserVibrationMonitoring as decimal (18,2)) as AtomiserVibrationMonitoring,
				   cast(M1.AtomizerRotationalSpeed as decimal (18,2)) as AtomizerRotationalSpeed,
				--  W11T01TankStatus,
				  case when AtomizeroilPressure = 0 then 'NotOk'
				  when AtomizeroilPressure = 1 then 'Ok'end as AtomizeroilPressure,
				   case when AtomizeroilCircuilation = 0 then 'NotOk'
				  when AtomizeroilCircuilation = 1 then 'Ok'end as AtomizeroilCircuilation,
				  Atomizerrunninghour,
				  cast(M1.HomogenizerInletPressure as decimal (18,2)) as HomogenizerInletPressure,
				  cast(M1.HomogenizerFreq as decimal (18,2)) as HomogenizerFreq,
				 cast(M1.HomogenizeroutletPressure as decimal (18,2)) as HomogenizeroutletPressure,
				 cast(M1.DryerfeedFlow as decimal (18,2)) as DryerfeedFlow,
				 cast(M1.DryerFeedTemp as decimal (18,2)) as DryerFeedTemp,
				 cast(M1.AirIntakePressuare as decimal (18,2)) as AirIntakePressuare,
				 cast(M1.DryingChamberVaccum as decimal (18,2)) as DryingChamberVaccum,
				 cast(M1.VibroVacacum as decimal (18,2)) as VibroVacacum,
				 cast(M1.Mainairsupplyflow as decimal (18,2)) as Mainairsupplyflow,
				 cast(M1.SFBFlow as decimal (18,2)) as SFBFlow,
				 cast(M1.VFFlow as decimal (18,2)) as VFFlow,
				 cast(M1.Airdispersertemp as decimal (18,2)) as Airdispersertemp,
				 cast(M1.MozzleCoolingTemp as decimal (18,2)) as MozzleCoolingTemp,
				 cast(M1.Mainairsupplytemp as decimal (18,2)) as Mainairsupplytemp,
				 cast(M1.SFBAirsupplytemp as decimal (18,2)) as SFBAirsupplytemp,
				 cast(M1.Wallsweepairtemp as decimal (18,2)) as Wallsweepairtemp,
				 cast(M1.VF1Airsupplytemp as decimal (18,2)) as VF1Airsupplytemp,
				 cast(M1.VF2Chillingtemp as decimal (18,2)) as VF2Chillingtemp,
				 cast(M1.VF2Heatingtemp as decimal (18,2)) as VF2Heatingtemp,
				 cast(M1.Sifterinlettemp as decimal (18,2)) as Sifterinlettemp,
				 cast(M1.Chamberoutlettemp as decimal (18,2)) as Chamberoutlettemp,
				 cast(M1.VFOutlettemp as decimal (18,2)) as VFOutlettemp,
				  cast(M1.Dryerexhausttemp as decimal (18,2)) as Dryerexhausttemp,
				 cast(M1.SFBDPT as decimal (18,2)) as SFBDPT,
				 cast(M1.Cyclone1dpt as decimal (18,2)) as Cyclone1dpt,
				 cast(M1.RootsBlowerpressure as decimal (18,2)) as RootsBlowerpressure,
				 cast(M1.RootsBlowerTemp as decimal (18,2)) as RootsBlowerTemp,
				 cast(M1.Recoverytankqnt as decimal (18,2)) as Recoverytankqnt
					
	from DryerDataLog M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_DryerPlant]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_DryerPlant] '15/03/2019' , 1
CREATE PROCEDURE [dbo].[usp_rpt_DryerPlant]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from DryerTag where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.SprayDryer')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTable') IS NOT NULL DROP TABLE ##TempTable
IF OBJECT_ID('TEMPDB.dbo.##TempResult') IS NOT NULL DROP TABLE ##TempResult

if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from DryerTag FT where FT.TagNo = Tags and IsDeleted = 0) as DryerPlantStatus
		into ##TempTable
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						SprayDryer
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from DryerTag FT where FT.TagNo = Tags and IsDeleted = 0) as DryerPlantStatus
		into ##TempTable
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						SprayDryer
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTable group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols

----Below Code Without Indexing

--set @query1 
--	= 'Select 
--			*
--		from
--			##TempTable
--		pivot
--		(
--			Avg(Value)
--            for DateTime in (' + @cols + ')
--		) as up1'

--exec(@query1)

-----Indexing------

set @query1 
	= 'Select 
			*
       Into ##TempResult	    
		from
			##TempTable
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

exec(@query1)

select * into #temp from ##TempResult


select a.* from #temp a inner join [dbo].[DryerTag] b
                     on a.TagNos=b.TagNo
where b.IsDeleted=0
order by b.[Index] asc

drop table ##TempResult,#temp

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_EvaporatorLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_EvaporatorLog] '09/10/2020' , -1
CREATE PROCEDURE [dbo].[usp_rpt_EvaporatorLog]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = 1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from EvaporatorTag where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.EvaporatorLog')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve
--- Convert(varchar(8), DateTime, 108) as DateTime,
--- Convert(varchar(8), DateTime, 108) as DateTime,
IF OBJECT_ID('TEMPDB.dbo.##TempTableEvap1') IS NOT NULL DROP TABLE ##TempTableEvap1

IF OBJECT_ID('TEMPDB.dbo.##TempResult') IS NOT NULL DROP TABLE ##TempResult
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from EvaporatorTag FT where FT.TagNo = Tags and IsDeleted = 0) as EvaporatorPlantStatus
		into ##TempTableEvap1
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						EvaporatorLog 
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from EvaporatorTag FT where FT.TagNo = Tags and IsDeleted = 0) as EvaporatorPlantStatus
		into ##TempTableEvap1
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						EvaporatorLog 
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableEvap1 group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
        Into ##TempResult	 
		from
			##TempTableEvap1
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)

select * into #temp from ##TempResult


select a.* from #temp a inner join [dbo].[EvaporatorTag] b
                     on a.TagNos=b.TagNo
where b.IsDeleted=0
order by b.[Index] asc

drop table ##TempResult,#temp

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_EvaporatorLog2]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_EvaporatorLog2] '15/12/2018' , 1
CREATE PROCEDURE [dbo].[usp_rpt_EvaporatorLog2]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	= stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from EvaporatorTag2 where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.EvaporatorLog2')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve
IF OBJECT_ID('TEMPDB.dbo.##TempTableEvap') IS NOT NULL DROP TABLE ##TempTableEvap

IF OBJECT_ID('TEMPDB.dbo.##TempResult') IS NOT NULL DROP TABLE ##TempResult
if(@ShiftId != 3)
Begin

set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from EvaporatorTag2 FT where FT.TagNo = Tags and IsDeleted = 0) as EvaporatorPlantStatus
		into ##TempTableEvap
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						EvaporatorLog2
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
end
else
Begin
	set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from EvaporatorTag2 FT where FT.TagNo = Tags and IsDeleted = 0) as EvaporatorPlantStatus
		into ##TempTableEvap
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						EvaporatorLog2
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + ') )
			)t'
--Select @query
exec(@query)
end



--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableEvap group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
          Into ##TempResult	 
		from
			##TempTableEvap
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)

select * into #temp from ##TempResult


select a.* from #temp a inner join [dbo].[EvaporatorTag2] b
                     on a.TagNos=b.TagNo
where b.IsDeleted=0
order by b.[Index] asc

drop table ##TempResult,#temp

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_InventoryReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_InventoryReport] '24/09/2019' , 3
CREATE PROCEDURE [dbo].[usp_rpt_InventoryReport]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from [InventoryTag] where IsDeleted = 0)
			and c.object_id = OBJECT_ID('[dbo].[InventoryLog]')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTableInventoery') IS NOT NULL DROP TABLE ##TempTableInventoery
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			case when Tags = ''' + 'Dryer' + ''' then (Select Name from DryerPlantStatus where IsDeleted = 0 and PLCValue = value)
			when Tags = ''' + 'Evap-1' + ''' then (Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = value)
			when Tags = ''' + 'Evap-2' + ''' then (Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = value)
			when Tags = ''' + 'FeedLine' + ''' then (Select  Status from [dbo].[FeedLineStatus] where PLCValue = value) 
			else  Convert(varchar(50),Value) end as Value,
			(Select Description from InventoryTag FT where FT.TagNo = Tags and IsDeleted = 0)  as InventoryStatus 
		into ##TempTableInventoery
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						InventoryLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
			Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Tags as TagNos,
			case when Tags = ''' + 'Dryer' + ''' then (Select Name from DryerPlantStatus where IsDeleted = 0 and PLCValue = value)
			when Tags = ''' + 'Evap-1' + ''' then (Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = value)
			when Tags = ''' + 'Evap-2' + ''' then (Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = value)
			  when Tags = ''' + 'FeedLine' + ''' then (Select  Status from [dbo].[FeedLineStatus] where PLCValue = value) 
			else  Convert(varchar(50),Value) end as Value,
			(Select Description from InventoryTag FT where FT.TagNo = Tags and IsDeleted = 0)  as InventoryStatus 
		into ##TempTableInventoery
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						InventoryLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableInventoery group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		from
			##TempTableInventoery
		pivot
		(
			max(Value)
            for DateTime in (' + @cols + ')
		) as up1
		order by TagNos'

--Select @query1

exec(@query1)

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_MassBalanceReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_MassBalanceReport] '07/10/2019'
CREATE procedure [dbo].[usp_rpt_MassBalanceReport]
	@FromDateTime date
AS

declare @ToDateTime datetime = (convert(datetime,@FromDateTime,103) -1)
declare @FromDateTime1 datetime=@FromDateTime
set @FromDateTime = @ToDateTime --- ToDate Value Here
set @ToDateTime=@FromDateTime1  --- FromDate Value Here

Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1
	from [MassBalanceAmul] t 
		 where ([PMST_1_E1_StartTrigger] = 0 or [PMST_2_E1_StartTrigger] = 0 or [PMST_3_E1_StartTrigger] = 0 or [PMST_4_E1_StartTrigger] = 0 or [PMST_1_E2_StartTrigger] = 0 
			or	[PMST_2_E2_StartTrigger] = 0 or [PMST_3_E2_StartTrigger] = 0 or [PMST_4_E2_StartTrigger] = 0 ) 
		 and Convert(date,[Date],103) = Convert(date,@ToDateTime,103)-- and @ToDateTime 
--select * from #temp1

Declare @ShiftName varchar(20) = null
Declare @ProductName varchar(50) = null
declare @a int = 1
declare @count int = (select count(*) from #temp1)

----------------------------------- Create Temp Table --------------------------
Create table #tempProductTreacebility (Id int IDENTITY(1,1),[Date] varchar(10),
								StartTime varchar(8),StopTime varchar(8),[Source] varchar(50),ProcessId int,TotalTime varchar(8),Quantity decimal(18,2),
								Fat varchar(8),SNF varchar(8))
----------------------------------

while (@a <= @count)
begin

	if((Select [PMST_1_E1_StartTrigger] from #temp1 where n = @a) = 0)
	begin
		
			Declare @T1ProcessId int = null
			set @T1ProcessId = (select Id from #temp1 where n = @a)
			Declare @T1tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_1_E1_StartTrigger],[PMST_1_E1_Quantity],Fat,SNF
				into #tmpRowT1 from [MassBalanceAmul] where [PMST_1_E1_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T1Row int = null
			set @T1Row = (Select [row] from #tmpRowT1 where id = @T1ProcessId)

			while ((Select Id from #tmpRowT1 where [PMST_1_E1_StartTrigger] != 0 and [Row] = @T1Row -1) != 0)
			begin
				set @T1tempId = (Select Id from #tmpRowT1 where [PMST_1_E1_StartTrigger] != 0 and [Row] = @T1Row -1)
				set @T1Row = @T1Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT1 where row = @T1Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				'PMST 1 Evap 1' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_1_E1_Quantity] from #tmpRowT1 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_1_E1_Quantity] from #tmpRowT1 where Id = @T1tempId)) as Quantity,
				(Select Fat from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT1
			from 
				#tmpRowT1
			where 
				Id between @T1tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT1)

		drop table #tmpRowT1,#tempT1
	end
	else if((Select [PMST_2_E1_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T2ProcessId int = null
			set @T2ProcessId = (select Id from #temp1 where n = @a)
			Declare @T2tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_2_E1_StartTrigger],[PMST_2_E1_Quantity],Fat,SNF 
			into #tmpRowT2 from [MassBalanceAmul] where [PMST_2_E1_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T2Row int = null
			set @T2Row = (Select [row] from #tmpRowT2 where id = @T2ProcessId)

			while ((Select Id from #tmpRowT2 where [PMST_2_E1_StartTrigger] != 0 and [Row] = @T2Row -1) != 0)
			begin
				set @T2tempId = (Select Id from #tmpRowT2 where [PMST_2_E1_StartTrigger] != 0 and [Row] = @T2Row -1)
				set @T2Row = @T2Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT2 where row = @T2Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType2 from #tmpRowT2 where row = @T1Row) and IsDeleted = 0) as ProductName,
				'PMST 2 Evap 1' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_2_E1_Quantity] from #tmpRowT2 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_2_E1_Quantity] from #tmpRowT2 where Id = @T2tempId)) as Quantity,
				(Select Fat from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT2
			from 
				#tmpRowT2
			where 
				Id between @T2tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT2)

		drop table #tmpRowT2,#tempT2
	end
	else if((Select [PMST_3_E1_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T3ProcessId int = null
			set @T3ProcessId = (select Id from #temp1 where n = @a)
			Declare @T3tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_3_E1_StartTrigger],[PMST_3_E1_Quantity] ,Fat,SNF
			into #tmpRowT3 from [MassBalanceAmul] where [PMST_3_E1_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T3Row int = null
			set @T3Row = (Select [row] from #tmpRowT3 where id = @T3ProcessId)
			
			while ((Select Id from #tmpRowT3 where [PMST_3_E1_StartTrigger] != 0 and [Row] = @T3Row -1) != 0)
			begin
				set @T3tempId = (Select Id from #tmpRowT3 where [PMST_3_E1_StartTrigger] != 0 and [Row] = @T3Row -1)
				set @T3Row = @T3Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT3 where row = @T3Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
				'PMST 3 Evap 1' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_3_E1_Quantity] from #tmpRowT3 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_3_E1_Quantity] from #tmpRowT3 where Id = @T3tempId)) as Quantity,
				(Select Fat from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT3
			from 
				#tmpRowT3
			where 
				Id between @T3tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT3)

		drop table #tmpRowT3,#tempT3
	end
	else if((Select [PMST_4_E1_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T4ProcessId int = null
			set @T4ProcessId = (select Id from #temp1 where n = @a)
			Declare @T4tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_4_E1_StartTrigger],[PMST_4_E1_Quantity],Fat,SNF 
			into #tmpRowT4 from [MassBalanceAmul] where [PMST_4_E1_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T4Row int = null
			set @T4Row = (Select [row] from #tmpRowT4 where id = @T4ProcessId)
			
			while ((Select Id from #tmpRowT4 where [PMST_4_E1_StartTrigger] != 0 and [Row] = @T4Row -1) != 0)
			begin
				set @T4tempId = (Select Id from #tmpRowT4 where [PMST_4_E1_StartTrigger] != 0 and [Row] = @T4Row -1)
				set @T4Row = @T4Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT4 where row = @T4Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT4 where row = @T4Row) and IsDeleted = 0) as ProductName,
				'PMST 4 Evap 1' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_4_E1_Quantity] from #tmpRowT4 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_4_E1_Quantity] from #tmpRowT4 where Id = @T4tempId)) as Quantity,
				(Select Fat from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT4
			from 
				#tmpRowT4
			where 
				Id between @T4tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT4)

		drop table #tmpRowT4,#tempT4
	end
	else if((Select [PMST_1_E2_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T5ProcessId int = null
			set @T5ProcessId = (select Id from #temp1 where n = @a)
			Declare @T5tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_1_E2_StartTrigger],[PMST_1_E2_Quantity],Fat,SNF 
			into #tmpRowT5 from [MassBalanceAmul] where [PMST_1_E2_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T5Row int = null
			set @T5Row = (Select [row] from #tmpRowT5 where id = @T5ProcessId)
			
			while ((Select Id from #tmpRowT5 where [PMST_1_E2_StartTrigger] != 0 and [Row] = @T5Row -1) != 0)
			begin
				set @T5tempId = (Select Id from #tmpRowT5 where [PMST_1_E2_StartTrigger] != 0 and [Row] = @T5Row -1)
				set @T5Row = @T5Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT5 where row = @T5Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT5 where row = @T5Row) and IsDeleted = 0) as ProductName,
				'PMST 1 Evap 2' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_1_E2_Quantity] from #tmpRowT5 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_1_E2_Quantity] from #tmpRowT5 where Id = @T5tempId)) as Quantity,
				(Select Fat from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT5
			from 
				#tmpRowT5
			where 
				Id between @T5tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT5)

		drop table #tmpRowT5,#tempT5
	end
	else if((Select [PMST_2_E2_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T6ProcessId int = null
			set @T6ProcessId = (select Id from #temp1 where n = @a)
			Declare @T6tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_2_E2_StartTrigger],[PMST_2_E2_Quantity],Fat,SNF 
			into #tmpRowT6 from [MassBalanceAmul] where [PMST_2_E2_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T6Row int = null
			set @T6Row = (Select [row] from #tmpRowT6 where id = @T6ProcessId)
			
			while ((Select Id from #tmpRowT6 where [PMST_2_E2_StartTrigger] != 0 and [Row] = @T6Row -1) != 0)
			begin
				set @T6tempId = (Select Id from #tmpRowT6 where [PMST_2_E2_StartTrigger] != 0 and [Row] = @T6Row -1)
				set @T6Row = @T6Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT6 where row = @T6Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT6 where row = @T6Row) and IsDeleted = 0) as ProductName,
				'PMST 2 Evap 2' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_2_E2_Quantity] from #tmpRowT6 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_2_E2_Quantity] from #tmpRowT6 where Id = @T6tempId)) as Quantity,
				(Select Fat from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT6
			from 
				#tmpRowT6
			where 
				Id between @T6tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT6)

		drop table #tmpRowT6,#tempT6
	end
	else if((Select [PMST_3_E2_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T7ProcessId int = null
			set @T7ProcessId = (select Id from #temp1 where n = @a)
			Declare @T7tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_3_E2_StartTrigger],[PMST_3_E2_Quantity],Fat,SNF 
			into #tmpRowT7 from [MassBalanceAmul] where [PMST_3_E2_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T7Row int = null
			set @T7Row = (Select [row] from #tmpRowT7 where id = @T7ProcessId)
			
			while ((Select Id from #tmpRowT7 where [PMST_3_E2_StartTrigger] != 0 and [Row] = @T7Row -1) != 0)
			begin
				set @T7tempId = (Select Id from #tmpRowT7 where [PMST_3_E2_StartTrigger] != 0 and [Row] = @T7Row -1)
				set @T7Row = @T7Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT7 where row = @T7Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT7 where row = @T7Row) and IsDeleted = 0) as ProductName,
				'PMST 3 Evap 2' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_3_E2_Quantity] from #tmpRowT7 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_3_E2_Quantity] from #tmpRowT7 where Id = @T7tempId)) as Quantity,
				(Select Fat from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT7
			from 
				#tmpRowT7
			where 
				Id between @T7tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT7)

		drop table #tmpRowT7,#tempT7
	end
	else if((Select [PMST_4_E2_StartTrigger] from #temp1 where n = @a) = 0)
	begin
			Declare @T8ProcessId int = null
			set @T8ProcessId = (select Id from #temp1 where n = @a)
			Declare @T8tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[PMST_4_E2_StartTrigger],[PMST_4_E2_Quantity],Fat,SNF 
			into #tmpRowT8 from [MassBalanceAmul] where [PMST_4_E2_StartTrigger] in (1,0) and Convert(date,[Date],103) between Convert(date,@FromDateTime,103)  and Convert(date, @ToDateTime,103) 
			Declare @T8Row int = null
			set @T8Row = (Select [row] from #tmpRowT8 where id = @T8ProcessId)
			
			while ((Select Id from #tmpRowT8 where [PMST_4_E2_StartTrigger] != 0 and [Row] = @T8Row -1) != 0)
			begin
				set @T8tempId = (Select Id from #tmpRowT8 where [PMST_4_E2_StartTrigger] != 0 and [Row] = @T8Row -1)
				set @T8Row = @T8Row - 1
			end
			--set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT8 where row = @T8Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT8 where row = @T8Row) and IsDeleted = 0) as ProductName,
				'PMST 4 Evap 2' as [Source],
				(Select ID from #temp1 where n = @a) as ProcessId,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select [PMST_4_E2_Quantity] from #tmpRowT8 where Id = (select Id from #temp1 where n = @a)) - (Select [PMST_4_E2_Quantity] from #tmpRowT8 where Id = @T8tempId)) as Quantity,
				(Select Fat from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as Fat,
				(Select SNF from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as SNF
			into 
				#tempT8
			from 
				#tmpRowT8
			where 
				Id between @T8tempId and (select Id from #temp1 where n = @a)
			group by [Date]
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],[Source],ProcessId,TotalTime,Quantity,Fat,SNF)
			(Select * from #tempT8)

		drop table #tmpRowT8,#tempT8
	end
	
	set @a = @a + 1
end
Declare @TotalPowderQty decimal(18,2) = 0
Set @TotalPowderQty = (Select top 1
							 LEAD(Quantity1,1) Over (Order By Date) - Quantity1     +
						 	LEAD(Quantity2,1) Over (Order By Date)- Quantity2+
							LEAD(Quantity3,1) Over (Order By Date)-  Quantity3 +
							LEAD(Quantity4,1) Over (Order By Date)  - Quantity4 
						from 
							[PowderSiloOpeningClosing] 
						where 
							Convert(date,[Date],103) = Convert(date,@ToDateTime,103))

--Select * from #temp
Declare @ProducuedQuantity float= (Select IsNull(Sum([TotalQuantity]),0)
									from 
										[PackingEntryMaster] 
									where 
										Convert(date,[Date],103) = Convert(date,@ToDateTime,103) and IsDeLeted = 0)

	Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)


--Declare @Count1 int= (Select COUNT(*) from #temp) 
--Declare @a1 int = 1
--While(@a1 <= @Count1)
--Begin
	--Declare @FirstValue decimal(18,2) = 1
	--Declare @SecondValue decimal(18,2) = 1
	--Set @FirstValue = (Select ISnull(Quantity1,0) + ISnull(Quantity2,0) + ISnull(Quantity3,0) + ISnull(Quantity4,0) from #temp where row1 = 1)
	--Set @SecondValue = (Select ISnull(Quantity1,0) + ISnull(Quantity2,0) + ISnull(Quantity3,0) + ISnull(Quantity4,0) from #temp where row1 = 2)

	--Set @TotalPowderQty = @TotalPowderQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
--	Set @a1 = @a1 + 1
--End
	--Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)
--Drop table #temp


--Declare @TotalAvaQty decimal(18,2) = 0

--Select 
--	row_number() OVER (ORDER BY id) as 'row1',*
--into 
--	#temp
--from 
--	PackingMachineMassBalanceAvapack where Convert(date,[DateTime],103) = Convert(date,@FromDateTime,103)

----Select * from #temp
--Declare @Count1 int= (Select COUNT(*) from #temp) 
--Declare @a1 int = 1
--While(@a1 <= @Count1)
--Begin
--	Declare @FirstValue decimal(18,2) = 1
--	Declare @SecondValue decimal(18,2) = 1
--	Set @FirstValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:01.1000000' and '00:00:59.1000000')
--	Set @SecondValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:35.1000000' and '23:59:59.1000000')

--	Set @TotalAvaQty = @TotalAvaQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
--	Set @a1 = @a1 + 1
--End
--	Set @TotalAvaQty = @TotalAvaQty * (Select AvaPackQty from [MassBalancePowderProduction] where IsDeleted = 0) 
--Drop table #temp

--Declare @PreviousBoschQty decimal(18,2) = 0
--Declare @CurrentBoschQty decimal(18,2) = 0
--Declare @TotalBoschQty decimal(18,2) = 0
--Set @PreviousBoschQty = (Select 
--	Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
--from 
--	PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDateTime,103)))


--Set @CurrentBoschQty = (Select 
--	Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
--from 
--	PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) = Convert(date,@FromDateTime,103))

--Set @TotalBoschQty =  @CurrentBoschQty - @PreviousBoschQty

--Declare @PreviousHassiaQty decimal(18,2) = 0
--Declare @CurrentHassiaQty decimal(18,2) = 0
--Declare @TotalHassiaQty decimal(18,2) = 0
--Set @PreviousHassiaQty = (Select 
--	Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0)
--from 
--	PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = DATEADD(DAY,-1,CONVERT(date,@FromDateTime,103)))


--Set @CurrentHassiaQty = (Select 
--	Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0) 
--from 
--	PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = Convert(date,@FromDateTime,103))

--Set @TotalHassiaQty =  @CurrentHassiaQty - @PreviousHassiaQty

--Select @TotalHassiaQty


select 
	Id as SrNo,
	ProcessId,
	[Date],
	StartTime,
	StopTime,
	TotalTime,
	[Source],
	Fat as FAT,
	SNF as SNF,
	Convert(float,Fat) + Convert(float,SNF) as TS,
	Convert(decimal(18,2),(Quantity * (Convert(float,Fat) + Convert(float,SNF))/100)) as TSKG,
	Quantity
from 
	#tempProductTreacebility

select 
	Id,
	[TSReverted],
	[TSToDryer],
	PowderQuantity,
	[TS],
	[RecoveredPowder],
	[TotalPowder],
	[TotalTsPowder],
	[DeltaTSKG],
	[DeltaTS],
	[TotalTS],
	[TotalTSKG],
	[TotalQuantity]
from 
	MassBalance
Where 
	Convert(date,[Date],103) = Convert(date,@ToDateTime,103)

Select @TotalPowderQty as 'PowderQuantity'--ISNULL(@TotalAvaQty,0) + ISNULL(@TotalBoschQty,0) + ISNULL(@TotalHassiaQty,0) as 'PowderQuantity'
drop table #temp1,#tempProductTreacebility




GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_NFwheyStorage_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_NFwheyStorage_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_NFwheyStorage_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when W41T01Typesofwhey = 0 then 'None'
					when W41T01Typesofwhey = 1 then 'Raw Whey'
					when W41T01Typesofwhey =2 then 'Past Whey'
					when W41T01Typesofwhey = 3 then 'Mozzerella Cheese Whey'
					when W41T01Typesofwhey = 4 then 'Panner Whey'
					when W41T01Typesofwhey= 5 then 'Raw Cream'
					when W41T01Typesofwhey= 6 then 'Past. Cream'
					when W41T01Typesofwhey= 7 then 'NF Whey'
					when W41T01Typesofwhey= 8 then 'Permeat Water'
					 end as W41T01Typesofwhey,
				--  W11T01TankStatus,
				  case when W41T01TankStatus = 0 then 'Unclean'
				  when W41T01TankStatus = 1 then 'Clean'end as W41T01TankStatus,
				  cast(M1.W41T01Qty as decimal (18,2)) as W41T01Qty,
				  cast(M1.W41T01Temp as decimal (18,2))as W41T01Temp ,
				  M1.W41T01AgeingTimer,
				  M1.W41T01DirtyTime,
				 case when W42T01Typesofwhey1 = 0 then 'None'
					when W42T01Typesofwhey1 = 1 then 'Raw Whey'
					when W42T01Typesofwhey1 =2 then 'Past Whey'
					when W42T01Typesofwhey1 = 3 then 'Mozzerella Cheese Whey'
					when W42T01Typesofwhey1 = 4 then 'Panner Whey'
					when W42T01Typesofwhey1= 5 then 'Raw Cream'
					when W42T01Typesofwhey1= 6 then 'Past. Cream'
					when W42T01Typesofwhey1= 7 then 'NF Whey'
					when W42T01Typesofwhey1= 8 then 'Permeat Water'
					 end as W42T01Typesofwhey1,
				 -- W12T01TankStatus1,
				  case when W42T01TankStatus1 = 0 then 'Unclean'
				  when W42T01TankStatus1 = 1 then 'Clean'end as  W42T01TankStatus1,
				  cast(M1.W42T01Qty1 as decimal (18,2)) as W42T01Qty1,
				  cast(M1.W42T01Temp1 as decimal (18,2))as W42T01Temp1 ,
				  M1.W42T01AgeingTimer1,
				  M1.W42T01DirtyTime1,
				   case when W43T01Typesofwhey1 = 0 then 'None'
					when W43T01Typesofwhey1 = 1 then 'Raw Whey'
					when W43T01Typesofwhey1 =2 then 'Past Whey'
					when W43T01Typesofwhey1 = 3 then 'Mozzerella Cheese Whey'
					when W43T01Typesofwhey1 = 4 then 'Panner Whey'
					when W43T01Typesofwhey1= 5 then 'Raw Cream'
					when W43T01Typesofwhey1= 6 then 'Past. Cream'
					when W43T01Typesofwhey1= 7 then 'NF Whey'
					when W43T01Typesofwhey1= 8 then 'Permeat Water'
					 end as W43T01Typesofwhey1,
				 -- W12T01TankStatus1,
				  case when W43T01TankStatus1 = 0 then 'Unclean'
				  when W43T01TankStatus1 = 1 then 'Clean'end as  W43T01TankStatus1,
				  cast(M1.W43T01Qty1 as decimal (18,2)) as W43T01Qty1,
				  cast(M1.W43T01Temp1 as decimal (18,2))as W43T01Temp1 ,
				  M1.W43T01AgeingTimer1,
				  M1.W43T01DirtyTime1

				 
						
					
					
	from NFWhey_StorageStatus M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PackingMachineLog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_PackingMachineLog] '07/10/2020' , -1
CREATE PROCEDURE [dbo].[usp_rpt_PackingMachineLog]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '09/03/2019'
--Declare @ShiftId varchar(50) = -1

DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from PackingMachineTag where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.PackingMachineLog') 
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve
IF OBJECT_ID('TEMPDB.dbo.##TempTableAvaPacking') IS NOT NULL DROP TABLE ##TempTableAvaPacking
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Value,
			(Select Description from PackingMachineTag FT where FT.TagNo = Tags and IsDeleted = 0) as PackingMachineStatus
		into ##TempTableAvaPacking
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						PackingMachineLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
			Value,
			(Select Description from PackingMachineTag FT where FT.TagNo = Tags and IsDeleted = 0) as PackingMachineStatus
		into ##TempTableAvaPacking
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						PackingMachineLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

IF OBJECT_ID('TEMPDB.dbo.##TempTablePackingAva') IS NOT NULL DROP TABLE ##TempTablePackingAva
DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableAvaPacking group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		into 
			##TempTablePackingAva
		from
			##TempTableAvaPacking
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)
Select * from ##TempTablePackingAva
-----------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------

--select 'Bosch start from here'

--------

DECLARE @colsUnpivotValveBosch AS NVARCHAR(MAX),
		@queryBosch  AS NVARCHAR(MAX),
		@queryBosch1  AS NVARCHAR(MAX)

	select @colsUnpivotValveBosch 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from PackingMachineBoschTag where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.PackingMachineBosch') 
			for xml path('')), 1, 1, '')

	--Select @colsUnpivotValve

Select
			Id,
			LEAD(DateTime,1) Over (Order By Id) as DateTime,

			abs( LEAD(Tag1,1) Over (Order By DateTime) - Tag1  ) as Tag1,
			abs(LEAD(Tag1EmptyBags,1) Over (Order By DateTime) - Tag1EmptyBags ) as Tag1EmptyBags,
			abs( Tag1Speed ) as Tag1Speed,

			abs( LEAD(Tag2,1) Over (Order By DateTime) - Tag2) as Tag2,
			abs( LEAD(Tag2EmptyBags,1) Over (Order By DateTime) - Tag2EmptyBags ) as Tag2EmptyBags,
			abs(Tag2Speed ) as Tag2Speed,

			abs(LEAD(Tag3,1) Over (Order By DateTime) - Tag3 )as Tag3,
			abs(LEAD(Tag3EmptyBags,1) Over (Order By DateTime) - Tag3EmptyBags)  as Tag3EmptyBags,
			abs(Tag3Speed ) as Tag3Speed,

			abs( LEAD(Tag4,1) Over (Order By DateTime) - Tag4) as Tag4,
			abs(LEAD(Tag4EmptyBags,1) Over (Order By DateTime) - Tag4EmptyBags)  as Tag4EmptyBags,
			abs(Tag4Speed ) as Tag4Speed,

			abs(LEAD(Tag5,1) Over (Order By DateTime) - Tag5 ) as Tag5,
			abs(LEAD(Tag5EmptyBags,1) Over (Order By DateTime) - Tag5EmptyBags ) as Tag5EmptyBags,
			abs(Tag5Speed ) as Tag5Speed,

			abs(LEAD(Tag6,1) Over (Order By DateTime) - Tag6) as Tag6,
			abs(LEAD(Tag6EmptyBags,1) Over (Order By DateTime) - Tag6EmptyBags ) as Tag6EmptyBags,
			abs(Tag6Speed ) as Tag6Speed,

			abs(LEAD(Tag7,1) Over (Order By DateTime) - Tag7 ) as Tag7,
			abs(LEAD(Tag7EmptyBags,1) Over (Order By DateTime) - Tag7EmptyBags)  as Tag7EmptyBags,
			abs(Tag7Speed)  as Tag7Speed,

			abs(LEAD( isnull(Tag8,0),1) Over (Order By DateTime) - isnull(Tag8,0) ) as Tag8,
			abs(LEAD(Tag8EmptyBags,1) Over (Order By DateTime) - Tag8EmptyBags ) as Tag8EmptyBags,
			abs(Tag8Speed ) as Tag8Speed,

			abs(LEAD(isnull(Tag9,0),1) Over (Order By DateTime) - isnull(Tag9,0)) as Tag9,
			abs(LEAD(Tag9EmptyBags,1) Over (Order By DateTime) - Tag9EmptyBags ) as Tag9EmptyBags,
			abs(Tag9Speed ) as Tag9Speed,

			abs(LEAD(isnull(Tag10,0),1) Over (Order By DateTime) - isnull(Tag10,0) ) as Tag10,
			abs(LEAD(Tag10EmptyBags,1) Over (Order By DateTime) - Tag10EmptyBags ) as Tag10EmptyBags,
			abs(Tag10Speed  )as Tag10Speed,

		    abs(LEAD(isnull(Tag11,0),1) Over (Order By DateTime) - isnull(Tag11,0) ) as Tag11,
			abs(LEAD(Tag11EmptyBags,1) Over (Order By DateTime) - Tag11EmptyBags ) as Tag11EmptyBags,
			abs(Tag11Speed ) as Tag11Speed,

		   abs(	LEAD(isnull(Tag12,0),1) Over (Order By DateTime) - isnull(Tag12,0) )as Tag12,
			abs(LEAD(Tag12EmptyBags,1) Over (Order By DateTime) - Tag12EmptyBags ) as Tag12EmptyBags,
			abs(Tag12Speed ) as Tag12Speed,

			abs(LEAD(isnull(Tag13,0),1) Over (Order By DateTime) - isnull(Tag13,0) ) as Tag13,
			abs( LEAD(Tag13EmptyBags,1) Over (Order By DateTime) - Tag13EmptyBags  )as Tag13EmptyBags,
			abs( Tag13Speed ) as Tag13Speed,

			abs(LEAD(isnull(Tag14,0),1) Over (Order By DateTime) - isnull(Tag14,0) )as Tag14,
			abs( LEAD(Tag14EmptyBags,1) Over (Order By DateTime) - Tag14EmptyBags )  as Tag14EmptyBags,
			abs( Tag14Speed )  as Tag14Speed,

			 abs( LEAD(isnull(Tag15,0),1) Over (Order By DateTime) - isnull(Tag15,0) )  as Tag15,
			abs(LEAD(Tag15EmptyBags,1) Over (Order By DateTime) - Tag15EmptyBags )  as Tag15EmptyBags,
			abs(Tag15Speed  ) as Tag15Speed,

			IsNull(LEAD(Hassia,1) Over (Order By DateTime),0) - IsNull(Hassia,0) as Hassia,
			IsNull(LEAD(Xpert,1) Over (Order By DateTime),0) - IsNull(Xpert,0) as Xpert
		into 
			#temp
		from
			PackingMachineBosch
		where
				Convert(date, DateTime, 103) = Convert(date, @FromDate, 103)
				--and (@ShiftId = -1.0)
					--or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = @ShiftId) and (Select ToTime from Shift where ShiftId = @ShiftId))

--Select * from #temp
Declare @Count int = (Select COUNT(*) from #temp)
IF OBJECT_ID('TEMPDB.dbo.##TempTablePacking') IS NOT NULL DROP TABLE ##TempTablePacking
IF OBJECT_ID('TEMPDB.dbo.##TempTableBoschPacking') IS NOT NULL DROP TABLE ##TempTableBoschPacking
if(@Count > 0)
	Begin

	if(@ShiftId != 3)
	Begin
	
		--Select 1
	set @queryBosch 
		  = 'Select 
				CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
				ISNULL(Value,0) as Value,
				(Select Description from PackingMachineBoschTag FT where FT.TagNo = Tags and IsDeleted = 0) as PackingMachineStatus
			into ##TempTablePacking
			from
				(select 
						Id,
						DateTime, 
						Tags, 
						Round(Value,2) as Value
					from
					(
						Select 
							*
						from
							#temp
					) as cp
					unpivot
					(
						Value for Tags in (' + @colsUnpivotValveBosch + ')
					) as up1
				where
					Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
					and (' + @ShiftId + ' = -1.0
					or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
				)t'
	--Select @query
	exec(@queryBosch)
	End
	Else
	Begin
		set @queryBosch 
		  = 'Select 
				CONCAT((Convert(varchar(6), DateTime, 108)),0,0) as DateTime,
				Value,
				(Select Description from PackingMachineTag FT where FT.TagNo = Tags and IsDeleted = 0) as PackingMachineStatus
			into ##TempTablePacking
			from
				(select 
						Id,
						DateTime, 
						Tags, 
						Round(Value,2) as Value
					from
					(
						Select 
							*
						from
							#temp
					) as cp
					unpivot
					(
						Value for Tags in (' + @colsUnpivotValveBosch + ')
					) as up1
				where
					Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
					and (' + @ShiftId + ' = -1.0
					or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
					or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
				)t'
	--Select @queryBosch
	exec(@queryBosch)
	End

----Insert into #temp1 (Description) values(@query)

----Select * from #temp1
--Select * from ##TempTablePacking
Declare @a int = (Select COUNT(*) from ##TempTablePacking)
if(@a>0)
Begin
	DECLARE @cols1 AS NVARCHAR(MAX)
	SELECT @cols1 = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
						FROM ##TempTablePacking group by DateTime
				FOR XML PATH(''), TYPE
				).value('.', 'NVARCHAR(MAX)') 
			,1,1,'')
	--Select @cols
	set @queryBosch1 
		= 'Select 
				*
			into
				##TempTableBoschPacking
			from
				##TempTablePacking
			pivot
			(
				Avg(Value)
				for DateTime in (' + @cols1 + ')
			) as up1'

	--Select @query1

	exec(@queryBosch1)
	Select 1 as Count
	Select * into #temp1 from ##TempTableBoschPacking a   -- into #temp1
	
	select a.* from #temp1 a inner join [dbo].[PackingMachineBoschTag] PBT on a.PackingMachineStatus = pbt.[Description] where pbt.IsDeleted=0 order by PBT.[Index] asc
	 ---order by PackingMachineStatus asc
End
Else
Begin
	Select 2 as Count
End
End

Drop Table #temp,#temp1

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PackingMachineLog1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_PackingMachineLog] '15/12/2018' , 1
CREATE PROCEDURE [dbo].[usp_rpt_PackingMachineLog1]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and C.name in (Select TagNo from PackingMachineTag where IsDeleted = 0)
			and c.object_id = OBJECT_ID('dbo.PackingMachineLog') 
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve
IF OBJECT_ID('TEMPDB.dbo.##TempTablePacking') IS NOT NULL DROP TABLE ##TempTablePacking
if(@ShiftId != 3)
Begin
set @query 
	  = 'Select 
			
			Convert(varchar(8), DateTime, 108) as DateTime,
			
			Value,
			(Select Description from PackingMachineTag FT where FT.TagNo = Tags and IsDeleted = 0) as PackingMachineStatus
		into ##TempTablePacking
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						PackingMachineLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
End
Else
Begin
	set @query 
	  = 'Select 
			
			Convert(varchar(8), DateTime, 108) as DateTime,
			
			Value,
			(Select Description from PackingMachineTag FT where FT.TagNo = Tags and IsDeleted = 0) as PackingMachineStatus
		into ##TempTablePacking
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Round(Value,2) as Value
				from
				(
					Select 
						*
					from
						PackingMachineLog
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and ''23:59:59''
				or Convert(time, DateTime, 108) between ''00:00:00'' and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
exec(@query)
End

--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTablePacking group by DateTime
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		from
			##TempTablePacking
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PastwheyStorage_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_PastwheyStorage_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_PastwheyStorage_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when W21T01TypesofMilk = 0 then 'None'
					when W21T01TypesofMilk = 1 then 'Raw Whey'
					when W21T01TypesofMilk =2 then 'Past Whey'
					when W21T01TypesofMilk = 3 then 'Mozzerella Cheese Whey'
					when W21T01TypesofMilk = 4 then 'Panner Whey'
					when W21T01TypesofMilk= 5 then 'Raw Cream'
					when W21T01TypesofMilk= 6 then 'Past. Cream'
					when W21T01TypesofMilk= 7 then 'NF Whey'
					when W21T01TypesofMilk= 8 then 'Permeat Water'
					 end as W21T01TypesofMilk,
				--  W11T01TankStatus,
				  case when W21T01TankStatus = 0 then 'Unclean'
				  when W21T01TankStatus = 1 then 'Clean'end as W21T01TankStatus,
				  cast(M1.W21T01Qty as decimal (18,2)) as W21T01Qty,
				  cast(M1.W21T01Temp as decimal (18,2))as W21T01Temp ,
				  M1.W21T01AgeingTimer,
				  M1.W21T01DirtyTime,
				 case when W22T01TypesofMilk1 = 0 then 'None'
					when W22T01TypesofMilk1 = 1 then 'Raw Whey'
					when W22T01TypesofMilk1 =2 then 'Past Whey'
					when W22T01TypesofMilk1 = 3 then 'Mozzerella Cheese Whey'
					when W22T01TypesofMilk1 = 4 then 'Panner Whey'
					when W22T01TypesofMilk1= 5 then 'Raw Cream'
					when W22T01TypesofMilk1= 6 then 'Past. Cream'
					when W22T01TypesofMilk1= 7 then 'NF Whey'
					when W22T01TypesofMilk1= 8 then 'Permeat Water'
					 end as W22T01TypesofMilk1,
				 -- W12T01TankStatus1,
				  case when W22T01TankStatus1 = 0 then 'Unclean'
				  when W22T01TankStatus1 = 1 then 'Clean'end as  W22T01TankStatus1,
				  cast(M1.W22T01Qty1 as decimal (18,2)) as W22T01Qty1,
				  cast(M1.W22T01Temp1 as decimal (18,2))as W22T01Temp1 ,
				  M1.W22T01AgeingTimer1,
				  M1.W22T01DirtyTime1

				 
						
					
					
	from PastWhey_StorageStatus M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PCIPLOGReport_New]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_PCIPLOGReport_New] '12/08/2020  12:35:11','12/08/2022 20:30:17'
CREATE procedure [dbo].[usp_rpt_PCIPLOGReport_New]
	@FromDateTime datetime,
	@ToDateTime datetime
AS

Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1 
	from PCIPLog t 
		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0  or StartTriggerT3 = 0) and [Date] between @FromDateTime and @ToDateTime
		  

 --select '#temp1'
 -- select * from #temp1

declare @a int = 1
declare @count int = (select count(*) from #temp1)
--select @count
--drop table #temp1 

Create table #tmpPCIPLOGReport (Id int IDENTITY(1,1),[Date] varchar(10),StartTime varchar(8),StopTime varchar(8),TotalTimeInPCIP varchar(8),
								[LineNo] varchar(10), ReceipeNo varchar(10),RouteNo int,RouteName varchar(50) ,Flow decimal(18,2),
								PreRinseStepTime decimal(18,2), PreRinseEffectiveCircuilationTime decimal(18,2),PreConductivity decimal(18,2),
								LYEStepTime decimal(18,2),LyeEffectiveCircuilationTime int,LYEReturnTemp decimal(18,2),LYEReturnCond decimal(18,2),
								ACIDStepTime decimal(18,2),AcidEffectiveCircuilationTime int,ACIDReturnTemp decimal(18,2), ACIDReturnCond decimal(18,2),
								INTERMEDIATEStepTime decimal(18,2),INTERMEDIATEEffectiveCircuilationTime int,INTERMEDIATEReturnTemp decimal(18,2),INTERMEDIATEReturnCond decimal(18,2),
								FINALStepTime decimal(18,2), FinalEffectiveCircuilationTime int,FINALReturnTemp decimal(18,2),FINALReturnCond decimal(18,2),
								STERILIZATIONStepTime decimal(18,2),STERILIZATIONEffectiveCircuilationTime int,STERILIZATIONReturnTemp decimal(18,2),STERILIZATIONReturnCond decimal(18,2),[Status] varchar(8))
								

while (@a <= @count)
begin

	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId int = null
			set @ProcessId = (select Id from #temp1 where n = @a)
			Declare @tempId int
		
			Select 
				row_number() OVER (ORDER BY id) [row],* into #tempPCIPLOGReport 
			from 
				PCIPLog 
			where 
				StartTriggerT1 in (1,0) 
				and [Date] between @FromDateTime and @ToDateTime 

	--select 'TempData'
 --      select * from #tempPCIPLOGReport

			--select * from #tmpCreamRow
			Declare @Row int = null
			set @Row = (Select [row] from #tempPCIPLOGReport where id = @ProcessId)
			--select @Row

			while ((Select Id from #tempPCIPLOGReport where StartTriggerT1 != 0 and [Row] = @Row -1) != 0)
			begin
					set @tempId = (Select Id from #tempPCIPLOGReport where StartTriggerT1 != 0 and [Row] = @Row -1)
					set @Row = @Row - 1
			end
  -- PID and TID
			--select @tempId as tid,@ProcessId as pid
--- Fetching Subtrigger Values
      declare @FlagLyeTrigger1 int=0,@FlagAcidTrigger1 int=0,@FlagIntermediateTrigger1 int=0,@FlagFinalTrigger1 int=0,@FlagSterilizationTrigger1 int=0,
			  @FlagPreRinseTrigger1 int = 0, @FlagRinsewithRecWaterTrigger1 int = 0

			set @FlagLyeTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1  )
			set @FlagAcidTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1  )
			set @FlagIntermediateTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1  )
			set @FlagFinalTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1  )
			set @FlagSterilizationTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1  )
			set @FlagPreRinseTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1  )
			set @FlagRinsewithRecWaterTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and RinsewithRecWaterTrigger1=1  )
	    --Total Count For SUbtrigger Found
			--select @FlagLyeTrigger1 as '@FlagLyeTrigger',@FlagAcidTrigger1 as '@FlagAcidTrigger1',@FlagIntermediateTrigger1 as '@FlagIntermediateTrigger1', @FlagFinalTrigger1 as '@FlagFinalTrigger1',@FlagSterilizationTrigger1 as '@FlagSterilizationTrigger1',@FlagSenitizationTrigger1 as '@FlagSenizationTrigger1'

--  Start Trigger-1 If Condition
			
			if(@FlagLyeTrigger1 >0 or @FlagAcidTrigger1 >0 or @FlagIntermediateTrigger1 >0 or @FlagFinalTrigger1 > 0 or @FlagSterilizationTrigger1 >0 
					or @FlagPreRinseTrigger1 >0 or @FlagRinsewithRecWaterTrigger1 >0 )
			begin
					Select 
						top 1 
						--convert(time,[Date],109) as StartTime,
						(select top 1 (convert(time,[Date],109)) from #tempPCIPLOGReport where Id = @tempId) as StartTime,
						(Select convert(time,[Date],109) from #tempPCIPLOGReport where id = @ProcessId) as StopTime,
						(Select convert(varchar(10),[Date],103) from #tempPCIPLOGReport where id = (select Id from #tempPCIPLOGReport where Id = @tempId)) as [Date],
						(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
									convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
									convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInPCIP,
						'C3F1'as LineNumber,
						--TankerNo,
						--(Select top 1 R.RouteName from Routes R inner join #tempPCIPLOGReport tmpcip  on R.PLCValue = tmpcip.RouteNo) as 'RouteName' ,
						RouteNo,
						case when RouteNo = 0 then 'None' 
						when RouteNo = 1 then 'C11T01' 
						when RouteNo = 2 then 'C12T01' 
						when RouteNo = 3 then 'C13T01' 
						when RouteNo = 4 then 'C14T01' 
						when RouteNo = 5 then 'Dryer Wet Cleaning' end as RouteName,
						
						 RecipeNo,
						Flow,
-------------------------------------------------------------------------------------------------------------------------------------------
						
						case when( @FlagPreRinseTrigger1 >= 1)
						then
							(select top 1 (PreRinseStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1 )
						else
			      			0
						end as 'PreRinseStepTime'	, 

						case when( @FlagPreRinseTrigger1 >= 1)
						then
							(select top 1 ([PreRinseEffectiveCircuilationTime]) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1 )
						else
			      			0
						end as 'Effective Circulation time (Program Time)'	, 

						
						case when( @FlagPreRinseTrigger1 >= 1)
						then
							(select top 1  max(PreConductivity) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1 )
						else
			      			0
						end as 'PreReturnCond',

--------------------------------------------------------------------------------------------------------------------------------------------------------------
						--case when( @FlagRinsewithRecWaterTrigger1 >= 1)
						--then
						--	(select top 1 (RinseWithRecWaterStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and RinsewithRecWaterTrigger1=1 )
						--else
			   --   			0
						--end as 'RinseWithRecWaterStepTime'	, 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1 (LYEStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LYEStepTime'	, 

						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1 (LyeEffectiveCircuilationTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LyeEffectiveCircuilationTime'	, 

						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1 (LYEReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LYEReturnTemp'	, 

						
						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1  max(LYEReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LYEReturnCond'	, 

-------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDStepTime'	, 
						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (AcidEffectiveCircuilationTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'AcidEffectiveCircuilationTime', 

						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDReturnTemp'	, 

						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDReturnCond'	, 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEStepTime'	,

							case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEEffectiveCircuilationTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEEffectiveCircuilationTime'	,

							case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnTemp'	,

						case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnCond'	,
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
					case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALStepTime'	,

						case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FinalEffectiveCircuilationTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FinalEffectiveCircuilationTime'	,

						case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALReturnTemp',

						case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALReturnCond'	,

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONStepTime'	,

						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONEffectiveCircuilationTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONEffectiveCircuilationTime' ,

						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONReturnTemp',

						
						
						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONReturncond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONReturncond',

						


						--case when( @FlagSterilizationTrigger1 >= 1)
						--then
						--case when ((select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 ) !=0)
						--then
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 )
						--else
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId  and STERILIZATIONTempSP>=80 )
						--	end
						--else
			   --   			0
						--end as 'STERILIZATIONReturnTemp'	,

						--STERILIZATIONStepTime,
						--STERILIZATIONTempSP,
						--STERILIZATIONReturnTemp,



						--SANITIZATIONStepTime,

						(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempPCIPLOGReport where id = (select Id from #temp1 where n = @a)) as [Status]
					into 
						#tempProcess
					from 
						#tempPCIPLOGReport
					where 
						Id between @tempId and (select Id from #temp1 where n = @a)
			
					--select * from #tempProcess

					

					Insert into #tmpPCIPLOGReport 
						(StartTime,StopTime,[Date],TotalTimeInPCIP,
						[LineNo],RouteNo,RouteName,ReceipeNo,Flow,PreRinseStepTime,PreRinseEffectiveCircuilationTime,PreConductivity,
						LYEStepTime,LyeEffectiveCircuilationTime,LYEReturnTemp,LYEReturnCond,
						ACIDStepTime,AcidEffectiveCircuilationTime, ACIDReturnTemp,ACIDReturnCond,
						INTERMEDIATEStepTime,INTERMEDIATEEffectiveCircuilationTime,INTERMEDIATEReturnTemp,INTERMEDIATEReturnCond,
						FINALStepTime,FinalEffectiveCircuilationTime,FINALReturnTemp,FINALReturnCond,
						STERILIZATIONStepTime,STERILIZATIONEffectiveCircuilationTime,STERILIZATIONReturnTemp,STERILIZATIONReturnCond,[Status])
					(Select * from #tempProcess)

					drop table #tempProcess
		 
			end

			drop table #tempPCIPLOGReport

	end

		if((Select StartTriggerT2 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId1 int = null
			set @ProcessId1= (select Id from #temp1 where n = @a)
			Declare @tempId1 int
		
			Select 
				row_number() OVER (ORDER BY id) [row1],* into #tempPCIPLOGReport1 
			from 
				PCIPLog 
			where 
				StartTriggerT2 in (1,0) 
				and [Date] between @FromDateTime and @ToDateTime 

	--select 'TempData'
 --      select * from #tempPCIPLOGReport

			--select * from #tmpCreamRow
			Declare @Row1 int = null
			set @Row1 = (Select [row1] from #tempPCIPLOGReport1 where id = @ProcessId1)
			--select @Row

			while ((Select Id from #tempPCIPLOGReport1 where StartTriggerT2 != 0 and [Row1] = @Row1 -1) != 0)
			begin
					set @tempId1= (Select Id from #tempPCIPLOGReport1 where StartTriggerT2 != 0 and [Row1] = @Row1 -1)
					set @Row1 = @Row1 - 1
			end
  -- PID and TID
			--select @tempId as tid,@ProcessId as pid
--- Fetching Subtrigger Values
      declare @FlagLyeTrigger2 int=0,@FlagAcidTrigger2 int=0,@FlagIntermediateTrigger2 int=0,@FlagFinalTrigger2 int=0,@FlagSterilizationTrigger2 int=0,
			  @FlagPreRinseTrigger2 int = 0, @FlagRinsewithRecWaterTrigger2 int = 0

			set @FlagLyeTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and LyeTrigger2=1  )
			set @FlagAcidTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and AcidTrigger2=1  )
			set @FlagIntermediateTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and IntermediateTrigger2=1  )
			set @FlagFinalTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and FinalTrigger2=1  )
			set @FlagSterilizationTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and SterilizationTrigger2=1  )
			set @FlagPreRinseTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and PreRinseTrigger2=1  )
			set @FlagRinsewithRecWaterTrigger2=(select count(*) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and RinsewithRecWaterTrigger2=1  )
	    --Total Count For SUbtrigger Found
			--select @FlagLyeTrigger1 as '@FlagLyeTrigger',@FlagAcidTrigger1 as '@FlagAcidTrigger1',@FlagIntermediateTrigger1 as '@FlagIntermediateTrigger1', @FlagFinalTrigger1 as '@FlagFinalTrigger1',@FlagSterilizationTrigger1 as '@FlagSterilizationTrigger1',@FlagSenitizationTrigger1 as '@FlagSenizationTrigger1'

--  Start Trigger-1 If Condition
			
			if(@FlagLyeTrigger2 >0 or @FlagAcidTrigger2 >0 or @FlagIntermediateTrigger2 >0 or @FlagFinalTrigger2 > 0 or @FlagSterilizationTrigger2 >0 
					or @FlagPreRinseTrigger2 >0 or @FlagRinsewithRecWaterTrigger2 >0 )
			begin
					Select 
						top 1 
						--convert(time,[Date],109) as StartTime,
						(select top 1 (convert(time,[Date],109)) from #tempPCIPLOGReport1 where Id = @tempId1) as StartTime,
						(Select convert(time,[Date],109) from #tempPCIPLOGReport1 where id = @ProcessId1) as StopTime,
						(Select convert(varchar(10),[Date],103) from #tempPCIPLOGReport1 where id = (select Id from #tempPCIPLOGReport1 where Id = @tempId1)) as [Date],
						(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
									convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
									convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport1 where id between @tempId1 and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInPCIP,
						'C3F2'as LineNumber,
						--TankerNo,
						--(Select top 1 R.RouteName from Routes R inner join #tempPCIPLOGReport tmpcip  on R.PLCValue = tmpcip.RouteNo) as 'RouteName' ,
						RouteNo,
						case when RouteNo = 0 then 'None' 
						when RouteNo = 1 then 'C11T01' 
						when RouteNo = 2 then 'C12T01' 
						when RouteNo = 3 then 'C13T01' 
						when RouteNo = 4 then 'C14T01' 
						when RouteNo = 5 then 'Dryer Wet Cleaning' end as RouteName,
						
						 RecipeNo,
						Flow,
-------------------------------------------------------------------------------------------------------------------------------------------
						
						case when( @FlagPreRinseTrigger2 >= 1)
						then
							(select top 1 (PreRinseStepTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and PreRinseTrigger2=1 )
						else
			      			0
						end as 'PreRinseStepTime'	, 

						case when( @FlagPreRinseTrigger2 >= 1)
						then
							(select top 1 ([PreRinseEffectiveCircuilationTime]) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and PreRinseTrigger2=1 )
						else
			      			0
						end as 'Effective Circulation time (Program Time)'	, 

						
						case when( @FlagPreRinseTrigger2 >= 1)
						then
							(select top 1  max(PreConductivity) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and PreRinseTrigger2=1 )
						else
			      			0
						end as 'PreReturnCond',

--------------------------------------------------------------------------------------------------------------------------------------------------------------
						--case when( @FlagRinsewithRecWaterTrigger1 >= 1)
						--then
						--	(select top 1 (RinseWithRecWaterStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and RinsewithRecWaterTrigger1=1 )
						--else
			   --   			0
						--end as 'RinseWithRecWaterStepTime'	, 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


						case when( @FlagLyeTrigger2 >= 1)
						then
							(select top 1 (LYEStepTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and LyeTrigger2=1 )
						else
			      			0
						end as 'LYEStepTime'	, 

						case when( @FlagLyeTrigger2 >= 1)
						then
							(select top 1 (LyeEffectiveCircuilationTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and LyeTrigger2=1 )
						else
			      			0
						end as 'LyeEffectiveCircuilationTime'	, 

						case when( @FlagLyeTrigger2 >= 1)
						then
							(select top 1 (LYEReturnTemp) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and LyeTrigger2=1 )
						else
			      			0
						end as 'LYEReturnTemp'	, 

						
						case when( @FlagLyeTrigger2 >= 1)
						then
							(select top 1  max(LYEReturnCond) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and LyeTrigger2=1 )
						else
			      			0
						end as 'LYEReturnCond'	, 

-------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagAcidTrigger2 >= 1)
						then
							(select top 1 (ACIDStepTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and AcidTrigger2=1 )
						else
			      			0
						end as 'ACIDStepTime'	, 
						case when( @FlagAcidTrigger2 >= 1)
						then
							(select top 1 (AcidEffectiveCircuilationTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and AcidTrigger2=1 )
						else
			      			0
						end as 'AcidEffectiveCircuilationTime', 

						case when( @FlagAcidTrigger2 >= 1)
						then
							(select top 1 (ACIDReturnTemp) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and AcidTrigger2=1 )
						else
			      			0
						end as 'ACIDReturnTemp'	, 

						case when( @FlagAcidTrigger2 >= 1)
						then
							(select top 1 (ACIDReturnCond) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and AcidTrigger2=1 )
						else
			      			0
						end as 'ACIDReturnCond'	, 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagIntermediateTrigger2 >= 1)
						then
							(select top 1 (INTERMEDIATEStepTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and IntermediateTrigger2=1 )
						else
			      			0
						end as 'INTERMEDIATEStepTime'	,

							case when( @FlagIntermediateTrigger2 >= 1)
						then
							(select top 1 (INTERMEDIATEEffectiveCircuilationTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and IntermediateTrigger2=1 )
						else
			      			0
						end as 'INTERMEDIATEEffectiveCircuilationTime'	,

							case when( @FlagIntermediateTrigger2 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnTemp) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and IntermediateTrigger2=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnTemp'	,

						case when( @FlagIntermediateTrigger2 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnCond) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and IntermediateTrigger2=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnCond'	,
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
					case when( @FlagFinalTrigger2 >= 1)
						then
							(select top 1 (FINALStepTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and FinalTrigger2=1 )
						else
			      			0
						end as 'FINALStepTime'	,

						case when( @FlagFinalTrigger2 >= 1)
						then
							(select top 1 (FinalEffectiveCircuilationTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and FinalTrigger2=1 )
						else
			      			0
						end as 'FinalEffectiveCircuilationTime'	,

						case when( @FlagFinalTrigger2 >= 1)
						then
							(select top 1 (FINALReturnTemp) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and FinalTrigger2=1 )
						else
			      			0
						end as 'FINALReturnTemp',

						case when( @FlagFinalTrigger2 >= 1)
						then
							(select top 1 (FINALReturnCond) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and FinalTrigger2=1 )
						else
			      			0
						end as 'FINALReturnCond'	,

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagSterilizationTrigger2 >= 1)
						then
							(select top 1 (STERILIZATIONStepTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and SterilizationTrigger2=1 )
						else
			      			0
						end as 'STERILIZATIONStepTime'	,

						case when( @FlagSterilizationTrigger2 >= 1)
						then
							(select top 1 (STERILIZATIONEffectiveCircuilationTime) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and SterilizationTrigger2=1 )
						else
			      			0
						end as 'STERILIZATIONEffectiveCircuilationTime' ,

						case when( @FlagSterilizationTrigger2 >= 1)
						then
							(select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and SterilizationTrigger2=1 )
						else
			      			0
						end as 'STERILIZATIONReturnTemp',

						
						
						case when( @FlagSterilizationTrigger2 >= 1)
						then
							(select top 1 (STERILIZATIONReturncond) from #tempPCIPLOGReport1 where Id between @tempId1 and @ProcessId1 and SterilizationTrigger2=1 )
						else
			      			0
						end as 'STERILIZATIONReturncond',

						


						--case when( @FlagSterilizationTrigger1 >= 1)
						--then
						--case when ((select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 ) !=0)
						--then
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 )
						--else
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId  and STERILIZATIONTempSP>=80 )
						--	end
						--else
			   --   			0
						--end as 'STERILIZATIONReturnTemp'	,

						--STERILIZATIONStepTime,
						--STERILIZATIONTempSP,
						--STERILIZATIONReturnTemp,



						--SANITIZATIONStepTime,

						(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempPCIPLOGReport1 where id = (select Id from #temp1 where n = @a)) as [Status]
					into 
						#tempProcess1
					from 
						#tempPCIPLOGReport1
					where 
						Id between @tempId1 and (select Id from #temp1 where n = @a)
			
					--select * from #tempProcess

					

					Insert into #tmpPCIPLOGReport 
						(StartTime,StopTime,[Date],TotalTimeInPCIP,
						[LineNo],RouteNo,RouteName,ReceipeNo,Flow,PreRinseStepTime,PreRinseEffectiveCircuilationTime,PreConductivity,
						LYEStepTime,LyeEffectiveCircuilationTime,LYEReturnTemp,LYEReturnCond,
						ACIDStepTime,AcidEffectiveCircuilationTime, ACIDReturnTemp,ACIDReturnCond,
						INTERMEDIATEStepTime,INTERMEDIATEEffectiveCircuilationTime,INTERMEDIATEReturnTemp,INTERMEDIATEReturnCond,
						FINALStepTime,FinalEffectiveCircuilationTime,FINALReturnTemp,FINALReturnCond,
						STERILIZATIONStepTime,STERILIZATIONEffectiveCircuilationTime,STERILIZATIONReturnTemp,STERILIZATIONReturnCond,[Status])
					(Select * from #tempProcess1)

					drop table #tempProcess1
		 
			end

			drop table #tempPCIPLOGReport1

	end

		if((Select StartTriggerT3 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId3 int = null
			set @ProcessId3= (select Id from #temp1 where n = @a)
			Declare @tempId3 int
		
			Select 
				row_number() OVER (ORDER BY id) [row3],* into #tempPCIPLOGReport3 
			from 
				PCIPLog 
			where 
				StartTriggerT3 in (1,0) 
				and [Date] between @FromDateTime and @ToDateTime 

	--select 'TempData'
 --      select * from #tempPCIPLOGReport

			--select * from #tmpCreamRow
			Declare @Row3 int = null
			set @Row3 = (Select [row3] from #tempPCIPLOGReport3 where id = @ProcessId3)
			--select @Row

			while ((Select Id from #tempPCIPLOGReport3 where StartTriggerT3 != 0 and [Row3] = @Row3 -1) != 0)
			begin
					set @tempId3= (Select Id from #tempPCIPLOGReport3 where StartTriggerT3 != 0 and [Row3] = @Row3 -1)
					set @Row3 = @Row3 - 1
			end
  -- PID and TID
			--select @tempId as tid,@ProcessId as pid
--- Fetching Subtrigger Values
      declare @FlagLyeTrigger3 int=0,@FlagAcidTrigger3 int=0,@FlagIntermediateTrigger3 int=0,@FlagFinalTrigger3 int=0,@FlagSterilizationTrigger3 int=0,
			  @FlagPreRinseTrigger3 int = 0, @FlagRinsewithRecWaterTrigger3 int = 0

			set @FlagLyeTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and LyeTrigger3=1  )
			set @FlagAcidTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and AcidTrigger3=1  )
			set @FlagIntermediateTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and IntermediateTrigger3=1  )
			set @FlagFinalTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and FinalTrigger3=1  )
			set @FlagSterilizationTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and SterilizationTrigger3=1  )
			set @FlagPreRinseTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and PreRinseTrigger3=1  )
			set @FlagRinsewithRecWaterTrigger3=(select count(*) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and RinsewithRecWaterTrigger3=1  )
	    --Total Count For SUbtrigger Found
			--select @FlagLyeTrigger1 as '@FlagLyeTrigger',@FlagAcidTrigger1 as '@FlagAcidTrigger1',@FlagIntermediateTrigger1 as '@FlagIntermediateTrigger1', @FlagFinalTrigger1 as '@FlagFinalTrigger1',@FlagSterilizationTrigger1 as '@FlagSterilizationTrigger1',@FlagSenitizationTrigger1 as '@FlagSenizationTrigger1'

--  Start Trigger-1 If Condition
			
			if(@FlagLyeTrigger3 >0 or @FlagAcidTrigger3 >0 or @FlagIntermediateTrigger3 >0 or @FlagFinalTrigger3 > 0 or @FlagSterilizationTrigger3 >0 
					or @FlagPreRinseTrigger3 >0 or @FlagRinsewithRecWaterTrigger3 >0 )
			begin
					Select 
						top 1 
						--convert(time,[Date],109) as StartTime,
						(select top 1 (convert(time,[Date],109)) from #tempPCIPLOGReport3 where Id = @tempId3) as StartTime,
						(Select convert(time,[Date],109) from #tempPCIPLOGReport3 where id = @ProcessId3) as StopTime,
						(Select convert(varchar(10),[Date],103) from #tempPCIPLOGReport3 where id = (select Id from #tempPCIPLOGReport3 where Id = @tempId3)) as [Date],
						(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
									convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
									convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport3 where id between @tempId3 and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInPCIP,
						'C3F3'as LineNumber,
						--TankerNo,
						--(Select top 1 R.RouteName from Routes R inner join #tempPCIPLOGReport tmpcip  on R.PLCValue = tmpcip.RouteNo) as 'RouteName' ,
						RouteNo,
						case when RouteNo = 0 then 'None' 
						when RouteNo = 1 then 'C11T01' 
						when RouteNo = 2 then 'C12T01' 
						when RouteNo = 3 then 'C13T01' 
						when RouteNo = 4 then 'C14T01' 
						when RouteNo = 5 then 'Dryer Wet Cleaning' end as RouteName,
						
						 RecipeNo,
						Flow,
-------------------------------------------------------------------------------------------------------------------------------------------
						
						case when( @FlagPreRinseTrigger3 >= 1)
						then
							(select top 1 (PreRinseStepTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and PreRinseTrigger3=1 )
						else
			      			0
						end as 'PreRinseStepTime'	, 

						case when( @FlagPreRinseTrigger3 >= 1)
						then
							(select top 1 ([PreRinseEffectiveCircuilationTime]) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and PreRinseTrigger3=1 )
						else
			      			0
						end as 'Effective Circulation time (Program Time)'	, 

						
						case when( @FlagPreRinseTrigger3 >= 1)
						then
							(select top 1  max(PreConductivity) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and PreRinseTrigger3=1 )
						else
			      			0
						end as 'PreReturnCond',

--------------------------------------------------------------------------------------------------------------------------------------------------------------
						--case when( @FlagRinsewithRecWaterTrigger1 >= 1)
						--then
						--	(select top 1 (RinseWithRecWaterStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and RinsewithRecWaterTrigger1=1 )
						--else
			   --   			0
						--end as 'RinseWithRecWaterStepTime'	, 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


						case when( @FlagLyeTrigger3 >= 1)
						then
							(select top 1 (LYEStepTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and LyeTrigger3=1 )
						else
			      			0
						end as 'LYEStepTime'	, 

						case when( @FlagLyeTrigger3 >= 1)
						then
							(select top 1 (LyeEffectiveCircuilationTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and LyeTrigger3=1 )
						else
			      			0
						end as 'LyeEffectiveCircuilationTime'	, 

						case when( @FlagLyeTrigger3 >= 1)
						then
							(select top 1 (LYEReturnTemp) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and LyeTrigger3=1 )
						else
			      			0
						end as 'LYEReturnTemp'	, 

						
						case when( @FlagLyeTrigger3 >= 1)
						then
							(select top 1  max(LYEReturnCond) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and LyeTrigger3=1 )
						else
			      			0
						end as 'LYEReturnCond'	, 

-------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagAcidTrigger3 >= 1)
						then
							(select top 1 (ACIDStepTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and AcidTrigger3=1 )
						else
			      			0
						end as 'ACIDStepTime'	, 
						case when( @FlagAcidTrigger3 >= 1)
						then
							(select top 1 (AcidEffectiveCircuilationTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and AcidTrigger3=1 )
						else
			      			0
						end as 'AcidEffectiveCircuilationTime', 

						case when( @FlagAcidTrigger3 >= 1)
						then
							(select top 1 (ACIDReturnTemp) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and AcidTrigger3=1 )
						else
			      			0
						end as 'ACIDReturnTemp'	, 

						case when( @FlagAcidTrigger3 >= 1)
						then
							(select top 1 (ACIDReturnCond) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and AcidTrigger3=1 )
						else
			      			0
						end as 'ACIDReturnCond'	, 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagIntermediateTrigger3 >= 1)
						then
							(select top 1 (INTERMEDIATEStepTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and IntermediateTrigger3=1 )
						else
			      			0
						end as 'INTERMEDIATEStepTime'	,

							case when( @FlagIntermediateTrigger3 >= 1)
						then
							(select top 1 (INTERMEDIATEEffectiveCircuilationTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and IntermediateTrigger3=1 )
						else
			      			0
						end as 'INTERMEDIATEEffectiveCircuilationTime'	,

							case when( @FlagIntermediateTrigger3 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnTemp) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and IntermediateTrigger3=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnTemp'	,

						case when( @FlagIntermediateTrigger3 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnCond) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and IntermediateTrigger3=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnCond'	,
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
					case when( @FlagFinalTrigger3 >= 1)
						then
							(select top 1 (FINALStepTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and FinalTrigger3=1 )
						else
			      			0
						end as 'FINALStepTime'	,

						case when( @FlagFinalTrigger3 >= 1)
						then
							(select top 1 (FinalEffectiveCircuilationTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and FinalTrigger3=1 )
						else
			      			0
						end as 'FinalEffectiveCircuilationTime'	,

						case when( @FlagFinalTrigger3 >= 1)
						then
							(select top 1 (FINALReturnTemp) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and FinalTrigger3=1 )
						else
			      			0
						end as 'FINALReturnTemp',

						case when( @FlagFinalTrigger3 >= 1)
						then
							(select top 1 (FINALReturnCond) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and FinalTrigger3=1 )
						else
			      			0
						end as 'FINALReturnCond'	,

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagSterilizationTrigger3 >= 1)
						then
							(select top 1 (STERILIZATIONStepTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and SterilizationTrigger3=1 )
						else
			      			0
						end as 'STERILIZATIONStepTime'	,

						case when( @FlagSterilizationTrigger3 >= 1)
						then
							(select top 1 (STERILIZATIONEffectiveCircuilationTime) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and SterilizationTrigger3=1 )
						else
			      			0
						end as 'STERILIZATIONEffectiveCircuilationTime' ,

						case when( @FlagSterilizationTrigger3 >= 1)
						then
							(select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and SterilizationTrigger3=1 )
						else
			      			0
						end as 'STERILIZATIONReturnTemp',

						
						
						case when( @FlagSterilizationTrigger3 >= 1)
						then
							(select top 1 (STERILIZATIONReturncond) from #tempPCIPLOGReport3 where Id between @tempId3 and @ProcessId3 and SterilizationTrigger3=1 )
						else
			      			0
						end as 'STERILIZATIONReturncond',

						


						--case when( @FlagSterilizationTrigger1 >= 1)
						--then
						--case when ((select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 ) !=0)
						--then
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 )
						--else
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId  and STERILIZATIONTempSP>=80 )
						--	end
						--else
			   --   			0
						--end as 'STERILIZATIONReturnTemp'	,

						--STERILIZATIONStepTime,
						--STERILIZATIONTempSP,
						--STERILIZATIONReturnTemp,



						--SANITIZATIONStepTime,

						(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempPCIPLOGReport3 where id = (select Id from #temp1 where n = @a)) as [Status]
					into 
						#tempProcess3
					from 
						#tempPCIPLOGReport3
					where 
						Id between @tempId3 and (select Id from #temp1 where n = @a)
			
					--select * from #tempProcess

					

					Insert into #tmpPCIPLOGReport 
						(StartTime,StopTime,[Date],TotalTimeInPCIP,
						[LineNo],RouteNo,RouteName,ReceipeNo,Flow,PreRinseStepTime,PreRinseEffectiveCircuilationTime,PreConductivity,
						LYEStepTime,LyeEffectiveCircuilationTime,LYEReturnTemp,LYEReturnCond,
						ACIDStepTime,AcidEffectiveCircuilationTime, ACIDReturnTemp,ACIDReturnCond,
						INTERMEDIATEStepTime,INTERMEDIATEEffectiveCircuilationTime,INTERMEDIATEReturnTemp,INTERMEDIATEReturnCond,
						FINALStepTime,FinalEffectiveCircuilationTime,FINALReturnTemp,FINALReturnCond,
						STERILIZATIONStepTime,STERILIZATIONEffectiveCircuilationTime,STERILIZATIONReturnTemp,STERILIZATIONReturnCond,[Status])
					(Select * from #tempProcess3)

					drop table #tempProcess3
		 
			end

			drop table #tempPCIPLOGReport3

	end


	

	set @a = @a + 1
	
end

select 
	Id as SrNo,
	[Date],
	[LineNo],
	RouteNo,
	RouteName,
	ReceipeNo,
	StartTime,
	StopTime,
    TotalTimeInPCIP,
	Flow,
	PreRinseStepTime,
	PreRinseEffectiveCircuilationTime,
	PreConductivity,
	LYEStepTime,
	LyeEffectiveCircuilationTime,
	LYEReturnTemp,
	LYEReturnCond,
	ACIDStepTime,
	AcidEffectiveCircuilationTime,
	ACIDReturnTemp,
	ACIDReturnCond,
	INTERMEDIATEStepTime,
	INTERMEDIATEEffectiveCircuilationTime,
	INTERMEDIATEReturnTemp,
	INTERMEDIATEReturnCond,
	FINALStepTime,
	FinalEffectiveCircuilationTime,
	FINALReturnTemp,	
	FINALReturnCond,
	STERILIZATIONStepTime,
	STERILIZATIONEffectiveCircuilationTime,
	STERILIZATIONReturnTemp,
	STERILIZATIONReturnCond,
	[Status]
from
	#tmpPCIPLOGReport

drop table #temp1,#tmpPCIPLOGReport

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PCIPLOGReport_New1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_PCIPLOGReport_New] '12/08/2020  12:35:11','12/08/2022 20:30:17'
CREATE procedure [dbo].[usp_rpt_PCIPLOGReport_New1]
	@FromDateTime datetime,
	@ToDateTime datetime
AS

Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1 
	from PCIPLog t 
		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0) and [Date] between @FromDateTime and @ToDateTime
		  

 --select '#temp1'
 -- select * from #temp1

declare @a int = 1
declare @count int = (select count(*) from #temp1)
--select @count
--drop table #temp1 

Create table #tmpPCIPLOGReport (Id int IDENTITY(1,1),[Date] varchar(10),StartTime varchar(8),StopTime varchar(8),TotalTimeInPCIP varchar(8),
								[LineNo] varchar(10), ReceipeNo varchar(10),RouteNo int,RouteName varchar(50) ,Flow decimal(18,2),
								PreRinseStepTime decimal(18,2), PreRinseEffectiveCircuilationTime decimal(18,2),PreConductivity decimal(18,2),
								LYEStepTime decimal(18,2),LYEFlow decimal(18,2),LYEReturnTemp decimal(18,2),LYEReturnCond decimal(18,2),
								ACIDStepTime decimal(18,2),ACIDFlow decimal(18,2),ACIDReturnTemp decimal(18,2), ACIDReturnCond decimal(18,2),
								INTERMEDIATEStepTime decimal(18,2),INTERMEDIATEFlow decimal(18,2),INTERMEDIATEReturnTemp decimal(18,2),INTERMEDIATEReturnCond decimal(18,2),
								FINALStepTime decimal(18,2), FINALFlow decimal(18,2),FINALReturnTemp decimal(18,2),FINALReturnCond decimal(18,2),
								STERILIZATIONStepTime decimal(18,2),STERILIZATIONFlow decimal(18,2),STERILIZATIONReturnTemp decimal(18,2),STERILIZATIONReturnCond decimal(18,2),[Status] varchar(8))
								

while (@a <= @count)
begin

	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
	begin
			Declare @ProcessId int = null
			set @ProcessId = (select Id from #temp1 where n = @a)
			Declare @tempId int
		
			Select 
				row_number() OVER (ORDER BY id) [row],* into #tempPCIPLOGReport 
			from 
				PCIPLog 
			where 
				StartTriggerT1 in (1,0) 
				and [Date] between @FromDateTime and @ToDateTime 

	--select 'TempData'
 --      select * from #tempPCIPLOGReport

			--select * from #tmpCreamRow
			Declare @Row int = null
			set @Row = (Select [row] from #tempPCIPLOGReport where id = @ProcessId)
			--select @Row

			while ((Select Id from #tempPCIPLOGReport where StartTriggerT1 != 0 and [Row] = @Row -1) != 0)
			begin
					set @tempId = (Select Id from #tempPCIPLOGReport where StartTriggerT1 != 0 and [Row] = @Row -1)
					set @Row = @Row - 1
			end
  -- PID and TID
			--select @tempId as tid,@ProcessId as pid
--- Fetching Subtrigger Values
      declare @FlagLyeTrigger1 int=0,@FlagAcidTrigger1 int=0,@FlagIntermediateTrigger1 int=0,@FlagFinalTrigger1 int=0,@FlagSterilizationTrigger1 int=0,
			  @FlagPreRinseTrigger1 int = 0, @FlagRinsewithRecWaterTrigger1 int = 0

			set @FlagLyeTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1  )
			set @FlagAcidTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1  )
			set @FlagIntermediateTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1  )
			set @FlagFinalTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1  )
			set @FlagSterilizationTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1  )
			set @FlagPreRinseTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1  )
			set @FlagRinsewithRecWaterTrigger1=(select count(*) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and RinsewithRecWaterTrigger1=1  )
	    --Total Count For SUbtrigger Found
			--select @FlagLyeTrigger1 as '@FlagLyeTrigger',@FlagAcidTrigger1 as '@FlagAcidTrigger1',@FlagIntermediateTrigger1 as '@FlagIntermediateTrigger1', @FlagFinalTrigger1 as '@FlagFinalTrigger1',@FlagSterilizationTrigger1 as '@FlagSterilizationTrigger1',@FlagSenitizationTrigger1 as '@FlagSenizationTrigger1'

--  Start Trigger-1 If Condition
			
			if(@FlagLyeTrigger1 >0 or @FlagAcidTrigger1 >0 or @FlagIntermediateTrigger1 >0 or @FlagFinalTrigger1 > 0 or @FlagSterilizationTrigger1 >0 
					or @FlagPreRinseTrigger1 >0 or @FlagRinsewithRecWaterTrigger1 >0 )
			begin
					Select 
						top 1 
						--convert(time,[Date],109) as StartTime,
						(select top 1 (convert(time,[Date],109)) from #tempPCIPLOGReport where Id = @tempId) as StartTime,
						(Select convert(time,[Date],109) from #tempPCIPLOGReport where id = @ProcessId) as StopTime,
						(Select convert(varchar(10),[Date],103) from #tempPCIPLOGReport where id = (select Id from #tempPCIPLOGReport where Id = @tempId)) as [Date],
						(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
									convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
									convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tempPCIPLOGReport where id between @tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTimeInPCIP,
						'C3F1'as LineNumber,
						--TankerNo,
						--(Select top 1 R.RouteName from Routes R inner join #tempPCIPLOGReport tmpcip  on R.PLCValue = tmpcip.RouteNo) as 'RouteName' ,
						RouteNo,
						case when RouteNo = 0 then 'None' 
						when RouteNo = 1 then 'C11T01' 
						when RouteNo = 2 then 'C12T01' 
						when RouteNo = 3 then 'C13T01' 
						when RouteNo = 4 then 'C14T01' 
						when RouteNo = 5 then 'Dryer Wet Cleaning' end as RouteName,
						
						case when RecipeNo = 1 then 'Type - 1' 
						when RecipeNo = 2 then 'Type - 2' 
						when RecipeNo = 3 then 'Type - 3' 
						when RecipeNo = 4 then 'Type - 4' 
						when RecipeNo = 5 then 'Type - 5' 
						when RecipeNo = 6 then 'Type - 6' end as RecipeNo,
						Flow,
-------------------------------------------------------------------------------------------------------------------------------------------
						
						case when( @FlagPreRinseTrigger1 >= 1)
						then
							(select top 1 (PreRinseStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1 )
						else
			      			0
						end as 'PreRinseStepTime'	, 

						case when( @FlagPreRinseTrigger1 >= 1)
						then
							(select top 1 ([PreRinseEffectiveCircuilationTime]) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1 )
						else
			      			0
						end as 'Effective Circulation time (Program Time)'	, 

						
						case when( @FlagPreRinseTrigger1 >= 1)
						then
							(select top 1  max(PreConductivity) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and PreRinseTrigger1=1 )
						else
			      			0
						end as 'PreReturnCond',

--------------------------------------------------------------------------------------------------------------------------------------------------------------
						--case when( @FlagRinsewithRecWaterTrigger1 >= 1)
						--then
						--	(select top 1 (RinseWithRecWaterStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and RinsewithRecWaterTrigger1=1 )
						--else
			   --   			0
						--end as 'RinseWithRecWaterStepTime'	, 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1 (LYEStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LYEStepTime'	, 

						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1 (LyeFlow) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LyeFlow'	, 

						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1 (LYEReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LYEReturnTemp'	, 

						
						case when( @FlagLyeTrigger1 >= 1)
						then
							(select top 1  max(LYEReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and LyeTrigger1=1 )
						else
			      			0
						end as 'LYEReturnCond'	, 

-------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDStepTime'	, 
						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDFlow) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDFlow', 

						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDReturnTemp'	, 

						case when( @FlagAcidTrigger1 >= 1)
						then
							(select top 1 (ACIDReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and AcidTrigger1=1 )
						else
			      			0
						end as 'ACIDReturnCond'	, 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEStepTime'	,

							case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEFlow) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEFlow'	,

							case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnTemp'	,

						case when( @FlagIntermediateTrigger1 >= 1)
						then
							(select top 1 (INTERMEDIATEReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and IntermediateTrigger1=1 )
						else
			      			0
						end as 'INTERMEDIATEReturnCond'	,
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
					case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALStepTime'	,

						case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALFlow) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALFlow'	,

						case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALReturnTemp',

						case when( @FlagFinalTrigger1 >= 1)
						then
							(select top 1 (FINALReturnCond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and FinalTrigger1=1 )
						else
			      			0
						end as 'FINALReturnCond'	,

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONStepTime) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONStepTime'	,

						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONFlow) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONFlow' ,

						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONReturnTemp',

						
						
						case when( @FlagSterilizationTrigger1 >= 1)
						then
							(select top 1 (STERILIZATIONReturncond) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 )
						else
			      			0
						end as 'STERILIZATIONReturncond',

						


						--case when( @FlagSterilizationTrigger1 >= 1)
						--then
						--case when ((select top 1 (STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 ) !=0)
						--then
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId and SterilizationTrigger1=1 and STERILIZATIONStepTime>=80 )
						--else
						--	(select top 1 max(STERILIZATIONReturnTemp) from #tempPCIPLOGReport where Id between @tempId and @ProcessId  and STERILIZATIONTempSP>=80 )
						--	end
						--else
			   --   			0
						--end as 'STERILIZATIONReturnTemp'	,

						--STERILIZATIONStepTime,
						--STERILIZATIONTempSP,
						--STERILIZATIONReturnTemp,



						--SANITIZATIONStepTime,

						(Select case when [Status] = 1 then 'Ok' else 'Not Ok' End from #tempPCIPLOGReport where id = (select Id from #temp1 where n = @a)) as [Status]
					into 
						#tempProcess
					from 
						#tempPCIPLOGReport
					where 
						Id between @tempId and (select Id from #temp1 where n = @a)
			
					--select * from #tempProcess

					

					Insert into #tmpPCIPLOGReport 
						(StartTime,StopTime,[Date],TotalTimeInPCIP,
						[LineNo],RouteNo,RouteName,ReceipeNo,Flow,PreRinseStepTime,PreRinseEffectiveCircuilationTime,PreConductivity,
						LYEStepTime,LYEFlow,LYEReturnTemp,LYEReturnCond,
						ACIDStepTime,ACIDFlow, ACIDReturnTemp,ACIDReturnCond,
						INTERMEDIATEStepTime,INTERMEDIATEFlow,INTERMEDIATEReturnTemp,INTERMEDIATEReturnCond,
						FINALStepTime,FINALFlow,FINALReturnTemp,FINALReturnCond,
						STERILIZATIONStepTime,STERILIZATIONFlow,STERILIZATIONReturnTemp,STERILIZATIONReturnCond,[Status])
					(Select * from #tempProcess)

					drop table #tempProcess
		 
			end

			drop table #tempPCIPLOGReport

	end



	

	set @a = @a + 1
	
end

select 
	Id as SrNo,
	[Date],
	[LineNo],
	RouteNo,
	RouteName,
	ReceipeNo,
	StartTime,
	StopTime,
    TotalTimeInPCIP,
	Flow,
	PreRinseStepTime,
	PreRinseEffectiveCircuilationTime,
	PreConductivity,
	LYEStepTime,
	LYEFlow,
	LYEReturnTemp,
	LYEReturnCond,
	ACIDStepTime,
	ACIDFlow,
	ACIDReturnTemp,
	ACIDReturnCond,
	INTERMEDIATEStepTime,
	INTERMEDIATEFlow,
	INTERMEDIATEReturnTemp,
	INTERMEDIATEReturnCond,
	FINALStepTime,
	FINALFlow,
	FINALReturnTemp,	
	FINALReturnCond,
	STERILIZATIONStepTime,
	STERILIZATIONFlow,
	STERILIZATIONReturnTemp,
	STERILIZATIONReturnCond,
	[Status]
from
	#tmpPCIPLOGReport

drop table #temp1,#tmpPCIPLOGReport


GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PlantStatus]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_PlantStatus] '12/19/2018','08/28/2019'
CREATE procedure [dbo].[usp_rpt_PlantStatus]
(
	@FromDateTime datetime,
	@ToDateTime datetime
)
AS

----------------------------------- Start Plant Status Evaporator 1----------------------------------
Begin
	Select  row_number() OVER (ORDER BY [DateTime]) n,LEAD(Id) over (Order By Id) as 'NextId',t.* into #tempEvap1
		from PlantStatusEvap1 t 
			 where [DateTime] between @FromDateTime and @ToDateTime 

	--Select * from #tempEvap1

	declare @a1 int = 1
	declare @count1 int = (select count(*) from #tempEvap1)
	----------------------------------- Create Temp Table --------------------------
	Create table #tempPlantStatusEvap1 (SrNo int IDENTITY(1,1),Id int,[Date] varchar(10),
									StartTime varchar(8),StopTime varchar(8),Plant varchar(15),PlantStatus varchar(100),TotalTime varchar(8),Quantity varchar(10),
									Remark varchar(max))
	----------------------------------

	while (@a1 <= @count1)
	begin
	if((Select CONVERT(varchar(10), [NextId]) from #tempEvap1 where n = @a1) != 'NULL')
	Begin
	
		Insert into #tempPlantStatusEvap1 
		(
		Id,
		[Date],
		StartTime,
		StopTime,
		Plant,
		PlantStatus,
		TotalTime,
		Quantity,
		Remark
		)
		values
		(
			(Select Id from #tempEvap1 where n = @a1),
			(Select convert(varchar(10),DateTime,103) from #tempEvap1 where n = @a1),
			(Select convert(time,DateTime,109) from #tempEvap1 where n = @a1),
			(Select convert(time,DateTime,109) from #tempEvap1 where n = @a1 + 1),
			'Evaporator 1',
			(Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = (select PlantStatusId from #tempEvap1 where n = @a1)),
		
			(Select convert(varchar(5),DateDiff(s, (Select DateTime from #tempEvap1 where n = @a1), (Select DateTime from #tempEvap1 where n = @a1 + 1))/3600) +':'+
			convert(varchar(5),DateDiff(s, (Select DateTime from #tempEvap1 where n = @a1), (Select DateTime from #tempEvap1 where n = @a1 + 1))%3600/60) +':'+
			convert(varchar(5),DateDiff(s, (Select DateTime from #tempEvap1 where n = @a1), (Select DateTime from #tempEvap1 where n = @a1 + 1))%60)
		 from #tempEvap1 where n = @a1),
							
			(Select Quantity from #tempEvap1 where n = @a1 + 1) - (Select Quantity from #tempEvap1 where n = @a1),
			(Select Remark from #tempEvap1 where n = @a1)
		)
	
		--Select * from #tempPlantStatusEvap1
	End
	else
	Begin
		Insert into #tempPlantStatusEvap1 
		(
			Id,
			[Date],
			StartTime,
			StopTime,
			Plant,
			PlantStatus,
			TotalTime,
			Quantity,
			Remark
		)
		values
		(
			(Select Id from #tempEvap1 where n = @a1),
			(Select convert(varchar(10),DateTime,103) from #tempEvap1 where n = @a1),
			(Select convert(time,DateTime,109) from #tempEvap1 where n = @a1),
			'',
			'Evaporator 1',
			(Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = (select PlantStatusId from #tempEvap1 where n = @a1)),
			'',
			'',
			''
		)

	End
		set @a1 = @a1 + 1
	end
	--Select * from #tempPlantStatusEvap1
	--select 
	--	Id as SrNo,
	--	Id,
	--	[Date],
	--	StartTime,
	--	StopTime,
	--	Plant,
	--	PlantStatus,
	--	TotalTime,
	--	Quantity,
	--	Remark
	--from 
	--	#tempPlantStatusEvap1

	drop table #tempEvap1--,#tempPlantStatusEvap1
End

----------------------------------- End of Plant Status Evaporator 1----------------------------------

----------------------------------- Start Plant Status Evaporator 2----------------------------------
Begin
Select  row_number() OVER (ORDER BY [DateTime]) n,LEAD(Id) over (Order By Id) as 'NextId',t.* into #tempEvap2
		from PlantStatusEvap2 t 
			 where [DateTime] between @FromDateTime and @ToDateTime 

	--Select * from #tempEvap2

	declare @a2 int = 1
	declare @count2 int = (select count(*) from #tempEvap2)
	----------------------------------- Create Temp Table --------------------------
	Create table #tempPlantStatusEvap2 (SrNo int IDENTITY(1,1),Id int,[Date] varchar(10),
									StartTime varchar(8),StopTime varchar(8),Plant varchar(15),PlantStatus varchar(100),TotalTime varchar(8),Quantity varchar(10),
									Remark varchar(max))
	----------------------------------

	while (@a2 <= @count2)
	begin
	if((Select CONVERT(varchar(10), [NextId]) from #tempEvap2 where n = @a2) != 'NULL')
	Begin
	
		Insert into #tempPlantStatusEvap2 
		(
		Id,
		[Date],
		StartTime,
		StopTime,
		Plant,
		PlantStatus,
		TotalTime,
		Quantity,
		Remark
		)
		values
		(
			(Select Id from #tempEvap2 where n = @a2),
			(Select convert(varchar(10),DateTime,103) from #tempEvap2 where n = @a2),
			(Select convert(time,DateTime,109) from #tempEvap2 where n = @a2),
			(Select convert(time,DateTime,109) from #tempEvap2 where n = @a2 + 1),
			'Evaporator 2',
			(Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = (select PlantStatusId from #tempEvap2 where n = @a2)),
		
			(Select convert(varchar(5),DateDiff(s, (Select DateTime from #tempEvap2 where n = @a2), (Select DateTime from #tempEvap2 where n = @a2 + 1))/3600) +':'+
			convert(varchar(5),DateDiff(s, (Select DateTime from #tempEvap2 where n = @a2), (Select DateTime from #tempEvap2 where n = @a2 + 1))%3600/60) +':'+
			convert(varchar(5),DateDiff(s, (Select DateTime from #tempEvap2 where n = @a2), (Select DateTime from #tempEvap2 where n = @a2 + 1))%60)
		 from #tempEvap2 where n = @a2),
							
			(Select Quantity from #tempEvap2 where n = @a2 + 1) - (Select Quantity from #tempEvap2 where n = @a2),
			(Select Remark from #tempEvap2 where n = @a2)
		)
	
		--Select * from #tempPlantStatusEvap2
	End
	else
	Begin
		Insert into #tempPlantStatusEvap2 
		(
			Id,
			[Date],
			StartTime,
			StopTime,
			Plant,
			PlantStatus,
			TotalTime,
			Quantity,
			Remark
		)
		values
		(
			(Select Id from #tempEvap2 where n = @a2),
			(Select convert(varchar(10),DateTime,103) from #tempEvap2 where n = @a2),
			(Select convert(time,DateTime,109) from #tempEvap2 where n = @a2),
			'',
			'Evaporator 2',
			(Select Name from PlantStatusEvaporator where IsDeleted = 0 and PLCValue = (select PlantStatusId from #tempEvap2 where n = @a2)),
			'',
			'',
			''
		)

	End
		set @a2 = @a2 + 1
	end
	--Select * from #tempPlantStatusEvap2
	--select 
	--	Id as SrNo,
	--	Id,
	--	[Date],
	--	StartTime,
	--	StopTime,
	--	Plant,
	--	PlantStatus,
	--	TotalTime,
	--	Quantity,
	--	Remark
	--from 
	--	#tempPlantStatusEvap2

	drop table #tempEvap2--,#tempPlantStatusEvap2
End
----------------------------------- End of Plant Status Evaporator 1----------------------------------


----------------------------------- Start Plant Status Dryer----------------------------------
Begin
	Select  row_number() OVER (ORDER BY [DateTime]) n,LEAD(Id) over (Order By Id) as 'NextId',t.* into #tempDryer
		from PlantStatusDryer t 
			 where [DateTime] between @FromDateTime and @ToDateTime 

	--Select * from #tempDryer

	declare @a3 int = 1
	declare @count3 int = (select count(*) from #tempDryer)
	----------------------------------- Create Temp Table --------------------------
	Create table #tempPlantStatusDryer (SrNo int IDENTITY(1,1),Id int,[Date] varchar(10),
									StartTime varchar(8),StopTime varchar(8),Plant varchar(15),PlantStatus varchar(100),TotalTime varchar(8),Quantity varchar(10),
									Remark varchar(max))
	----------------------------------

	while (@a3 <= @count3)
	begin
	if((Select CONVERT(varchar(10), [NextId]) from #tempDryer where n = @a3) != 'NULL')
	Begin
	
		Insert into #tempPlantStatusDryer 
		(
		Id,
		[Date],
		StartTime,
		StopTime,
		Plant,
		PlantStatus,
		TotalTime,
		Quantity,
		Remark
		)
		values
		(
			(Select Id from #tempDryer where n = @a3),
			(Select convert(varchar(10),DateTime,103) from #tempDryer where n = @a3),
			(Select convert(time,DateTime,109) from #tempDryer where n = @a3),
			(Select convert(time,DateTime,109) from #tempDryer where n = @a3 + 1),
			'Dryer',
			(Select Name from DryerPlantStatus where IsDeleted = 0 and PLCValue = (select PlantStatusId from #tempDryer where n = @a3)),
			(Select convert(varchar(5),DateDiff(s, (Select DateTime from #tempDryer where n = @a3), (Select DateTime from #tempDryer where n = @a3 + 1))/3600) +':'+
			convert(varchar(5),DateDiff(s, (Select DateTime from #tempDryer where n = @a3), (Select DateTime from #tempDryer where n = @a3 + 1))%3600/60) +':'+
			convert(varchar(5),DateDiff(s, (Select DateTime from #tempDryer where n = @a3), (Select DateTime from #tempDryer where n = @a3 + 1))%60)
		 from #tempDryer where n = @a3),
							
			(Select Quantity from #tempDryer where n = @a3 + 1) - (Select Quantity from #tempDryer where n = @a3),
			(Select Remark from #tempDryer where n = @a3)
		)
	
		--Select * from #tempPlantStatusDryer
	End
	else
	Begin
		Insert into #tempPlantStatusDryer 
		(
			Id,
			[Date],
			StartTime,
			StopTime,
			Plant,
			PlantStatus,
			TotalTime,
			Quantity,
			Remark
		)
		values
		(
			(Select Id from #tempDryer where n = @a3),
			(Select convert(varchar(10),DateTime,103) from #tempDryer where n = @a3),
			(Select convert(time,DateTime,109) from #tempDryer where n = @a3),
			'',
			'Dryer',
			(Select Name from DryerPlantStatus where IsDeleted = 0 and PLCValue = (select PlantStatusId from #tempDryer where n = @a3)),
			'',
			'',
			''
		)

	End
		set @a3 = @a3 + 1
	end
	--Select * from #tempPlantStatusDryer
	--select 
	--	Id as SrNo,
	--	Id,
	--	[Date],
	--	StartTime,
	--	StopTime,
	--	Plant,
	--	PlantStatus,
	--	TotalTime,
	--	Quantity,
	--	Remark
	--from 
	--	#tempPlantStatusDryer

	drop table #tempDryer--,#tempPlantStatusDryer
End
----------------------------------- End of Plant Status Dryer----------------------------------

Select *  into #tempPlantStatus from (Select 
	--row_number() OVER (ORDER BY [Date]) as SrNo,
	Id,
	[Date],
	StartTime,
	StopTime,
	Plant,
	PlantStatus,
	TotalTime,
	Quantity,
	Remark
from
	#tempPlantStatusEvap1
union all
Select 
	--row_number() OVER (ORDER BY [Date]) as SrNo,
	Id,
	[Date],
	StartTime,
	StopTime,
	Plant,
	PlantStatus,
	TotalTime,
	Quantity,
	Remark
from
	#tempPlantStatusEvap2
union all
Select 
	--row_number() OVER (ORDER BY [Date]) as SrNo,
	Id,
	[Date],
	StartTime,
	StopTime,
	Plant,
	PlantStatus,
	TotalTime,
	Quantity,
	Remark
from
	#tempPlantStatusDryer)s

Select 
	row_number() OVER (ORDER BY [Date]) as SrNo,
	Id,
	[Date],
	StartTime,
	StopTime,
	Plant,
	PlantStatus,
	TotalTime,
	Quantity,
	Remark 
from 
	#tempPlantStatus
order by Date,StartTime
drop table #tempPlantStatusDryer,#tempPlantStatusEvap1,#tempPlantStatusEvap2,#tempPlantStatus

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PlantStatus_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [dbo].[usp_rpt_PlantStatus_Insert] 'MFT-2',10,20,'29/07/2017 15:34:12','29/07/2017 15:57:58',1,'29/07/2017 15:34:12'
CREATE procedure [dbo].[usp_rpt_PlantStatus_Insert]
(
	@Remark VarChar(200) = NULL,
	@StausId int = null,
	@strPlantName varchar(200)
	
)
AS
	--SET NOCOUNT ON
	if(@strPlantName = 'Evaporator 1')
		Begin
					UPDATE [dbo].[PlantStatusEvap1]
				SET
					Remark = @Remark
				WHERE 
					Id = @StausId
		End

	else if(@strPlantName = 'Evaporator 2')
		Begin
					UPDATE [dbo].[PlantStatusEvap2]
						SET
							Remark = @Remark
						WHERE 
							Id = @StausId
		End

	else if(@strPlantName = 'Dryer')
		Begin
					UPDATE [dbo].[PlantStatusDryer]
						SET
							Remark = @Remark
						WHERE 
							Id = @StausId
		End


	
	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PlantStatus_Old]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_PlantStatus] '08/10/2017','08/28/2019'
Create procedure [dbo].[usp_rpt_PlantStatus_Old]
(
	@FromDateTime datetime,
	@ToDateTime datetime
)
AS

Begin
Select  row_number() OVER (ORDER BY [DateTime]) n,t.* into #temp1
	from PlantStatus t 
		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0)
		 and [DateTime] between @FromDateTime and @ToDateTime 
--select * from #temp1


declare @a int = 1
declare @count int = (select count(*) from #temp1)
----------------------------------- Create Temp Table --------------------------
Create table #tempPlantStatus (Id int IDENTITY(1,1),[Date] varchar(10),
								StartTime varchar(8),StopTime varchar(8),Plant varchar(50),PlantStatus varchar(50),TotalTime varchar(8),Quantity varchar(10),
								Remark varchar(max))
----------------------------------

while (@a <= @count)
begin

	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
	begin
		
			Declare @T1ProcessId int = null
			set @T1ProcessId = (select Id from #temp1 where n = @a)
			Declare @T1tempId int
		
			Select row_number() OVER (ORDER BY id) [row],* into #tmpRowT1 from PlantStatus where StartTriggerT1 in (1,0) and [DateTime] between @FromDateTime and @ToDateTime 
			Declare @T1Row int = null
			set @T1Row = (Select [row] from #tmpRowT1 where id = @T1ProcessId)
					

			while ((Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1) != 0)
			begin
				set @T1tempId = (Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1)
				set @T1Row = @T1Row - 1
			end
			
			Select 
				top 1 convert(time,DateTime,109) as StartTime,
				(Select convert(time,DateTime,109) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),DateTime,103) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as [Date],
				case when PlantId = 1 then 'Evaporator - 1'
					when PlantId = 2 then 'Evaporator - 2' end as Plant,
					case when PlantStatus = 1 then 'Idle'
					when PlantStatus = 2 then 'On Cold Air'
					when PlantStatus = 3 then 'On Hot Air'
					when PlantStatus = 4 then 'On Water' end as PlantStatus,
				(select convert(varchar(5),DateDiff(s, (select top 1 DateTime from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 DateTime from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 DateTime from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 DateTime from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 DateTime from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 DateTime from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select Quantity from #tmpRowT1 where Id = (select Id from #temp1 where n = @a)) - (Select Quantity from #tmpRowT1 where Id = @T1tempId)) as TotalQuantity,
				Remarks
			into 
				#tempT1
			from 
				#tmpRowT1
			where 
				Id between @T1tempId and (select Id from #temp1 where n = @a)
			group by DateTime,PlantId,PlantStatus,Remarks
			Insert into #tempPlantStatus (StartTime,StopTime,[Date],Plant,PlantStatus,TotalTime,Quantity,Remark)
			(Select * from #tempT1)

		drop table #tmpRowT1,#tempT1
	end
	else if((Select StartTriggerT2 from #temp1 where n = @a) = 0)
	begin
		
			Declare @T2ProcessId int = null
			set @T2ProcessId = (select Id from #temp1 where n = @a)
			Declare @T2tempId int
		
			Select row_number() OVER (ORDER BY id) [row],* into #tmpRowT2 from PlantStatus where StartTriggerT2 in (1,0) and [DateTime] between @FromDateTime and @ToDateTime 
			Declare @T2Row int = null
			set @T2Row = (Select [row] from #tmpRowT2 where id = @T2ProcessId)
					

			while ((Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1) != 0)
			begin
				set @T2tempId = (Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1)
				set @T2Row = @T2Row - 1
			end
			
			Select 
				top 1 convert(time,DateTime,109) as StartTime,
				(Select convert(time,DateTime,109) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),DateTime,103) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as [Date],
				case when PlantId = 1 then 'Dryer'
					when PlantId = 2 then 'Dryer' end as Plant,
				(Select Name from PlantStatusMaster where IsDeleted = 0 and PLCValue = ((select Id from #temp1 where n = @a))) as PlantStatus,
				(select convert(varchar(5),DateDiff(s, (select top 1 DateTime from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 DateTime from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 DateTime from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 DateTime from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 DateTime from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 DateTime from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select Quantity from #tmpRowT2 where Id = (select Id from #temp1 where n = @a)) - (Select Quantity from #tmpRowT2 where Id = @T2tempId)) as TotalQuantity,
				Remarks
			into 
				#tempT2
			from 
				#tmpRowT2
			where 
				Id between @T2tempId and (select Id from #temp1 where n = @a)
			group by DateTime,PlantId,PlantStatus,Remarks
			Insert into #tempPlantStatus (StartTime,StopTime,[Date],Plant,PlantStatus,TotalTime,Quantity,Remark)
			(Select * from #tempT2)

		drop table #tmpRowT2,#tempT2
	end
	set @a = @a + 1
end

select 
	Id as SrNo,
	StartTime,
	StopTime,
	[Date],
	Plant,
	PlantStatus,
	TotalTime,
	Quantity,
	Remark
from 
	#tempPlantStatus

drop table #temp1,#tempPlantStatus

End

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PowderProcessingCostReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec  [dbo].[usp_rpt_PowderProcessingCostReport] '07/12/2019'
CREATE Procedure [dbo].[usp_rpt_PowderProcessingCostReport]
(
	@FromDateTime datetime
)
as
--Declare @FromDateTime datetime = '03/19/2019'

	----------------------------------- Create Temp Table --------------------------
Create table #tempUtilityTotal (Id int IDENTITY(1,1),[Date] varchar(10),
								ChilledWater float,ChilledWaterCost float,RawWater float,RawWaterCost float,[SoftWater] float,[SoftWaterCost] float,[Steam] float,SteamCost float,
								[CompressedAir] float,AirCost float,MCC1 float,MCC2 float,MCC3 float,MCC4 float,MCC5 float,MCC6 float,MCC7 float,MCC8 float,TotalPower float,PowerCost float,[Acid] float,AcidCost float,
								[LYE] float,LyeCost float,PowderQuantity float)
	---------------------------------------------------------------------------------

--Declare @TotalAvaQty decimal(18,2) = 0

--Select 
--	row_number() OVER (ORDER BY id) as 'row1',*
--into 
--	#temp
--from 
--	PackingMachineMassBalanceAvapack where CONVERT(date,[DateTime],103) = CONVERT(date, @FromDateTime,103)

----Select * from #temp
--Declare @Count1 int= (Select COUNT(*) from #temp) 
--Declare @a1 int = 1
--While(@a1 <= @Count1)
--Begin
--	Declare @FirstValue decimal(18,2) = 1
--	Declare @SecondValue decimal(18,2) = 1
--	Set @FirstValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:01.1000000' and '00:00:59.1000000')
--	Set @SecondValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:35.1000000' and '23:59:59.1000000')
		

--	Set @TotalAvaQty = @TotalAvaQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
--	Set @a1 = @a1 + 1
--End
--	Set @TotalAvaQty = @TotalAvaQty * (Select AvaPackQty from [MassBalancePowderProduction] where IsDeleted = 0) 
--Drop table #temp
	 
	

--Declare @PreviousBoschQty decimal(18,2) = 0
--Declare @CurrentBoschQty decimal(18,2) = 0
--Declare @TotalBoschQty decimal(18,2) = 0
	
--	Set @PreviousBoschQty = (Select 
--		Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	from 
--		PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,@FromDateTime,103)))


--	Set @CurrentBoschQty = (Select 
--		Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--		Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	from 
--		PackingMachineMassBalanceBosch where CONVERT(date,[DateTime],103) = CONVERT(date, @FromDateTime,103))

--	Set @TotalBoschQty =  @CurrentBoschQty - @PreviousBoschQty

--	Declare @PreviousHassiaQty decimal(18,2) = 0
--	Declare @CurrentHassiaQty decimal(18,2) = 0
--	Declare @TotalHassiaQty decimal(18,2) = 0
--	Set @PreviousHassiaQty = (Select 
--		Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0)
--	from 
--		PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = DATEADD(DAY,-1,CONVERT(date,@FromDateTime,103)))


--	Set @CurrentHassiaQty = (Select 
--		Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	from 
--		PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = Convert(date,@FromDateTime,103))

--	Set @TotalHassiaQty =  @CurrentHassiaQty - @PreviousHassiaQty

Declare @TotalPowderQty decimal(18,2) = 0
Set @TotalPowderQty = (Select top 1
						--	Quantity1 - LEAD(Quantity1,1) Over (Order By Date) +
						--Quantity2 -	LEAD(Quantity2,1) Over (Order By Date)+
						--Quantity3 -	LEAD(Quantity3,1) Over (Order By Date)+
						--Quantity4 -	LEAD(Quantity4,1) Over (Order By Date) 
						 LEAD(Quantity1,1) Over (Order By Date)- Quantity1  +
							LEAD(Quantity2,1) Over (Order By Date) - Quantity2  +
							LEAD(Quantity3,1) Over (Order By Date)-Quantity3  +
					     	LEAD(Quantity4,1) Over (Order By Date) - Quantity4
						from 
							[PowderSiloOpeningClosing] 
						where 
							Convert(date,[Date],103) = Convert(date,@FromDateTime,103))

--Select * from #temp
Declare @ProducuedQuantity float= (Select IsNull(Sum([TotalQuantity]),0)
								from 
									[PackingEntryMaster] 
								where 
									Convert(date,[Date],103) = Convert(date,@FromDateTime,103) 
									and IsDeLeted = 0)
Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)

--select @TotalPowderQty 'tq'
--Declare @Count1 int= (Select COUNT(*) from #temp) 
--Declare @a1 int = 1
--While(@a1 <= @Count1)
--Begin
	--Declare @FirstValue decimal(18,2) = 1
	--Declare @SecondValue decimal(18,2) = 1
	--Set @FirstValue = (Select ISnull(Quantity1,0) + ISnull(Quantity2,0) + ISnull(Quantity3,0) + ISnull(Quantity4,0) from #temp where row1 = 1)
	--Set @SecondValue = (Select ISnull(Quantity1,0) + ISnull(Quantity2,0) + ISnull(Quantity3,0) + ISnull(Quantity4,0) from #temp where row1 = 2)

	--Set @TotalPowderQty = @TotalPowderQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
--	Set @a1 = @a1 + 1
--End
	--Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)
--Drop table #temp
	

	Select 
		CONVERT(varchar(10),[DateTime],103) as 'Date',
		ChilledWaterTR AS 'ChilledWater',
		ChilledWaterTR * (Select [ChilledWaterCost] from [UtilityConsumptionCost]) as 'ChilledWaterCost',
		RawWater,
		RawWater * (Select [RawWaterCost] from [UtilityConsumptionCost]) as 'RawWaterCost',
		[SoftWater],
		[SoftWater] * (Select [SoftWaterCost] from [UtilityConsumptionCost]) as 'SoftWaterCost',
		--ChilledWaterFlow,
		--(ChilledWaterFlow *([ChilledWaterSupplyTemp] - [ChilledWaterReturnTemp]) / 3024) AS 'ChilledWater',

		[Steam],
		[Steam] * (Select [SteamCost] from [UtilityConsumptionCost]) as 'SteamCost',
		[CompressedAir],
		[CompressedAir] * (Select [AirCost] from [UtilityConsumptionCost]) as 'AirCost',
		--[Nitrogen],
		Convert(decimal(18,2), [MCC1]) as MCC1,
		Convert(decimal(18,2), [MCC2]) as MCC2,
		Convert(decimal(18,2), [MCC3]) as MCC3,
		Convert(decimal(18,2), [MCC4]) as MCC4,
		Convert(decimal(18,2), [MCC5]) as MCC5,
		Convert(decimal(18,2), [MCC6]) as MCC6,
		Convert(decimal(18,2), [MCC7]) as MCC7,
		Convert(decimal(18,2), [MCC8]) as MCC8,
		Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8])) as 'TotalPower',
		Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8])) * (Select [PowerCost] from [UtilityConsumptionCost]) as 'PowerCost',
		[Acid],
		[Acid] * (Select [AcidCost] from [UtilityConsumptionCost]) as 'AcidCost',
		[LYE],
		[LYE] * (Select [LyeCost] from [UtilityConsumptionCost]) as 'LyeCost',
		--ISNULL(@TotalAvaQty,0) + ISNULL(@TotalBoschQty,0) + ISNULL(@TotalHassiaQty,0) as 'PowderQuantity'
		ISNULL(@TotalPowderQty,0) as 'PowderQuantity'

	into
		#tempUtility
	from 
		UtilityConsumption t 
	Where 
		CONVERT(date,[DateTime],103) = CONVERT(date, @FromDateTime+1,103)

		Insert Into #tempUtilityTotal(Date,ChilledWater,ChilledWaterCost,RawWater,RawWaterCost,[SoftWater],SoftWaterCost,[Steam],SteamCost,[CompressedAir],AirCost,MCC1,
									MCC2,MCC3,MCC4,MCC5,MCC6,MCC7,MCC8,TotalPower,PowerCost,[Acid],AcidCost,[LYE],LyeCost,PowderQuantity)
		select * from #tempUtility


		drop table #tempUtility

Select 
	Date,
	CONVERT(decimal(18,3), (TotalPower / PowderQuantity)) as 'TotalPowder',
	CONVERT(decimal(18,3), ((TotalPower / PowderQuantity) * (Select PowerCost from UtilityConsumptionCost))) as 'ElectricityValue',
	CONVERT(decimal(18,3), CompressedAir / PowderQuantity) as 'TotalAir',
	CONVERT(decimal(18,3), ((CompressedAir / PowderQuantity) * (Select [AirCost] from UtilityConsumptionCost))) as 'AirValue',
	CONVERT(decimal(18,3), SoftWater / PowderQuantity) as 'TotalSoftWater',
	CONVERT(decimal(18,3), ((SoftWater / PowderQuantity) * (Select [SoftWaterCost] from UtilityConsumptionCost))) as 'SoftWaterValue',
	CONVERT(decimal(18,3), Steam / PowderQuantity) as 'TotalSteam',
	CONVERT(decimal(18,3), ((Steam / PowderQuantity) * (Select SteamCost from UtilityConsumptionCost))) as 'SteamValue',
	CONVERT(decimal(18,3), (ISNULL(ChilledWater,0)) / PowderQuantity) as 'ChilledWater',
	CONVERT(decimal(18,3), ((ChilledWater / PowderQuantity) * (Select [ChilledWaterCost] from UtilityConsumptionCost))) as 'ChilledWaterValue'
into #LastData
 from 
	#tempUtilityTotal
--Select * from #LastData
Create Table #temp1 (Id int IDENTITY(1,1),Name varchar(20),Consumption float,cost float)

insert into #temp1 (Name,Consumption,cost)
values ('Electricity',(Select TotalPowder from #LastData),(Select ElectricityValue from #LastData))

insert into #temp1 (Name,Consumption,cost)
values ('Air',(Select TotalAir from #LastData),(Select AirValue from #LastData))

insert into #temp1 (Name,Consumption,cost)
values ('Soft Water',(Select TotalSoftWater from #LastData),(Select SoftWaterValue from #LastData))

insert into #temp1 (Name,Consumption,cost)
values ('Steam',(Select TotalSteam from #LastData),(Select SteamValue from #LastData))

insert into #temp1 (Name,Consumption,cost)
values ('Chilled Water',(Select ChilledWater from #LastData),(Select ChilledWaterValue from #LastData))


Select * from #temp1

Select sum(cost) as 'TotalCostPerKg' from #temp1 

Drop table #tempUtilityTotal,#temp1,#LastData

Create Table #temp2 (Id int IDENTITY(1,1),Name varchar(40),Consumption float)

insert into #temp2 (Name,Consumption)
values ('Steam/kg',(Select [SteamCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Electricity (Per Unit KWH)',(Select [PowerCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Air (Per Cu.mt) ',(Select [AirCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Soft Water/Litre',(Select [SoftWaterCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Chilled Water (1 TR cost)',(Select [ChilledWaterCost] from UtilityConsumptionCost))

Select * from #temp2
Drop table #temp2
--	Drop table #tempUtility
--End

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_PowderTreasability]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_PowderTreasability]  '07/14/2017','07/15/2019'
CREATE procedure [dbo].[usp_rpt_PowderTreasability]
(
	@FromDateTime datetime,
	@ToDateTime datetime
)
AS

Begin

Select row_number() OVER (ORDER BY id) as 'row1',LEAD(Id) over (Order By Id) as 'Next',* 
into #tempRowT1 from PowderTraceability where [ProcessDateTime] between @FromDateTime and @ToDateTime --where Id between @T1tempId and @T1ProcessId
--select * from #tempRowT1

Declare @ShiftName varchar(20) = null
Declare @ProductName varchar(50) = null
declare @a int = 1
Declare @TempT1 int = 1
declare @count int = (select count(*) from #tempRowT1)

----------------------------------- Create Temp Table --------------------------
Create table #tempProductTreacebility (Id int IDENTITY(1,1),Date varchar(10),
								StartTime varchar(8),StopTime varchar(8),PowderSilo varchar(50),TotalTime varchar(8),StartQuantity float,
								StopQuantity float,TotalQuantity varchar(10))
----------------------------------


	--if((Select StartTrigger from #temp1 where n = @a) = 0)
	begin
			----------------------------------- Create Temp Table for Start and End Id --------------------------
			Create table #TempTracebility1 (Id int IDENTITY(1,1),StartId int,EndId int)
			----------------------------------- Create Temp Table --------------------------

			Declare @T1ProcessId int = 1
			set @T1ProcessId = (select Id from #tempRowT1 where row1 = @a)
			Declare @T1tempId int = 1
			
			
			--Select row_number() OVER (ORDER BY id) as 'row1',LEAD(Id) over (Order By Id) as 'Next',* into #tempRowT1 from PowderTraceability where [ProcessDateTime] between @FromDateTime and @ToDateTime --where Id between @T1tempId and @T1ProcessId
			Declare @CountTemp int= (Select COUNT(*) from #tempRowT1)
			--Select * from #tempRowT1
			----------------------------It is used for Source Destination change-----------------------------------
			while(@TempT1 <= @CountTemp)
			Begin
				if((select CONVERT(varchar(10), [Next]) from #tempRowT1 where row1 = @CountTemp and StartTrigger != 0) != 'NULL')
				Begin
					insert into #TempTracebility1 (StartId,EndId) values ((select Id from #tempRowT1 where row1 = @CountTemp),(select Next from #tempRowT1 where row1 = @CountTemp))
					Set @T1ProcessId = (Select Id from #tempRowT1 where row1 = @CountTemp - 1)
				End
				
			Set @CountTemp = @CountTemp - 1
			End
			--Select * from #TempTracebility1
			
			Declare @T1Temp int = 1
			While(@T1Temp <= (Select Count(*) from #TempTracebility1))
			Begin
			
		
				Select 
					top 1(Select convert(time,ProcessDateTime,109) from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) as StartTime,
					(Select convert(time,ProcessDateTime,109) from #tempRowT1 where Id = (Select EndId from #TempTracebility1 where Id = @T1Temp)) as StopTime,
					(Select convert(varchar(10),ProcessDateTime,103) from #tempRowT1 where id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) as ProcessDateTime,
					isnull( (Select Name from SILO where IsDeleted = 0 and PLCValue = ((Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)))),'-' ) as PowderSilo,
					(select convert(varchar(5),DateDiff(s, (select top 1 ProcessDateTime from #tempRowT1 where id between (Select StartId from #TempTracebility1 where Id = @T1Temp) and (Select EndId from #TempTracebility1 where Id = @T1Temp)), (select top 1 ProcessDateTime from #tempRowT1 where id between (Select StartId from #TempTracebility1 where Id = @T1Temp) and (Select EndId from #TempTracebility1 where Id = @T1Temp) order by id desc))/3600)+':'+
								convert(varchar(5),DateDiff(s, (select top 1 ProcessDateTime from #tempRowT1 where id between (Select StartId from #TempTracebility1 where Id = @T1Temp) and (Select EndId from #TempTracebility1 where Id = @T1Temp)), (select top 1 ProcessDateTime from #tempRowT1 where id between (Select StartId from #TempTracebility1 where Id = @T1Temp) and (Select EndId from #TempTracebility1 where Id = @T1Temp) order by id desc))%3600/60)+':'+
								convert(varchar(5),(DateDiff(s, (select top 1 ProcessDateTime from #tempRowT1 where id between (Select StartId from #TempTracebility1 where Id = @T1Temp) and (Select EndId from #TempTracebility1 where Id = @T1Temp)), (select top 1 ProcessDateTime from #tempRowT1 where id between (Select StartId from #TempTracebility1 where Id = @T1Temp) and (Select EndId from #TempTracebility1 where Id = @T1Temp) order by id desc))%60))) as TotalTime,
					isnull( (case when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 1 then (Select QuantityT1 from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) 
					when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 2 then (Select QuantityT2 from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) 
					when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 3 then (Select QuantityT3 from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) 
					when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 4 then (Select QuantityT4 from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) end
					),0 )as StartQuantity,
					Isnull((case when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 1 then (Select QuantityT1 from #tempRowT1 where Id = (Select EndId from #TempTracebility1 where Id = @T1Temp)) 
					when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 2 then (Select QuantityT2 from #tempRowT1 where Id = (Select EndId from #TempTracebility1 where Id = @T1Temp)) 
					when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 3 then (Select QuantityT3 from #tempRowT1 where Id = (Select EndId from #TempTracebility1 where Id = @T1Temp)) 
					when (Select SILOID from #tempRowT1 where Id = (Select StartId from #TempTracebility1 where Id = @T1Temp)) = 4 then (Select QuantityT4 from #tempRowT1 where Id = (Select EndId from #TempTracebility1 where Id = @T1Temp)) end
					),0 )as StopQuantity
				into 
					#tempT1
				from 
					#tempRowT1
				group by ProcessDateTime,SiloId
				Insert into #tempProductTreacebility (StartTime,StopTime,Date,PowderSilo,TotalTime,StartQuantity,StopQuantity)
				(Select * from #tempT1)

				drop table #tempT1

				Set @T1Temp = @T1Temp + 1
			End
		drop table #TempTracebility1--,#tempT1

	
end
Select 
	row_number() OVER (ORDER BY [Date]) as SrNo,
	PowderSilo,
	[Date],
	StartTime,
	round(StartQuantity,2) as StartQuantity,
	StopTime,
	round(StopQuantity,2) as StopQuantity,
	--Destination ,
	TotalTime,
	round((StopQuantity - StartQuantity),2) as TotalQuantity
from 
	#tempProductTreacebility
order by Date,StartTime

drop table #tempProductTreacebility,#tempRowT1

End

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_ROCIP_New]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec usp_rpt_ROCIP_New '07/12/2019','07/12/2019',-1
CREATE PROCEDURE [dbo].[usp_rpt_ROCIP_New]
	   @FromDate datetime ,
		@ToDate datetime,
		@LineNo int =3
AS




Create table #temp1(n int IDENTITY(1,1),Id int,[Date] varchar(10),RoLine Varchar(10),StartTime Varchar(8), StopTime varchar(8),TotalTime varchar(10),StepNo varchar(50),FeedFlow float ,Pressure float,PH float,L1FLow float,L2FLow float,L2Temp float,Retentate float)
 
	create table #TempIDs (n int IDentity(1,1),Id int,RO1Step int,RO2Step int,RO3Step int)

	--Insert into #TempIDs(Id)
	--select a.Id from [dbo].[RO_CIP_New] a where a.[Ro1StepNo] =0 or a.[Ro2StepNo]=0 or a.[Ro3StepNo]=0 and convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  
	

	If(@LineNo = -1)
Begin

	Insert into #TempIDs(Id,RO1Step,RO2Step,RO3Step)
	select a.Id,a.Ro1StepNo,a.Ro2StepNo,a.Ro3StepNo from [dbo].[RO_CIP_New] a where a.[Ro1StepNo] =0 or a.[Ro2StepNo]=0 or a.[Ro3StepNo]=0 and convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

	
End
Else if(@LineNo = 1)
Begin
	Insert into #TempIDs(Id,RO1Step)
	select a.Id,a.Ro1StepNo from [dbo].[RO_CIP_New] a where a.[Ro1StepNo] =0  and convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

End
Else if(@LineNo = 2)
Begin
	Insert into #TempIDs(Id,RO2Step)
	select a.Id,a.Ro2StepNo from [dbo].[RO_CIP_New] a where a.[Ro2StepNo]=0 and convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

End
Else if(@LineNo = 3)
Begin
	Insert into #TempIDs(Id,RO3Step)
	select a.Id ,a.Ro3StepNo from [dbo].[RO_CIP_New] a where a.[Ro3StepNo]=0 and convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

End

  --select * from 	#TempIDs	

	
	declare @a int=1 ,@cnt int =0
	set @cnt = (select count (*) from #TempIDs) 
	--select @a as a,@cnt as cnt
	
	while(@a <= @cnt)
	begin
	-- WHile Loop Start

	---Ro 1 Cycle 
			if((Select a.RO1Step from #TempIDs a where n = @a) = 0)
			begin
			       
                  Declare @ProcessId1 int = null,@ProcessId int
				set @ProcessId1 = (select Id from #TempIDs where n = @a)
				set @ProcessId =(select Id from #TempIDs where n = @a)
				Declare @tempId1 int
		
				Select 
					row_number() OVER (ORDER BY id) [row],* into #tempROLOGReport1 
				from 
					RO_CIP_New
				where 
					Ro1StepNo between 0 and 30 and
					convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

			--select * from #tempROLOGReport1

				Declare @Row1 int = null
				set @Row1 = (Select [row] from #tempROLOGReport1 where id = @ProcessId1)
				while ((Select Id from #tempROLOGReport1 where Ro1StepNo != 0 and [Row] = @Row1 -1) != 0)
				begin
					set @tempId1 = (Select Id from #tempROLOGReport1 where Ro1StepNo != 0 and [Row] = @Row1 -1)
					set @Row1 = @Row1 - 1
				end

				--select @ProcessId as Pid,@tempId1 as tid 
				
				--- Ineer Looping Started
				declare @aa int ,@ccnt int
				set @aa=1
				set @ccnt=(select count(*) from #tempROLOGReport1) 
				
			--	select @aa as aa ,@ccnt as ccnt
				 while (@aa<= @ccnt)
				 begin
				     if((select a.Ro1StepNo from #tempROLOGReport1 a where row=@aa) in (3,4,5,6,7))
					 begin
					
					       declare @PID1 int  ,@EID1 int
						   set @PID1= (select Id from #tempROLOGReport1 where row=@aa)
						   set @EID1= (select Id from #tempROLOGReport1 where row=@aa+1)


						  -- select @PID1 as p1 , @EID1 as E1

					    Insert into #temp1 (Date,RoLine,StartTime,StopTime,TotalTime,StepNo,FeedFlow,Pressure,PH,L1FLow,L2FLow,L2Temp,Retentate)
						values(
						       (select convert( varchar(10),Datetime,103) from #tempROLOGReport1 where Id= @PID1 ),
							   'Ro-1',
							   (select convert( time,Datetime,109) from #tempROLOGReport1 where Id= @PID1 ),
							   (select convert( time,Datetime,109) from #tempROLOGReport1 where Id= @EID1),
							    (select convert(varchar(5),DateDiff(s, (select top 1 Datetime from #tempROLOGReport1 where id between @PID1 and @EID1), (select top 1 Datetime from #tempROLOGReport1 where id between @PID1 and @EID1 order by id desc))/3600)+':'+
							   convert(varchar(5),DateDiff(s, (select top 1 Datetime from #tempROLOGReport1 where id between @PID1 and @EID1), (select top 1 Datetime from #tempROLOGReport1 where id between @PID1 and @EID1 order by id desc))%3600/60)+':'+
							   convert(varchar(5),(DateDiff(s, (select top 1 Datetime from #tempROLOGReport1 where id between @PID1 and @EID1), (select top 1 Datetime from #tempROLOGReport1 where id between @PID1 and @EID1 order by id desc))%60))) ,
							   (select 
							      case when (a.Ro1StepNo = 3 ) then 'Pre-Heat'
								     when (a.Ro1StepNo=4) then 'Dose'
									 when (a.Ro1StepNo=5) then 'Heat'
									 when (a.Ro1StepNo=6) then 'Circulation'
									 when (a.Ro1StepNo=7) then 'Flush'
									 end 
								  from #tempROLOGReport1 a where Id= @PID1),
                                 (select  a.[F03-FT01_Flow] from #tempROLOGReport1 a where Id= @EID1),
							   (select  a.[F03-PT01_Pressure] from #tempROLOGReport1 a where Id= @EID1),
							   (select  a.PH from #tempROLOGReport1 a where Id= @EID1),
							   (select  a.Loop1_Flow from #tempROLOGReport1 a where Id= @EID1),
							   (select  a.Loop2_Flow from #tempROLOGReport1 a where Id= @EID1),
							   (select  a.Loop2_Temp from #tempROLOGReport1 a where Id= @EID1),
							   (select  a.Retentate from #tempROLOGReport1 a where Id= @EID1)
						)

						
					 end

					 set @aa =@aa+1
				 end
				--- Ineer Looping Ended





				drop table #tempROLOGReport1
			end

---Ro 1 Cycle  End

---Ro 2 Cycle 
        
		  	if((Select a.RO2Step from #TempIDs a where n = @a) = 0)
			begin
			       
                  Declare @ProcessId2 int = null,@ProcessId_2 int
				set @ProcessId2 = (select Id from #TempIDs where n = @a)
				set @ProcessId_2 =(select Id from #TempIDs where n = @a)
				Declare @tempId2 int
		
				Select 
					row_number() OVER (ORDER BY id) [row],* into #tempROLOGReport2 
				from 
					RO_CIP_New
				where 
					Ro2StepNo between 0 and 30 and
					convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

			--select * from #tempROLOGReport2

				Declare @Row2 int = null
				set @Row2 = (Select [row] from #tempROLOGReport2 where id = @ProcessId2)
				while ((Select Id from #tempROLOGReport2 where Ro2StepNo != 0 and [Row] = @Row2 -1) != 0)
				begin
					set @tempId2 = (Select Id from #tempROLOGReport2 where Ro2StepNo != 0 and [Row] = @Row2 -1)
					set @Row2 = @Row2 - 1
				end

				--select @ProcessId as Pid,@tempId1 as tid 
				
				--- Ineer Looping Started
				declare @aa2 int ,@ccnt2 int
				set @aa2=1
				set @ccnt2=(select count(*) from #tempROLOGReport2) 
				
			--	select @aa as aa ,@ccnt as ccnt
				 while (@aa2<= @ccnt2)
				 begin
				     if((select a.Ro2StepNo from #tempROLOGReport2 a where row=@aa2) in (3,4,5,6,7))
					 begin
					
					       declare @PID2 int  ,@EID2 int
						   set @PID2= (select Id from #tempROLOGReport2 where row=@aa2)
						   set @EID2= (select Id from #tempROLOGReport2 where row=@aa2+1)


						  -- select @PID1 as p1 , @EID1 as E1

					    Insert into #temp1 (Date,RoLine,StartTime,StopTime,TotalTime,StepNo,FeedFlow,Pressure,PH,L1FLow,L2FLow,L2Temp,Retentate)
						values(
						       (select convert( varchar(10),Datetime,103) from #tempROLOGReport2 where Id= @PID2 ),
							   'Ro-2',
							   (select convert( time,Datetime,109) from #tempROLOGReport2 where Id= @PID2 ),
							   (select convert( time,Datetime,109) from #tempROLOGReport2 where Id= @EID2),
							    (select convert(varchar(5),DateDiff(s, (select top 1 Datetime from #tempROLOGReport2 where id between @PID2 and @EID2), (select top 1 Datetime from #tempROLOGReport2 where id between @PID2 and @EID2 order by id desc))/3600)+':'+
							   convert(varchar(5),DateDiff(s, (select top 1 Datetime from #tempROLOGReport2 where id between @PID2 and @EID2), (select top 1 Datetime from #tempROLOGReport2 where id between @PID2 and @EID2 order by id desc))%3600/60)+':'+
							   convert(varchar(5),(DateDiff(s, (select top 1 Datetime from #tempROLOGReport2 where id between @PID2 and @EID2), (select top 1 Datetime from #tempROLOGReport2 where id between @PID2 and @EID2 order by id desc))%60))) ,
							   (select 
							      case when (a.Ro2StepNo = 3 ) then 'Pre-Heat'
								     when (a.Ro2StepNo=4) then 'Dose'
									 when (a.Ro2StepNo=5) then 'Heat'
									 when (a.Ro2StepNo=6) then 'Circulation'
									 when (a.Ro2StepNo=7) then 'Flush'
									 end 
								  from #tempROLOGReport2 a where Id= @PID2),
                                 (select  a.[F03-FT01_Flow] from #tempROLOGReport2 a where Id= @EID2),
							   (select  a.[F03-PT01_Pressure] from #tempROLOGReport2 a where Id= @EID2),
							   (select  a.PH from #tempROLOGReport2 a where Id= @EID2),
							   (select  a.Loop1_Flow from #tempROLOGReport2 a where Id= @EID2),
							   (select  a.Loop2_Flow from #tempROLOGReport2 a where Id= @EID2),
							   (select  a.Loop2_Temp from #tempROLOGReport2 a where Id= @EID2),
							   (select  a.Retentate from #tempROLOGReport2 a where Id= @EID2)
						)

						
					 end

					 set @aa2 =@aa2+1
				 end
				--- Ineer Looping Ended





				drop table #tempROLOGReport2
			end
---Ro 2 Cycle End

--RO 3 Cycle Start
           
		   	if((Select a.RO3Step from #TempIDs a where n = @a) = 0)
			begin
			       
                  Declare @ProcessId3 int = null,@ProcessId_3 int
				set @ProcessId3 = (select Id from #TempIDs where n = @a)
				set @ProcessId_3 =(select Id from #TempIDs where n = @a)
				Declare @tempId3 int
		
				Select 
					row_number() OVER (ORDER BY id) [row],* into #tempROLOGReport3 
				from 
					RO_CIP_New
				where 
					Ro3StepNo between 0 and 30 and
					convert(Date,Datetime,103) between convert (Date,@FromDate,103) and convert( date,@ToDate,103)  

			--select * from #tempROLOGReport3

				Declare @Row3 int = null
				set @Row3 = (Select [row] from #tempROLOGReport3 where id = @ProcessId3)
				while ((Select Id from #tempROLOGReport3 where Ro3StepNo != 0 and [Row] = @Row3 -1) != 0)
				begin
					set @tempId3 = (Select Id from #tempROLOGReport3 where Ro3StepNo != 0 and [Row] = @Row3 -1)
					set @Row3 = @Row3 - 1
				end

				--select @ProcessId as Pid,@tempId1 as tid 
				
				--- Ineer Looping Started
				declare @aa3 int ,@ccnt3 int
				set @aa3=1
				set @ccnt3=(select count(*) from #tempROLOGReport3) 
				
			--	select @aa as aa ,@ccnt as ccnt
				 while (@aa3<= @ccnt3)
				 begin
				     if((select a.Ro3StepNo from #tempROLOGReport3 a where row=@aa3) in (3,4,5,6,7))
					 begin
					
					       declare @PID3 int  ,@EID3 int
						   set @PID3= (select Id from #tempROLOGReport3 where row=@aa3)
						   set @EID3= (select Id from #tempROLOGReport3 where row=@aa3+1)


						  -- select @PID1 as p1 , @EID1 as E1

					    Insert into #temp1 (Date,RoLine,StartTime,StopTime,TotalTime,StepNo,FeedFlow,Pressure,PH,L1FLow,L2FLow,L2Temp,Retentate)
						values(
						       (select convert( varchar(10),Datetime,103) from #tempROLOGReport3 where Id= @PID3 ),
							   'Ro-3',
							   (select convert( time,Datetime,109) from #tempROLOGReport3 where Id= @PID3 ),
							   (select convert( time,Datetime,109) from #tempROLOGReport3 where Id= @EID3),
							    (select convert(varchar(5),DateDiff(s, (select top 1 Datetime from #tempROLOGReport3 where id between @PID3 and @EID3), (select top 1 Datetime from #tempROLOGReport3 where id between @PID3 and @EID3 order by id desc))/3600)+':'+
							   convert(varchar(5),DateDiff(s, (select top 1 Datetime from #tempROLOGReport3 where id between @PID3 and @EID3), (select top 1 Datetime from #tempROLOGReport3 where id between @PID3 and @EID3 order by id desc))%3600/60)+':'+
							   convert(varchar(5),(DateDiff(s, (select top 1 Datetime from #tempROLOGReport3 where id between @PID3 and @EID3), (select top 1 Datetime from #tempROLOGReport3 where id between @PID3 and @EID3 order by id desc))%60))) ,
							   (select 
							      case when (a.Ro3StepNo = 3 ) then 'Pre-Heat'
								     when (a.Ro3StepNo=4) then 'Dose'
									 when (a.Ro3StepNo=5) then 'Heat'
									 when (a.Ro3StepNo=6) then 'Circulation'
									 when (a.Ro3StepNo=7) then 'Flush'
									 end 
								  from #tempROLOGReport3 a where Id= @PID3),
                                 (select  a.[F03-FT01_Flow] from #tempROLOGReport3 a where Id= @EID3),
							   (select  a.[F03-PT01_Pressure] from #tempROLOGReport3 a where Id= @EID3),
							   (select  a.PH from #tempROLOGReport3 a where Id= @EID3),
							   (select  a.Loop1_Flow from #tempROLOGReport3 a where Id= @EID3),
							   (select  a.Loop2_Flow from #tempROLOGReport3 a where Id= @EID3),
							   (select  a.Loop2_Temp from #tempROLOGReport3 a where Id= @EID3),
							   (select  a.Retentate from #tempROLOGReport3 a where Id= @EID3)
						)

						
					 end

					 set @aa3 =@aa3+1
				 end
				--- Ineer Looping Ended

				drop table #tempROLOGReport3
			end

--RO 3 Cycle End


     set @a=@a+1

  -- WHile End
	End
		
		
		
	--select * from #temp1	
		select 
		     a.Date,
			 a.StartTime,
			 a.StopTime,
			 a.TotalTime,
			 a.RoLine,
			 a.StepNo,
			 round(a.FeedFlow,2) as 'FeedFlow - F03-FT01 (ltr/hr)',
			 round(a.Pressure,2) as 'Pressure - F03-PT01 (Bar)',
			  round(a.PH,2) as 'pH',
			  round(a.L1FLow,2) as 'Loop1-Flow - L01-FT01 (ltr/hr)',
			  round(a.L2FLow,2) as 'Loop2-Flow - L02-FT01 (ltr/hr)',
			  round(a.L2Temp,2) as 'Loop2-Temp. - A02-TT01 (Deg C)',
			  round(a.Retentate,2) as 'RetentateFlow - R01-FT01 (ltr/hr) '
	    from #temp1 a
			
drop table #temp1,#TempIDs

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_ROCIPLOG]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_CIPLOGReport] '03/17/2019','03/18/2019',-1
CREATE procedure [dbo].[usp_rpt_ROCIPLOG]
	@FromDate datetime,
	@LineNo int 
AS

--declare @FromDate datetime = '03/20/2019'
--declare @LineNo int = -1
Create table #temp1(n int IDENTITY(1,1),Id int,[Date] varchar(10),StepNoCIP1 int,[StepNoCIP2] int,[StepNoCIP3] int,[Trigger] int,
								F03PT01 decimal(18,2),F03FT01 decimal(18),L01FT01 decimal(18,2),L02FT01 decimal(18,2))
If(@LineNo = -1)
Begin

	Insert into #temp1
		([Id],[Date],StepNoCIP1,[StepNoCIP2],[StepNoCIP3],[Trigger],F03PT01,F03FT01,L01FT01,L02FT01) 
	(Select 
		[Id],[DateTime],[StepNoCIP1],[StepNoCIP2],[StepNoCIP3],[Trigger],[F03_PT01],[F03_FT01],[L01_FT01],[L02_FT01]
	from 
		ROCIP t 
	where 
		([StepNoCIP1] = 0 or [StepNoCIP2] = 0 or [StepNoCIP3] = 0) and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103)) 

	
End
Else if(@LineNo = 1)
Begin
	Insert into #temp1
		([Id],[Date],[StepNoCIP1],[Trigger],F03PT01,F03FT01,L01FT01,L02FT01) 
	(Select 
		[Id],[DateTime],[StepNoCIP1],[Trigger],[F03_PT01],[F03_FT01],[L01_FT01],[L02_FT01]
	from 
		ROCIP t 
	where 
		([StepNoCIP1] = 0) and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103))
End
Else if(@LineNo = 2)
Begin
	Insert into #temp1
		([Id],[Date],[StepNoCIP2],[Trigger],F03PT01,F03FT01,L01FT01,L02FT01) 
	(Select 
		[Id],[DateTime],[StepNoCIP2],[Trigger],[F03_PT01],[F03_FT01],[L01_FT01],[L02_FT01] 
	from 
		ROCIP t 
	where 
		([StepNoCIP2] = 0) and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103))
End
Else if(@LineNo = 3)
Begin
	Insert into #temp1
		([Id],[Date],[StepNoCIP3],[Trigger],F03PT01,F03FT01,L01FT01,L02FT01) 
	(Select 
		[Id],[DateTime],[StepNoCIP3],[Trigger],[F03_PT01],[F03_FT01],[L01_FT01],[L02_FT01] 
	from 
		ROCIP t
	where 
		([StepNoCIP3] = 0) and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103)) 
End
--Select 
--		row_number() OVER (ORDER BY [DateTime]) n,t.* 
--into 
--	#temp1 
--from 
--	ROCIP t 
--where 
--	([StepNoCIP1] = 0 or [StepNoCIP2] = 0 or [StepNoCIP3] = 0) and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103)

--Select * from #temp1
declare @a int = 1
declare @count int = (select count(*) from #temp1)
Create table #tmpCIPLOGReport (Id int IDENTITY(1,1),StartTime varchar(8),StopTime varchar(8),[Date] varchar(10),TotalTimeInCIP varchar(8),ROName varchar(10),StepNo int,
								F03PT01 decimal(18,2),F03FT01 decimal(18),L01FT01 decimal(18,2),L02FT01 decimal(18,2))

while (@a <= @count)
begin

if((Select [StepNoCIP1] from #temp1 where n = @a) = 0)
begin
	Declare @ProcessId1 int = null
	set @ProcessId1 = (select Id from #temp1 where n = @a)
	Declare @tempId1 int
		
	Select 
		row_number() OVER (ORDER BY id) [row],* into #tempROLOGReport1 
	from 
		ROCIP
	where 
		[StepNoCIP1] between 0 and 30
		and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103)
			--select * from #tempROLOGReport1
	Declare @Row1 int = null
	set @Row1 = (Select [row] from #tempROLOGReport1 where id = @ProcessId1)
	while ((Select Id from #tempROLOGReport1 where [StepNoCIP1] != 0 and [Row] = @Row1 -1) != 0)
	begin
		set @tempId1 = (Select Id from #tempROLOGReport1 where [StepNoCIP1] != 0 and [Row] = @Row1 -1)
		set @Row1 = @Row1 - 1
	end
			
	Select 
		row_number() OVER (ORDER BY id) [row1],* 
	into 
		#tempROCIPTrigger1 
	from 
		#tempROLOGReport1
	where 
		Id between @tempId1 and @ProcessId1
		and [Trigger] = 1
			
		declare @aTrigger1 int = 1
		Declare @CountTrigger1 int = (Select COUNT(*) from #tempROCIPTrigger1)	
--Select * from #tempROCIPTrigger1
		while (@aTrigger1 <= @CountTrigger1)
		begin
			

			Select 
				top 1 
					(Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)) as StartTime,
				(Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROLOGReport1 where row = (select row from #tempROCIPTrigger1 where row1 = @aTrigger1) + 1)) as StopTime,
				(Select convert(varchar(10),@FromDate,103)) as [Date],
				(select convert(varchar(5),DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)), (Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROLOGReport1 where row = (select row from #tempROCIPTrigger1 where row1 = @aTrigger1) + 1)))/3600)+':'+
							convert(varchar(5),DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)), (Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROLOGReport1 where row = (select row from #tempROCIPTrigger1 where row1 = @aTrigger1) + 1)))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)), (Select convert(time,[DateTime],109) from #tempROLOGReport1 where id = (select Id from #tempROLOGReport1 where row = (select row from #tempROCIPTrigger1 where row1 = @aTrigger1) + 1)))%60))) as TotalTimeInCIP,
				'Ro - 1'as ROName,
				(Select StepNoCIP1 from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)) as StepNo,
				(Select F03_PT01 from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)) as 'F03_PT01',
				(Select [F03_FT01] from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)) as 'F03_FT01',
				(Select [L01_FT01] from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)) as 'L01_FT01',
				(Select [L02_FT01] from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger1 where row1 = @aTrigger1)) as 'L02_FT01'
			into 
				#tempProcess1
			from 
				#tempROLOGReport1
			where 
				Id between @tempId1 and (select Id from #temp1 where n = @a)
		--select * from #tempProcess1
		Insert into #tmpCIPLOGReport 
			(StartTime,StopTime,[Date],TotalTimeInCIP,ROName,StepNo,F03PT01,F03FT01,L01FT01,L02FT01)
		(Select * from #tempProcess1)

			drop table #tempProcess1
		Set @aTrigger1 = @aTrigger1 + 1
		End

		drop table #tempROLOGReport1,#tempROCIPTrigger1
end
else if((Select [StepNoCIP2] from #temp1 where n = @a) = 0)
begin
	Declare @ProcessId2 int = null
	set @ProcessId2 = (select Id from #temp1 where n = @a)
	Declare @tempId2 int
		
	Select 
		row_number() OVER (ORDER BY id) [row],* into #tempROLOGReport2 
	from 
		ROCIP
	where 
		[StepNoCIP2] between 0 and 30
		and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103)
			--select * from #tempROLOGReport2
	Declare @Row2 int = null
	set @Row2 = (Select [row] from #tempROLOGReport2 where id = @ProcessId2)
	while ((Select Id from #tempROLOGReport2 where [StepNoCIP2] != 0 and [Row] = @Row2 -1) != 0)
	begin
		set @tempId2 = (Select Id from #tempROLOGReport2 where [StepNoCIP2] != 0 and [Row] = @Row2 -1)
		set @Row2 = @Row2 - 1
	end
			
	Select 
		row_number() OVER (ORDER BY id) [row1],* 
	into 
		#tempROCIPTrigger2 
	from 
		#tempROLOGReport2
	where 
		Id between @tempId2 and @ProcessId2
		and [Trigger] = 1
			
		declare @aTrigger2 int = 1
		Declare @CountTrigger2 int = (Select COUNT(*) from #tempROCIPTrigger2)	
--Select * from #tempROCIPTrigger2
		while (@aTrigger2 <= @CountTrigger2)
		begin
			

			Select 
				top 1 
					(Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)) as StartTime,
				(Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROLOGReport2 where row = (select row from #tempROCIPTrigger2 where row1 = @aTrigger2) + 1)) as StopTime,
				(Select convert(varchar(10),@FromDate,103)) as [Date],
				(select convert(varchar(5),DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)), (Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROLOGReport2 where row = (select row from #tempROCIPTrigger2 where row1 = @aTrigger2) + 1)))/3600)+':'+
							convert(varchar(5),DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)), (Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROLOGReport2 where row = (select row from #tempROCIPTrigger2 where row1 = @aTrigger2) + 1)))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)), (Select convert(time,[DateTime],109) from #tempROLOGReport2 where id = (select Id from #tempROLOGReport2 where row = (select row from #tempROCIPTrigger2 where row1 = @aTrigger2) + 1)))%60))) as TotalTimeInCIP,
				'Ro - 2'as ROName,
				(Select StepNoCIP2 from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)) as StepNo,
				(Select F03_PT01 from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)) as 'F03_PT01',
				(Select [F03_FT01] from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)) as 'F03_FT01',
				(Select [L01_FT01] from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)) as 'L01_FT01',
				(Select [L02_FT01] from #tempROLOGReport2 where id = (select Id from #tempROCIPTrigger2 where row1 = @aTrigger2)) as 'L02_FT01'
			into 
				#tempProcess2
			from 
				#tempROLOGReport2
			where 
				Id between @tempId2 and (select Id from #temp1 where n = @a)
		--select * from #tempProcess2
		Insert into #tmpCIPLOGReport 
			(StartTime,StopTime,[Date],TotalTimeInCIP,ROName,StepNo,F03PT01,F03FT01,L01FT01,L02FT01)
		(Select * from #tempProcess2)

			drop table #tempProcess2
			Set @aTrigger2 = @aTrigger2 + 1
		End

		drop table #tempROLOGReport2,#tempROCIPTrigger2
end
else if((Select [StepNoCIP3] from #temp1 where n = @a) = 0)
begin
	Declare @ProcessId3 int = null
	set @ProcessId3 = (select Id from #temp1 where n = @a)
	Declare @tempId3 int
		
	Select 
		row_number() OVER (ORDER BY id) [row],* into #tempROLOGReport3 
	from 
		ROCIP
	where 
		[StepNoCIP3] between 0 and 30
		and CONVERT(Date,[DateTime],103) = CONVERT(Date,@FromDate,103)
			--select * from #tempROLOGReport3
	Declare @Row3 int = null
	set @Row3 = (Select [row] from #tempROLOGReport3 where id = @ProcessId3)
	while ((Select Id from #tempROLOGReport3 where [StepNoCIP3] != 0 and [Row] = @Row3 -1) != 0)
	begin
		set @tempId3 = (Select Id from #tempROLOGReport3 where [StepNoCIP3] != 0 and [Row] = @Row3 -1)
		set @Row3 = @Row3 - 1
	end
			
	Select 
		row_number() OVER (ORDER BY id) [row1],* 
	into 
		#tempROCIPTrigger3 
	from 
		#tempROLOGReport3
	where 
		Id between @tempId3 and @ProcessId3
		and [Trigger] = 1
			
		declare @aTrigger3 int = 1
		Declare @CountTrigger3 int = (Select COUNT(*) from #tempROCIPTrigger3)	
--Select * from #tempROCIPTrigger3
		while (@aTrigger3 <= @CountTrigger3)
		begin
			

			Select 
				top 1 
					(Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)) as StartTime,
				(Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROLOGReport3 where row = (select row from #tempROCIPTrigger3 where row1 = @aTrigger3) + 1)) as StopTime,
				(Select convert(varchar(10),@FromDate,103)) as [Date],
				(select convert(varchar(5),DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)), (Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROLOGReport3 where row = (select row from #tempROCIPTrigger3 where row1 = @aTrigger3) + 1)))/3600)+':'+
							convert(varchar(5),DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)), (Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROLOGReport3 where row = (select row from #tempROCIPTrigger3 where row1 = @aTrigger3) + 1)))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)), (Select convert(time,[DateTime],109) from #tempROLOGReport3 where id = (select Id from #tempROLOGReport3 where row = (select row from #tempROCIPTrigger3 where row1 = @aTrigger3) + 1)))%60))) as TotalTimeInCIP,
				'Ro - 3'as ROName,
				(Select StepNoCIP3 from #tempROLOGReport1 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)) as StepNo,
				(Select F03_PT01 from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)) as 'F03_PT01',
				(Select [F03_FT01] from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)) as 'F03_FT01',
				(Select [L01_FT01] from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)) as 'L01_FT01',
				(Select [L02_FT01] from #tempROLOGReport3 where id = (select Id from #tempROCIPTrigger3 where row1 = @aTrigger3)) as 'L02_FT01'
			into 
				#tempProcess3
			from 
				#tempROLOGReport3
			where 
				Id between @tempId3 and (select Id from #temp1 where n = @a)
		--select * from #tempProcess3
		Insert into #tmpCIPLOGReport 
			(StartTime,StopTime,[Date],TotalTimeInCIP,ROName,StepNo,F03PT01,F03FT01,L01FT01,L02FT01)
		(Select * from #tempProcess3)

			drop table #tempProcess3
			Set @aTrigger3 = @aTrigger3 + 1
		End

		drop table #tempROLOGReport3,#tempROCIPTrigger3
end

	set @a = @a + 1
	
end

select 
	row_number() OVER (ORDER BY id) as SrNo,
	[Date],
	StartTime,
	StopTime,
	TotalTimeInCIP as 'Total Time',
	ROName,
	StepNo,
	F03PT01 as 'F03PT01 (Bar)',
	F03FT01 as 'F03FT01 (ltr/h)',
	L01FT01 as 'L01FT01 (ltr/h)',
	L02FT01 as 'L02FT01 (ltr/h)'
from
	#tmpCIPLOGReport

--select * from #tmpCIPLOGReport
drop table #temp1,#tmpCIPLOGReport


GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_ROLOGReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_ROLOGReport] '07/11/2019','07/15/2019',-1
CREATE procedure [dbo].[usp_rpt_ROLOGReport]
	@FromDateTime datetime,
	@ToDateTime datetime,	
	@ROID int
AS

if(@ROID = -1)
 Begin
	Select 
		'RO_1' as 'RO Unit',
		[DateTime],
		round([F03_FT01],2) as F03_FT01,
		round([F03_SC],2) as F03_SC,
		round([PRESSURE],2) as PRESSURE,
		round([PH],2) as PH,
		round([L1_FLOW],2) as L1_FLOW,
		round([L2_FLOW],2) as L2_FLOW,
		round([L2_TEMP],2) as L2_TEMP,
		round([RETENTATE_FLOW],2) as RETENTATE_FLOW,
		round([PERMEATE_CONDUCTIVITY],2) as PERMEATE_CONDUCTIVITY
	From 
		RO_1 
	Where 
		[DateTime] between @FromDateTime and @ToDateTime 

	Union all

	Select 
		'RO_2' as 'RO Unit',
		[DateTime],
		round([F03_FT01],2) as F03_FT01,
		round([F03_SC],2) as F03_SC,
		round([PRESSURE],2) as PRESSURE,
		round([PH],2) as PH,
		round([L1_FLOW],2) as L1_FLOW,
		round([L2_FLOW],2) as L2_FLOW,
		round([L2_TEMP],2) as L2_TEMP,
		round([RETENTATE_FLOW],2) as RETENTATE_FLOW,
		round([PERMEATE_CONDUCTIVITY],2) as PERMEATE_CONDUCTIVITY
	From 
		RO_2
	Where 
		[DateTime] between @FromDateTime and @ToDateTime 

	Union all

	Select 
		'RO_3' as 'RO Unit',
		[DateTime],
		round([F03_FT01],2) as F03_FT01,
		round([F03_SC],2) as F03_SC,
		round([PRESSURE],2) as PRESSURE,
		round([PH],2) as PH,
		round([L1_FLOW],2) as L1_FLOW,
		round([L2_FLOW],2) as L2_FLOW,
		round([L2_TEMP],2) as L2_TEMP,
		round([RETENTATE_FLOW],2) as RETENTATE_FLOW,
		round([PERMEATE_CONDUCTIVITY],2) as PERMEATE_CONDUCTIVITY
	From 
		RO_3 
	Where 
		[DateTime] between @FromDateTime and @ToDateTime 
	End

Else if(@ROID = 1)
	Begin
	Select 
		'RO_1' as 'RO Unit',
		[DateTime],
		round([F03_FT01],2) as F03_FT01,
		round([F03_SC],2) as F03_SC,
		round([PRESSURE],2) as PRESSURE,
		round([PH],2) as PH,
		round([L1_FLOW],2) as L1_FLOW,
		round([L2_FLOW],2) as L2_FLOW,
		round([L2_TEMP],2) as L2_TEMP,
		round([RETENTATE_FLOW],2) as RETENTATE_FLOW,
		round([PERMEATE_CONDUCTIVITY],2) as PERMEATE_CONDUCTIVITY
	From 
		RO_1 
	Where 
		[DateTime] between @FromDateTime and @ToDateTime 
	End

Else if(@ROID = 2)
	Begin
	Select 
		'RO_2' as 'RO Unit',	
		[DateTime],
		round([F03_FT01],2) as F03_FT01,
		round([F03_SC],2) as F03_SC,
		round([PRESSURE],2) as PRESSURE,
		round([PH],2) as PH,
		round([L1_FLOW],2) as L1_FLOW,
		round([L2_FLOW],2) as L2_FLOW,
		round([L2_TEMP],2) as L2_TEMP,
		round([RETENTATE_FLOW],2) as RETENTATE_FLOW,
		round([PERMEATE_CONDUCTIVITY],2) as PERMEATE_CONDUCTIVITY
	From 
			RO_2 
	Where 
			[DateTime] between @FromDateTime and @ToDateTime 
	End

Else if(@ROID = 3)
	Begin
	Select 
		'RO_3' as 'RO Unit',
		[DateTime],
		round([F03_FT01],2) as F03_FT01,
		round([F03_SC],2) as F03_SC,
		round([PRESSURE],2) as PRESSURE,
		round([PH],2) as PH,
		round([L1_FLOW],2) as L1_FLOW,
		round([L2_FLOW],2) as L2_FLOW,
		round([L2_TEMP],2) as L2_TEMP,
		round([RETENTATE_FLOW],2) as RETENTATE_FLOW,
		round([PERMEATE_CONDUCTIVITY],2) as PERMEATE_CONDUCTIVITY
	From 
		RO_3 
	Where 
		[DateTime] between @FromDateTime and @ToDateTime 
	End
	

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_ROPermeate_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_ROPermeate_Report] '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_ROPermeate_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when TypesofMilk = 0 then 'None'
					when TypesofMilk = 1 then 'Raw Whey'
					when TypesofMilk =2 then 'Past Whey'
					when TypesofMilk = 3 then 'Mozzerella Cheese Whey'
					when TypesofMilk = 4 then 'Panner Whey'
					when TypesofMilk= 5 then 'Raw Cream'
					when TypesofMilk= 6 then 'Past. Cream'
					when TypesofMilk= 7 then 'NF Whey'
					when TypesofMilk= 8 then 'Permeat Water'
					 end as TypesofMilk,
				--  W11T01TankStatus,
				  case when TankStatus = 0 then 'Unclean'
				  when TankStatus = 1 then 'Clean'end as TankStatus,
				  cast(M1.Qty as decimal (18,2)) as Qty,
				  cast(M1.Temp as decimal (18,2))as Temp ,
				  QtyofwatertoCIPKichen,
				  M1.AgeingTimer,
				  M1.DirtyTime
				 
						
					
					
	from RO_Permeate_Status M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_ROProduction]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


-- exec [dbo].[usp_rpt_ROProduction] '07/11/2019','07/12/2019',-1
CREATE PROCEDURE [dbo].[usp_rpt_ROProduction]
	@FromDate datetime ,
    @ToDate   datetime,  
    @LineNo int 
AS

 create table #tmpId (n int identity(1,1),EId int,R1Start int ,R2Start int,R3Start int)

If(@LineNo = -1)
Begin
	  insert into #tmpId (EId ,R1Start,R2Start,R3Start)
	  (select a.Id,a.R1_ON_Product,a.R2_ON_Product,R3_ON_Product from [dbo].[RO_Production] a where  a.R1_ON_Product =0 or a.R2_ON_Product =0 or a.R3_ON_Product =0  and convert(date,DateTime,103)   between convert(date,@FromDate,103) and convert(date,@ToDate,103)) 
End

Else if(@LineNo = 1)
Begin
      insert into #tmpId (EId ,R1Start)
	  (select a.Id,a.R1_ON_Product from [dbo].[RO_Production] a where a.R1_ON_Product =0  and convert(date,DateTime) between convert(date,@FromDate) and convert(date,@ToDate)) 
End

Else if(@LineNo = 2)
Begin
    insert into #tmpId (EId ,R2Start)
	  (select a.Id,a.R2_ON_Product from [dbo].[RO_Production] a where a.R2_ON_Product =0  and convert(date,DateTime) between convert(date,@FromDate) and convert(date,@ToDate)) 
End

Else if(@LineNo = 3)
Begin
       insert into #tmpId (EId,R3Start)
	  (select a.Id,a.R3_ON_Product from [dbo].[RO_Production] a where a.R3_ON_Product =0  and convert(date,DateTime) between convert(date,@FromDate) and convert(date,@ToDate)) 
End

--select * from #tmpId

declare @a int=1,
        @cnt int=0
		
		set	@cnt =(select COUNT(*) from #tmpId)

		---Main Table created here
		Create table #tempData(SrNo int IDENTITY(1,1),ROUnit varchar(10),[Date] varchar(10),
							StartTime varchar(8),StopTime varchar(8),TotalTime varchar(8),FeedTotal float,
							PermeateTotal float,RetentateTotal float)


--select @a as a,@cnt as cnt

--- while loop started 
while(@a <= @cnt )
begin
	--- For Ro1 Cycles
     if((Select R1Start from #tmpId where n = @a) = 0)
	 begin
				Declare @ProcessId int, @ProcessId1 int = null,@tempId1 int=0
				set @ProcessId = (select EId from #tmpId where n = @a)
				set @ProcessId1 = (select EId from #tmpId where n = @a)
				
				Select 
					row_number() OVER (ORDER BY id) [row],* into #tempROProduction1 
				from 
					[RO_Production] a
				where 
				    a.R1_ON_Product in (0,1) and
					CONVERT(Date,[DateTime],103) between  CONVERT(Date,@FromDate,103) and CONVERT(Date,@ToDate,103)
		
				Declare @Row1 int = null
				set @Row1 = (Select [row] from #tempROProduction1 where id = @ProcessId1)
				while ((Select Id from #tempROProduction1 where R1_ON_Product != 0 and [Row] = @Row1 -1) != 0)
				begin
					set @tempId1 = (Select Id from #tempROProduction1 where R1_ON_Product != 0 and [Row] = @Row1 -1)
					set @Row1 = @Row1 - 1
				end

			--	select @ProcessId as pid,@tempId1 as tid

				insert into  #tempData(ROUnit,Date,StartTime,StopTime,TotalTime,FeedTotal,PermeateTotal,RetentateTotal)
				values
				(
				      'RO-1',
					  (select convert(varchar(10),a.DateTime,103) from #tempROProduction1 a where Id = @tempId1),
					  (select convert(time,a.DateTime,109) from #tempROProduction1 a where Id = @tempId1),
					  (select convert(time,a.DateTime,109) from #tempROProduction1 a where Id = @ProcessId),
					  (select convert(varchar(5),DateDiff(s, (select top 1 [DateTime] from #tempROProduction1 where id = @tempId1), (select top 1 [DateTime] from #tempROProduction1 where id = @ProcessId ))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [DateTime] from #tempROProduction1 where id = @tempId1 ), (select top 1 [DateTime] from #tempROProduction1 where id = @ProcessId ))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [DateTime] from #tempROProduction1 where id = @tempId1), (select top 1 [DateTime] from #tempROProduction1 where id = @ProcessId ))%60))),
                      (select isnull(round(a.R1_Feed_TOT,2),0) from #tempROProduction1 a where Id = @ProcessId),
					  (select isnull(round(a.R1_Permeate_TOT,2),0) from #tempROProduction1 a where Id = @ProcessId),
					  (select isnull(round(a.R1_Retentate_TOT,2),0) from #tempROProduction1 a where Id = @ProcessId)  
				)
				 
        drop table #tempROProduction1
	 end

	 else if((Select R2Start from #tmpId where n = @a) = 0)
	 begin

	          Declare @ProcessId2 int, @ProcessId2_1 int = null,@tempId2 int=0
				set @ProcessId2 = (select EId from #tmpId where n = @a)
				set @ProcessId2_1 = (select EId from #tmpId where n = @a)
				
				Select 
					row_number() OVER (ORDER BY id) [row],* into #tempROProduction2 
				from 
					[RO_Production] a
				where 
				    a.R2_ON_Product in (0,1) and
					CONVERT(Date,[DateTime],103) between  CONVERT(Date,@FromDate,103) and CONVERT(Date,@ToDate,103)
		
				Declare @Row2 int = null
				set @Row2 = (Select [row] from #tempROProduction2 where id = @ProcessId2_1)
				while ((Select Id from #tempROProduction2 where R2_ON_Product != 0 and [Row] = @Row2 -1) != 0)
				begin
					set @tempId2 = (Select Id from #tempROProduction2 where R2_ON_Product != 0 and [Row] = @Row2 -1)
					set @Row2 = @Row2 - 1
				end

			--	select @ProcessId2 as pid,@tempId2 as tid

				insert into  #tempData(ROUnit,Date,StartTime,StopTime,TotalTime,FeedTotal,PermeateTotal,RetentateTotal)
				values
				(
				      'RO-2',
					  (select convert(varchar(10),a.DateTime,103) from #tempROProduction2 a where Id = @tempId2),
					  (select convert(time,a.DateTime,109) from #tempROProduction2 a where Id = @tempId2),
					  (select convert(time,a.DateTime,109) from #tempROProduction2 a where Id = @ProcessId2),
					  (select convert(varchar(5),DateDiff(s, (select top 1 [DateTime] from #tempROProduction2 where id = @tempId2), (select top 1 [DateTime] from #tempROProduction2 where id = @ProcessId2 ))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [DateTime] from #tempROProduction2 where id = @tempId2 ), (select top 1 [DateTime] from #tempROProduction2 where id = @ProcessId2 ))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [DateTime] from #tempROProduction2 where id = @tempId2), (select top 1 [DateTime] from #tempROProduction2 where id = @ProcessId2 ))%60))),
                      (select isnull(round(a.R2_Feed_TOT,2),0) from #tempROProduction2 a where Id = @ProcessId2),
					  (select isnull(round(a.R2_Permeate_TOT,2),0) from #tempROProduction2 a where Id = @ProcessId2),
					  (select isnull(round(a.R2_Retentate_TOT,2),0) from #tempROProduction2 a where Id = @ProcessId2)  
				)
				 
			drop table #tempROProduction2

	 end

	 else if((Select R3Start from #tmpId where n = @a) = 0) 
	 begin
	       
		       Declare @ProcessId3 int, @ProcessId3_1 int = null,@tempId3 int=0
				set @ProcessId3 = (select EId from #tmpId where n = @a)
				set @ProcessId3_1 = (select EId from #tmpId where n = @a)
				
				Select 
					row_number() OVER (ORDER BY id) [row],* into #tempROProduction3 
				from 
					[RO_Production] a
				where 
				    a.R3_ON_Product in (0,1) and
					CONVERT(Date,[DateTime],103) between  CONVERT(Date,@FromDate,103) and CONVERT(Date,@ToDate,103)
		
		-- select * from #tempROProduction3

				Declare @Row3 int = null
				set @Row3 = (Select [row] from #tempROProduction3 where id = @ProcessId3_1)
				while ((Select Id from #tempROProduction3 where R3_ON_Product != 0 and [Row] = @Row3 -1) != 0)
				begin
					set @tempId3 = (Select Id from #tempROProduction3 where R3_ON_Product != 0 and [Row] = @Row3 -1)
					set @Row3 = @Row3 - 1
				end

			--	select @ProcessId3 as pid,@tempId3 as tid

				insert into  #tempData(ROUnit,Date,StartTime,StopTime,TotalTime,FeedTotal,PermeateTotal,RetentateTotal)
				values
				(
				      'RO-3',
					  (select convert(varchar(10),a.DateTime,103) from #tempROProduction3 a where Id = @tempId3),
					  (select convert(time,a.DateTime,109) from #tempROProduction3 a where Id = @tempId3),
					  (select convert(time,a.DateTime,109) from #tempROProduction3 a where Id = @ProcessId3),
					  (select convert(varchar(5),DateDiff(s, (select top 1 [DateTime] from #tempROProduction3 where id = @tempId3), (select top 1 [DateTime] from #tempROProduction3 where id = @ProcessId3 ))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [DateTime] from #tempROProduction3 where id = @tempId3 ), (select top 1 [DateTime] from #tempROProduction3 where id = @ProcessId3 ))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [DateTime] from #tempROProduction3 where id = @tempId3), (select top 1 [DateTime] from #tempROProduction3 where id = @ProcessId3 ))%60))),
                      (select isnull(round(a.R3_Feed_TOT,2),0) from #tempROProduction3 a where Id = @ProcessId3),
					  (select isnull(round(a.R3_Permeate_TOT,2),0) from #tempROProduction3 a where Id = @ProcessId3),
					  (select isnull(round(a.R3_Retentate_TOT,2),0) from #tempROProduction3 a where Id = @ProcessId3)  
				)
				 
			drop table #tempROProduction3
	 end


	

	set @a=@a+1
end
--- while loop ended
	select 
		a.SrNo,
		a.ROUnit,
		a.Date,
		a.StartTime,
		a.StopTime,
		a.TotalTime,
		round (isnull (a.FeedTotal,0),2) as 'FeedTotal (ltr)',
		round (isnull (a.PermeateTotal,0),2) as 'PermeateTotal (ltr)',
		round (isnull (a.RetentateTotal,0),2) as 'RetentateTotal (ltr)'
		--a.FeedTotal as 'FeedTotal (ltr)',
		--a.PermeateTotal as 'PermeateTotal (ltr)',
		--a.RetentateTotal as 'RetentateTotal (ltr)'
	from 
		#tempData a

	select 
	    'Total' as 'Sum',
		sum(round (isnull (a.FeedTotal,0),2)) as 'Feed Total (ltr)',
		sum(round (isnull (a.PermeateTotal,0),2)) as 'Permeate Total (ltr)',
		sum(round (isnull (a.RetentateTotal,0),2)) as 'Retentate Total (ltr)'
		
	from 
		#tempData a
		
drop table #tempData,#tmpId
	

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_RWSTStorage_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_RWSTStorage_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_RWSTStorage_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				    case when W11T01Typesofwhey = 0 then 'None'
					when W11T01Typesofwhey = 1 then 'Raw Whey'
					when W11T01Typesofwhey = 2 then 'Past Whey'
					when W11T01Typesofwhey = 3 then 'Mozzerella Cheese Whey'
					when W11T01Typesofwhey = 4 then 'Panner Whey'
					when W11T01Typesofwhey= 5 then 'Raw Cream'
					when W11T01Typesofwhey= 6 then 'Past. Cream'
					when W11T01Typesofwhey= 7 then 'NF Whey'
					when W11T01Typesofwhey= 8 then 'Permeat Water'
					 end as W11T01Typesofwhey,
				--  W11T01TankStatus,
				  case when W11T01TankStatus = 0 then 'Unclean'
				  when W11T01TankStatus = 1 then 'Clean'end as W11T01TankStatus,
				  cast(M1.W11T01Qty as decimal (18,2)) as W11T01Qty,
				  cast(M1.W11T01Temp as decimal (18,2))as W11T01Temp ,
				  M1.W11T01AgeingTimer,
				  M1.W11T01DirtyTime,
				   'Mozzerella Cheese whey' as W12T01Typesofwhey1,
				 -- W12T01TankStatus1,
				  case when W12T01TankStatus1 = 0 then 'Unclean'
				  when W12T01TankStatus1 = 1 then 'Clean'end as  W12T01TankStatus,
				  cast(M1.W12T01Qty1 as decimal (18,2)) as W12T01Qty1,
				  cast(M1.W12T01Temp1 as decimal (18,2))as W12T01Temp1 ,
				  M1.W12T01AgeingTimer1,
				  M1.W12T01DirtyTime1

				 
						
					
					
	from RWST_Storage M1 
	where
	[Datetime] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_SugarSyrup]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [usp_rpt_SugarSyrup] '03/03/2019','07/11/2019',-1
CREATE procedure [dbo].[usp_rpt_SugarSyrup]
(
	@FromDate datetime,
	@ToDate datetime,
	@LineNo int=-1
)
AS


Select  row_number() OVER (ORDER BY [Date]) n,t.*--,0 as IsDeleted 
	into #temp1 
from SugarSyrup t where ([FillingTriggerT1] = 0 or [DosingTriggerT1] = 0 or [CirculationTriggerT1] = 0
Or [FillingTriggerT2] = 0 or [DosingTriggerT2] = 0 or [CirculationTriggerT2] = 0) and [date] between @FromDate and @ToDate + 1


--select * from #temp1

declare @a int = 1
declare @count int = (select count(*) from #temp1)


Create table #tmpSugarSyrup (Id int IDENTITY(1,1),[Date] Date,[Time] varchar(8),Tank varchar(50),SugarSilo varchar(50),SugarQty varchar(10),BatchStartTime varchar(10),BatchStopTime varchar(10), 
BatchTotalTime varchar(10),WaterQty varchar(10),BatchTemp varchar(10),Operation varchar(50))

--Select * from #tmpSugarSyrup

while (@a <= @count)
begin
--select * from #temp1

	if((Select [FillingTriggerT1] from #temp1 where n = @a) = 0)
	begin
		Declare @ProcessId int = null
		set @ProcessId = (select Id from #temp1 where n = @a)
		Declare @tempId int
		Declare @tmpSiloId int = null
		--set @tmpSiloId = (select SugarSilo from #temp1 where n = @a)
		Select row_number() OVER (ORDER BY id) [row],* into #tmpSiloRow from SugarSyrup where [FillingTriggerT1] in (0,1)  and [date] between --and SugarSilo = @tmpSiloId and [date] between 
		@FromDate and @ToDate + 1
		--select * from #tmpSiloRow
		Declare @Row int = null
		set @Row = (Select [row] from #tmpSiloRow where id = @ProcessId)
		--select @Row
		while ((Select Id from #tmpSiloRow where [FillingTriggerT1] != 0 and [Row] = @Row -1) != 0)
		begin
			set @tempId = (Select Id from #tmpSiloRow where [FillingTriggerT1] != 0 and [Row] = @Row -1)
			set @Row = @Row - 1
		end
		--select @tempId
		 if (Isnull (@tempId,0) !=0)
		Begin
				select 
					top 1 convert(date,date,103) as [Date],
					convert(varchar(8),convert(time,date,103)) as [Time],
					'ST1' as Tank,
					'-' as SugarSilo,
					(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = @tempId) as BatchStartTime,
					(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchStopTime,
					(select convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId), (select date from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%60))) as BatchTotalTime,
					(select QtyWaterTakenT1 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) - (select QtyWaterTakenT1 from SugarSyrup where Id = @tempId) as WaterQty,
					--round(QtyWaterTakenT1,2) as WaterQty,
					0 as SugarQty,
					0 as BatchTemp,
					'Filling' as Operation
				Into 
					#tempLoading
				from 
					SugarSyrup 
				where 
					id between @tempId and (select id from #temp1 where n = @a)
					order by date desc
				
				--Select * from #tempLoading
				
				Insert Into #tmpSugarSyrup ([Date],[Time],Tank,SugarSilo,SugarQty,BatchStartTime,BatchStopTime,BatchTotalTime,WaterQty,BatchTemp,Operation) 
				values
				(
					(Select Date from #tempLoading),
					(Select Time from #tempLoading),
					(Select Tank from #tempLoading),
					(Select isnull( SugarSilo ,'-') from #tempLoading),
					(Select isnull (abs (SugarQty),0) from #tempLoading),
					(Select BatchStartTime from #tempLoading),
					(Select BatchStopTime from #tempLoading),
					(Select BatchTotalTime from #tempLoading),
					(Select isnull( WaterQty,0 ) from #tempLoading),
					(Select isnull ( BatchTemp,0) from #tempLoading),
					(Select Operation from #tempLoading)
				)
				--Select * from #tmpSugarSyrup
         drop table #tempLoading
		 End		
	drop table #tmpSiloRow  --,#tempUnloading
		--end
	end
	else if((Select [DosingTriggerT1] from #temp1 where n = @a) = 0)
	begin
	
				Declare @ProcessId1 int = null
				set @ProcessId1 = (select Id from #temp1 where n = @a)
				Declare @tempId1 int
				Declare @tmpSiloId1 int = null
				--set @tmpSiloId1 = (select TrasnferSiloNo from #temp1 where n = @a)
				Select row_number() OVER (ORDER BY id) [row],* into #tmpSiloRow1 from SugarSyrup where  [DosingTriggerT1] in (0,1)  and  [date] between -- TrasnferSiloNo = @tmpSiloId and [date] between 
				@FromDate and @ToDate  + 1
				--select * from #tmpSiloRow1
				Declare @Row1 int = null
				set @Row1 = (Select [row] from #tmpSiloRow1 where id = @ProcessId1)
				--select @Row
				while ((Select Id from #tmpSiloRow1 where [DosingTriggerT1] != 0 and [Row] = @Row1 -1) != 0)
				begin
					set @tempId1 = (Select Id from #tmpSiloRow1 where [DosingTriggerT1] != 0 and [Row] = @Row1 -1)
					set @Row1 = @Row1 - 1
				end

				 if (Isnull (@tempId1,0) !=0)
			  begin 
						select 
							top 1 convert(date,date,103) as [Date],
							convert(varchar(8),convert(time,date,103)) as [Time],
							'ST1' as Tank,
							(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SugarSilo from #tmpSiloRow1 where Id = @tempId1)) as SugarSilo,
							--'Silo 1' as SugarSilo,
							(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = @tempId1) as BatchStartTime,
							(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchStopTime,
							(select convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId1), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))/3600)+':'+
								convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId1), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%3600/60)+':'+
								convert(varchar(5),(DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId1), (select date from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%60))) as BatchTotalTime,
							0 as WaterQty,
							case when SugarSilo = 11000 then 
							(select SugarQtyTakenT1 from SugarSyrup where Id = @tempId1) - (select SugarQtyTakenT1 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) 
							else (select SugarQtyTakenT2 from SugarSyrup where Id = @tempId1) - (select SugarQtyTakenT2 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) 
							end as SugarQty,
							--SugarQtyTakenT1 as SugarQty,
							0 as BatchTemp,
							'Dosing' as Operation
						Into 
							#tempUnLoading
						from 
							SugarSyrup 
						where 
							id between @tempId1 and (select id from #temp1 where n = @a)
							order by date desc

						Insert Into #tmpSugarSyrup ([Date],[Time],Tank,SugarSilo,SugarQty,BatchStartTime,BatchStopTime,BatchTotalTime,WaterQty,BatchTemp,Operation) 
						values
						(
							(Select Date from #tempUnLoading),
							(Select Time from #tempUnLoading),
							(Select Tank from #tempUnLoading),
							(Select isnull( SugarSilo,'-' ) from #tempUnLoading),
							(Select isnull (abs (SugarQty),0) from #tempUnLoading),
							(Select BatchStartTime from #tempUnLoading),
							(Select BatchStopTime from #tempUnLoading),
							(Select BatchTotalTime from #tempUnLoading),
							(Select isnull( WaterQty,0 ) from #tempUnLoading),
							(Select isnull (BatchTemp,0) from #tempUnLoading),
							(Select Operation from #tempUnLoading)
						)
				--Select * from #tmpSugarSyrup
				drop table #tempUnLoading
				End
		drop table #tmpSiloRow1
	End
	else if((Select [CirculationTriggerT1] from #temp1 where n = @a) = 0)
	begin
	
				Declare @ProcessId3 int = null
				set @ProcessId3 = (select Id from #temp1 where n = @a)
				Declare @tempId3 int
				--Declare @tmpSiloId1 int = null
				--set @tmpSiloId1 = (select TrasnferSiloNo from #temp1 where n = @a)
				Select row_number() OVER (ORDER BY id) [row],* into #tmpSiloRow3 from SugarSyrup where  [CirculationTriggerT1] in (0,1)  and   [date] between -- TrasnferSiloNo = @tmpSiloId and [date] between 
				@FromDate and @ToDate  + 1
				--select * from #tmpSiloRow3
				Declare @Row3 int = null
				set @Row3 = (Select [row] from #tmpSiloRow3 where id = @ProcessId3)
				--select @Row
				while ((Select Id from #tmpSiloRow3 where [CirculationTriggerT1] != 0 and [Row] = @Row3 -1) != 0)
				begin
					set @tempId3 = (Select Id from #tmpSiloRow3 where [CirculationTriggerT1] != 0 and [Row] = @Row3 -1)
					set @Row3 = @Row3 - 1
				end

			 if (Isnull (@tempId3,0) !=0)
			 begin
				select 
					top 1 convert(date,date,103) as [Date],
					convert(varchar(8),convert(time,date,103)) as [Time],
					'ST1' as Tank,
					'-' as SugarSilo,
					(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = @tempId3) as BatchStartTime,
					(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchStopTime,
					(select convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId3), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))/3600)+':'+
						convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId3), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%3600/60)+':'+
						convert(varchar(5),(DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId3), (select date from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%60))) as BatchTotalTime,
					0 as WaterQty,
					0 as SugarQty,
					(select BatchTempT1 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchTemp,
					--BatchTempT1 as BatchTemp,
					'Circulation' as Operation
				Into 
					#tempSugarSyrup3
				from 
					SugarSyrup 
				where 
					id between @tempId3 and (select id from #temp1 where n = @a)
					order by date desc

					Insert Into #tmpSugarSyrup ([Date],[Time],Tank,SugarSilo,SugarQty,BatchStartTime,BatchStopTime,BatchTotalTime,WaterQty,BatchTemp,Operation) 
					values
					(
						(Select Date from #tempSugarSyrup3),
						(Select Time from #tempSugarSyrup3),
						(Select Tank from #tempSugarSyrup3),
						(Select isnull( SugarSilo , '-') from #tempSugarSyrup3),
						(Select isnull( abs (SugarQty),0) from #tempSugarSyrup3),
						(Select BatchStartTime from #tempSugarSyrup3),
						(Select BatchStopTime from #tempSugarSyrup3),
						(Select BatchTotalTime from #tempSugarSyrup3),
						(Select isnull (WaterQty,0) from #tempSugarSyrup3),
						(Select isnull( BatchTemp,0) from #tempSugarSyrup3),
						(Select Operation from #tempSugarSyrup3)
					)
					--Select * from #tmpSugarSyrup
					Drop table #tempSugarSyrup3
				 End
		drop table #tmpSiloRow3
	End
	else if((Select [FillingTriggerT2] from #temp1 where n = @a) = 0)
	begin
		Declare @ProcessId4 int = null
		set @ProcessId4 = (select Id from #temp1 where n = @a)
		Declare @tempId4 int
		--Declare @tmpSiloId int = null
		--set @tmpSiloId = (select SugarSilo from #temp1 where n = @a)
		Select row_number() OVER (ORDER BY id) [row],* into #tmpSiloRow4 from SugarSyrup where [FillingTriggerT2] in (0,1)  and [date] between --and SugarSilo = @tmpSiloId and [date] between 
		@FromDate and @ToDate + 1
		--select * from #tmpSiloRow4
		Declare @Row4 int = null
		set @Row4 = (Select [row] from #tmpSiloRow4 where id = @ProcessId4)
		--select @Row4
		while ((Select Id from #tmpSiloRow4 where [FillingTriggerT2] != 0 and [Row] = @Row4 -1) != 0)
		begin
			set @tempId4 = (Select Id from #tmpSiloRow4 where [FillingTriggerT2] != 0 and [Row] = @Row4 -1)
			set @Row4 = @Row4 - 1
		end
		--select @tempId4

		--select @tempId4 as 'Eid',(select Id as Pid from #temp1 where n = @a) 
		 
		 if (Isnull (@tempId4,0) !=0)
		 begin
		select 
			top 1 convert(date,date,103) as [Date],
			convert(varchar(8),convert(time,date,103)) as [Time],
			'ST2' as Tank,
			'-' as SugarSilo,
			(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = @tempId4) as BatchStartTime,
			(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchStopTime,
			(select convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId4), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))/3600)+':'+
					convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId4), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%3600/60)+':'+
					convert(varchar(5),(DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId4), (select date from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%60))) as BatchTotalTime,
			(select QtyWaterTakenT1 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) - (select QtyWaterTakenT1 from SugarSyrup where Id = @tempId4) as WaterQty,
			--round(QtyWaterTakenT1,2) as WaterQty,
			0 as SugarQty,
			0 as BatchTemp,
			'Filling' as Operation
		Into 
			#tempSugarSyrup4
		from 
			SugarSyrup 
		where 
			id between @tempId4 and (select id from #temp1 where n = @a)
			order by date desc
				
			--Select * from #tempSugarSyrup4
				
			Insert Into #tmpSugarSyrup ([Date],[Time],Tank,SugarSilo,SugarQty,BatchStartTime,BatchStopTime,BatchTotalTime,WaterQty,BatchTemp,Operation) 
		values
		(
			(Select Date from #tempSugarSyrup4),
			(Select Time from #tempSugarSyrup4),
			(Select Tank from #tempSugarSyrup4),
			(Select isnull (SugarSilo,'-' ) from #tempSugarSyrup4),
			(Select isnull (abs (SugarQty),0) from #tempSugarSyrup4),
			(Select BatchStartTime from #tempSugarSyrup4),
			(Select BatchStopTime from #tempSugarSyrup4),
			(Select BatchTotalTime from #tempSugarSyrup4),
			(Select isnull (WaterQty,0 ) from #tempSugarSyrup4),
			(Select isnull( BatchTemp ,0) from #tempSugarSyrup4),
			(Select Operation from #tempSugarSyrup4)
		)
			--Select * from #tmpSugarSyrup
			drop table #tempSugarSyrup4
		end		
			drop table #tmpSiloRow4  --,#tempUnloading
	

	end
	else if((Select [DosingTriggerT2] from #temp1 where n = @a) = 0)
	begin
	
				Declare @ProcessId5 int = null
				set @ProcessId5 = (select Id from #temp1 where n = @a)
				Declare @tempId5 int
				--Declare @tmpSiloId1 int = null
				--set @tmpSiloId1 = (select TrasnferSiloNo from #temp1 where n = @a)
				Select row_number() OVER (ORDER BY id) [row],* into #tmpSiloRow5 from SugarSyrup where  [DosingTriggerT2] in (0,1)  and  [date] between -- TrasnferSiloNo = @tmpSiloId and [date] between 
				@FromDate and @ToDate  + 1
				--select * from #tmpSiloRow5
				Declare @Row5 int = null
				set @Row5 = (Select [row] from #tmpSiloRow5 where id = @ProcessId5)
				--select @Row
				while ((Select Id from #tmpSiloRow5 where [DosingTriggerT2] != 0 and [Row] = @Row5 -1) != 0)
				begin
					set @tempId5 = (Select Id from #tmpSiloRow5 where [DosingTriggerT2] != 0 and [Row] = @Row5 -1)
					set @Row5 = @Row5 - 1
				end

        if (Isnull (@tempId5,0) !=0)
		begin
				
				select 
					top 1 convert(date,date,103) as [Date],
					convert(varchar(8),convert(time,date,103)) as [Time],
					'ST2' as Tank,
					(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SugarSilo from #tmpSiloRow5 where Id = @tempId5)) as SugarSilo,
					--'Silo 1' as SugarSilo,
					(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = @tempId5) as BatchStartTime,
					(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchStopTime,
					(select convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId5), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))/3600)+':'+
						convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId5), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%3600/60)+':'+
						convert(varchar(5),(DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId5), (select date from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%60))) as BatchTotalTime,
					0 as WaterQty,
					case when SugarSilo = 11000 then 
					(select SugarQtyTakenT1 from SugarSyrup where Id = @tempId5) - (select SugarQtyTakenT1 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) 
					else (select SugarQtyTakenT2 from SugarSyrup where Id = @tempId5) - (select SugarQtyTakenT2 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) 
					end as SugarQty,
					--SugarQtyTakenT1 as SugarQty,
					0 as BatchTemp,
					'Dosing' as Operation
				Into 
					#tempSugarSyrup5
				from 
					SugarSyrup 
				where 
					id between @tempId5 and (select id from #temp1 where n = @a)
					order by date desc

				Insert Into #tmpSugarSyrup ([Date],[Time],Tank,SugarSilo,SugarQty,BatchStartTime,BatchStopTime,BatchTotalTime,WaterQty,BatchTemp,Operation) 
				values
				(
					(Select Date from #tempSugarSyrup5),
					(Select Time from #tempSugarSyrup5),
					(Select Tank from #tempSugarSyrup5),
					(Select isnull (SugarSilo,'-') from #tempSugarSyrup5),
					(Select isnull (abs (SugarQty),0) from #tempSugarSyrup5),
					(Select BatchStartTime from #tempSugarSyrup5),
					(Select BatchStopTime from #tempSugarSyrup5),
					(Select BatchTotalTime from #tempSugarSyrup5),
					(Select isnull ( WaterQty ,0)from #tempSugarSyrup5),
					(Select Isnull (BatchTemp,0) from #tempSugarSyrup5),
					(Select Operation from #tempSugarSyrup5)
				)
				--Select * from #tmpSugarSyrup
        Drop table #tempSugarSyrup5
		End
		drop table #tmpSiloRow5
	End
	else if((Select [CirculationTriggerT2] from #temp1 where n = @a) = 0)
	begin
	
				Declare @ProcessId6 int = null
				set @ProcessId6 = (select Id from #temp1 where n = @a)
				Declare @tempId6 int
				--Declare @tmpSiloId1 int = null
				--set @tmpSiloId1 = (select TrasnferSiloNo from #temp1 where n = @a)
				Select row_number() OVER (ORDER BY id) [row],* into #tmpSiloRow6 from SugarSyrup where  [CirculationTriggerT2] in (0,1)  and   [date] between -- TrasnferSiloNo = @tmpSiloId and [date] between 
				@FromDate and @ToDate  + 1
				--select * from #tmpSiloRow6
				Declare @Row6 int = null
				set @Row6 = (Select [row] from #tmpSiloRow6 where id = @ProcessId6)
				--select @Row
				while ((Select Id from #tmpSiloRow6 where [CirculationTriggerT2] != 0 and [Row] = @Row6 -1) != 0)
				begin
					set @tempId6 = (Select Id from #tmpSiloRow6 where [CirculationTriggerT2] != 0 and [Row] = @Row6 -1)
					set @Row6 = @Row6 - 1
				end

				 if (Isnull (@tempId6,0) !=0)
				 begin
					select 
						top 1 convert(date,date,103) as [Date],
						convert(varchar(8),convert(time,date,103)) as [Time],
						'ST2' as Tank,
						'-' as SugarSilo,
						(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = @tempId6) as BatchStartTime,
						(select convert(varchar(8),convert(time,date,103)) from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchStopTime,
						(select convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId6), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId6), (select [Date] from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select [Date] from SugarSyrup where Id = @tempId6), (select date from SugarSyrup where Id = (Select Id from #temp1 where n = @a)))%60))) as BatchTotalTime,
						0 as WaterQty,
						0 as SugarQty,
						(select BatchTempT1 from SugarSyrup where Id = (Select Id from #temp1 where n = @a)) as BatchTemp,
						--BatchTempT1 as BatchTemp,
						'Circulation' as Operation
					Into 
						#tempSugarSyrup6
					from 
						SugarSyrup 
					where 
						id between @tempId6 and (select id from #temp1 where n = @a)
						order by date desc

					Insert Into #tmpSugarSyrup ([Date],[Time],Tank,SugarSilo,SugarQty,BatchStartTime,BatchStopTime,BatchTotalTime,WaterQty,BatchTemp,Operation) 
					values
					(
						(Select Date from #tempSugarSyrup6),
						(Select Time from #tempSugarSyrup6),
						(Select Tank from #tempSugarSyrup6),
						(Select isnull (SugarSilo,'-') from #tempSugarSyrup6),
						(Select isnull (abs (SugarQty),0) from #tempSugarSyrup6),
						(Select BatchStartTime from #tempSugarSyrup6),
						(Select BatchStopTime from #tempSugarSyrup6),
						(Select BatchTotalTime from #tempSugarSyrup6),
						(Select isnull (WaterQty,0) from #tempSugarSyrup6),
						(Select isnull (BatchTemp,0) from #tempSugarSyrup6),
						(Select Operation from #tempSugarSyrup6)
					)
					--Select * from #tmpSugarSyrup
					drop table #tempSugarSyrup6
				End
		drop table #tmpSiloRow6
	End
	set @a = @a + 1
end

 select 
	--CONVERT(varchar(10),[Date],103) as 'Date',
	--convert(varchar(8),[Time]) Time,
	--Tank,
	--SugarSilo,
	--SugarQty,
	--BatchStartTime,
	--BatchStopTime,
	--BatchTotalTime,
	--WaterQty,
	--BatchTemp,
	--Operation

	CONVERT(varchar(10),[Date],103) as 'Date',
	convert(varchar(8),[Time]) Time,
	Tank,
	SugarSilo,
	isnull(SugarQty,0)as SugarQty,
	BatchStartTime,
	BatchStopTime,
	BatchTotalTime,
	isnull(WaterQty,0) as WaterQty,
	isnull (BatchTemp,0) as BatchTemp,
	Operation
from 
	#tmpSugarSyrup
--Select * from #tmpSugarSyrup
drop table  #temp1
drop table #tmpSugarSyrup




GO
/****** Object:  StoredProcedure [dbo].[Usp_rpt_tbl_ChemicalConsumption]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [GEA-Britania]

--exec Usp_rpt_tbl_ChemicalConsumption '2021-07-26 12:05:00.000', '2021-07-27 12:05:00.000'
CREATE procedure [dbo].[Usp_rpt_tbl_ChemicalConsumption]
(
@FromDate datetime,
@ToDate datetime
)
As
Begin

  select
   ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
    convert(varchar(20),M1.[Datetime],103)Date,
	convert(varchar(8),M1.[Datetime],108) Time,
    Acid,
    Lye
  from 
     ChemicalConsumption  M1
  where Datetime between @FromDate and @ToDate
End
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_tbl_CPLlog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec usp_rpt_tbl_CPLlog '2021-07-26 12:05:00.000', '2021-07-27 12:05:00.000'
CREATE PROCEDURE [dbo].[usp_rpt_tbl_CPLlog] 
(
@FromDate datetime,
@ToDate datetime
)
As
Begin
 select
      
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				  'In Production' as PasteurizerStatus,
				  (select SiloName from SourceDestination where PLCValue = Source) as Source,
				    (select SiloName from SourceDestination where PLCValue = Destination) as Destination,					
					Flow,
					BatchTotalizer,
					TransferedQty,					
				    case when HeatingFDVStatus = 0 then 'Heating Not Ok'
					when HeatingFDVStatus = 1 then 'Heating Ok'
				
					 end as HeatingFDVStatus,
					  case when ChillingFDVStatus = 0 then 'Chilling Not Ok'
					when ChillingFDVStatus = 1 then 'Chilling Ok'
				
					 end as ChillingFDVStatus,
					 Heating,
					 Cooling,
					 HotWaterPHEInlet,
					 RegenerationEfficiency
					
  from 
     CPLLog  M1
  where DateTime between @FromDate and @ToDate
end
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_tbl_Evaporatorlog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec usp_rpt_tbl_Evaporatorlog '2021-07-26 12:05:00.000', '2021-07-27 12:05:00.000'
CREATE PROCEDURE [dbo].[usp_rpt_tbl_Evaporatorlog] 
(
@FromDate datetime,
@ToDate datetime
)
As
Begin
 select
      
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				  PlantStatus,
					EvapBalanceTank,					
			     	cast (FeedFlow as decimal(18,2)) as FeedFlow,
					cast (FeedConductivity as decimal(18,2)) as FeedConductivity,
					cast (FeedPreheatertmp as decimal(18,2)) as FeedPreheatertmp ,
					cast (PCDTemp as decimal(18,2)) as PCDTemp ,
					cast (FV1Heatingtemp as decimal(18,2)) as FV1Heatingtemp ,
				    cast (FV2Heatingtemp as decimal(18,2)) as FV2Heatingtemp ,
				 	cast (DSITemp as decimal(18,2)) as DSITemp ,
					cast (FV1regenerationtemp as decimal(18,2)) as FV1regenerationtemp ,
					cast (FV2regenerationtemp as decimal(18,2)) as FV2regenerationtemp ,
					cast (Cal1Temp as decimal(18,2)) as Cal1Temp ,
					cast (Cal2Temp as decimal(18,2)) as Cal2Temp ,
					cast (Cal3Temp as decimal(18,2)) as Cal3Temp ,
					cast (Cal4Temp as decimal(18,2)) as Cal4Temp ,
					cast (CondenserCWInTemp as decimal(18,2)) as CondenserCWInTemp ,
					cast (CondenserCWOutTemp as decimal(18,2)) as CondenserCWOutTemp ,
					cast (CondenserTemp as decimal(18,2)) as CondenserTemp ,
					cast (PlantVaccum as decimal(18,2)) as PlantVaccum ,
					cast (PCDTVRPressure as decimal(18,2)) as PCDTVRPressure ,
					cast (CalTVRPressure as decimal(18,2)) as CalTVRPressure ,
					cast (DSIBackPressure as decimal(18,2)) as DSIBackPressure ,
					cast (DSISteamSupplyPressure as decimal(18,2)) as DSISteamSupplyPressure ,
					cast (DSIOutletTemp as decimal(18,2)) as DSIOutletTemp ,
					cast (CondensateCond as decimal(18,2)) as CondensateCond ,
					cast (Ejector1SteamPressure as decimal(18,2)) as Ejector1SteamPressure ,
					cast (Ejector2SteamPressure as decimal(18,2)) as Ejector2SteamPressure ,
					cast (ConcFlow as decimal(18,2)) as ConcFlow ,
					cast (FinalConcDensity as decimal(18,2)) as FinalConcDensity ,
					cast (FinalConcFlow as decimal(18,2)) as FinalConcFlow ,
				   cast (FinalConcTemp as decimal(18,2)) as FinalConcTemp 

				
  from 
     EvaporatorDataLogSheet  M1
  where DateTime between @FromDate and @ToDate
end
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_tbl_WPLlog]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec usp_rpt_tbl_WPLlog '2021-12-27 10:05:00.000', '2021-12-27 18:05:00.000'
CREATE PROCEDURE [dbo].[usp_rpt_tbl_WPLlog] 
(
@FromDate datetime,
@ToDate datetime
)
As
Begin
 select
      
				  ROW_NUMBER() over (order by M1.[DateTime]) as 'SrNo',
				  convert(varchar(20),M1.[Datetime],103)Date,
				  convert(varchar(8),M1.[Datetime],108) Time,
				  'In Production' as PasteurizerStatus,
				  (select SiloName from SourceDestination where PLCValue = Source) as Source,
				    (select SiloName from SourceDestination where PLCValue = Destination) as Destination,
					case when CreamDestination = 1021 then 'CBT'
					     when CreamDestination = 1022 then 'PCST'
						 end as CreamDestination,
					 cast(Flow as decimal (18,2)) as Flow,
					 cast(CreamFlow as decimal (18,2)) as CreamFlow,
					 cast(BatchTotalizer as decimal (18,2)) as BatchTotalizer,
					  cast(CreamFlow as decimal (18,2)) as CreamFlow,
					 cast(BatchTotalizer as decimal (18,2)) as BatchTotalizer,
					  cast(TransferedQty as decimal (18,2)) as TransferedQty,
					 cast(CreamGenerationQty as decimal (18,2)) as CreamGenerationQty,
				
				    case when HeatingFDVStatus = 0 then 'Heating Not Ok'
					when HeatingFDVStatus = 1 then 'Heating Ok'
				
					 end as HeatingFDVStatus,
					  case when ChillingFDVStatus = 0 then 'Chilling Not Ok'
					when ChillingFDVStatus = 1 then 'Chilling Ok'
				
					 end as ChillingFDVStatus,
					 cast (Heating as decimal(18,2)) as Heating,
					 cast (Cooling as decimal(18,2)) as Cooling,
					 cast (HotWaterPHEInlet as decimal(18,2)) as HotWaterPHEInlet,
					 cast (RegenerationEfficiency as decimal(18,2)) as RegenerationEfficiency,
					  cast (SeparatorInletTemp as decimal(18,2)) as SeparatorInletTemp,
					
					 case when SeparatorInlineBypassed = 0 then 'Separator ByPass'
					when SeparatorInlineBypassed = 1 then 'Separator Inline'
				
					 end as SeparatorInlineBypassed,
					  cast (BRCInletTemp as decimal(18,2)) as BRCInletTemp,					
					-- BRCInletTemp,
					 case when BRCInlineBypassed = 0 then 'BRC ByPass'
					when BRCInlineBypassed = 1 then 'BRC Inline'
				
					 end as BRCInlineBypassed
				
  from 
     WPLLog  M1
  where DateTime between @FromDate and @ToDate
end
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_temp]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec [dbo].[usp_rpt_temp] '28/11/2018' , 3
CREATE PROCEDURE [dbo].[usp_rpt_temp]
	@FromDate varchar(50),
	@ShiftId varchar(50)
AS

--Declare @FromDate varchar(50) = '28/11/2018'
--Declare @ShiftId varchar(50) = -1
DECLARE @colsUnpivotValve AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@query1  AS NVARCHAR(MAX)
	select @colsUnpivotValve 
	  = stuff(
	  (select 
			','+quotename(C.name)
		FROM 
			sys.columns c
		WHERE 
			c.name not in ('Id', 'DateTime')
			and c.object_id = OBJECT_ID('dbo.SprayDryer')  
			for xml path('')), 1, 1, '')

--Select @colsUnpivotValve

IF OBJECT_ID('TEMPDB.dbo.##TempTableTesting') IS NOT NULL DROP TABLE ##TempTableTesting
set @query 
	  = 'Select 
			
			Convert(varchar(8), DateTime, 108) as DateTime,
			Tags as TagNos,
			Value,
			(Select Description from FaultTag FT where FT.TagNo = Tags and IsDeleted = 0) as DryerPlantStatus
		into ##TempTableTesting
		from
			(select 
					Id,
					DateTime, 
					Tags, 
					Value
				from
				(
					Select 
						*
					from
						SprayDryer
				) as cp
				unpivot
				(
					Value for Tags in (' + @colsUnpivotValve + ')
				) as up1
			where
				Convert(date, DateTime, 103) = Convert(date, ''' + @FromDate + ''', 103)
				and (' + @ShiftId + ' = -1.0
				or Convert(time, DateTime, 108) between (Select FromTime from Shift where ShiftId = ' + @ShiftId + ') and (Select ToTime from Shift where ShiftId = ' + @ShiftId + '))
			)t'
--Select @query
exec(@query)
--Insert into #temp1 (Description) values(@query)

--Select * from #temp1
--Select * from ##TempTableTesting

DECLARE @cols AS NVARCHAR(MAX)
SELECT @cols = STUFF((SELECT Distinct ',' + QUOTENAME(DateTime) 
                    FROM ##TempTableTesting
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
--Select @cols
set @query1 
	= 'Select 
			*
		from
			##TempTableTesting
		pivot
		(
			Avg(Value)
            for DateTime in (' + @cols + ')
		) as up1'

--Select @query1

exec(@query1)

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_TransferReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_TransferReport] '12/30/2021 11:00:00','12/30/2021 19:40:00'
CREATE procedure [dbo].[usp_rpt_TransferReport]
	@FromDateTime datetime,
	@ToDateTime datetime
AS

Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1
	from [Transfer] t 
		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0 or StartTriggerT3 = 0 or StartTriggerT4 = 0 or StartTriggerT5 = 0 
			or	StartTriggerT6 = 0 or StartTriggerT7 = 0 or StartTriggerT8 = 0 or StartTriggerT9 = 0  or StartTriggerT20 = 0) 
		 and [Date] between @FromDateTime and @ToDateTime 
--select * from #temp1

Declare @ShiftName varchar(20) = null
Declare @ProductName varchar(50) = null
declare @a int = 1
declare @count int = (select count(*) from #temp1)

----------------------------------- Create Temp Table --------------------------
Create table #tempProductTreacebility (Id int IDENTITY(1,1),[Date] varchar(10),ShiftName varchar(50),FunctionNo varchar(20),[Status] varchar(20),Fat float, SNF float,TransferName varchar(50),Product varchar(50),
								StartTime varchar(8),StopTime varchar(8),[Source] varchar(50),Destination varchar(50),TotalTime varchar(8),Quantity decimal(18,2))
----------------------------------

while (@a <= @count)
begin

	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
	begin
		
			Declare @T1ProcessId int = null
			set @T1ProcessId = (select Id from #temp1 where n = @a)
			Declare @T1tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT1],[SourceT1],[QuantityT1],[DestinationT1],Status,FAT,SNF
				into #tmpRowT1 from [Transfer] where StartTriggerT1 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T1Row int = null
			set @T1Row = (Select [row] from #tmpRowT1 where id = @T1ProcessId)

			while ((Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1) != 0)
			begin
				set @T1tempId = (Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1)
				set @T1Row = @T1Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT1 where row = @T1Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				'P001' as FunctionNo,
				--Status,
				  case when [Status] = 0 then 'Idle'
					when [Status] = 1 then 'Filling'	
					when [Status] = 2 then 'Emptying'		
					when [Status] = 3 then 'CIP Running'		
					when [Status] = 4 then 'CIP Paused'		
					when [Status] = 5 then 'CIP Abort'	
					when [Status] = 6 then 'Transfer Running'
					when [Status] = 7 then 'WP Running'
					 end as Status,
				    cast( Fat as decimal(18,2)) as Fat,
					cast( SNF as decimal(18,2)) as SNF,
					 'Raw Whey Reception' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT1 from #tmpRowT1 where Id = @T1ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT1 from #tmpRowT1 where Id = @T1ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				(Select QuantityT1 from #tmpRowT1 where Id = (select Id from #temp1 where n = @a))  as Quantity
			into 
				#tempT1
			from 
				#tmpRowT1
			where 
				Id between @T1tempId and (select Id from #temp1 where n = @a)
		--	group by [Date],DestinationT1,SourceT1
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT1)

		drop table #tmpRowT1,#tempT1
	end
	else if((Select StartTriggerT2 from #temp1 where n = @a) = 0)
	begin
			Declare @T2ProcessId int = null
			set @T2ProcessId = (select Id from #temp1 where n = @a)
			Declare @T2tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT2],[SourceT2],[QuantityT2],[DestinationT2],[Status2],[Fat2],[SNF2]
			into #tmpRowT2 from [Transfer] where StartTriggerT2 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T2Row int = null
			set @T2Row = (Select [row] from #tmpRowT2 where id = @T2ProcessId)

			while ((Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1) != 0)
			begin
				set @T2tempId = (Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1)
				set @T2Row = @T2Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT2 where row = @T2Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as [Date],
					@ShiftName as 'ShiftName',
			'P002' as FunctionNo,
				--Status,
				   case when [Status2] = 0 then 'Idle'
					when [Status2] = 1 then 'Filling'	
					when [Status2] = 2 then 'Emptying'		
					when [Status2] = 3 then 'CIP Running'		
					when [Status2] = 4 then 'CIP Paused'		
					when [Status2] = 5 then 'CIP Abort'	
					when [Status2] = 6 then 'Transfer Running'
					when [Status2] = 7 then 'WP Running'
					 end as Status,
				
						cast( Fat2 as decimal(18,2)) as Fat2,
					cast( SNF2 as decimal(18,2)) as SNF2,
					 'Inter-Silo Transfer' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT2 from #tmpRowT2 where Id = @T2ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT2 from #tmpRowT2 where Id = @T2ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT2 from #tmpRowT2 where Id = (select Id from #temp1 where n = @a))) as Quantity-- - (Select QuantityT2 from #tmpRowT2 where Id = @T2tempId)) as Quantity
			into 
				#tempT2
			from 
				#tmpRowT2
			where 
				Id between @T2tempId and (select Id from #temp1 where n = @a)
			--group by [Date],DestinationT2,SourceT2
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT2)

		drop table #tmpRowT2,#tempT2
	end
	else if((Select StartTriggerT3 from #temp1 where n = @a) = 0)
	begin
			Declare @T3ProcessId int = null
			set @T3ProcessId = (select Id from #temp1 where n = @a)
			Declare @T3tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT3],[SourceT3],[QuantityT3],[DestinationT3],Status3,Fat3,SNF3
			into #tmpRowT3 from [Transfer] where StartTriggerT3 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T3Row int = null
			set @T3Row = (Select [row] from #tmpRowT3 where id = @T3ProcessId)
			
			while ((Select Id from #tmpRowT3 where StartTriggerT3 != 0 and [Row] = @T3Row -1) != 0)
			begin
				set @T3tempId = (Select Id from #tmpRowT3 where StartTriggerT3 != 0 and [Row] = @T3Row -1)
				set @T3Row = @T3Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT3 where row = @T3Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P003' as FunctionNo,
				--Status,
				   case when [Status3] = 0 then 'Idle'
					when [Status3] = 1 then 'Filling'	
					when [Status3] = 2 then 'Emptying'		
					when [Status3] = 3 then 'CIP Running'		
					when [Status3] = 4 then 'CIP Paused'		
					when [Status3] = 5 then 'CIP Abort'	
					when [Status3] = 6 then 'Transfer Running'
					when [Status3] = 7 then 'WP Running'
					 end as Status,
						cast( Fat3 as decimal(18,2)) as Fat3,
					cast( snf3 as decimal(18,2)) as snf3,
					 'Past. Whey To NF Transfer' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT3 from #tmpRowT3 where Id = @T3ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT3 from #tmpRowT3 where Id = @T3ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT3 from #tmpRowT3 where Id = (select Id from #temp1 where n = @a))) as Quantity --- (Select QuantityT3 from #tmpRowT3 where Id = @T3tempId)) as Quantity
			into 
				#tempT3
			from 
				#tmpRowT3
			where 
				Id between @T3tempId and (select Id from #temp1 where n = @a)
			--group by [Date],SourceT3,DestinationT3
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT3)

		drop table #tmpRowT3,#tempT3
	end
	else if((Select StartTriggerT4 from #temp1 where n = @a) = 0)
	begin
			Declare @T4ProcessId int = null
			set @T4ProcessId = (select Id from #temp1 where n = @a)
			Declare @T4tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT4],[SourceT4],[QuantityT4],[DestinationT4],Status4,Fat4,SNF4
			into #tmpRowT4 from [Transfer] where StartTriggerT4 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T4Row int = null
			set @T4Row = (Select [row] from #tmpRowT4 where id = @T4ProcessId)
			
			while ((Select Id from #tmpRowT4 where StartTriggerT4 != 0 and [Row] = @T4Row -1) != 0)
			begin
				set @T4tempId = (Select Id from #tmpRowT4 where StartTriggerT4 != 0 and [Row] = @T4Row -1)
				set @T4Row = @T4Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT4 where row = @T4Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P004' as FunctionNo,
				--Status,
				   case when [Status4] = 0 then 'Idle'
					when [Status4] = 1 then 'Filling'	
					when [Status4] = 2 then 'Emptying'		
					when [Status4] = 3 then 'CIP Running'		
					when [Status4] = 4 then 'CIP Paused'		
					when [Status4] = 5 then 'CIP Abort'
					when [Status4] = 6 then 'Transfer Running'
					when [Status4] = 7 then 'WP Running'
					 end as Status,
					cast( Fat4 as decimal(18,2)) as Fat4,
					cast( snf4 as decimal(18,2)) as snf4,
					 'Past. Cream Transfer To Tanker Dispatch' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT4 from #tmpRowT4 where Id = @T4ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT4 from #tmpRowT4 where Id = @T4ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT4 from #tmpRowT4 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT4
			from 
				#tmpRowT4
			where 
				Id between @T4tempId and (select Id from #temp1 where n = @a)
			--group by [Date],SourceT4,DestinationT4
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT4)

		drop table #tmpRowT4,#tempT4
	end
	else if((Select StartTriggerT5 from #temp1 where n = @a) = 0)
	begin
			Declare @T5ProcessId int = null
			set @T5ProcessId = (select Id from #temp1 where n = @a)
			Declare @T5tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT5],[SourceT5],[QuantityT5],[DestinationT5],Status5,Fat5,SNF5
			into #tmpRowT5 from [Transfer] where StartTriggerT5 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T5Row int = null
			set @T5Row = (Select [row] from #tmpRowT5 where id = @T5ProcessId)
			
			while ((Select Id from #tmpRowT5 where StartTriggerT5 != 0 and [Row] = @T5Row -1) != 0)
			begin
				set @T5tempId = (Select Id from #tmpRowT5 where StartTriggerT5 != 0 and [Row] = @T5Row -1)
				set @T5Row = @T4Row - 1
			end
				set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT5 where row = @T5Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P005' as FunctionNo,
				--Status,
				 case when [Status5] = 0 then 'Idle'
					when [Status5] = 1 then 'Filling'	
					when [Status5] = 2 then 'Emptying'		
					when [Status5] = 3 then 'CIP Running'		
					when [Status5] = 4 then 'CIP Paused'		
					when [Status5] = 5 then 'CIP Abort'	
					when [Status5] = 6 then 'Transfer Running'
					when [Status5] = 7 then 'WP Running'
					 end as Status,
					cast( Fat5 as decimal(18,2)) as Fat5,
					cast( snf5 as decimal(18,2)) as snf5,
					 'Past. Cream Transfer To Ghee Plant' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT5 from #tmpRowT5 where Id = @T5ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT5 from #tmpRowT5 where Id = @T5ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT5 from #tmpRowT5 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT5
			from 
				#tmpRowT5
			where 
				Id between @T5tempId and (select Id from #temp1 where n = @a)
			--group by [Date],SourceT5,DestinationT5
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT5)

		drop table #tmpRowT5,#tempT5
	end
	else if((Select StartTriggerT6 from #temp1 where n = @a) = 0)
	begin
				Declare @T6ProcessId int = null
			set @T6ProcessId = (select Id from #temp1 where n = @a)
			Declare @T6tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT6],[SourceT6],[QuantityT6],[DestinationT6],Status6,Fat6,SNF6
			into #tmpRowT6 from [Transfer] where StartTriggerT6 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T6Row int = null
			set @T6Row = (Select [row] from #tmpRowT6 where id = @T6ProcessId)
			
			while ((Select Id from #tmpRowT6 where StartTriggerT6 != 0 and [Row] = @T6Row -1) != 0)
			begin
				set @T6tempId = (Select Id from #tmpRowT6 where StartTriggerT6 != 0 and [Row] = @T6Row -1)
				set @T6Row = @T6Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT6 where row = @T6Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P006' as FunctionNo,
				--Status,
				 case when [Status6] = 0 then 'Idle'
					when [Status6] = 1 then 'Filling'	
					when [Status6] = 2 then 'Emptying'		
					when [Status6] = 3 then 'CIP Running'		
					when [Status6] = 4 then 'CIP Paused'		
					when [Status6] = 5 then 'CIP Abort'	
					when [Status6] = 6 then 'Transfer Running'
					when [Status6] = 7 then 'WP Running'
					 end as Status,
						cast( Fat6 as decimal(18,2)) as Fat6,
					cast( snf6 as decimal(18,2)) as snf6,
					 'NF Tank Filling' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT6 from #tmpRowT6 where Id = @T6ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT6 from #tmpRowT6 where Id = @T6ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT6 from #tmpRowT6 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT6
			from 
				#tmpRowT6
			where 
				Id between @T6tempId and (select Id from #temp1 where n = @a)
			--group by [Date],SourceT6,DestinationT6
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT6)

		drop table #tmpRowT6,#tempT6
	end
	else if((Select StartTriggerT7 from #temp1 where n = @a) = 0)
	begin
				Declare @T7ProcessId int = null
			set @T7ProcessId = (select Id from #temp1 where n = @a)
			Declare @T7tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT7],[SourceT7],[QuantityT7],[DestinationT7],Status7,Fat7,SNF7
			into #tmpRowT7 from [Transfer] where StartTriggerT7 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T7Row int = null
			set @T7Row = (Select [row] from #tmpRowT7 where id = @T7ProcessId)
			
			while ((Select Id from #tmpRowT7 where StartTriggerT7 != 0 and [Row] = @T7Row -1) != 0)
			begin
				set @T7tempId = (Select Id from #tmpRowT7 where StartTriggerT7 != 0 and [Row] = @T7Row -1)
				set @T7Row = @T7Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT7 where row = @T7Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P007' as FunctionNo,
				--Status,
				 case when [Status7] = 0 then 'Idle'
					when [Status7] = 1 then 'Filling'	
					when [Status7] = 2 then 'Emptying'		
					when [Status7] = 3 then 'CIP Running'		
					when [Status7] = 4 then 'CIP Paused'		
					when [Status7] = 5 then 'CIP Abort'		
					when [Status7] = 6 then 'Transfer Running'
					when [Status7] = 7 then 'WP Running'
					 end as Status,
					cast( Fat7 as decimal(18,2)) as Fat7,
					cast( snf7 as decimal(18,2)) as snf7,
					 'NF Tank To Evap. Transfer' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT7 from #tmpRowT7 where Id = @T7ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT7 from #tmpRowT7 where Id = @T7ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT7 from #tmpRowT7 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT7
			from 
				#tmpRowT7
			where 
				Id between @T7tempId and (select Id from #temp1 where n = @a)
			--group by [Date],SourceT7,DestinationT7
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT7)

		drop table #tmpRowT7,#tempT7
	end
	else if((Select StartTriggerT8 from #temp1 where n = @a) = 0)
	begin
		Declare @T8ProcessId int = null
			set @T8ProcessId = (select Id from #temp1 where n = @a)
			Declare @T8tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT8],[SourceT8],[QuantityT8],[DestinationT8],Status8,Fat8,SNF8
			into #tmpRowT8 from [Transfer] where StartTriggerT8 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T8Row int = null
			set @T8Row = (Select [row] from #tmpRowT8 where id = @T8ProcessId)
			
			while ((Select Id from #tmpRowT8 where StartTriggerT8 != 0 and [Row] = @T8Row -1) != 0)
			begin
				set @T8tempId = (Select Id from #tmpRowT8 where StartTriggerT8 != 0 and [Row] = @T8Row -1)
				set @T8Row = @T8Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT8 where row = @T8Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P008' as FunctionNo,
				--Status,
				 	 case when [Status8] = 0 then 'Idle'
					when [Status8] = 1 then 'Filling'	
					when [Status8] = 2 then 'Emptying'		
					when [Status8] = 3 then 'CIP Running'		
					when [Status8] = 4 then 'CIP Paused'		
					when [Status8] = 5 then 'CIP Abort'	
					when [Status8] = 6 then 'Transfer Running'
					when [Status8] = 7 then 'WP Running'
					 end as Status,
					cast( Fat8 as decimal(18,2)) as Fat8,
					cast( snf8 as decimal(18,2)) as snf8,
					 'Crystllization to dryer' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT8 from #tmpRowT8 where Id = @T8ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT8 from #tmpRowT8 where Id = @T8ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT8 from #tmpRowT8 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT8
			from 
				#tmpRowT8
			where 
				Id between @T8tempId and (select Id from #temp1 where n = @a)
			--group by [Date],SourceT8,DestinationT8
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT8)

		drop table #tmpRowT8,#tempT8
	end
	else if((Select StartTriggerT9 from #temp1 where n = @a) = 0)
	begin
		Declare @T9ProcessId int = null
			set @T9ProcessId = (select Id from #temp1 where n = @a)
			Declare @T9tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT9],[SourceT9],[QuantityT9],[DestinationT9],Status9,Fat9,SNF9
			into #tmpRowT9 from [Transfer] where StartTriggerT9 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T9Row int = null
			set @T9Row = (Select [row] from #tmpRowT9 where id = @T9ProcessId)
			
			while ((Select Id from #tmpRowT9 where StartTriggerT9 != 0 and [Row] = @T9Row -1) != 0)
			begin
				set @T9tempId = (Select Id from #tmpRowT9 where StartTriggerT9 != 0 and [Row] = @T9Row -1)
				set @T9Row = @T9Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT9 where row = @T9Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT9 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT9 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P009' as FunctionNo,
				--Status,
				case when [Status9] = 0 then 'Idle'
					when [Status9] = 1 then 'Filling'	
					when [Status9] = 2 then 'Emptying'		
					when [Status9] = 3 then 'CIP Running'		
					when [Status9] = 4 then 'CIP Paused'		
					when [Status9] = 5 then 'CIP Abort'		
					when [Status9] = 6 then 'Transfer Running'
					when [Status9] = 7 then 'WP Running'
					 end as Status,
						cast( Fat9 as decimal(18,2)) as Fat9,
					cast( snf9 as decimal(18,2)) as snf9,
					 'Milk transfer from Powder plant to RWST' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT9 from #tmpRowT9 where Id = @T9ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT9 from #tmpRowT9 where Id = @T9ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT9 from #tmpRowT9 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT9
			from 
				#tmpRowT9
			where 
				Id between @T9tempId and (select Id from #temp1 where n = @a)
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT9)

		drop table #tmpRowT9,#tempT9
	end
	else if((Select StartTriggerT20 from #temp1 where n = @a) = 0)
	begin
			Declare @T20ProcessId int = null
			set @T20ProcessId = (select Id from #temp1 where n = @a)
			Declare @T20tempId int
			
			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT20],[SourceT20],[QuantityT20],[DestinationT20],Status20,Fat20,SNF20
			into #tmpRowT20 from [Transfer] where StartTriggerT20 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T20Row int = null
			set @T20Row = (Select [row] from #tmpRowT20 where id = @T20ProcessId)
			
			while ((Select Id from #tmpRowT20 where StartTriggerT20 != 0 and [Row] = @T20Row -1) != 0)
			begin
				set @T20tempId = (Select Id from #tmpRowT20 where StartTriggerT20 != 0 and [Row] = @T20Row -1)
				set @T20Row = @T20Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT20 where row = @T20Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT20 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT20 where id = (select Id from #temp1 where n = @a)) as [Date],
				
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
			'P020' as FunctionNo,
				--Status,
				case when [Status20] = 0 then 'Idle'
					when [Status20] = 1 then 'Filling'	
					when [Status20] = 2 then 'Emptying'		
					when [Status20] = 3 then 'CIP Running'		
					when [Status20] = 4 then 'CIP Paused'		
					when [Status20] = 5 then 'CIP Abort'
					when [Status20] = 6 then 'Transfer Running'
					when [Status20] = 7 then 'WP Running'
					 end as Status,
					cast( Fat20 as decimal(18,2)) as Fat20,
					cast( snf20 as decimal(18,2)) as snf20,
					 
					 'Greek Yogurt Reception' as TransferName,
					 'Whey' as Product,
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue = (Select SourceT20 from #tmpRowT20 where Id = @T20ProcessId))as [Source],
				(Select SiloName from SourceDestination where IsDeleted = 0 and PLCValue  = (Select DestinationT20 from #tmpRowT20 where Id = @T20ProcessId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT20 from #tmpRowT20 where Id = (select Id from #temp1 where n = @a))) as Quantity 
			into 
				#tempT20
			from 
				#tmpRowT20
			where 
				Id between @T20tempId and (select Id from #temp1 where n = @a)
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,FunctionNo,Status,Fat,SNF,TransferName,Product,[Source],Destination,TotalTime,Quantity)
			(Select * from #tempT20)

		drop table #tmpRowT20,#tempT20
	end
	--else if((Select StartTriggerT11 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T11ProcessId int = null
	--		set @T11ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T11tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT11,QuantityT11,SourceT11,DestinationT11
	--			into #tmpRowT11 from [Transfer] where StartTriggerT11 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T11Row int = null
	--		set @T11Row = (Select [row] from #tmpRowT11 where id = @T11ProcessId)

	--		while ((Select Id from #tmpRowT11 where StartTriggerT11 != 0 and [Row] = @T11Row -1) != 0)
	--		begin
	--			set @T11tempId = (Select Id from #tmpRowT11 where StartTriggerT11 != 0 and [Row] = @T11Row -1)
	--			set @T11Row = @T11Row - 1
	--		end
	--		--select @T11tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT11 where row = @T11Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT11 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT11 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			--(Select ProductName from Product where IdentifierCode = (Select ProductType11 from #tmpRowT11 where row = @T11Row) and IsDeleted = 0) as ProductName,
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT11 from #tmpRowT11 where Id = @T11tempId))as [Source],
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT11 from #tmpRowT11 where Id = @T11tempId)) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT11 from #tmpRowT11 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT11 from #tmpRowT11 where Id = @T11tempId)) as Quantity
	--		into 
	--			#tempT11
	--		from 
	--			#tmpRowT11
	--		where 
	--			Id between @T11tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT11,SourceT11
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT11)

	--	drop table #tmpRowT11,#tempT11
	--end
	--else if((Select StartTriggerT12 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T12ProcessId int = null
	--		set @T12ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T12tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT12,QuantityT12,SourceT12,DestinationT12
	--			 into #tmpRowT12 from [Transfer] where StartTriggerT12 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T12Row int = null
	--		set @T12Row = (Select [row] from #tmpRowT12 where id = @T12ProcessId)


	--		while ((Select Id from #tmpRowT12 where StartTriggerT12 != 0 and [Row] = @T12Row -1) != 0)
	--		begin
	--			set @T12tempId = (Select Id from #tmpRowT12 where StartTriggerT12 != 0 and [Row] = @T12Row -1)
	--			set @T12Row = @T12Row - 1
	--		end
	--		--select @T12tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT12 where row = @T12Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT12 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT12 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			--(Select ProductName from Product where IdentifierCode = (Select ProductType12 from #tmpRowT12 where row = @T12Row) and IsDeleted = 0) as ProductName,
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT12 from #tmpRowT12 where Id = @T12tempId))as [Source],
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT12 from #tmpRowT12 where Id = @T12tempId)) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT12 from #tmpRowT12 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT12 from #tmpRowT12 where Id = @T12tempId)) as Quantity
	--		into 
	--			#tempT12
	--		from 
	--			#tmpRowT12
	--		where 
	--			Id between @T12tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT12,SourceT12
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT12)

	--	drop table #tmpRowT12,#tempT12
	--end
	--else if((Select StartTriggerT13 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T13ProcessId int = null
	--		set @T13ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T13tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT13,QuantityT13,SourceT13,DestinationT13
	--			into #tmpRowT13 from [Transfer] where StartTriggerT13 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T13Row int = null
	--		set @T13Row = (Select [row] from #tmpRowT13 where id = @T13ProcessId)

	--		while ((Select Id from #tmpRowT13 where StartTriggerT13 != 0 and [Row] = @T13Row -1) != 0)
	--		begin
	--			set @T13tempId = (Select Id from #tmpRowT13 where StartTriggerT13 != 0 and [Row] = @T13Row -1)
	--			set @T13Row = @T13Row - 1
	--		end
	--		--select @T13tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT13 where row = @T13Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT13 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT13 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			--(Select ProductName from Product where IdentifierCode = (Select ProductType13 from #tmpRowT13 where row = @T13Row) and IsDeleted = 0) as ProductName,
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT13 from #tmpRowT13 where Id = @T13tempId))as [Source],
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT13 from #tmpRowT13 where Id = @T13tempId)) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT13 from #tmpRowT13 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT13 from #tmpRowT13 where Id = @T13tempId)) as Quantity
	--		into 
	--			#tempT13
	--		from 
	--			#tmpRowT13
	--		where 
	--			Id between @T13tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],SourceT13,DestinationT13
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT13)

	--	drop table #tmpRowT13,#tempT13
	--end
	--else if((Select StartTriggerT14 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T14ProcessId int = null
	--		set @T14ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T14tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT14,QuantityT14,SourceT14,DestinationT14
	--			 into #tmpRowT14 from [Transfer] where StartTriggerT14 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T14Row int = null
	--		set @T14Row = (Select [row] from #tmpRowT14 where id = @T14ProcessId)

	--		while ((Select Id from #tmpRowT14 where StartTriggerT14 != 0 and [Row] = @T14Row -1) != 0)
	--		begin
	--			set @T14tempId = (Select Id from #tmpRowT14 where StartTriggerT14 != 0 and [Row] = @T14Row -1)
	--			set @T14Row = @T14Row - 1
	--		end
	--		--select @T14tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT14 where row = @T14Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT14 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT14 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			--(Select ProductName from Product where IdentifierCode = (Select ProductType14 from #tmpRowT14 where row = @T14Row) and IsDeleted = 0) as ProductName,
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT14 from #tmpRowT14 where Id = @T14tempId))as [Source],
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT14 from #tmpRowT14 where Id = @T14tempId)) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT14 from #tmpRowT14 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT14 from #tmpRowT14 where Id = @T14tempId)) as Quantity
	--		into 
	--			#tempT14
	--		from 
	--			#tmpRowT14
	--		where 
	--			Id between @T14tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT14,SourceT14
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT14)

	--	drop table #tmpRowT14,#tempT14
	--end
	--else if((Select StartTriggerT15 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T15ProcessId int = null
	--		set @T15ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T15tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT15,QuantityT15,SourceT15,DestinationT15
	--			 into #tmpRowT15 from [Transfer] where StartTriggerT15 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T15Row int = null
	--		set @T15Row = (Select [row] from #tmpRowT15 where id = @T15ProcessId)

	--		while ((Select Id from #tmpRowT15 where StartTriggerT15 != 0 and [Row] = @T15Row -1) != 0)
	--		begin
	--			set @T15tempId = (Select Id from #tmpRowT15 where StartTriggerT15 != 0 and [Row] = @T15Row -1)
	--			set @T15Row = @T15Row - 1
	--		end
	--		--select @T15tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT15 where row = @T15Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT15 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT15 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			--(Select ProductName from Product where IdentifierCode = (Select ProductType15 from #tmpRowT15 where row = @T15Row) and IsDeleted = 0) as ProductName,
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT15 from #tmpRowT15 where Id = @T15tempId))as [Source],
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT15 from #tmpRowT15 where Id = @T15tempId)) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT15 from #tmpRowT15 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT15 from #tmpRowT15 where Id = @T15tempId)) as Quantity
	--		into 
	--			#tempT15
	--		from 
	--			#tmpRowT15
	--		where 
	--			Id between @T15tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT15,SOURCET15
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT15)

	--	drop table #tmpRowT15,#tempT15
	--end
	--else if((Select StartTriggerT16 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T16ProcessId int = null
	--		set @T16ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T16tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT16,QuantityT16,SourceT16,DestinationT16
	--			 into #tmpRowT16 from [Transfer] where StartTriggerT16 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T16Row int = null
	--		set @T16Row = (Select [row] from #tmpRowT16 where id = @T16ProcessId)

	--		while ((Select Id from #tmpRowT16 where StartTriggerT16 != 0 and [Row] = @T16Row -1) != 0)
	--		begin
	--			set @T16tempId = (Select Id from #tmpRowT16 where StartTriggerT16 != 0 and [Row] = @T16Row -1)
	--			set @T16Row = @T16Row - 1
	--		end
	--		--select @T16tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT16 where row = @T16Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT16 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT16 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			--(Select ProductName from Product where IdentifierCode = (Select ProductType16 from #tmpRowT16 where row = @T16Row) and IsDeleted = 0) as ProductName,
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT16 from #tmpRowT16 where Id = @T16tempId))as [Source],
	--			(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT16 from #tmpRowT16 where Id = @T16tempId)) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT16 from #tmpRowT16 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT16 from #tmpRowT16 where Id = @T16tempId)) as Quantity
	--		into 
	--			#tempT16
	--		from 
	--			#tmpRowT16
	--		where 
	--			Id between @T16tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT16,SOURCET16
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT16)

	--	drop table #tmpRowT16,#tempT16
	--end
	--else if((Select StartTriggerT17 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T17ProcessId int = null
	--		set @T17ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T17tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT17,ProductType17,QuantityT17,SourceT17,DestinationT17
	--			 into #tmpRowT17 from [Transfer] where StartTriggerT17 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T17Row int = null
	--		set @T17Row = (Select [row] from #tmpRowT17 where id = @T17ProcessId)
			
	--		while ((Select Id from #tmpRowT17 where StartTriggerT17 != 0 and [Row] = @T17Row -1) != 0)
	--		begin
	--			set @T17tempId = (Select Id from #tmpRowT17 where StartTriggerT17 != 0 and [Row] = @T17Row -1)
	--			set @T17Row = @T17Row - 1
	--		end
	--		--select @T17tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT17 where row = @T17Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT17 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT17 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType17 from #tmpRowT17 where row = @T17Row) and IsDeleted = 0) as ProductName,
	--			'RECON' as [Source],
	--			(Select case when DestinationT17 = 0 then 'No Selection' 
	--				when DestinationT17 = 1 then 'SMST - 1'
	--				when DestinationT17 = 2 then 'SMST - 2'
	--				when DestinationT17 = 3 then 'SMST - 3'
	--				when DestinationT17 = 4 then 'SMST - 4'
	--				when DestinationT17 = 5 then 'SMST - 5' end from #temp1 where n= @a) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT17 from #tmpRowT17 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT17 from #tmpRowT17 where Id = @T17tempId)) as Quantity
	--		into 
	--			#tempT17
	--		from 
	--			#tmpRowT17
	--		where 
	--			Id between @T17tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],SourceT17,DestinationT17
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT17)

	--	drop table #tmpRowT17,#tempT17
	--end
	--else if((Select StartTriggerT18 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T18ProcessId int = null
	--		set @T18ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T18tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT18,ProductType18,QuantityT18,SourceT18,DestinationT18
	--			 into #tmpRowT18 from [Transfer] where StartTriggerT18 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T18Row int = null
	--		set @T18Row = (Select [row] from #tmpRowT18 where id = @T18ProcessId)

	--		while ((Select Id from #tmpRowT18 where StartTriggerT18 != 0 and [Row] = @T18Row -1) != 0)
	--		begin
	--			set @T18tempId = (Select Id from #tmpRowT18 where StartTriggerT18 != 0 and [Row] = @T18Row -1)
	--			set @T18Row = @T18Row - 1
	--		end
	--		--select @T18tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT18 where row = @T18Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT18 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT18 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType18 from #tmpRowT18 where row = @T18Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT18 = 0 then 'No Selection'  
	--				when SourceT18 = 1 then 'RINMST - 1'
	--				when SourceT18 = 2 then 'RINMST - 2' end as [Source],
	--			'RECON' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT18 from #tmpRowT18 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT18 from #tmpRowT18 where Id = @T18tempId)) as Quantity
	--		into 
	--			#tempT18
	--		from 
	--			#tmpRowT18
	--		where 
	--			Id between @T18tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],SourceT18,DestinationT18
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT18)

	--	drop table #tmpRowT18,#tempT18
	--end
	--else if((Select StartTriggerT19 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T19ProcessId int = null
	--		set @T19ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T19tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT19,ProductType19,QuantityT19,SourceT19,DestinationT19
	--			 into #tmpRowT19 from [Transfer] where StartTriggerT19 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T19Row int = null
	--		set @T19Row = (Select [row] from #tmpRowT19 where id = @T19ProcessId)

	--		while ((Select Id from #tmpRowT19 where StartTriggerT19 != 0 and [Row] = @T19Row -1) != 0)
	--		begin
	--			set @T19tempId = (Select Id from #tmpRowT19 where StartTriggerT19 != 0 and [Row] = @T19Row -1)
	--			set @T19Row = @T19Row - 1
	--		end
	--		--select @T19tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT19 where row = @T19Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT19 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT19 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType19 from #tmpRowT19 where row = @T19Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT19 = 0 then 'No Selection'    
	--				when SourceT19 = 1 then 'RMST - 1'
	--				when SourceT19 = 2 then 'RMST - 2'
	--				when SourceT19 = 3 then 'RMST - 3'
	--				when SourceT19 = 4 then 'RMST - 4' end as [Source],
	--			'MPL - 1' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT19 where id between @T19tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT19 where id between @T19tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT19 where id between @T19tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT19 where id between @T19tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT19 where id between @T19tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT19 where id between @T19tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT19 from #tmpRowT19 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT19 from #tmpRowT19 where Id = @T19tempId)) as Quantity
	--		into 
	--			#tempT19
	--		from 
	--			#tmpRowT19
	--		where 
	--			Id between @T19tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],SourceT19,DestinationT19
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT19)

	--	drop table #tmpRowT19,#tempT19
	--end
	--else if((Select StartTriggerT20 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T20ProcessId int = null
	--		set @T20ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T20tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT20,ProductType20,QuantityT20,SourceT20,DestinationT20
	--			 into #tmpRowT20 from [Transfer] where StartTriggerT20 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T20Row int = null
	--		set @T20Row = (Select [row] from #tmpRowT20 where id = @T20ProcessId)

	--		while ((Select Id from #tmpRowT20 where StartTriggerT20 != 0 and [Row] = @T20Row -1) != 0)
	--		begin
	--			set @T20tempId = (Select Id from #tmpRowT20 where StartTriggerT20 != 0 and [Row] = @T20Row -1)
	--			set @T20Row = @T20Row - 1
	--		end
	--		--select @T20tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT20 where row = @T20Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT20 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT20 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType20 from #tmpRowT20 where row = @T20Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT20 = 0 then 'No Selection'   
	--				when SourceT20 = 1 then 'RMST - 1'
	--				when SourceT20 = 2 then 'RMST - 2'
	--				when SourceT20 = 3 then 'RMST - 3'
	--				when SourceT20 = 4 then 'RMST - 4' end as [Source],
	--			'MPL - 2' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT20 where id between @T20tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT20 from #tmpRowT20 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT20 from #tmpRowT20 where Id = @T20tempId)) as Quantity
	--		into 
	--			#tempT20
	--		from 
	--			#tmpRowT20
	--		where 
	--			Id between @T20tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT20,SourceT20
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT20)

	--	drop table #tmpRowT20,#tempT20
	--end
	--else if((Select StartTriggerT21 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T21ProcessId int = null
	--		set @T21ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T21tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT21,ProductType21,QuantityT21,SourceT21,DestinationT21 
	--			into #tmpRowT21 from [Transfer] where StartTriggerT21 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T21Row int = null
	--		set @T21Row = (Select [row] from #tmpRowT21 where id = @T21ProcessId)

	--		while ((Select Id from #tmpRowT21 where StartTriggerT21 != 0 and [Row] = @T21Row -1) != 0)
	--		begin
	--			set @T21tempId = (Select Id from #tmpRowT21 where StartTriggerT21 != 0 and [Row] = @T21Row -1)
	--			set @T21Row = @T21Row - 1
	--		end
	--		--select @T21tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT21 where row = @T21Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT21 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT21 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType21 from #tmpRowT21 where row = @T21Row) and IsDeleted = 0) as ProductName,
	--			'MPL - 1' as [Source],
	--			(Select case when DestinationT21 = 0 then 'No Selection'  
	--				when DestinationT21 = 1 then 'PMST - 1'
	--				when DestinationT21 = 2 then 'PMST - 2'
	--				when DestinationT21 = 3 then 'PMST - 3'
	--				when DestinationT21 = 4 then 'PMST - 4'
	--				when DestinationT21 = 5 then 'PMST - 5' end from #temp1 where n= @a) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT21 where id between @T21tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT21 where id between @T21tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT21 where id between @T21tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT21 where id between @T21tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT21 where id between @T21tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT21 where id between @T21tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT21 from #tmpRowT21 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT21 from #tmpRowT21 where Id = @T21tempId)) as Quantity
	--		into 
	--			#tempT21
	--		from 
	--			#tmpRowT21
	--		where 
	--			Id between @T21tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],SourceT21,DestinationT21
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT21)

	--	drop table #tmpRowT21,#tempT21
	--end
	--else if((Select StartTriggerT22 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T22ProcessId int = null
	--		set @T22ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T22tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT22,ProductType22,QuantityT22,SourceT22,DestinationT22
	--			 into #tmpRowT22 from [Transfer] where StartTriggerT22 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T22Row int = null
	--		set @T22Row = (Select [row] from #tmpRowT22 where id = @T22ProcessId)

	--		while ((Select Id from #tmpRowT22 where StartTriggerT22 != 0 and [Row] = @T22Row -1) != 0)
	--		begin
	--			set @T22tempId = (Select Id from #tmpRowT22 where StartTriggerT22 != 0 and [Row] = @T22Row -1)
	--			set @T22Row = @T22Row - 1
	--		end
	--		--select @T22tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT22 where row = @T22Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT22 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT22 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType22 from #tmpRowT22 where row = @T22Row) and IsDeleted = 0) as ProductName,
	--			'MPL - 2' as [Source],
	--			(Select case when DestinationT22 = 0 then 'No Selection'  
	--				when DestinationT22 = 1 then 'PMST - 1'
	--				when DestinationT22 = 2 then 'PMST - 2'
	--				when DestinationT22 = 3 then 'PMST - 3'
	--				when DestinationT22 = 4 then 'PMST - 4'
	--				when DestinationT22 = 5 then 'PMST - 5' end from #temp1 where n= @a) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT22 where id between @T22tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT22 where id between @T22tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT22 where id between @T22tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT22 where id between @T22tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT22 where id between @T22tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT22 where id between @T22tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT22 from #tmpRowT22 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT22 from #tmpRowT22 where Id = @T22tempId)) as Quantity
	--		into 
	--			#tempT22
	--		from 
	--			#tmpRowT22
	--		where 
	--			Id between @T22tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT22,SourceT22
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT22)

	--	drop table #tmpRowT22,#tempT22
	--end 
	--else if((Select StartTriggerT23 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T23ProcessId int = null
	--		set @T23ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T23tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT23,ProductType23,QuantityT23,SourceT23,DestinationT23 
	--			 into #tmpRowT23 from [Transfer] where StartTriggerT23 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T23Row int = null
	--		set @T23Row = (Select [row] from #tmpRowT23 where id = @T23ProcessId)

	--		while ((Select Id from #tmpRowT23 where StartTriggerT23 != 0 and [Row] = @T23Row -1) != 0)
	--		begin
	--			set @T23tempId = (Select Id from #tmpRowT23 where StartTriggerT23 != 0 and [Row] = @T23Row -1)
	--			set @T23Row = @T23Row - 1
	--		end
	--		--select @T23tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT23 where row = @T23Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT23 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT23 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType23 from #tmpRowT23 where row = @T23Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT23 = 0 then 'No Selection'  
	--				when SourceT23 = 1 then 'PMST - 1'
	--				when SourceT23 = 2 then 'PMST - 2'
	--				when SourceT23 = 3 then 'PMST - 3'
	--				when SourceT23 = 4 then 'PMST - 4'
	--				when SourceT23 = 5 then 'PMST - 5' end as [Source],
	--			(Select	case when DestinationT23 = 0 then 'No Selection'  
	--				when DestinationT23 = 1 then 'SMST - 1'
	--				when DestinationT23 = 2 then 'SMST - 2'
	--				when DestinationT23 = 3 then 'SMST - 3'
	--				when DestinationT23 = 4 then 'SMST - 4' end from #temp1 where n= @a) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT23 where id between @T23tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT23 where id between @T23tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT23 where id between @T23tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT23 where id between @T23tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT23 where id between @T23tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT23 where id between @T23tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT23 from #tmpRowT23 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT23 from #tmpRowT23 where Id = @T23tempId)) as Quantity
	--		into 
	--			#tempT23
	--		from 
	--			#tmpRowT23
	--		where 
	--			Id between @T23tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT23,SourceT23
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT23)

	--	drop table #tmpRowT23,#tempT23
	--end
	--else if((Select StartTriggerT24 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T24ProcessId int = null
	--		set @T24ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T24tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT24,ProductType24,QuantityT24,SourceT24,DestinationT24
	--			 into #tmpRowT24 from [Transfer] where StartTriggerT24 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T24Row int = null
	--		set @T24Row = (Select [row] from #tmpRowT24 where id = @T24ProcessId)
			
	--		while ((Select Id from #tmpRowT24 where StartTriggerT24 != 0 and [Row] = @T24Row -1) != 0)
	--		begin
	--			set @T24tempId = (Select Id from #tmpRowT24 where StartTriggerT24 != 0 and [Row] = @T24Row -1)
	--			set @T24Row = @T24Row - 1
	--		end
	--		--select @T24tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT24 where row = @T24Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT24 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT24 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType24 from #tmpRowT24 where row = @T24Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT24 = 0 then 'No Selection'  
	--				when SourceT24 = 1 then 'SMST - 1'
	--				when SourceT24 = 2 then 'SMST - 2'
	--				when SourceT24 = 3 then 'SMST - 3' 
	--				when SourceT24 = 4 then 'SMST - 4' end as [Source],
	--			'CURD Pasturization' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT24 where id between @T24tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT24 where id between @T24tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT24 where id between @T24tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT24 where id between @T24tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT24 where id between @T24tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT24 where id between @T24tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT24 from #tmpRowT24 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT24 from #tmpRowT24 where Id = @T24tempId)) as Quantity
	--		into 
	--			#tempT24
	--		from 
	--			#tmpRowT24
	--		where 
	--			Id between @T24tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT24,SourceT24
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT24)

	--	drop table #tmpRowT24,#tempT24
	--end
	--else if((Select StartTriggerT25 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T25ProcessId int = null
	--		set @T25ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T25tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT25,ProductType25,QuantityT25,SourceT25,DestinationT25
	--			 into #tmpRowT25 from [Transfer] where StartTriggerT25 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T25Row int = null
	--		set @T25Row = (Select [row] from #tmpRowT25 where id = @T25ProcessId)
			
	--		while ((Select Id from #tmpRowT25 where StartTriggerT25 != 0 and [Row] = @T25Row -1) != 0)
	--		begin
	--			set @T25tempId = (Select Id from #tmpRowT25 where StartTriggerT25 != 0 and [Row] = @T25Row -1)
	--			set @T25Row = @T25Row - 1
	--		end
	--		--select @T24tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT25 where row = @T25Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT25 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT25 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType25 from #tmpRowT25 where row = @T25Row) and IsDeleted = 0) as ProductName,
	--			'CURD Pasturization' as [Source],
	--			(Select case when DestinationT25 = 0 then 'No Selection' 
	--				when DestinationT25 = 1 then 'CHILL CST - 1'
	--				when DestinationT25 = 2 then 'CHILL CST - 2' end from #temp1 where n= @a) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT25 where id between @T25tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT25 where id between @T25tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT25 where id between @T25tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT25 where id between @T25tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT25 where id between @T25tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT25 where id between @T25tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT25 from #tmpRowT25 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT25 from #tmpRowT25 where Id = @T25tempId)) as Quantity
	--		into 
	--			#tempT25
	--		from 
	--			#tmpRowT25
	--		where 
	--			Id between @T25tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT25,SourceT25
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT25)

	--	drop table #tmpRowT25,#tempT25
	--end
	--else if((Select StartTriggerT26 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T26ProcessId int = null
	--		set @T26ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T26tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT26,ProductType26,QuantityT26,SourceT26,DestinationT26 
	--			 into #tmpRowT26 from [Transfer] where StartTriggerT26 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T26Row int = null
	--		set @T26Row = (Select [row] from #tmpRowT26 where id = @T26ProcessId)

	--		while ((Select Id from #tmpRowT26 where StartTriggerT26 != 0 and [Row] = @T26Row -1) != 0)
	--		begin
	--			set @T26tempId = (Select Id from #tmpRowT26 where StartTriggerT26 != 0 and [Row] = @T26Row -1)
	--			set @T26Row = @T26Row - 1
	--		end
	--		--select @T24tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT26 where row = @T26Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT26 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT26 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType26 from #tmpRowT26 where row = @T26Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT26 = 0 then 'No Selection'  
	--				when SourceT26 = 1 then 'CHILL CST - 1'
	--				when SourceT26 = 2 then 'CHILL CST - 2' end as [Source],
	--			'Curd Inoculation Tanks' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT26 where id between @T26tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT26 where id between @T26tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT26 where id between @T26tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT26 where id between @T26tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT26 where id between @T26tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT26 where id between @T26tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT26 from #tmpRowT26 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT26 from #tmpRowT26 where Id = @T26tempId)) as Quantity
	--		into 
	--			#tempT26
	--		from 
	--			#tmpRowT26
	--		where 
	--			Id between @T26tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT26,SourceT26
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination,TotalTime,Quantity)
	--		(Select * from #tempT26)

	--	drop table #tmpRowT26,#tempT26
	--end
	--else if((Select StartTriggerT27 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T27ProcessId int = null
	--		set @T27ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T27tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT27,ProductType27,QuantityT27,SourceT27,DestinationT27 
	--			 into #tmpRowT27 from [Transfer] where StartTriggerT27 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T27Row int = null
	--		set @T27Row = (Select [row] from #tmpRowT27 where id = @T27ProcessId)

	--		while ((Select Id from #tmpRowT27 where StartTriggerT27 != 0 and [Row] = @T27Row -1) != 0)
	--		begin
	--			set @T27tempId = (Select Id from #tmpRowT27 where StartTriggerT27 != 0 and [Row] = @T27Row -1)
	--			set @T27Row = @T27Row - 1
	--		end
	--		--select @T24tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT27 where row = @T27Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT27 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT27 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType27 from #tmpRowT27 where row = @T27Row) and IsDeleted = 0) as ProductName,
	--			case when SourceT27 = 0 then 'No Selection' 
	--				when SourceT27 = 1 then 'SMST - 1'
	--				when SourceT27 = 2 then 'SMST - 2'
	--				when SourceT27 = 3 then 'SMST - 3' 
	--				when SourceT27 = 4 then 'SMST - 4' end as [Source],
	--			'ButterMilk Pasturization' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT27 where id between @T27tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT27 where id between @T27tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT27 where id between @T27tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT27 where id between @T27tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT27 where id between @T27tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT27 where id between @T27tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT27 from #tmpRowT27 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT27 from #tmpRowT27 where Id = @T27tempId)) as Quantity
	--		into 
	--			#tempT27
	--		from 
	--			#tmpRowT27
	--		where 
	--			Id between @T27tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT27,SourceT27
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT27)

	--	drop table #tmpRowT27,#tempT27
	--end
	--else if((Select StartTriggerT28 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T28ProcessId int = null
	--		set @T28ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T28tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT28,ProductType28,QuantityT28,SourceT28,DestinationT28 
	--			 into #tmpRowT28 from [Transfer] where StartTriggerT28 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T28Row int = null
	--		set @T28Row = (Select [row] from #tmpRowT28 where id = @T28ProcessId)

	--		while ((Select Id from #tmpRowT28 where StartTriggerT28 != 0 and [Row] = @T28Row -1) != 0)
	--		begin
	--			set @T28tempId = (Select Id from #tmpRowT28 where StartTriggerT28 != 0 and [Row] = @T28Row -1)
	--			set @T28Row = @T28Row - 1
	--		end
	--		--select @T24tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT28 where row = @T28Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT28 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT28 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType28 from #tmpRowT28 where row = @T28Row) and IsDeleted = 0) as ProductName,
	--			'ButterMilk Pasturization' as [Source],
	--			'Curd Settle tank' as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT28 where id between @T28tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT28 where id between @T28tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT28 where id between @T28tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT28 where id between @T28tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT28 where id between @T28tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT28 where id between @T28tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT28 from #tmpRowT28 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT28 from #tmpRowT28 where Id = @T28tempId)) as Quantity
	--		into 
	--			#tempT28
	--		from 
	--			#tmpRowT28
	--		where 
	--			Id between @T28tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT28,SourceT28
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT28)

	--	drop table #tmpRowT28,#tempT28
	--end
	--else if((Select StartTriggerT29 from #temp1 where n = @a) = 0)
	--begin
	--		Declare @T29ProcessId int = null
	--		set @T29ProcessId = (select Id from #temp1 where n = @a)
	--		Declare @T29tempId int
		
	--		Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT29,ProductType29,QuantityT29,SourceT29,DestinationT29 
	--			 into #tmpRowT29 from [Transfer] where StartTriggerT29 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
	--		Declare @T29Row int = null
	--		set @T29Row = (Select [row] from #tmpRowT29 where id = @T29ProcessId)

	--		while ((Select Id from #tmpRowT29 where StartTriggerT29 != 0 and [Row] = @T29Row -1) != 0)
	--		begin
	--			set @T29tempId = (Select Id from #tmpRowT29 where StartTriggerT29 != 0 and [Row] = @T29Row -1)
	--			set @T29Row = @T29Row - 1
	--		end
	--		--select @T24tempId
	--		set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT29 where row = @T29Row)) between FromTime and ToTime)
			
	--		Select 
	--			top 1 convert(time,[Date],109) as StartTime,
	--			(Select convert(time,[Date],109) from #tmpRowT29 where id = (select Id from #temp1 where n = @a)) as StopTime,
	--			(Select convert(varchar(10),[Date],103) from #tmpRowT29 where id = (select Id from #temp1 where n = @a)) as [Date],
	--			@ShiftName as 'ShiftName',
	--			(Select ProductName from Product where IdentifierCode = (Select ProductType29 from #tmpRowT29 where row = @T29Row) and IsDeleted = 0) as ProductName,
	--			'Curd Settle tank' as [Source],
	--			(Select case when DestinationT29 = 0 then 'No Selection'
	--				when DestinationT29 = 1 then 'BMST - 1'
	--				when DestinationT29 = 2 then 'BMST - 2'
	--				when DestinationT29 = 3 then 'BMST - 3'
	--				when DestinationT29 = 4 then 'BMST - 4' end from #temp1 where n= @a) as Destination,
	--			(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT29 where id between @T29tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT29 where id between @T29tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
	--						convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT29 where id between @T29tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT29 where id between @T29tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
	--						convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT29 where id between @T29tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT29 where id between @T29tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
	--			((Select QuantityT29 from #tmpRowT29 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT29 from #tmpRowT29 where Id = @T29tempId)) as Quantity
	--		into 
	--			#tempT29
	--		from 
	--			#tmpRowT29
	--		where 
	--			Id between @T29tempId and (select Id from #temp1 where n = @a)
	--		group by [Date],DestinationT29,SourceT29
	--		Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,ProductName,[Source],Destination ,TotalTime,Quantity)
	--		(Select * from #tempT29)

	--	drop table #tmpRowT29,#tempT29
	--end
	

	set @a = @a + 1
end

select 
Id as SrNo,
ShiftName,
[Date],
StartTime,
StopTime,
TotalTime,
Status,
--ShiftName,
Fat,
SNF,
FunctionNo,
[Source],
Destination ,
TransferName,
Product,
Quantity
from #tempProductTreacebility

drop table #temp1,#tempProductTreacebility




GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_TransferReport_Amul]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_TransferReport_Amul] '07/13/2019 01:00:00','07/13/2019 16:00:00','--All--','--All--'
CREATE procedure [dbo].[usp_rpt_TransferReport_Amul]
	@FromDateTime datetime,
	@ToDateTime datetime,
	@SourceName varchar(200) = NULL,
	@DestinationName varchar(200) = NULL
AS

--Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1
--	from [Transfer] t 
--		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0 or StartTriggerT3 = 0 or StartTriggerT4 = 0 or StartTriggerT5 = 0 
--			or	StartTriggerT6 = 0 or StartTriggerT7 = 0 or StartTriggerT8 = 0 or StartTriggerT9 = 0 or StartTriggerT10 = 0
--			or StartTriggerT11 = 0 or StartTriggerT12 = 0 or StartTriggerT13 = 0 or StartTriggerT14 = 0 or StartTriggerT15 = 0 or StartTriggerT16 = 0) 
--		 and [Date] between @FromDateTime and @ToDateTime 
----select * from #temp1

--Declare @ShiftName varchar(20) = null
--Declare @ProductName varchar(50) = null
--declare @a int = 1
--declare @count int = (select count(*) from #temp1)

------------------------------------- Create Temp Table --------------------------
--Create table #tempProductTreacebility (Id int IDENTITY(1,1),[Date] varchar(10),ShiftName varchar(50),
--								StartTime varchar(8),StopTime varchar(8),[Source] varchar(50),Destination varchar(50),TotalTime varchar(8),Quantity decimal(18,2))
------------------------------------

--while (@a <= @count)
--begin

--	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
--	begin
		
--			Declare @T1ProcessId int = null
--			set @T1ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T1tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT1],[SourceT1],[QuantityT1],[DestinationT1] 
--				into #tmpRowT1 from [Transfer] where StartTriggerT1 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T1Row int = null
--			set @T1Row = (Select [row] from #tmpRowT1 where id = @T1ProcessId)

--			while ((Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1) != 0)
--			begin
--				set @T1tempId = (Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1)
--				set @T1Row = @T1Row - 1
--			end
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT1 where row = @T1Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT1 from #tmpRowT1 where Id = @T1tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT1 from #tmpRowT1 where Id = @T1tempId)) as Destination,
--				--'MPL Idle' 
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT1 from #tmpRowT1 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT1 from #tmpRowT1 where Id = @T1tempId)) as Quantity
--			into 
--				#tempT1
--			from 
--				#tmpRowT1
--			where 
--				Id between @T1tempId and (select Id from #temp1 where n = @a)
--				and SourceT1 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT1 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT1,SourceT1
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT1)

--		drop table #tmpRowT1,#tempT1
--	end
--	else if((Select StartTriggerT2 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T2ProcessId int = null
--			set @T2ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T2tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT2],[SourceT2],[QuantityT2],[DestinationT2] 
--			into #tmpRowT2 from [Transfer] where StartTriggerT2 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T2Row int = null
--			set @T2Row = (Select [row] from #tmpRowT2 where id = @T2ProcessId)

--			while ((Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1) != 0)
--			begin
--				set @T2tempId = (Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1)
--				set @T2Row = @T2Row - 1
--			end
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT2 where row = @T2Row)) between FromTime and ToTime)
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType2 from #tmpRowT2 where row = @T1Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT2 from #tmpRowT2 where Id = @T2tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT2 from #tmpRowT2 where Id = @T2tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT2 from #tmpRowT2 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT2 from #tmpRowT2 where Id = @T2tempId)) as Quantity
--			into 
--				#tempT2
--			from 
--				#tmpRowT2
--			where 
--				Id between @T2tempId and (select Id from #temp1 where n = @a)
--				and SourceT2 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT2 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT2,SourceT2
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT2)

--		drop table #tmpRowT2,#tempT2
--	end
--	else if((Select StartTriggerT3 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T3ProcessId int = null
--			set @T3ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T3tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT3],[SourceT3],[QuantityT3],[DestinationT3] 
--			into #tmpRowT3 from [Transfer] where StartTriggerT3 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T3Row int = null
--			set @T3Row = (Select [row] from #tmpRowT3 where id = @T3ProcessId)
			
--			while ((Select Id from #tmpRowT3 where StartTriggerT3 != 0 and [Row] = @T3Row -1) != 0)
--			begin
--				set @T3tempId = (Select Id from #tmpRowT3 where StartTriggerT3 != 0 and [Row] = @T3Row -1)
--				set @T3Row = @T3Row - 1
--			end
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT3 where row = @T3Row)) between FromTime and ToTime)
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT3 from #tmpRowT3 where Id = @T3tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT3 from #tmpRowT3 where Id = @T3tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT3 from #tmpRowT3 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT3 from #tmpRowT3 where Id = @T3tempId)) as Quantity
--			into 
--				#tempT3
--			from 
--				#tmpRowT3
--			where 
--				Id between @T3tempId and (select Id from #temp1 where n = @a)
--				and SourceT3 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT3 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT3,DestinationT3
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT3)

--		drop table #tmpRowT3,#tempT3
--	end
--	else if((Select StartTriggerT4 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T4ProcessId int = null
--			set @T4ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T4tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT4],[SourceT4],[QuantityT4],[DestinationT4] 
--			 into #tmpRowT4 from [Transfer] where StartTriggerT4 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T4Row int = null
--			set @T4Row = (Select [row] from #tmpRowT4 where id = @T4ProcessId)

--			while ((Select Id from #tmpRowT4 where StartTriggerT4 != 0 and [Row] = @T4Row -1) != 0)
--			begin
--				set @T4tempId = (Select Id from #tmpRowT4 where StartTriggerT4 != 0 and [Row] = @T4Row -1)
--				set @T4Row = @T4Row - 1
--			end
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT4 where row = @T4Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType4 from #tmpRowT4 where row = @T4Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT4 from #tmpRowT4 where Id = @T4tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT4 from #tmpRowT4 where Id = @T4tempId)) as	Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT4 from #tmpRowT4 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT4 from #tmpRowT4 where Id = @T4tempId)) as Quantity
--			into 
--				#tempT4
--			from 
--				#tmpRowT4
--			where 
--				Id between @T4tempId and (select Id from #temp1 where n = @a)
--				and SourceT4 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT4 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT4,DestinationT4
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT4)

--		drop table #tmpRowT4,#tempT4
--	end
--	else if((Select StartTriggerT5 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T5ProcessId int = null
--			set @T5ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T5tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT5],[SourceT5],[QuantityT5],[DestinationT5] 
--			 into #tmpRowT5 from [Transfer] where StartTriggerT5 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T5Row int = null
--			set @T5Row = (Select [row] from #tmpRowT5 where id = @T5ProcessId)

--			while ((Select Id from #tmpRowT5 where StartTriggerT5 != 0 and [Row] = @T5Row -1) != 0)
--			begin
--				set @T5tempId = (Select Id from #tmpRowT5 where StartTriggerT5 != 0 and [Row] = @T5Row -1)
--				set @T5Row = @T5Row - 1
--			end
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT5 where row = @T5Row)) between FromTime and ToTime)
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType5 from #tmpRowT5 where row = @T5Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT5 from #tmpRowT5 where Id = @T5tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT5 from #tmpRowT5 where Id = @T5tempId)) as	Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT5 from #tmpRowT5 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT5 from #tmpRowT5 where Id = @T5tempId)) as Quantity
--			into 
--				#tempT5
--			from 
--				#tmpRowT5
--			where 
--				Id between @T5tempId and (select Id from #temp1 where n = @a)
--				and SourceT5 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT5 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT5,DestinationT5
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT5)

--		drop table #tmpRowT5,#tempT5
--	end
--	else if((Select StartTriggerT6 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T6ProcessId int = null
--			set @T6ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T6tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT6],[SourceT6],[QuantityT6],[DestinationT6] 
--			 into #tmpRowT6 from [Transfer] where StartTriggerT6 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T6Row int = null
--			set @T6Row = (Select [row] from #tmpRowT6 where id = @T6ProcessId)

--			while ((Select Id from #tmpRowT6 where StartTriggerT6 != 0 and [Row] = @T6Row -1) != 0)
--			begin
--				set @T6tempId = (Select Id from #tmpRowT6 where StartTriggerT6 != 0 and [Row] = @T6Row -1)
--				set @T6Row = @T6Row - 1
--			end
--			--select @T6tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT6 where row = @T6Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType6 from #tmpRowT6 where row = @T6Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT6 from #tmpRowT6 where Id = @T6tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT6 from #tmpRowT6 where Id = @T6tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT6 from #tmpRowT6 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT6 from #tmpRowT6 where Id = @T6tempId)) as Quantity
--			into 
--				#tempT6
--			from 
--				#tmpRowT6
--			where 
--				Id between @T6tempId and (select Id from #temp1 where n = @a)
--				and SourceT6 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT6 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT6,DestinationT6
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT6)

--		drop table #tmpRowT6,#tempT6
--	end
--	else if((Select StartTriggerT7 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T7ProcessId int = null
--			set @T7ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T7tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT7],[SourceT7],[QuantityT7],[DestinationT7] 
--				into #tmpRowT7 from [Transfer] where StartTriggerT7 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T7Row int = null
--			set @T7Row = (Select [row] from #tmpRowT7 where id = @T7ProcessId)

--			while ((Select Id from #tmpRowT7 where StartTriggerT7 != 0 and [Row] = @T7Row -1) != 0)
--			begin
--				set @T7tempId = (Select Id from #tmpRowT7 where StartTriggerT7 != 0 and [Row] = @T7Row -1)
--				set @T7Row = @T7Row - 1
--			end
--			--select @T7tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT7 where row = @T7Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType7 from #tmpRowT7 where row = @T7Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT7 from #tmpRowT7 where Id = @T7tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT7 from #tmpRowT7 where Id = @T7tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT7 from #tmpRowT7 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT7 from #tmpRowT7 where Id = @T7tempId)) as Quantity
--			into 
--				#tempT7
--			from 
--				#tmpRowT7
--			where 
--				Id between @T7tempId and (select Id from #temp1 where n = @a)
--				and SourceT7 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT7 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT7,DestinationT7
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT7)

--		drop table #tmpRowT7,#tempT7
--	end
--	else if((Select StartTriggerT8 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T8ProcessId int = null
--			set @T8ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T8tempId int
			
--			Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT8],[SourceT8],[QuantityT8],[DestinationT8] 
--				 into #tmpRowT8 from [Transfer] where StartTriggerT8 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T8Row int = null
--			set @T8Row = (Select [row] from #tmpRowT8 where id = @T8ProcessId)

--			while ((Select Id from #tmpRowT8 where StartTriggerT8 != 0 and [Row] = @T8Row -1) != 0)
--			begin
--				set @T8tempId = (Select Id from #tmpRowT8 where StartTriggerT8 != 0 and [Row] = @T8Row -1)
--				set @T8Row = @T8Row - 1
--			end
--			--select @T8tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT8 where row = @T8Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType8 from #tmpRowT8 where row = @T8Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT8 from #tmpRowT8 where Id = @T8tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT8 from #tmpRowT8 where Id = @T8tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT8 from #tmpRowT8 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT8 from #tmpRowT8 where Id = @T8tempId)) as Quantity
--			into 
--				#tempT8
--			from 
--				#tmpRowT8
--			where 
--				Id between @T8tempId and (select Id from #temp1 where n = @a)
--				and SourceT8 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT8 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT8,DestinationT8
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT8)

--		drop table #tmpRowT8,#tempT8
--	end
--	else if((Select StartTriggerT9 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T9ProcessId int = null
--			set @T9ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T9tempId int
--			Declare @ShiftName9 varchar(20) = null
--			Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT9],[SourceT9],[QuantityT9],[DestinationT9] 
--				 into #tmpRowT9 from [Transfer] where StartTriggerT9 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T9Row int = null
--			set @T9Row = (Select [row] from #tmpRowT9 where id = @T9ProcessId)


--			while ((Select Id from #tmpRowT9 where StartTriggerT9 != 0 and [Row] = @T9Row -1) != 0)
--			begin
--				set @T9tempId = (Select Id from #tmpRowT9 where StartTriggerT9 != 0 and [Row] = @T9Row -1)
--				set @T9Row = @T9Row - 1
--			end
--			--select @T9tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT9 where row = @T9Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT9 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT9 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType9 from #tmpRowT9 where row = @T9Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT9 from #tmpRowT9 where Id = @T9tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT9 from #tmpRowT9 where Id = @T9tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT9 from #tmpRowT9 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT9 from #tmpRowT9 where Id = @T9tempId)) as Quantity
--			into 
--				#tempT9
--			from 
--				#tmpRowT9
--			where 
--				Id between @T9tempId and (select Id from #temp1 where n = @a)
--				and SourceT9 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT9 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT9,DestinationT9
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT9)

--		drop table #tmpRowT9,#tempT9
--	end
--	else if((Select StartTriggerT10 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T10ProcessId int = null
--			set @T10ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T10tempId int
--			Declare @ShiftName10 varchar(20) = null
--			Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT10],[SourceT10],[QuantityT10],[DestinationT10] 
--				 into #tmpRowT10 from [Transfer] where StartTriggerT10 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T10Row int = null
--			set @T10Row = (Select [row] from #tmpRowT10 where id = @T10ProcessId)

--			while ((Select Id from #tmpRowT10 where StartTriggerT10 != 0 and [Row] = @T10Row -1) != 0)
--			begin
--				set @T10tempId = (Select Id from #tmpRowT10 where StartTriggerT10 != 0 and [Row] = @T10Row -1)
--				set @T10Row = @T10Row - 1
--			end
--			--select @T10tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT10 where row = @T10Row)) between FromTime and ToTime)

--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT10 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT10 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType10 from #tmpRowT10 where row = @T10Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT10 from #tmpRowT10 where Id = @T10tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT10 from #tmpRowT10 where Id = @T10tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT10 from #tmpRowT10 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT10 from #tmpRowT10 where Id = @T10tempId)) as Quantity
--			into 
--				#tempT10
--			from 
--				#tmpRowT10
--			where 
--				Id between @T10tempId and (select Id from #temp1 where n = @a)
--				and SourceT10 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT10 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT10,DestinationT10
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT10)

--		drop table #tmpRowT10,#tempT10
--	end
--	else if((Select StartTriggerT11 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T11ProcessId int = null
--			set @T11ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T11tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT11,QuantityT11,SourceT11,DestinationT11
--				into #tmpRowT11 from [Transfer] where StartTriggerT11 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T11Row int = null
--			set @T11Row = (Select [row] from #tmpRowT11 where id = @T11ProcessId)

--			while ((Select Id from #tmpRowT11 where StartTriggerT11 != 0 and [Row] = @T11Row -1) != 0)
--			begin
--				set @T11tempId = (Select Id from #tmpRowT11 where StartTriggerT11 != 0 and [Row] = @T11Row -1)
--				set @T11Row = @T11Row - 1
--			end
--			--select @T11tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT11 where row = @T11Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT11 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT11 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType11 from #tmpRowT11 where row = @T11Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT11 from #tmpRowT11 where Id = @T11tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT11 from #tmpRowT11 where Id = @T11tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT11 from #tmpRowT11 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT11 from #tmpRowT11 where Id = @T11tempId)) as Quantity
--			into 
--				#tempT11
--			from 
--				#tmpRowT11
--			where 
--				Id between @T11tempId and (select Id from #temp1 where n = @a)
--				and SourceT11 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT11 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT11,SourceT11
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT11)

--		drop table #tmpRowT11,#tempT11
--	end
--	else if((Select StartTriggerT12 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T12ProcessId int = null
--			set @T12ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T12tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT12,QuantityT12,SourceT12,DestinationT12
--				 into #tmpRowT12 from [Transfer] where StartTriggerT12 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T12Row int = null
--			set @T12Row = (Select [row] from #tmpRowT12 where id = @T12ProcessId)


--			while ((Select Id from #tmpRowT12 where StartTriggerT12 != 0 and [Row] = @T12Row -1) != 0)
--			begin
--				set @T12tempId = (Select Id from #tmpRowT12 where StartTriggerT12 != 0 and [Row] = @T12Row -1)
--				set @T12Row = @T12Row - 1
--			end
--			--select @T12tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT12 where row = @T12Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT12 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT12 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType12 from #tmpRowT12 where row = @T12Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT12 from #tmpRowT12 where Id = @T12tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT12 from #tmpRowT12 where Id = @T12tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT12 from #tmpRowT12 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT12 from #tmpRowT12 where Id = @T12tempId)) as Quantity
--			into 
--				#tempT12
--			from 
--				#tmpRowT12
--			where 
--				Id between @T12tempId and (select Id from #temp1 where n = @a)
--				and SourceT12 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT12 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT12,SourceT12
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT12)

--		drop table #tmpRowT12,#tempT12
--	end
--	else if((Select StartTriggerT13 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T13ProcessId int = null
--			set @T13ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T13tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT13,QuantityT13,SourceT13,DestinationT13
--				into #tmpRowT13 from [Transfer] where StartTriggerT13 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T13Row int = null
--			set @T13Row = (Select [row] from #tmpRowT13 where id = @T13ProcessId)

--			while ((Select Id from #tmpRowT13 where StartTriggerT13 != 0 and [Row] = @T13Row -1) != 0)
--			begin
--				set @T13tempId = (Select Id from #tmpRowT13 where StartTriggerT13 != 0 and [Row] = @T13Row -1)
--				set @T13Row = @T13Row - 1
--			end
--			--select @T13tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT13 where row = @T13Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT13 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT13 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType13 from #tmpRowT13 where row = @T13Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT13 from #tmpRowT13 where Id = @T13tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT13 from #tmpRowT13 where Id = @T13tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT13 from #tmpRowT13 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT13 from #tmpRowT13 where Id = @T13tempId)) as Quantity
--			into 
--				#tempT13
--			from 
--				#tmpRowT13
--			where 
--				Id between @T13tempId and (select Id from #temp1 where n = @a)
--				and SourceT13 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT13 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],SourceT13,DestinationT13
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT13)

--		drop table #tmpRowT13,#tempT13
--	end
--	else if((Select StartTriggerT14 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T14ProcessId int = null
--			set @T14ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T14tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT14,QuantityT14,SourceT14,DestinationT14
--				 into #tmpRowT14 from [Transfer] where StartTriggerT14 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T14Row int = null
--			set @T14Row = (Select [row] from #tmpRowT14 where id = @T14ProcessId)

--			while ((Select Id from #tmpRowT14 where StartTriggerT14 != 0 and [Row] = @T14Row -1) != 0)
--			begin
--				set @T14tempId = (Select Id from #tmpRowT14 where StartTriggerT14 != 0 and [Row] = @T14Row -1)
--				set @T14Row = @T14Row - 1
--			end
--			--select @T14tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT14 where row = @T14Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT14 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT14 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType14 from #tmpRowT14 where row = @T14Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT14 from #tmpRowT14 where Id = @T14tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT14 from #tmpRowT14 where Id = @T14tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT14 from #tmpRowT14 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT14 from #tmpRowT14 where Id = @T14tempId)) as Quantity
--			into 
--				#tempT14
--			from 
--				#tmpRowT14
--			where 
--				Id between @T14tempId and (select Id from #temp1 where n = @a)
--				and SourceT14 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT14 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT14,SourceT14
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT14)

--		drop table #tmpRowT14,#tempT14
--	end
--	else if((Select StartTriggerT15 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T15ProcessId int = null
--			set @T15ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T15tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT15,QuantityT15,SourceT15,DestinationT15
--				 into #tmpRowT15 from [Transfer] where StartTriggerT15 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T15Row int = null
--			set @T15Row = (Select [row] from #tmpRowT15 where id = @T15ProcessId)

--			while ((Select Id from #tmpRowT15 where StartTriggerT15 != 0 and [Row] = @T15Row -1) != 0)
--			begin
--				set @T15tempId = (Select Id from #tmpRowT15 where StartTriggerT15 != 0 and [Row] = @T15Row -1)
--				set @T15Row = @T15Row - 1
--			end
--			--select @T15tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT15 where row = @T15Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT15 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT15 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType15 from #tmpRowT15 where row = @T15Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT15 from #tmpRowT15 where Id = @T15tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT15 from #tmpRowT15 where Id = @T15tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT15 from #tmpRowT15 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT15 from #tmpRowT15 where Id = @T15tempId)) as Quantity
--			into 
--				#tempT15
--			from 
--				#tmpRowT15
--			where 
--				Id between @T15tempId and (select Id from #temp1 where n = @a)
--				and SourceT15 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT15 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT15,SOURCET15
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT15)

--		drop table #tmpRowT15,#tempT15
--	end
--	else if((Select StartTriggerT16 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T16ProcessId int = null
--			set @T16ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T16tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT16,QuantityT16,SourceT16,DestinationT16
--				 into #tmpRowT16 from [Transfer] where StartTriggerT16 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T16Row int = null
--			set @T16Row = (Select [row] from #tmpRowT16 where id = @T16ProcessId)

--			while ((Select Id from #tmpRowT16 where StartTriggerT16 != 0 and [Row] = @T16Row -1) != 0)
--			begin
--				set @T16tempId = (Select Id from #tmpRowT16 where StartTriggerT16 != 0 and [Row] = @T16Row -1)
--				set @T16Row = @T16Row - 1
--			end
--			--select @T16tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT16 where row = @T16Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT16 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT16 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType16 from #tmpRowT16 where row = @T16Row) and IsDeleted = 0) as ProductName,
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT16 from #tmpRowT16 where Id = @T16tempId))as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT16 from #tmpRowT16 where Id = @T16tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT16 from #tmpRowT16 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT16 from #tmpRowT16 where Id = @T16tempId)) as Quantity
--			into 
--				#tempT16
--			from 
--				#tmpRowT16
--			where 
--				Id between @T16tempId and (select Id from #temp1 where n = @a)
--				and SourceT16 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--				and DestinationT16 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
--			group by [Date],DestinationT16,SOURCET16
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT16)

--		drop table #tmpRowT16,#tempT16
--	end
--	else if((Select StartTriggerT17 from #temp1 where n = @a) = 0)
--	begin
--			Declare @T17ProcessId int = null
--			set @T17ProcessId = (select Id from #temp1 where n = @a)
--			Declare @T17tempId int
		
--			Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT17,QuantityT17,SourceT17,DestinationT17
--				 into #tmpRowT17 from [Transfer] where StartTriggerT17 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
--			Declare @T17Row int = null
--			set @T17Row = (Select [row] from #tmpRowT17 where id = @T17ProcessId)
			
--			while ((Select Id from #tmpRowT17 where StartTriggerT17 != 0 and [Row] = @T17Row -1) != 0)
--			begin
--				set @T17tempId = (Select Id from #tmpRowT17 where StartTriggerT17 != 0 and [Row] = @T17Row -1)
--				set @T17Row = @T17Row - 1
--			end
--			--select @T17tempId
--			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT17 where row = @T17Row)) between FromTime and ToTime)
			
--			Select 
--				top 1 convert(time,[Date],109) as StartTime,
--				(Select convert(time,[Date],109) from #tmpRowT17 where id = (select Id from #temp1 where n = @a)) as StopTime,
--				(Select convert(varchar(10),[Date],103) from #tmpRowT17 where id = (select Id from #temp1 where n = @a)) as [Date],
--				@ShiftName as 'ShiftName',
--				--(Select ProductName from Product where IdentifierCode = (Select ProductType17 from #tmpRowT17 where row = @T17Row) and IsDeleted = 0) as ProductName,
--				'Butter Milk' as [Source],
--				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT17 from #tmpRowT17 where Id = @T17tempId)) as Destination,
--				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
--							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
--							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
--				((Select QuantityT17 from #tmpRowT17 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT17 from #tmpRowT17 where Id = @T17tempId)) as Quantity
--			into 
--				#tempT17
--			from 
--				#tmpRowT17
--			where 
--				Id between @T17tempId and (select Id from #temp1 where n = @a)
--			group by [Date],SourceT17,DestinationT17
--			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
--			(Select * from #tempT17)

--		drop table #tmpRowT17,#tempT17
--	end


--	set @a = @a + 1
--end

--select 
--convert(varchar(10),Id ) as SrNo,
--[Date],
--StartTime,
--StopTime,
--TotalTime,

----ShiftName,

--[Source],
--Destination ,

--Quantity
--from #tempProductTreacebility

--union all

--select 
--convert(varchar(10),'Total') as SrNo,
--'' as [Date],
--'' as StartTime,
--'' as StopTime,
--'' as TotalTime,

----ShiftName,

--'' as [Source],
--'' as Destination ,

--sum(Quantity)
--from #tempProductTreacebility

--drop table #temp1,#tempProductTreacebility

Select  row_number() OVER (ORDER BY [Date]) n,t.* into #temp1
	from [Transfer] t 
		 where (StartTriggerT1 = 0 or StartTriggerT2 = 0 or StartTriggerT3 = 0 or StartTriggerT4 = 0 or StartTriggerT5 = 0 
			or	StartTriggerT6 = 0 or StartTriggerT7 = 0 or StartTriggerT8 = 0 or StartTriggerT9 = 0 or StartTriggerT10 = 0
			or StartTriggerT11 = 0 or StartTriggerT12 = 0 or StartTriggerT13 = 0 or StartTriggerT14 = 0 or StartTriggerT15 = 0 or StartTriggerT16 = 0 or StartTriggerT17 = 0 or StartTriggerT18 = 0) 
		 and [Date] between @FromDateTime and @ToDateTime 
--select * from #temp1
Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT1],[SourceT1],[QuantityT1],[DestinationT1] 
				into #tmpRowT1 from [Transfer] where StartTriggerT1 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT2],[SourceT2],[QuantityT2],[DestinationT2] 
				into #tmpRowT2 from [Transfer] where StartTriggerT2 in (1,0) and [Date] between @FromDateTime and @ToDateTime 


Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT3],[SourceT3],[QuantityT3],[DestinationT3] 
		into #tmpRowT3 from [Transfer] where StartTriggerT3 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT4],[SourceT4],[QuantityT4],[DestinationT4] 
			 into #tmpRowT4 from [Transfer] where StartTriggerT4 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT5],[SourceT5],[QuantityT5],[DestinationT5] 
			 into #tmpRowT5 from [Transfer] where StartTriggerT5 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT6],[SourceT6],[QuantityT6],[DestinationT6] 
			 into #tmpRowT6 from [Transfer] where StartTriggerT6 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT7],[SourceT7],[QuantityT7],[DestinationT7] 
				into #tmpRowT7 from [Transfer] where StartTriggerT7 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT8],[SourceT8],[QuantityT8],[DestinationT8] 
				 into #tmpRowT8 from [Transfer] where StartTriggerT8 in (1,0) and [Date] between @FromDateTime and @ToDateTime  

Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT9],[SourceT9],[QuantityT9],[DestinationT9] 
				 into #tmpRowT9 from [Transfer] where StartTriggerT9 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT10],[SourceT10],[QuantityT10],[DestinationT10] 
				 into #tmpRowT10 from [Transfer] where StartTriggerT10 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT11,QuantityT11,SourceT11,DestinationT11
				into #tmpRowT11 from [Transfer] where StartTriggerT11 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT12,QuantityT12,SourceT12,DestinationT12
				 into #tmpRowT12 from [Transfer] where StartTriggerT12 in (1,0) and [Date] between @FromDateTime and @ToDateTime

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT13,QuantityT13,SourceT13,DestinationT13
				into #tmpRowT13 from [Transfer] where StartTriggerT13 in (1,0) and [Date] between @FromDateTime and @ToDateTime

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT14,QuantityT14,SourceT14,DestinationT14
				 into #tmpRowT14 from [Transfer] where StartTriggerT14 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT15,QuantityT15,SourceT15,DestinationT15
				 into #tmpRowT15 from [Transfer] where StartTriggerT15 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT16,QuantityT16,SourceT16,DestinationT16
				 into #tmpRowT16 from [Transfer] where StartTriggerT16 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT17,QuantityT17,SourceT17,DestinationT17
				 into #tmpRowT17 from [Transfer] where StartTriggerT17 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
				 
Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT18,QuantityT18,SourceT18,DestinationT18
				 into #tmpRowT18 from [Transfer] where StartTriggerT18 in (1,0) and [Date] between @FromDateTime and @ToDateTime 

Declare @ShiftName varchar(20) = null
Declare @ProductName varchar(50) = null
declare @a int = 1
declare @count int = (select count(*) from #temp1)

----------------------------------- Create Temp Table --------------------------
Create table #tempProductTreacebility (Id int IDENTITY(1,1),[Date] varchar(10),ShiftName varchar(50),
								StartTime varchar(8),StopTime varchar(8),[Source] varchar(50),Destination varchar(50),TotalTime varchar(8),Quantity decimal(18,2))
----------------------------------

while (@a <= @count)
begin

	if((Select StartTriggerT1 from #temp1 where n = @a) = 0)
	begin
		
			Declare @T1ProcessId int = null
			set @T1ProcessId = (select Id from #temp1 where n = @a)
			Declare @T1tempId int
			
			
			Declare @T1Row int = null
			set @T1Row = (Select [row] from #tmpRowT1 where id = @T1ProcessId)

			while ((Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1) != 0)
			begin
				set @T1tempId = (Select Id from #tmpRowT1 where StartTriggerT1 != 0 and [Row] = @T1Row -1)
				set @T1Row = @T1Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT1 where row = @T1Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT1 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT1 from #tmpRowT1 where Id = @T1tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT1 from #tmpRowT1 where Id = @T1tempId)) as Destination,
				--'MPL Idle' 
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT1 where id between @T1tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT1 from #tmpRowT1 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT1 from #tmpRowT1 where Id = @T1tempId)) as Quantity
			into 
				#tempT1
			from 
				#tmpRowT1
			where 
				Id between @T1tempId and (select Id from #temp1 where n = @a)
				and SourceT1 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT1 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT1,SourceT1
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT1)

		drop table #tempT1
	end
	else if((Select StartTriggerT2 from #temp1 where n = @a) = 0)
	begin
			Declare @T2ProcessId int = null
			set @T2ProcessId = (select Id from #temp1 where n = @a)
			Declare @T2tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT2],[SourceT2],[QuantityT2],[DestinationT2] 
			--into #tmpRowT2 from [Transfer] where StartTriggerT2 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T2Row int = null
			set @T2Row = (Select [row] from #tmpRowT2 where id = @T2ProcessId)

			while ((Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1) != 0)
			begin
				set @T2tempId = (Select Id from #tmpRowT2 where StartTriggerT2 != 0 and [Row] = @T2Row -1)
				set @T2Row = @T2Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT2 where row = @T2Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT2 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				IsNull(@ShiftName,'0') as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType2 from #tmpRowT2 where row = @T1Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT2 from #tmpRowT2 where Id = @T2tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT2 from #tmpRowT2 where Id = @T2tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT2 where id between @T2tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT2 from #tmpRowT2 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT2 from #tmpRowT2 where Id = @T2tempId)) as Quantity
			into 
				#tempT2
			from 
				#tmpRowT2
			where 
				Id between @T2tempId and (select Id from #temp1 where n = @a)
				and SourceT2 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT2 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT2,SourceT2
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT2)

		drop table #tempT2
	end
	else if((Select StartTriggerT3 from #temp1 where n = @a) = 0)
	begin
			Declare @T3ProcessId int = null
			set @T3ProcessId = (select Id from #temp1 where n = @a)
			Declare @T3tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT3],[SourceT3],[QuantityT3],[DestinationT3] 
			--into #tmpRowT3 from [Transfer] where StartTriggerT3 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T3Row int = null
			set @T3Row = (Select [row] from #tmpRowT3 where id = @T3ProcessId)
			
			while ((Select Id from #tmpRowT3 where StartTriggerT3 != 0 and [Row] = @T3Row -1) != 0)
			begin
				set @T3tempId = (Select Id from #tmpRowT3 where StartTriggerT3 != 0 and [Row] = @T3Row -1)
				set @T3Row = @T3Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT3 where row = @T3Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT3 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType3 from #tmpRowT3 where row = @T3Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT3 from #tmpRowT3 where Id = @T3tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT3 from #tmpRowT3 where Id = @T3tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT3 where id between @T3tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT3 from #tmpRowT3 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT3 from #tmpRowT3 where Id = @T3tempId)) as Quantity
			into 
				#tempT3
			from 
				#tmpRowT3
			where 
				Id between @T3tempId and (select Id from #temp1 where n = @a)
				and SourceT3 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT3 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT3,DestinationT3
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT3)

		drop table #tempT3
	end
	else if((Select StartTriggerT4 from #temp1 where n = @a) = 0)
	begin
			Declare @T4ProcessId int = null
			set @T4ProcessId = (select Id from #temp1 where n = @a)
			Declare @T4tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT4],[SourceT4],[QuantityT4],[DestinationT4] 
			-- into #tmpRowT4 from [Transfer] where StartTriggerT4 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T4Row int = null
			set @T4Row = (Select [row] from #tmpRowT4 where id = @T4ProcessId)

			while ((Select Id from #tmpRowT4 where StartTriggerT4 != 0 and [Row] = @T4Row -1) != 0)
			begin
				set @T4tempId = (Select Id from #tmpRowT4 where StartTriggerT4 != 0 and [Row] = @T4Row -1)
				set @T4Row = @T4Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT4 where row = @T4Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT4 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType4 from #tmpRowT4 where row = @T4Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT4 from #tmpRowT4 where Id = @T4tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT4 from #tmpRowT4 where Id = @T4tempId)) as	Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT4 where id between @T4tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT4 from #tmpRowT4 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT4 from #tmpRowT4 where Id = @T4tempId)) as Quantity
			into 
				#tempT4
			from 
				#tmpRowT4
			where 
				Id between @T4tempId and (select Id from #temp1 where n = @a)
				and SourceT4 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT4 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT4,DestinationT4
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT4)

		drop table #tempT4
	end
	else if((Select StartTriggerT5 from #temp1 where n = @a) = 0)
	begin
			Declare @T5ProcessId int = null
			set @T5ProcessId = (select Id from #temp1 where n = @a)
			Declare @T5tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT5],[SourceT5],[QuantityT5],[DestinationT5] 
			-- into #tmpRowT5 from [Transfer] where StartTriggerT5 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T5Row int = null
			set @T5Row = (Select [row] from #tmpRowT5 where id = @T5ProcessId)

			while ((Select Id from #tmpRowT5 where StartTriggerT5 != 0 and [Row] = @T5Row -1) != 0)
			begin
				set @T5tempId = (Select Id from #tmpRowT5 where StartTriggerT5 != 0 and [Row] = @T5Row -1)
				set @T5Row = @T5Row - 1
			end
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT5 where row = @T5Row)) between FromTime and ToTime)
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT5 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType5 from #tmpRowT5 where row = @T5Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT5 from #tmpRowT5 where Id = @T5tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT5 from #tmpRowT5 where Id = @T5tempId)) as	Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT5 where id between @T5tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT5 from #tmpRowT5 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT5 from #tmpRowT5 where Id = @T5tempId)) as Quantity
			into 
				#tempT5
			from 
				#tmpRowT5
			where 
				Id between @T5tempId and (select Id from #temp1 where n = @a)
				and SourceT5 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT5 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT5,DestinationT5
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT5)

		drop table #tempT5
	end
	else if((Select StartTriggerT6 from #temp1 where n = @a) = 0)
	begin
			Declare @T6ProcessId int = null
			set @T6ProcessId = (select Id from #temp1 where n = @a)
			Declare @T6tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,[Date],[StartTriggerT6],[SourceT6],[QuantityT6],[DestinationT6] 
			-- into #tmpRowT6 from [Transfer] where StartTriggerT6 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T6Row int = null
			set @T6Row = (Select [row] from #tmpRowT6 where id = @T6ProcessId)

			while ((Select Id from #tmpRowT6 where StartTriggerT6 != 0 and [Row] = @T6Row -1) != 0)
			begin
				set @T6tempId = (Select Id from #tmpRowT6 where StartTriggerT6 != 0 and [Row] = @T6Row -1)
				set @T6Row = @T6Row - 1
			end
			--select @T6tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT6 where row = @T6Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT6 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType6 from #tmpRowT6 where row = @T6Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT6 from #tmpRowT6 where Id = @T6tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT6 from #tmpRowT6 where Id = @T6tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT6 where id between @T6tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT6 from #tmpRowT6 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT6 from #tmpRowT6 where Id = @T6tempId)) as Quantity
			into 
				#tempT6
			from 
				#tmpRowT6
			where 
				Id between @T6tempId and (select Id from #temp1 where n = @a)
				and SourceT6 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT6 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT6,DestinationT6
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT6)

		drop table #tempT6
	end
	else if((Select StartTriggerT7 from #temp1 where n = @a) = 0)
	begin
			Declare @T7ProcessId int = null
			set @T7ProcessId = (select Id from #temp1 where n = @a)
			Declare @T7tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT7],[SourceT7],[QuantityT7],[DestinationT7] 
			--	into #tmpRowT7 from [Transfer] where StartTriggerT7 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T7Row int = null
			set @T7Row = (Select [row] from #tmpRowT7 where id = @T7ProcessId)

			while ((Select Id from #tmpRowT7 where StartTriggerT7 != 0 and [Row] = @T7Row -1) != 0)
			begin
				set @T7tempId = (Select Id from #tmpRowT7 where StartTriggerT7 != 0 and [Row] = @T7Row -1)
				set @T7Row = @T7Row - 1
			end
			--select @T7tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT7 where row = @T7Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT7 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				IsNull(@ShiftName,'0') as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType7 from #tmpRowT7 where row = @T7Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT7 from #tmpRowT7 where Id = @T7tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT7 from #tmpRowT7 where Id = @T7tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT7 where id between @T7tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT7 from #tmpRowT7 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT7 from #tmpRowT7 where Id = @T7tempId)) as Quantity
			into 
				#tempT7
			from 
				#tmpRowT7
			where 
				Id between @T7tempId and (select Id from #temp1 where n = @a)
				and SourceT7 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT7 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT7,DestinationT7
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT7)

		drop table #tempT7
	end
	else if((Select StartTriggerT8 from #temp1 where n = @a) = 0)
	begin
			Declare @T8ProcessId int = null
			set @T8ProcessId = (select Id from #temp1 where n = @a)
			Declare @T8tempId int
			
			--Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT8],[SourceT8],[QuantityT8],[DestinationT8] 
			--	 into #tmpRowT8 from [Transfer] where StartTriggerT8 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T8Row int = null
			set @T8Row = (Select [row] from #tmpRowT8 where id = @T8ProcessId)

			while ((Select Id from #tmpRowT8 where StartTriggerT8 != 0 and [Row] = @T8Row -1) != 0)
			begin
				set @T8tempId = (Select Id from #tmpRowT8 where StartTriggerT8 != 0 and [Row] = @T8Row -1)
				set @T8Row = @T8Row - 1
			end
			--select @T8tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT8 where row = @T8Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT8 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType8 from #tmpRowT8 where row = @T8Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT8 from #tmpRowT8 where Id = @T8tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT8 from #tmpRowT8 where Id = @T8tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT8 where id between @T8tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT8 from #tmpRowT8 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT8 from #tmpRowT8 where Id = @T8tempId)) as Quantity
			into 
				#tempT8
			from 
				#tmpRowT8
			where 
				Id between @T8tempId and (select Id from #temp1 where n = @a)
				and SourceT8 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT8 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT8,DestinationT8
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT8)

		drop table #tempT8
	end
	else if((Select StartTriggerT9 from #temp1 where n = @a) = 0)
	begin
			Declare @T9ProcessId int = null
			set @T9ProcessId = (select Id from #temp1 where n = @a)
			Declare @T9tempId int
			Declare @ShiftName9 varchar(20) = null
			--Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT9],[SourceT9],[QuantityT9],[DestinationT9] 
			--	 into #tmpRowT9 from [Transfer] where StartTriggerT9 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T9Row int = null
			set @T9Row = (Select [row] from #tmpRowT9 where id = @T9ProcessId)


			while ((Select Id from #tmpRowT9 where StartTriggerT9 != 0 and [Row] = @T9Row -1) != 0)
			begin
				set @T9tempId = (Select Id from #tmpRowT9 where StartTriggerT9 != 0 and [Row] = @T9Row -1)
				set @T9Row = @T9Row - 1
			end
			--select @T9tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT9 where row = @T9Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT9 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT9 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType9 from #tmpRowT9 where row = @T9Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT9 from #tmpRowT9 where Id = @T9tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT9 from #tmpRowT9 where Id = @T9tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT9 where id between @T9tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT9 from #tmpRowT9 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT9 from #tmpRowT9 where Id = @T9tempId)) as Quantity
			into 
				#tempT9
			from 
				#tmpRowT9
			where 
				Id between @T9tempId and (select Id from #temp1 where n = @a)
				and SourceT9 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT9 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT9,DestinationT9
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT9)

		drop table #tempT9
	end
	else if((Select StartTriggerT10 from #temp1 where n = @a) = 0)
	begin
			Declare @T10ProcessId int = null
			set @T10ProcessId = (select Id from #temp1 where n = @a)
			Declare @T10tempId int
			Declare @ShiftName10 varchar(20) = null
			--Select row_number() OVER (ORDER BY id) [row],Id,Date,[StartTriggerT10],[SourceT10],[QuantityT10],[DestinationT10] 
			--	 into #tmpRowT10 from [Transfer] where StartTriggerT10 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T10Row int = null
			set @T10Row = (Select [row] from #tmpRowT10 where id = @T10ProcessId)

			while ((Select Id from #tmpRowT10 where StartTriggerT10 != 0 and [Row] = @T10Row -1) != 0)
			begin
				set @T10tempId = (Select Id from #tmpRowT10 where StartTriggerT10 != 0 and [Row] = @T10Row -1)
				set @T10Row = @T10Row - 1
			end
			--select @T10tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT10 where row = @T10Row)) between FromTime and ToTime)

			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT10 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT10 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType10 from #tmpRowT10 where row = @T10Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT10 from #tmpRowT10 where Id = @T10tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT10 from #tmpRowT10 where Id = @T10tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT10 where id between @T10tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT10 from #tmpRowT10 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT10 from #tmpRowT10 where Id = @T10tempId)) as Quantity
			into 
				#tempT10
			from 
				#tmpRowT10
			where 
				Id between @T10tempId and (select Id from #temp1 where n = @a)
				and SourceT10 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT10 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT10,DestinationT10
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT10)

		drop table #tempT10
	end
	else if((Select StartTriggerT11 from #temp1 where n = @a) = 0)
	begin
			Declare @T11ProcessId int = null
			set @T11ProcessId = (select Id from #temp1 where n = @a)
			Declare @T11tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT11,QuantityT11,SourceT11,DestinationT11
			--	into #tmpRowT11 from [Transfer] where StartTriggerT11 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T11Row int = null
			set @T11Row = (Select [row] from #tmpRowT11 where id = @T11ProcessId)

			while ((Select Id from #tmpRowT11 where StartTriggerT11 != 0 and [Row] = @T11Row -1) != 0)
			begin
				set @T11tempId = (Select Id from #tmpRowT11 where StartTriggerT11 != 0 and [Row] = @T11Row -1)
				set @T11Row = @T11Row - 1
			end
			--select @T11tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT11 where row = @T11Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT11 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT11 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType11 from #tmpRowT11 where row = @T11Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT11 from #tmpRowT11 where Id = @T11tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT11 from #tmpRowT11 where Id = @T11tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT11 where id between @T11tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT11 from #tmpRowT11 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT11 from #tmpRowT11 where Id = @T11tempId)) as Quantity
			into 
				#tempT11
			from 
				#tmpRowT11
			where 
				Id between @T11tempId and (select Id from #temp1 where n = @a)
				and SourceT11 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT11 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT11,SourceT11
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT11)

		drop table #tempT11
	end
	else if((Select StartTriggerT12 from #temp1 where n = @a) = 0)
	begin
			Declare @T12ProcessId int = null
			set @T12ProcessId = (select Id from #temp1 where n = @a)
			Declare @T12tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT12,QuantityT12,SourceT12,DestinationT12
			--	 into #tmpRowT12 from [Transfer] where StartTriggerT12 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T12Row int = null
			set @T12Row = (Select [row] from #tmpRowT12 where id = @T12ProcessId)


			while ((Select Id from #tmpRowT12 where StartTriggerT12 != 0 and [Row] = @T12Row -1) != 0)
			begin
				set @T12tempId = (Select Id from #tmpRowT12 where StartTriggerT12 != 0 and [Row] = @T12Row -1)
				set @T12Row = @T12Row - 1
			end
			--select @T12tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT12 where row = @T12Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT12 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT12 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType12 from #tmpRowT12 where row = @T12Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT12 from #tmpRowT12 where Id = @T12tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT12 from #tmpRowT12 where Id = @T12tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT12 where id between @T12tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT12 from #tmpRowT12 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT12 from #tmpRowT12 where Id = @T12tempId)) as Quantity
			into 
				#tempT12
			from 
				#tmpRowT12
			where 
				Id between @T12tempId and (select Id from #temp1 where n = @a)
				and SourceT12 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT12 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT12,SourceT12
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT12)

		drop table #tempT12
	end
	else if((Select StartTriggerT13 from #temp1 where n = @a) = 0)
	begin
			Declare @T13ProcessId int = null
			set @T13ProcessId = (select Id from #temp1 where n = @a)
			Declare @T13tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT13,QuantityT13,SourceT13,DestinationT13
			--	into #tmpRowT13 from [Transfer] where StartTriggerT13 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T13Row int = null
			set @T13Row = (Select [row] from #tmpRowT13 where id = @T13ProcessId)

			while ((Select Id from #tmpRowT13 where StartTriggerT13 != 0 and [Row] = @T13Row -1) != 0)
			begin
				set @T13tempId = (Select Id from #tmpRowT13 where StartTriggerT13 != 0 and [Row] = @T13Row -1)
				set @T13Row = @T13Row - 1
			end
			--select @T13tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT13 where row = @T13Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT13 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT13 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType13 from #tmpRowT13 where row = @T13Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT13 from #tmpRowT13 where Id = @T13tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT13 from #tmpRowT13 where Id = @T13tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT13 where id between @T13tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT13 from #tmpRowT13 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT13 from #tmpRowT13 where Id = @T13tempId)) as Quantity
			into 
				#tempT13
			from 
				#tmpRowT13
			where 
				Id between @T13tempId and (select Id from #temp1 where n = @a)
				and SourceT13 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT13 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],SourceT13,DestinationT13
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT13)

		drop table #tempT13
	end
	else if((Select StartTriggerT14 from #temp1 where n = @a) = 0)
	begin
			Declare @T14ProcessId int = null
			set @T14ProcessId = (select Id from #temp1 where n = @a)
			Declare @T14tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT14,QuantityT14,SourceT14,DestinationT14
			--	 into #tmpRowT14 from [Transfer] where StartTriggerT14 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T14Row int = null
			set @T14Row = (Select [row] from #tmpRowT14 where id = @T14ProcessId)

			while ((Select Id from #tmpRowT14 where StartTriggerT14 != 0 and [Row] = @T14Row -1) != 0)
			begin
				set @T14tempId = (Select Id from #tmpRowT14 where StartTriggerT14 != 0 and [Row] = @T14Row -1)
				set @T14Row = @T14Row - 1
			end
			--select @T14tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT14 where row = @T14Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT14 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT14 where id = (select Id from #temp1 where n = @a)) as [Date],
				--@ShiftName as 'ShiftName',
				IsNull(@ShiftName,'0') as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType14 from #tmpRowT14 where row = @T14Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT14 from #tmpRowT14 where Id = @T14tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT14 from #tmpRowT14 where Id = @T14tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT14 where id between @T14tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT14 from #tmpRowT14 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT14 from #tmpRowT14 where Id = @T14tempId)) as Quantity
			into 
				#tempT14
			from 
				#tmpRowT14
			where 
				Id between @T14tempId and (select Id from #temp1 where n = @a)
				and SourceT14 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT14 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT14,SourceT14
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT14)

		drop table #tempT14
	end
	else if((Select StartTriggerT15 from #temp1 where n = @a) = 0)
	begin
			Declare @T15ProcessId int = null
			set @T15ProcessId = (select Id from #temp1 where n = @a)
			Declare @T15tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT15,QuantityT15,SourceT15,DestinationT15
			--	 into #tmpRowT15 from [Transfer] where StartTriggerT15 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T15Row int = null
			set @T15Row = (Select [row] from #tmpRowT15 where id = @T15ProcessId)

			while ((Select Id from #tmpRowT15 where StartTriggerT15 != 0 and [Row] = @T15Row -1) != 0)
			begin
				set @T15tempId = (Select Id from #tmpRowT15 where StartTriggerT15 != 0 and [Row] = @T15Row -1)
				set @T15Row = @T15Row - 1
			end
			--select @T15tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT15 where row = @T15Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT15 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT15 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType15 from #tmpRowT15 where row = @T15Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT15 from #tmpRowT15 where Id = @T15tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT15 from #tmpRowT15 where Id = @T15tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT15 where id between @T15tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT15 from #tmpRowT15 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT15 from #tmpRowT15 where Id = @T15tempId)) as Quantity
			into 
				#tempT15
			from 
				#tmpRowT15
			where 
				Id between @T15tempId and (select Id from #temp1 where n = @a)
				and SourceT15 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT15 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT15,SOURCET15
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT15)

		drop table #tempT15
	end
	else if((Select StartTriggerT16 from #temp1 where n = @a) = 0)
	begin
			Declare @T16ProcessId int = null
			set @T16ProcessId = (select Id from #temp1 where n = @a)
			Declare @T16tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT16,QuantityT16,SourceT16,DestinationT16
			--	 into #tmpRowT16 from [Transfer] where StartTriggerT16 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T16Row int = null
			set @T16Row = (Select [row] from #tmpRowT16 where id = @T16ProcessId)

			while ((Select Id from #tmpRowT16 where StartTriggerT16 != 0 and [Row] = @T16Row -1) != 0)
			begin
				set @T16tempId = (Select Id from #tmpRowT16 where StartTriggerT16 != 0 and [Row] = @T16Row -1)
				set @T16Row = @T16Row - 1
			end
			--select @T16tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT16 where row = @T16Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT16 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT16 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType16 from #tmpRowT16 where row = @T16Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT16 from #tmpRowT16 where Id = @T16tempId))as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT16 from #tmpRowT16 where Id = @T16tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT16 where id between @T16tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT16 from #tmpRowT16 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT16 from #tmpRowT16 where Id = @T16tempId)) as Quantity
			into 
				#tempT16
			from 
				#tmpRowT16
			where 
				Id between @T16tempId and (select Id from #temp1 where n = @a)
				and SourceT16 in (Select RouteNo from CIPRoutes where (@SourceName != '--All--' and RouteName like '%' + @SourceName + '%') or (@SourceName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
				and DestinationT16 in (Select RouteNo from CIPRoutes where (@DestinationName != '--All--' and RouteName like '%' + @DestinationName + '%') or (@DestinationName = '--All--' and RouteName = RouteName) and IsDeleted = 0)
			group by [Date],DestinationT16,SOURCET16
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT16)

		drop table #tempT16
	end
	else if((Select StartTriggerT17 from #temp1 where n = @a) = 0)
	begin
			Declare @T17ProcessId int = null
			set @T17ProcessId = (select Id from #temp1 where n = @a)
			Declare @T17tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT17,QuantityT17,SourceT17,DestinationT17
			--	 into #tmpRowT17 from [Transfer] where StartTriggerT17 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T17Row int = null
			set @T17Row = (Select [row] from #tmpRowT17 where id = @T17ProcessId)
			
			while ((Select Id from #tmpRowT17 where StartTriggerT17 != 0 and [Row] = @T17Row -1) != 0)
			begin
				set @T17tempId = (Select Id from #tmpRowT17 where StartTriggerT17 != 0 and [Row] = @T17Row -1)
				set @T17Row = @T17Row - 1
			end
			--select @T17tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT17 where row = @T17Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT17 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT17 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType17 from #tmpRowT17 where row = @T17Row) and IsDeleted = 0) as ProductName,
				'Butter Milk' as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT17 from #tmpRowT17 where Id = @T17tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT17 where id between @T17tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT17 from #tmpRowT17 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT17 from #tmpRowT17 where Id = @T17tempId)) as Quantity
			into 
				#tempT17
			from 
				#tmpRowT17
			where 
				Id between @T17tempId and (select Id from #temp1 where n = @a)
			group by [Date],SourceT17,DestinationT17
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT17)

		drop table #tempT17
	end
	else if((Select StartTriggerT18 from #temp1 where n = @a) = 0)
	begin
			Declare @T18ProcessId int = null
			set @T18ProcessId = (select Id from #temp1 where n = @a)
			Declare @T18tempId int
		
			--Select row_number() OVER (ORDER BY id) [row],ID,[Date],StartTriggerT18,QuantityT18,SourceT18,DestinationT18
			--	 into #tmpRowT18 from [Transfer] where StartTriggerT18 in (1,0) and [Date] between @FromDateTime and @ToDateTime 
			Declare @T18Row int = null
			set @T18Row = (Select [row] from #tmpRowT18 where id = @T18ProcessId)
			
			while ((Select Id from #tmpRowT18 where StartTriggerT18 != 0 and [Row] = @T18Row -1) != 0)
			begin
				set @T18tempId = (Select Id from #tmpRowT18 where StartTriggerT18 != 0 and [Row] = @T18Row -1)
				set @T18Row = @T18Row - 1
			end
			--select @T18tempId
			set @ShiftName = (Select Name from Shift where CONVERT(time(7),(Select CONVERT(varchar(10),date,108) from #tmpRowT18 where row = @T18Row)) between FromTime and ToTime)
			
			Select 
				top 1 convert(time,[Date],109) as StartTime,
				(Select convert(time,[Date],109) from #tmpRowT18 where id = (select Id from #temp1 where n = @a)) as StopTime,
				(Select convert(varchar(10),[Date],103) from #tmpRowT18 where id = (select Id from #temp1 where n = @a)) as [Date],
				@ShiftName as 'ShiftName',
				--(Select ProductName from Product where IdentifierCode = (Select ProductType17 from #tmpRowT18 where row = @T18Row) and IsDeleted = 0) as ProductName,
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select SourceT18 from #tmpRowT18 where Id = @T18tempId)) as [Source],
				(Select RouteName from CIPRoutes where IsDeleted = 0 and RouteNo = (Select DestinationT18 from #tmpRowT18 where Id = @T18tempId)) as Destination,
				(select convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a) order by id desc))/3600)+':'+
							convert(varchar(5),DateDiff(s, (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a) order by id desc))%3600/60)+':'+
							convert(varchar(5),(DateDiff(s, (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a)), (select top 1 [Date] from #tmpRowT18 where id between @T18tempId and (select Id from #temp1 where n = @a) order by id desc))%60))) as TotalTime,
				((Select QuantityT18 from #tmpRowT18 where Id = (select Id from #temp1 where n = @a)) - (Select QuantityT18 from #tmpRowT18 where Id = @T18tempId)) as Quantity
			into 
				#tempT18
			from 
				#tmpRowT18
			where 
				Id between @T18tempId and (select Id from #temp1 where n = @a)
			group by [Date],SourceT18,DestinationT18
			Insert into #tempProductTreacebility (StartTime,StopTime,[Date],ShiftName,[Source],Destination ,TotalTime,Quantity)
			(Select * from #tempT18)

		drop table #tempT18
	end

	set @a = @a + 1
end

drop table #tmpRowT1,#tmpRowT2,#tmpRowT3,#tmpRowT4,#tmpRowT5,#tmpRowT6,#tmpRowT7,#tmpRowT8,#tmpRowT9,#tmpRowT10,#tmpRowT11,#tmpRowT12,#tmpRowT13,#tmpRowT14,#tmpRowT15,#tmpRowT16,#tmpRowT17,#tmpRowT18
select 
convert(varchar(10),Id ) as SrNo,
[Date],
StartTime,
StopTime,
TotalTime,

--ShiftName,

[Source],
Destination ,

--abs(Quantity) as Quantity,
Quantity
from #tempProductTreacebility

union all

select 
convert(varchar(10),'Total') as SrNo,
'' as [Date],
'' as StartTime,
'' as StopTime,
'' as TotalTime,

--ShiftName,

'' as [Source],
'' as Destination ,

sum(CONVERT(decimal(18,2), abs(Quantity)))  as Quantity
from #tempProductTreacebility

drop table #temp1,#tempProductTreacebility

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_UtilityConsumption]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_rpt_UtilityConsumption] '07/14/2019','07/14/2019'
CREATE procedure [dbo].[usp_rpt_UtilityConsumption]
	@FromDateTime datetime,
	@ToDateTime datetime
AS
Begin
--	--Select 
--	--	CONVERT(varchar(10),[DateTime],103) as 'Date',
--	--	[SoftWater],
--	--	ChilledWaterFlow,
--	--	ChilledWaterTR AS 'ChilledWater',
--	--	--(ChilledWaterFlow *([ChilledWaterSupplyTemp] - [ChilledWaterReturnTemp]) / 3024) AS 'ChilledWater',
--	--	[Steam],
--	--	[CompressedAir],
--	--	[Nitrogen],
--	--	Convert(decimal(18,2), [MCC1] / 1000) as MCC1,
--	--	Convert(decimal(18,2), [MCC2] / 1000) as MCC2,
--	--	Convert(decimal(18,2), [MCC3] / 1000) as MCC3,
--	--	Convert(decimal(18,2), [MCC4] / 1000) as MCC4,
--	--	Convert(decimal(18,2), [MCC5] / 1000) as MCC5,
--	--	Convert(decimal(18,2), [MCC6] / 1000) as MCC6,
--	--	Convert(decimal(18,2), [MCC7] / 1000) as MCC7,
--	--	Convert(decimal(18,2), [MCC8] / 1000) as MCC8,
--	--	Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8]) / 1000) as 'Total',
--	--	[Acid],
--	--	[LYE],
--	--	[SteamCondensate],
--	--	[ROEvap12],
--	--	[ROPermate],
--	--	[TotalCondensate]
--	--into
--	--	#tempUtility
--	--from 
--	--	UtilityConsumption t 
--	--Where 
--	--	[DateTime] between @FromDateTime and @ToDateTime + 1

--	--Select * from #tempUtility
--	--union all
--	--Select
--	--	CONVERT(varchar(10),'Total:-',103) as 'Date',
--	--	Sum([SoftWater]),
--	--	Sum(ChilledWaterFlow),
--	--	Sum(ChilledWater),
--	--	Sum([Steam]),
--	--	Sum([CompressedAir]),
--	--	Sum([Nitrogen]),
--	--	Sum([MCC1]),
--	--	Sum([MCC2]),
--	--	Sum([MCC3]),
--	--	Sum([MCC4]),
--	--	Sum([MCC5]),
--	--	Sum([MCC6]),
--	--	Sum([MCC7]),
--	--	Sum([MCC8]),
--	--	Sum([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8]) as 'Total',
--	--	Sum([Acid]),
--	--	Sum([LYE]),
--	--	Sum([SteamCondensate]),
--	--	Sum([ROEvap12]),
--	--	Sum([ROPermate]),
--	--	Sum([TotalCondensate])
--	--from 
--	--	#tempUtility

--	--Drop table #tempUtility


----	Declare @FromDateTime datetime = '03/10/2019'
----Declare @ToDateTime datetime = '03/11/2019'
--Declare @count int = (Select DATEDIFF(Day,@FromDateTime,@ToDateTime))
--Declare @a int = 0

--	----------------------------------- Create Temp Table --------------------------
--Create table #tempUtilityTotal (Id int IDENTITY(1,1),[Date] varchar(10),
--								ChilledWater float,ChilledWaterCost float,RawWater float,RawWaterCost float,[SoftWater] float,[SoftWaterCost] float,[Steam] float,SteamCost float,
--								[CompressedAir] float,AirCost float,MCC1 float,MCC2 float,MCC3 float,MCC4 float,MCC5 float,MCC6 float,MCC7 float,MCC8 float,TotalPower float,PowerCost float,[Acid] float,AcidCost float,
--								[LYE] float,LyeCost float,PowderQuantity float)
--	---------------------------------------------------------------------------------

--while(@a <= @count)
--Begin

--Declare @TotalPowderQty decimal(18,2) = 0
--Set @TotalPowderQty = (Select top 1
--							Quantity1 - LEAD(Quantity1,1) Over (Order By Date) +
--						Quantity2 -	LEAD(Quantity2,1) Over (Order By Date)+
--						Quantity3 -	LEAD(Quantity3,1) Over (Order By Date)+
--						Quantity4 -	LEAD(Quantity4,1) Over (Order By Date) 
--						from 
--							[PowderSiloOpeningClosing] 
--						where 
--							Convert(date,[Date],103) = CONVERT(date, DATEADD(day, @a, @FromDateTime),103))

----Select * from #temp
--Declare @ProducuedQuantity float= (Select IsNull(Sum([TotalQuantity]),0)
--								from 
--									[PackingEntryMaster] 
--								where 
--									Convert(date,[Date],103) = CONVERT(date, DATEADD(day, @a, @FromDateTime),103)
--									and IsDeLeted = 0)
--Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)

--                                                            --Declare @TotalPowderQty decimal(18,2) = 0
----Select 
----	row_number() OVER (ORDER BY id) as 'row1',*
----into 
----	#temp
----from 
----	[PowderSiloOpeningClosing] where Convert(date,[Date],103) =  CONVERT(date, DATEADD(day, @a, @FromDateTime),103)


----Declare @ProducuedQuantity float= (Select IsNull(Sum([TotalQuantity]),0)
----from 
----	[PackingEntryMaster] where Convert(date,[Date],103) = CONVERT(date, DATEADD(day, @a, @FromDateTime),103) and IsDeLeted = 0)

------Declare @Count1 int= (Select COUNT(*) from #temp) 
------Declare @a1 int = 1
------While(@a1 <= @Count1)
------Begin
----	Declare @FirstValue decimal(18,2) = 1
----	Declare @SecondValue decimal(18,2) = 1
----	Set @FirstValue = (Select ISnull(Quantity1,0) + ISnull(Quantity2,0) + ISnull(Quantity3,0) + ISnull(Quantity4,0) from #temp where row1 = 1)
----	Set @SecondValue = (Select ISnull(Quantity1,0) + ISnull(Quantity2,0) + ISnull(Quantity3,0) + ISnull(Quantity4,0) from #temp where row1 = 2)

----	Set @TotalPowderQty = @TotalPowderQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
------	Set @a1 = @a1 + 1
------End
----		Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)
----Drop table #temp


--	--Declare @TotalAvaQty decimal(18,2) = 0

--	--Select 
--	--	row_number() OVER (ORDER BY id) as 'row1',*
--	--into 
--	--	#temp
--	--from 
--	--	PackingMachineMassBalanceAvapack where CONVERT(date,[DateTime],103) = CONVERT(date, DATEADD(day, @a, @FromDateTime),103)

--	----Select * from #temp
--	--Declare @Count1 int= (Select COUNT(*) from #temp) 
--	--Declare @a1 int = 1
--	--While(@a1 <= @Count1)
--	--Begin
--	--	Declare @FirstValue decimal(18,2) = 1
--	--	Declare @SecondValue decimal(18,2) = 1
--	--	Set @FirstValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:01.1000000' and '00:00:59.1000000')
--	--	Set @SecondValue = (Select Tag1 from #temp where row1 = @a1 and CONVERT(time,DateTime,103) between '00:00:35.1000000' and '23:59:59.1000000')

--	--	Set @TotalAvaQty = @TotalAvaQty + ISNULL(@SecondValue,0) - ISNULL(@FirstValue,0)
--	--	Set @a1 = @a1 + 1
--	--End
--	--	Set @TotalAvaQty = @TotalAvaQty * (Select AvaPackQty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	--Drop table #temp

--	--Declare @PreviousBoschQty decimal(18,2) = 0
--	--Declare @CurrentBoschQty decimal(18,2) = 0
--	--Declare @TotalBoschQty decimal(18,2) = 0
--	--Set @PreviousBoschQty = (Select 
--	--	Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	--from 
--	--	PackingMachineMassBalanceBosch where Convert(date,[DateTime],103) =  DATEADD(DAY,-1,CONVERT(date,CONVERT(date, DATEADD(day, @a, @FromDateTime),103),103)))


--	--Set @CurrentBoschQty = (Select 
--	--	Tag1 * (Select Bosch1Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag2 * (Select Bosch2Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag3 * (Select Bosch3Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag4 * (Select Bosch4Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag5 * (Select Bosch5Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag6 * (Select Bosch6Qty from [MassBalancePowderProduction] where IsDeleted = 0) + 
--	--	Tag7 * (Select Bosch7Qty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	--from 
--	--	PackingMachineMassBalanceBosch where CONVERT(date,[DateTime],103) = CONVERT(date, DATEADD(day, @a, @FromDateTime),103))

--	--Set @TotalBoschQty =  @CurrentBoschQty - @PreviousBoschQty

--	--Declare @PreviousHassiaQty decimal(18,2) = 0
--	--Declare @CurrentHassiaQty decimal(18,2) = 0
--	--Declare @TotalHassiaQty decimal(18,2) = 0
--	--Set @PreviousHassiaQty = (Select 
--	--	Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0)
--	--from 
--	--	PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = DATEADD(DAY,-1,CONVERT(date,CONVERT(date, DATEADD(day, @a, @FromDateTime),103),103)))


--	--Set @CurrentHassiaQty = (Select 
--	--	Tag1 * (Select HassiaQty from [MassBalancePowderProduction] where IsDeleted = 0) 
--	--from 
--	--	PackingMachineMassBalanceHassia where Convert(date,[DateTime],103) = Convert(date,@FromDateTime,103))

--	--Set @TotalHassiaQty =  @CurrentHassiaQty - @PreviousHassiaQty



--	Select 
--		--CONVERT(varchar(10),[DateTime],103) as 'Date',
--		CONVERT(varchar(10),convert(datetime,[DateTime] -(1)),103) as 'Date',
--		ChilledWaterTR AS 'ChilledWater',
--		ChilledWaterTR * (Select [ChilledWaterCost] from [UtilityConsumptionCost]) as 'ChilledWaterCost',
--		RawWater,
--		RawWater * (Select [RawWaterCost] from [UtilityConsumptionCost]) as 'RawWaterCost',
--		[SoftWater],
--		[SoftWater] * (Select [SoftWaterCost] from [UtilityConsumptionCost]) as 'SoftWaterCost',
--		--ChilledWaterFlow,
--		--(ChilledWaterFlow *([ChilledWaterSupplyTemp] - [ChilledWaterReturnTemp]) / 3024) AS 'ChilledWater',

--		[Steam],
--		[Steam] * (Select [SteamCost] from [UtilityConsumptionCost]) as 'SteamCost',
--		[CompressedAir],
--		[CompressedAir] * (Select [AirCost] from [UtilityConsumptionCost]) as 'AirCost',
--		--[Nitrogen],
--		Convert(decimal(18,2), [MCC1]) as MCC1,
--		Convert(decimal(18,2), [MCC2]) as MCC2,
--		Convert(decimal(18,2), [MCC3]) as MCC3,
--		Convert(decimal(18,2), [MCC4]) as MCC4,
--		Convert(decimal(18,2), [MCC5]) as MCC5,
--		Convert(decimal(18,2), [MCC6]) as MCC6,
--		Convert(decimal(18,2), [MCC7]) as MCC7,
--		Convert(decimal(18,2), [MCC8]) as MCC8,
--		Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8])) as 'TotalPower',
--		Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8])) * (Select [PowerCost] from [UtilityConsumptionCost]) as 'PowerCost',
--		[Acid],
--		[Acid] * (Select [AcidCost] from [UtilityConsumptionCost]) as 'AcidCost',
--		[LYE],
--		[LYE] * (Select [LyeCost] from [UtilityConsumptionCost]) as 'LyeCost',
--		--ISNULL(@TotalAvaQty,0) + ISNULL(@TotalBoschQty,0) + ISNULL(@TotalHassiaQty,0) as 'PowderQuantity'
--		@TotalPowderQty as 'PowderQuantity'
--	into
--		#tempUtility
--	from 
--		UtilityConsumption t 
--	Where 
--		CONVERT(date,[DateTime],103) = CONVERT(date, DATEADD(day, @a, @FromDateTime),103)

--		Insert Into #tempUtilityTotal(Date,ChilledWater,ChilledWaterCost,RawWater,RawWaterCost,[SoftWater],SoftWaterCost,[Steam],SteamCost,[CompressedAir],AirCost,MCC1,
--									MCC2,MCC3,MCC4,MCC5,MCC6,MCC7,MCC8,TotalPower,PowerCost,[Acid],AcidCost,[LYE],LyeCost,PowderQuantity)
--		select * from #tempUtility


--		drop table #tempUtility
--Set @a = @a + 1
--End

--Select 
--	Date,
--	ChilledWater,
--	ChilledWaterCost,
--	RawWater,
--	RawWaterCost,
--	[SoftWater],
--	SoftWaterCost,
--	[Steam],
--	SteamCost,
--	[CompressedAir],
--	AirCost,
--	MCC1,
--	MCC2,
--	MCC3,
--	MCC4,
--	MCC5,
--	MCC6,
--	MCC7,
--	MCC8,
--	TotalPower,
--	PowerCost,
--	[Acid],
--	AcidCost,
--	[LYE],
--	LyeCost,
--	CONVERT(decimal(18,3), ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost) as 'TotalCost',
--	CONVERT(decimal(18,3), (ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost) / PowderQuantity) as 'Total Cost Per Kg',
--	CONVERT(decimal(18,3), (SteamCost + PowerCost + ChilledWaterCost + AirCost) / PowderQuantity) as 'ProcessingCost',
--	CONVERT(decimal(18,3), TotalPower / PowderQuantity) as 'Specific Power Consumption',
--	CONVERT(decimal(18,3), Steam / PowderQuantity) as 'Specific Steam Consumption',
--	CONVERT(decimal(18,3), (ISNULL(RawWater,0) + ISNULL(SoftWater,0)) / PowderQuantity) as 'Specific Water Consumption'
-- from 
--	#tempUtilityTotal
	
--union all
--	Select
--		CONVERT(varchar(10),'Total/Avg',103) as 'Date',
--		Sum(ChilledWater),
--		Sum(ChilledWaterCost),
--		Sum(RawWater),
--		Sum(RawWaterCost),
--		Sum([SoftWater]),
--		Sum(SoftWaterCost),
--		Sum([Steam]),
--		Sum(SteamCost),
--		Sum([CompressedAir]),
--		Sum(AirCost),
--		Sum([MCC1]),
--		Sum([MCC2]),
--		Sum([MCC3]),
--		Sum([MCC4]),
--		Sum([MCC5]),
--		Sum([MCC6]),
--		Sum([MCC7]),
--		Sum([MCC8]),
--		Sum(TotalPower),
--		Sum(PowerCost),
--		Sum([Acid]),
--		Sum(AcidCost),
--		Sum([LYE]),
--		Sum(LyeCost),
--		Sum(CONVERT(decimal(18,3), ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost)),
--		CONVERT(decimal(18,3),Avg((ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost) / PowderQuantity)),
--		(CONVERT(decimal(18,3), Avg((SteamCost + PowerCost + ChilledWaterCost + AirCost) / PowderQuantity))),
--		(CONVERT(decimal(18,3), Avg(TotalPower / PowderQuantity))),
--		(CONVERT(decimal(18,3), Avg(Steam / PowderQuantity))),
--		(CONVERT(decimal(18,3), Avg((ISNULL(RawWater,0) + ISNULL(SoftWater,0)) / PowderQuantity)))
--	from 
--		#tempUtilityTotal


--Drop table #tempUtilityTotal

--Create Table #temp2 (Id int IDENTITY(1,1),Name varchar(40),Consumption float)

--insert into #temp2 (Name,Consumption)
--values ('Steam/kg',(Select [SteamCost] from UtilityConsumptionCost))

--insert into #temp2 (Name,Consumption)
--values ('Electricity (Per Unit KWH)',(Select [PowerCost] from UtilityConsumptionCost))

--insert into #temp2 (Name,Consumption)
--values ('Air (Per Cu.mt) ',(Select [AirCost] from UtilityConsumptionCost))

--insert into #temp2 (Name,Consumption)
--values ('Soft Water/Litre',(Select [SoftWaterCost] from UtilityConsumptionCost))

--insert into #temp2 (Name,Consumption)
--values ('Chilled Water (1 TR cost)',(Select [ChilledWaterCost] from UtilityConsumptionCost))

--Select * from #temp2
--Drop table #temp2




---------------------------New SP developed By sohag as per clients requiremnets-----------
if(convert(date,@FromDateTime,103)= convert(date,@ToDateTime,103))
begin
set @ToDateTime=  @ToDateTime+1
end
else
begin
set @FromDateTime=@FromDateTime+1
set @ToDateTime=  @ToDateTime+1
end
Declare @count int = (Select DATEDIFF(Day,@FromDateTime,((@ToDateTime ))))
--select @ToDateTime,@FromDateTime
Declare @a int = 0
--select @count as cnt
	----------------------------------- Create Temp Table --------------------------
Create table #tempUtilityTotal (Id int IDENTITY(1,1),[Date] varchar(10),
								ChilledWater float,ChilledWaterCost float,RawWater float,RawWaterCost float,[SoftWater] float,[SoftWaterCost] float,[Steam] float,SteamCost float,
								[CompressedAir] float,AirCost float,MCC1 float,MCC2 float,MCC3 float,MCC4 float,MCC5 float,MCC6 float,MCC7 float,MCC8 float,TotalPower float,PowerCost float,[Acid] float,AcidCost float,
								[LYE] float,LyeCost float,PowderQuantity float)
	---------------------------------------------------------------------------------

	Declare @TotalPowderQty decimal(18,2) = 0

	--Set @TotalPowderQty = (Select top 1
	--						Quantity1 - LEAD(Quantity1,1) Over (Order By Date) +
	--					Quantity2 -	LEAD(Quantity2,1) Over (Order By Date)+
	--					Quantity3 -	LEAD(Quantity3,1) Over (Order By Date)+
	--					Quantity4 -	LEAD(Quantity4,1) Over (Order By Date) 
	--					from 
	--						[PowderSiloOpeningClosing] 
	--					where 
	--						Convert(date,[Date],103) between  convert(date,@FromDateTime,103) and convert(date,@ToDateTime,103))

	  
	Set @TotalPowderQty = (Select top 1
							  LEAD(Quantity1,1) Over (Order By Date) - Quantity1  +
						 	LEAD(Quantity2,1) Over (Order By Date)- Quantity2 +
						 	LEAD(Quantity3,1) Over (Order By Date) - Quantity3 +
						 	LEAD(Quantity4,1) Over (Order By Date) - Quantity4
						from 
							[PowderSiloOpeningClosing] 
						where 
							Convert(date,[Date],103) between  convert(date,@FromDateTime,103) and convert(date,@ToDateTime,103))

--Select * from #temp
    Declare @ProducuedQuantity float= (Select IsNull(Sum([TotalQuantity]),0)
								from 
									[PackingEntryMaster] 
								where 
									Convert(date,[Date],103)  between  convert(date,@FromDateTime,103) and convert(date,@ToDateTime,103)
									and IsDeLeted = 0)
Set @TotalPowderQty = ISNULL(@TotalPowderQty,0) + ISNULL(@ProducuedQuantity,0)

	Select 
		--CONVERT(varchar(10),[DateTime],103) as 'Date',
		CONVERT(varchar(10),convert(datetime,[DateTime] -(1)),103) as 'Date',
		abs(ChilledWaterTR) AS 'ChilledWater',
		abs( ChilledWaterTR * (Select [ChilledWaterCost] from [UtilityConsumptionCost])) as 'ChilledWaterCost',
		abs(RawWater) as RawWater,
		abs( RawWater * (Select [RawWaterCost] from [UtilityConsumptionCost]) )as 'RawWaterCost',
		abs([SoftWater]) as SoftWater,
		abs( [SoftWater] * (Select [SoftWaterCost] from [UtilityConsumptionCost])) as 'SoftWaterCost',
		--ChilledWaterFlow,
		--(ChilledWaterFlow *([ChilledWaterSupplyTemp] - [ChilledWaterReturnTemp]) / 3024) AS 'ChilledWater',

		abs([Steam]) as Steam,
		abs([Steam] * (Select [SteamCost] from [UtilityConsumptionCost]) )as 'SteamCost',
		abs([CompressedAir]) as CompressedAir,
		abs([CompressedAir] * (Select [AirCost] from [UtilityConsumptionCost]) )as 'AirCost',
		--[Nitrogen],
		abs(Convert(decimal(18,2), [MCC1])) as MCC1,
		abs(Convert(decimal(18,2), [MCC2])) as MCC2,
		abs(Convert(decimal(18,2), [MCC3])) as MCC3,
		abs(Convert(decimal(18,2), [MCC4])) as MCC4,
		abs(Convert(decimal(18,2), [MCC5])) as MCC5,
		abs(Convert(decimal(18,2), [MCC6]) ) as MCC6,
		abs(Convert(decimal(18,2), [MCC7])) as MCC7,
		abs(Convert(decimal(18,2), [MCC8])) as MCC8,
		abs(Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8])) )as 'TotalPower',
		abs(Convert(decimal(18,2),([MCC1] + [MCC2] + [MCC3] + [MCC4] + [MCC5] + [MCC6] + [MCC7] + [MCC8])) * (Select [PowerCost] from [UtilityConsumptionCost])) as 'PowerCost',
		abs([Acid]) as Acid,
		abs([Acid] * (Select [AcidCost] from [UtilityConsumptionCost]) )as 'AcidCost',
		abs([LYE]) as LYE, 
		abs([LYE] * (Select [LyeCost] from [UtilityConsumptionCost]) ) as 'LyeCost',
		--ISNULL(@TotalAvaQty,0) + ISNULL(@TotalBoschQty,0) + ISNULL(@TotalHassiaQty,0) as 'PowderQuantity'
		abs(@TotalPowderQty) as 'PowderQuantity'
	into
		#tempUtility
	from 
		UtilityConsumption t 
	Where 
		CONVERT(date,[DateTime],103) between  convert(date,@FromDateTime,103) and convert(date,@ToDateTime,103)-- CONVERT(date, DATEADD(day, @a, @FromDateTime),103)

		Insert Into #tempUtilityTotal(Date,ChilledWater,ChilledWaterCost,RawWater,RawWaterCost,[SoftWater],SoftWaterCost,[Steam],SteamCost,[CompressedAir],AirCost,MCC1,
									MCC2,MCC3,MCC4,MCC5,MCC6,MCC7,MCC8,TotalPower,PowerCost,[Acid],AcidCost,[LYE],LyeCost,PowderQuantity)
		select * from #tempUtility


		drop table #tempUtility


Select 
	Date,
	ChilledWater,
	ChilledWaterCost,
	RawWater,
	RawWaterCost,
	[SoftWater],
	SoftWaterCost,
	[Steam],
	SteamCost,
	[CompressedAir],
	AirCost,
	MCC1,
	MCC2,
	MCC3,
	MCC4,
	MCC5,
	MCC6,
	MCC7,
	MCC8,
	TotalPower,
	PowerCost,
	[Acid],
	AcidCost,
	[LYE],
	LyeCost,
	CONVERT(decimal(18,3), ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost) as 'TotalCost',
	CONVERT(decimal(18,3), (ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost) / PowderQuantity) as 'Total Cost Per Kg',
	CONVERT(decimal(18,3), (SteamCost + PowerCost + ChilledWaterCost + AirCost) / PowderQuantity) as 'ProcessingCost',
	CONVERT(decimal(18,3), TotalPower / PowderQuantity) as 'Specific Power Consumption',
	CONVERT(decimal(18,3), Steam / PowderQuantity) as 'Specific Steam Consumption',
	CONVERT(decimal(18,3), (ISNULL(RawWater,0) + ISNULL(SoftWater,0)) / PowderQuantity) as 'Specific Water Consumption' ,
	CONVERT(decimal(18,3), CompressedAir / PowderQuantity) as 'Specific Air Consumption'  ,
	CONVERT(decimal(18,3), ChilledWater / PowderQuantity) as 'Specific ChilledWater Consumption'
 from 
	#tempUtilityTotal
	
union all
	Select
		CONVERT(varchar(10),'Total/Avg',103) as 'Date',
		Sum(ChilledWater),
		Sum(ChilledWaterCost),
		Sum(RawWater),
		Sum(RawWaterCost),
		Sum([SoftWater]),
		Sum(SoftWaterCost),
		Sum([Steam]),
		Sum(SteamCost),
		Sum([CompressedAir]),
		Sum(AirCost),
		Sum([MCC1]),
		Sum([MCC2]),
		Sum([MCC3]),
		Sum([MCC4]),
		Sum([MCC5]),
		Sum([MCC6]),
		Sum([MCC7]),
		Sum([MCC8]),
		Sum(TotalPower),
		Sum(PowerCost),
		Sum([Acid]),
		Sum(AcidCost),
		Sum([LYE]),
		Sum(LyeCost),
		Sum(CONVERT(decimal(18,3), ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost)),
		CONVERT(decimal(18,3),Avg((ChilledWaterCost + ISNULL(RawWaterCost,0) + SoftWaterCost + SteamCost + AirCost + PowerCost + AcidCost + LyeCost) / PowderQuantity)),
		(CONVERT(decimal(18,3), Avg((SteamCost + PowerCost + ChilledWaterCost + AirCost) / PowderQuantity))),
		(CONVERT(decimal(18,3), Avg(TotalPower / PowderQuantity))),
		(CONVERT(decimal(18,3), Avg(Steam / PowderQuantity))),
		(CONVERT(decimal(18,3), Avg((ISNULL(RawWater,0) + ISNULL(SoftWater,0)) / PowderQuantity))) ,
		(CONVERT(decimal(18,3), Avg(CompressedAir / PowderQuantity))),
		(CONVERT(decimal(18,3), Avg(ChilledWater / PowderQuantity)))
	from 
		#tempUtilityTotal


Drop table #tempUtilityTotal

Create Table #temp2 (Id int IDENTITY(1,1),Name varchar(40),Consumption float)

insert into #temp2 (Name,Consumption)
values ('Steam/kg',(Select [SteamCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Electricity (Per Unit KWH)',(Select [PowerCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Air (Per Cu.mt) ',(Select [AirCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Soft Water/Litre',(Select [SoftWaterCost] from UtilityConsumptionCost))

insert into #temp2 (Name,Consumption)
values ('Chilled Water (1 TR cost)',(Select [ChilledWaterCost] from UtilityConsumptionCost))

Select * from #temp2
Drop table #temp2

------End sohag's Sp------ 



End

GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_UtilityConsumption_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_rpt_UtilityConsumption_Report '2021-07-26 08:14:32.657' ,'2021-07-27 12:50:32.657'

CREATE  PROCEDURE [dbo].[usp_rpt_UtilityConsumption_Report] 
(
	@FromDate datetime,
	@ToDate datetime
	
)
AS
Begin

		Select
				  
				  ROW_NUMBER() over (order by M1.[Date]) as 'SrNo',
				  convert(varchar(20),M1.[Date],103)Date,
				  convert(varchar(8),M1.[Date],108) Time,
				   cast(MCC1WheyProcesses as decimal(18,2)) as MCC1WheyProcesses,
				   cast(MCC2Evaporator as decimal(18,2)) as MCC2Evaporator,
				    cast(MCC3Dryer as decimal(18,2)) as MCC3Dryer,
				   cast(MCC4SCM as decimal(18,2)) as MCC4SCM,
				  cast( MCC1WheyProcesses+MCC2Evaporator+MCC3Dryer+MCC4SCM as decimal(18,2))as TotalPowerConsumption,
				    cast(SteamConsumptioninWheyPlant as decimal(18,2)) as SteamConsumptioninWheyPlant,
				   cast( SteamConsumptioninEvaporator as decimal(18,2)) as SteamConsumptioninEvaporator,
				  cast(  HPSteamConsumptioninDryer as decimal(18,2)) as HPSteamConsumptioninDryer,
				  cast(  SteamConsumptionindryerothers as decimal(18,2)) as SteamConsumptionindryerothers,
				  cast(  SteamConsumptioninWheyPlant + SteamConsumptioninEvaporator+HPSteamConsumptioninDryer+SteamConsumptionindryerothers as decimal(18,2)) as TotalSteamConsumption,
				  cast(  ChilledWaterinWheyProcessing as decimal(18,2))as ChilledWaterinWheyProcessing,
				  cast(  ChilledWaterinpowderplant as decimal(18,2)) as ChilledWaterinpowderplant,
				   cast(Chilledwaterinlettemp as decimal(18,2)) as Chilledwaterinlettemp,
				   cast(ChilledwaterOutlettemp as decimal(18,2)) as ChilledwaterOutlettemp,
				  cast(  ChilledWaterinWheyProcessing+ChilledWaterinpowderplant as decimal(18,2))as TotalChilledWaterConsumption,
				   cast(SoftWater as decimal(18,2))as SoftWater,
				   ROWater as ROWater,
				   CompressedAir as CompressedAir,
				   RawWater as RawWater,
				   Remarks as Remarks
				--  W11T01TankStatus,
				 
					
	from UtilityConsumption M1 
	where
	[Date] between @FromDate and @ToDate
		--convert(date,M1.DateTime,103) between convert(date,@FromDate) and convert(date,@ToDate,103)
	--	order by Id,Datetime asc

End


GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_UtilityGeneration]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_rpt_UtilityGeneration] '01/01/2018 11:00:00','12/28/2019'
CREATE PROCEDURE [dbo].[usp_rpt_UtilityGeneration]
(
	@FromDateTime datetime,
	@ToDateTime datetime
)
AS
Begin
	--SET NOCOUNT ON
	
SELECT 
	--[Id],
	Convert(varchar(10),[DateTime],103) as 'Date',
	Convert(varchar(8),(Convert(time,[DateTime],123))) as 'Time',
	[Raw],
	[SOFT],
	[ChilledPressure],
	[Flow] / 1000 as 'Flow',
	[SupplyTemprature],
	[ReturnTemprature],
	[MainHPSteamHeaderPressure],
	[EvaporatorSteamPressure],
	[LPSteam],
	[AirPressure],
	[NitrogenPressure],
	[OxygenContent]
 FROM 
	[UtilityGeneration]
where
	DateTime between @FromDateTime and @ToDateTime + 1
	
End
	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_UtilityGeneration1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_rpt_UtilityGeneration1] '07/01/2019','07/28/2019'
CREATE PROCEDURE [dbo].[usp_rpt_UtilityGeneration1]
(
	@FromDateTime datetime,
	@ToDateTime datetime
)
AS
Begin
	--SET NOCOUNT ON
	
--SELECT 
--	--[Id],
--	Convert(varchar(10),[DateTime],103) +' '+ Convert(varchar(8),[DateTime],108) as 'Date',
--	 [NitrogenGeneration],
--	[BoilerGeneration],
--	[EvaporatorGeneration]
-- FROM 
--	[UtilityGeneration]
--where
--	DateTime between @FromDateTime and @ToDateTime + 1
	
--	Union all
--SELECT 
--	--[Id],
--	'Total',
--	Sum([NitrogenGeneration]) as NitrogenGeneration,
--	Sum([BoilerGeneration]) as BoilerGeneration,
--	Sum([EvaporatorGeneration]) as EvaporatorGeneration
--FROM 
--	[UtilityGeneration]
--where
--	DateTime between @FromDateTime and @ToDateTime + 1

-------------------------------------------------------------

create table #tmpDate(n int identity(1,1),Date Date)

	insert into #tmpDate(Date)
	select distinct convert(date,DateTime,103) from  [UtilityGeneration] where convert(date,DateTime) between dateadd( DAY,-1,convert(date,@FromDateTime)) and dateadd( DAY,+1,convert(date,@ToDateTime)) order by  convert(date,DateTime,103) asc

--	select '#tmpDate'
--select * from #tmpDate 

	declare @a int=2,@cnt int

	set @cnt = (select count (*) from #tmpDate)
--	select @cnt

	declare @PreNitrogenGeneration float , @PreBoilerCondGeneration float , @PreEvaporatorGeneration float,
	       @NextNitrogenGeneration float , @NextBoilerCondGeneration float , @NextEvaporatorGeneration float
         
		 create table #FinalData (Date date,BoilerGeneration float ,EvaporatorGenaration float,NitrogenGeneration float)     

	while (@a <= @cnt)
	begin
	    
		

		 set @PreNitrogenGeneration = (select  Max(NitrogenGeneration) from [UtilityGeneration] where Convert( date,[DateTime],103) = (select Date from #tmpDate where n=@a-1))
	     set  @NextNitrogenGeneration=	(select Max(NitrogenGeneration) from [UtilityGeneration] where Convert( date,[DateTime],103) = (select Date from #tmpDate where n=@a))

		 	 set @PreBoilerCondGeneration = (select  Max(BoilerGeneration) from [UtilityGeneration] where Convert( date,[DateTime],103) = (select Date from #tmpDate where n=@a-1))
	     set  @NextBoilerCondGeneration=	(select Max(BoilerGeneration) from [UtilityGeneration] where Convert( date,[DateTime],103) = (select Date from #tmpDate where n=@a))

		 	 set @PreEvaporatorGeneration = (select  Max(EvaporatorGeneration) from [UtilityGeneration] where Convert( date,[DateTime],103) = (select Date from #tmpDate where n=@a-1))
	     set  @NextEvaporatorGeneration=	(select Max(EvaporatorGeneration) from [UtilityGeneration] where Convert( date,[DateTime],103) = (select Date from #tmpDate where n=@a))


		 --select @PreNitrogenGeneration as NPre,@NextNitrogenGeneration as Nnext
		 --select @PreBoilerCondGeneration as Bpre,@NextBoilerCondGeneration as Bnext
		 -- select @PreEvaporatorGeneration as Epre,@NextEvaporatorGeneration as Enext

		    Insert into  #FinalData (Date ,BoilerGeneration,EvaporatorGenaration,NitrogenGeneration)
			values
			(
			    convert(date,(select Date from #tmpDate where n= @a),103),
				abs(round((@NextBoilerCondGeneration - @PreBoilerCondGeneration),2)),
				abs(round((@NextEvaporatorGeneration - @PreEvaporatorGeneration),2)),
				abs(round((@NextNitrogenGeneration - @PreNitrogenGeneration ),2))
			)

	   set @a=@a+1
	end


	--select * from #FinalData
	select
	Date,
	 a.BoilerGeneration as 'BoilerGeneration',
	 a.EvaporatorGenaration as 'EvaporatorGeneration' ,
	 a.NitrogenGeneration  as 'NitrogenGeneration'
	from 
	#FinalData a 
	where convert(date,a.Date,103) between convert(date,@FromDateTime,103) and convert(date,@ToDateTime,103) 
	order by  Date asc


	drop table #tmpDate,#FinalData



End
	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_Silo_Selection]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Silo_Selection]
	@Param int
AS
BEGIN
	If(@Param = 1)
	Begin
		Select Name, Convert(Varchar(MAX),PLCValue) + '-' + Convert(Varchar(MAX),31) AS Line from SILO
		Union All
		Select 'WHEY', Convert(Varchar(MAX),32) + '-' + Convert(Varchar(MAX),32)
	End
	Else 
	Begin
		Select 'RMST-1 to MPL1' as Name, Convert(Varchar(MAX),1) + '-' + Convert(Varchar(MAX),11) AS Line 
		Union All
		Select 'RMST-2 to MPL1', Convert(Varchar(MAX),2) + '-' + Convert(Varchar(MAX),11) AS Line
		Union All
		Select 'RMST-1 to MPL2', Convert(Varchar(MAX),1) + '-' + Convert(Varchar(MAX),12) AS Line
		Union All
		Select 'RMST-2 to MPL2', Convert(Varchar(MAX),2) + '-' + Convert(Varchar(MAX),12) AS Line
		Union All
		Select 'PMST-1 to 20TPD', Convert(Varchar(MAX),3) + '-' + Convert(Varchar(MAX),13) AS Line
		Union All
		Select 'PMST-2 to 20TPD', Convert(Varchar(MAX),4) + '-' + Convert(Varchar(MAX),13) AS Line
		Union All
		Select 'PMST-1 to 30TPD', Convert(Varchar(MAX),3) + '-' + Convert(Varchar(MAX),14) AS Line
		Union All
		Select 'PMST-2 to 30TPD', Convert(Varchar(MAX),4) + '-' + Convert(Varchar(MAX),14) AS Line
		Union All
		Select 'HMST to SMST', Convert(Varchar(MAX),15) + '-' + Convert(Varchar(MAX),15) AS Line
		Union All
		Select 'HMST to PANEER', Convert(Varchar(MAX),16) + '-' + Convert(Varchar(MAX),16) AS Line
		Union All
		Select 'SMST to PANEER', Convert(Varchar(MAX),17) + '-' + Convert(Varchar(MAX),17) AS Line
		Union All
		Select 'HMST to WHEY', Convert(Varchar(MAX),18) + '-' + Convert(Varchar(MAX),18) AS Line
		Union All
		Select 'PANEER to MPL', Convert(Varchar(MAX),19) + '-' + Convert(Varchar(MAX),19) AS Line
		Union All
		Select 'WHEY to MPL', Convert(Varchar(MAX),20) + '-' + Convert(Varchar(MAX),20)
	End
END




GO
/****** Object:  StoredProcedure [dbo].[usp_Tag_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Tag_SelectAll]
	
AS
BEGIN
	SELECT 
		COLUMN_NAME as Name
	FROM 
		GEA.INFORMATION_SCHEMA.COLUMNS
	WHERE 
		TABLE_NAME In (N'VFD_PLC','Valve_PLC', 'Motor_PLC', 'Transmitter_PLC')
		and COLUMN_NAME not in ('Id', 'DateTime')
END




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CIPRecipe_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_CIPRecipe_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Circuit]
	--WHERE
	--		[Id] = @Id

	Update 
		CIPRecipe
	SET
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CIPRecipe_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_CIPRecipe_Insert]
(
	@Id int = NULL OUTPUT,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@IsDeleted int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @StatusCount int = (Select COUNT(*) from CIPRecipe where [PLCValue] = @PLCValue and IsDeleted = 0)
	Declare @Status int
	
	If(@StatusCount = 0)
	Begin
		INSERT INTO CIPRecipe
		(
			[Name],
			[PLCValue],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@Name,
			@PLCValue,
			0,
			@CreatedBy,
			@CreatedDate
		)

		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End
--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CIPRecipe_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_CIPRecipe_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		CIPRecipe
	WHERE  
		[Id] = @Id
		and IsDeleted = 0

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CIPRecipe_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_CIPRecipe_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		CIPRecipe
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CIPRecipe_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_CIPRecipe_Update]
(
	@Id int,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @StatusCount int = (Select COUNT(*) from Status where [PLCValue] = @PLCValue and IsDeleted = 0 and Id != @Id)
	Declare @Status int
	
	If(@StatusCount = 0)
	Begin
		UPDATE 
			CIPRecipe
		SET
			[Name] = @Name,
			[PLCValue] = @PLCValue,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id

		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CompressedAirTag_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_CompressedAirTag_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [FaultTag]
	--WHERE
	--		[Id] = @Id

	Update 
		[dbo].[CompressedAirTag]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CompressedAirTag_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_CompressedAirTag_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @CompressedAirTagcount int
	Declare @status int
	set @CompressedAirTagcount = (Select COUNT(id) from CompressedAirTag where TagNo = @TagNo and IsDeleted = 0)
	
	if(@CompressedAirTagcount =0)
	begin
		INSERT INTO CompressedAirTag
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CompressedAirTag_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_CompressedAirTag_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[dbo].[CompressedAirTag]
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CompressedAirTag_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_CompressedAirTag_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   
		CompressedAirTag
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_CompressedAirTag_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_CompressedAirTag_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @CompressedAirTagcount int
	Declare @status int
	set @CompressedAirTagcount = (Select COUNT(id) from CompressedAirTag where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@CompressedAirTagcount =0)
	begin
		UPDATE 
			[dbo].[CompressedAirTag]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag1_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag1_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	
	Update 
		[dbo].[DesiccantTag1]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag1_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag1_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @DesiccantTag1count int
	Declare @status int
	set @DesiccantTag1count = (Select COUNT(id) from DesiccantTag1 where TagNo = @TagNo and IsDeleted = 0)
	
	if(@DesiccantTag1count =0)
	begin
		INSERT INTO [dbo].[DesiccantTag1]
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag1_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag1_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[dbo].[DesiccantTag1]
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag1_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag1_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   
		[dbo].[DesiccantTag1]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag1_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag1_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @DesiccantTag1count int
	Declare @status int
	set @DesiccantTag1count = (Select COUNT(id) from DesiccantTag1 where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@DesiccantTag1count =0)
	begin
		UPDATE 
			[dbo].[DesiccantTag1]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag2_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag2_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	
	Update 
		[dbo].[DesiccantTag2]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag2_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag2_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @DesiccantTag2count int
	Declare @status int
	set @DesiccantTag2count = (Select COUNT(id) from DesiccantTag2 where TagNo = @TagNo and IsDeleted = 0)
	
	if(@DesiccantTag2count =0)
	begin
		INSERT INTO [dbo].[DesiccantTag2]
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag2_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag2_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[dbo].[DesiccantTag2]
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag2_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag2_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   
		[dbo].[DesiccantTag2]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DesiccantTag2_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DesiccantTag2_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @DesiccantTag2count int
	Declare @status int
	set @DesiccantTag2count = (Select COUNT(id) from DesiccantTag2 where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@DesiccantTag2count =0)
	begin
		UPDATE 
			[dbo].[DesiccantTag2]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Device_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Device_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Device]
	--WHERE
	--		[Id] = @Id

	Update 
		[DeviceMaster]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Device_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Device_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @Faultcount int
	Declare @status int
	set @Faultcount = (Select COUNT(id) from [DeviceMaster] where TagNo = @TagNo and IsDeleted = 0 AND Type = @Type)
	
	if(@Faultcount =0)
	begin
		INSERT INTO [DeviceMaster]
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Device_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Device_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
SELECT 
		D.[Id],D.[TagNo],[Description],
		[Type],E.Name
	FROM   
		[DeviceMaster] D inner Join EquipmentMaster E
			On E.Id = D.Type
	
	WHERE
		E.IsDeleted = 0
	and D.IsDeleted = 0
	and	D.[Id] = @Id

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Device_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Device_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		D.[Id],D.[TagNo],[Description],
		[Type],E.Name
	FROM   
		[DeviceMaster] D inner Join EquipmentMaster E
			On E.Id = D.Type
	
	WHERE
		E.IsDeleted = 0
	and D.IsDeleted = 0

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Device_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Device_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @Faultcount int
	Declare @status int
	set @Faultcount = (Select COUNT(id) from [DeviceMaster] where TagNo = @TagNo and Id != @Id and IsDeleted = 0 AND Type = @Type)
	
	if(@Faultcount =0)
	begin
		UPDATE 
			[DeviceMaster]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DeviceMaster_Select_Equipment]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[usp_tbl_DeviceMaster_Select_Equipment]
(
	@Name Varchar(100)
)
AS
	--SET NOCOUNT ON
	
SELECT 
		E.Id,E.Name
	FROM   
		[DeviceMaster] D inner Join EquipmentMaster E
			On E.Id = D.Type
	
	WHERE
		 D.IsDeleted = 0
		 and E.Isdeleted = 0
			and	D.TagNo = @Name

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DryerTag_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DryerTag_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [FaultTag]
	--WHERE
	--		[Id] = @Id

	Update 
		DryerTag
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DryerTag_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DryerTag_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @DryerTagcount  int
	Declare @status int
	set @DryerTagcount  = (Select COUNT(id) from DryerTag where TagNo = @TagNo and IsDeleted = 0)
	
	if(@DryerTagcount  =0)
	begin
		INSERT INTO DryerTag
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DryerTag_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DryerTag_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		DryerTag
	WHERE  
		[Id] = @Id

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DryerTag_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DryerTag_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   
		DryerTag
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_DryerTag_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_DryerTag_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @DryerTagcount  int
	Declare @status int
	set @DryerTagcount  = (Select COUNT(id) from DryerTag where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@DryerTagcount = 0)
	begin
		UPDATE 
			DryerTag
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Employee_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Employee_Delete]
(
	@ID int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Employee]
	--WHERE
	--

	Update 
		[Employee]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
	Id = @Id


	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Employee_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Employee_Insert]
(
	@Name nvarchar(300) = NULL,
	@Code nvarchar(50) = NULL,
	@BranchId int = NULL,
	@OrganisationId int = NULL,
	@RoleId int = NULL,
	@DepartmentId int = NULL,
	@DesignationId int = NULL,
	@ReportingToId int = NULL,
	@Address nvarchar(MAX) = NULL,
	@ContactNo varchar(50) = NULL,
	@MobileNo varchar(50) = NULL,
	@Email varchar(50) = NULL,
	@IsUser int = NULL,
	@UserName nvarchar(50) = NULL,
	@Password nvarchar(50) = NULL,
	@JoinDate varchar(50) = NULL,
	@BirthDate varchar(50) = NULL,
	@MarriageDate varchar(50) = NULL,
	@AllowAccountAccess int = NULL,
	@IsResigned int = NULL,
	@ResignationDate varchar(50) = NULL,
	@LastWorkingDate varchar(50) = NULL,
	@CreatedBy int = NULL,
	@CreatedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	declare @EmployeeCount int
	set @EmployeeCount = (select count(Id) from Employee where Name = @Name and IsDeleted = 0)
	if(@EmployeeCount = 0)

	INSERT INTO [Employee]
	(
		[Name],
		[Code],
		[BranchId],
		[OrganisationId],
		[RoleId],
		[DepartmentId],
		[DesignationId],
		[ReportingToId],
		[Address],
		[ContactNo],
		[MobileNo],
		[Email],
		[IsUser],
		[UserName],
		[Password],
		[JoinDate],
		[BirthDate],
		[MarriageDate],
		[AllowAccountAccess],
		[IsResigned],
		[ResignationDate],
		[LastWorkingDate],
		[IsDeleted],
		[CreatedBy],
		[CreatedDate]
	)
	VALUES
	(
		@Name,
		@Code,
		@BranchId,
		@OrganisationId,
		@RoleId,
		@DepartmentId,
		@DesignationId,
		@ReportingToId,
		@Address,
		@ContactNo,
		@MobileNo,
		@Email,
		@IsUser,
		@UserName,
		@Password,
		@JoinDate,
		@BirthDate,
		@MarriageDate,
		@AllowAccountAccess,
		@IsResigned,
		@ResignationDate,
		@LastWorkingDate,
		0,
		@CreatedBy,
		@CreatedDate		
	)


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Employee_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Employee_Select]
(
		@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[Code],		[BranchId],		[OrganisationId],		[RoleId],		[DepartmentId],		[DesignationId],		[ReportingToId],		[Address],		[ContactNo],		[MobileNo],		[Email],		[IsUser],		[UserName],		[Password],		[JoinDate],		[BirthDate],		[MarriageDate],		[AllowAccountAccess],		[IsResigned],		[ResignationDate],		[LastWorkingDate],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Employee]
	WHERE  
	Id = @Id

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Employee_Select_ForLogin]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_tbl_Employee_Select_ForLogin] 'BanasUser','BanasUser'
CREATE PROCEDURE [dbo].[usp_tbl_Employee_Select_ForLogin]
(
	@UserName varchar(50),
	@Password varchar(50)
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*
	FROM   
		[Employee]
	WHERE  
		IsDeleted = 0 and
		[UserName] = @UserName and
		[Password] = @Password


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Employee_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Employee_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[Code],		[BranchId],		[OrganisationId],		[RoleId],		[DepartmentId],		[DesignationId],		[ReportingToId],		[Address],		[ContactNo],		[MobileNo],		[Email],		[IsUser],		[UserName],		[Password],		[JoinDate],		[BirthDate],		[MarriageDate],		[AllowAccountAccess],		[IsResigned],		[ResignationDate],		[LastWorkingDate],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Employee]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Employee_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Employee_Update]
(
	@Id int,
	@Name nvarchar(300) = NULL,
	@Code nvarchar(50) = NULL,
	@BranchId int = NULL,
	@OrganisationId int = NULL,
	@RoleId int = NULL,
	@DepartmentId int = NULL,
	@DesignationId int = NULL,
	@ReportingToId int = NULL,
	@Address nvarchar(MAX) = NULL,
	@ContactNo varchar(50) = NULL,
	@MobileNo varchar(50) = NULL,
	@Email varchar(50) = NULL,
	@IsUser int = NULL,
	@UserName nvarchar(50) = NULL,
	@Password nvarchar(50) = NULL,
	@JoinDate varchar(50) = NULL,
	@BirthDate varchar(50) = NULL,
	@MarriageDate varchar(50) = NULL,
	@AllowAccountAccess int = NULL,
	@IsResigned int = NULL,
	@ResignationDate varchar(50) = NULL,
	@LastWorkingDate varchar(50) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	declare @EmployeeCount int
	set @EmployeeCount = (select count(Id) from Employee where Name = @Name and Id!=@Id and IsDeleted=0)
	If(@EmployeeCount = 0)
	UPDATE 
		[Employee]
	SET
		[Name] = @Name,
		[Code] = @Code,
		[BranchId] = @BranchId,
		[OrganisationId] = @OrganisationId,
		[RoleId] = @RoleId,
		[DepartmentId] = @DepartmentId,
		[DesignationId] = @DesignationId,
		[ReportingToId] = @ReportingToId,
		[Address] = @Address,
		[ContactNo] = @ContactNo,
		[MobileNo] = @MobileNo,
		[Email] = @Email,
		[IsUser] = @IsUser,
		[UserName] = @UserName,
		[Password] = @Password,
		[JoinDate] = @JoinDate,
		[BirthDate] = @BirthDate,
		[MarriageDate] = @MarriageDate,
		[AllowAccountAccess] = @AllowAccountAccess,
		[IsResigned] = @IsResigned,
		[ResignationDate] = @ResignationDate,
		[LastWorkingDate] = @LastWorkingDate,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		Id = @Id



	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_EquipmentMaster_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[usp_tbl_EquipmentMaster_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [FaultTag]
	--WHERE
	--		[Id] = @Id

	Update 
		EquipmentMaster
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_EquipmentMaster_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_EquipmentMaster_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Remarks varchar(MAX) = NULL,
	@Name varchar(MAX) = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @EquipmentMastercount int
	Declare @status int
	set @EquipmentMastercount = (Select COUNT(id) from EquipmentMaster where Name = @Name and IsDeleted = 0)
	
	if(@EquipmentMastercount =0)
	begin
		INSERT INTO EquipmentMaster
		(
			[TagNo],
			Remarks,
			Name,
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Remarks,
			@Name,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_EquipmentMaster_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[usp_tbl_EquipmentMaster_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],Remarks,Name
	FROM   
		EquipmentMaster
	WHERE  
		[Id] = @Id

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_EquipmentMaster_Select_Device]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[usp_tbl_EquipmentMaster_Select_Device]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
SELECT 
		D.[Id],D.[TagNo]
	FROM   
		[DeviceMaster] D 
	
	WHERE
		 D.IsDeleted = 0
	and	D.Type = @Id

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_EquipmentMaster_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[usp_tbl_EquipmentMaster_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],Remarks,Name
		
	FROM   
		EquipmentMaster
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_EquipmentMaster_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_EquipmentMaster_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Remarks varchar(MAX) = NULL,
	@Name varchar(MAX) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @Equipmentcount int
	Declare @status int
	set @Equipmentcount = (Select COUNT(id) from EquipmentMaster where Name = @Name and Id != @Id and IsDeleted = 0)
	
	if(@Equipmentcount =0)
	begin
		UPDATE 
			[EquipmentMaster]
		SET
			[TagNo] = @TagNo,
			[Remarks] = @Remarks,
			[Name] = @Name,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator1Tag_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator1Tag_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	
	Update 
		[dbo].[EvaporatorTag]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator1Tag_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator1Tag_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @EvaporatorTagcount int
	Declare @status int
	set @EvaporatorTagcount = (Select COUNT(id) from EvaporatorTag where TagNo = @TagNo and IsDeleted = 0)
	
	if(@EvaporatorTagcount =0)
	begin
		INSERT INTO [dbo].[EvaporatorTag]
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator1Tag_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator1Tag_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[dbo].[EvaporatorTag]
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator1Tag_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator1Tag_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   
		[EvaporatorTag]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator1Tag_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator1Tag_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @EvaporatorTagcount int
	Declare @status int
	set @EvaporatorTagcount = (Select COUNT(id) from EvaporatorTag where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@EvaporatorTagcount =0)
	begin
		UPDATE 
			[dbo].[EvaporatorTag]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator2Tag_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator2Tag_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	
	Update 
		[dbo].[EvaporatorTag2]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator2Tag_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator2Tag_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @EvaporatorTag2count int
	Declare @status int
	set @EvaporatorTag2count = (Select COUNT(id) from EvaporatorTag2 where TagNo = @TagNo and IsDeleted = 0)
	
	if(@EvaporatorTag2count =0)
	begin
		INSERT INTO [dbo].[EvaporatorTag2]
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator2Tag_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator2Tag_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[dbo].[EvaporatorTag2]
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator2Tag_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator2Tag_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   		
		[dbo].[EvaporatorTag2]
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Evaporator2Tag_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Evaporator2Tag_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @EvaporatorTag2count int
	Declare @status int
	set @EvaporatorTag2count = (Select COUNT(id) from EvaporatorTag2 where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@EvaporatorTag2count =0)
	begin
		UPDATE 
			[dbo].[EvaporatorTag2]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Inventory_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[usp_tbl_Inventory_Select]
(
		@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[Code],		[BranchId],		[OrganisationId],		[RoleId],		[DepartmentId],		[DesignationId],		[ReportingToId],		[Address],		[ContactNo],		[MobileNo],		[Email],		[IsUser],		[UserName],		[Password],		[JoinDate],		[BirthDate],		[MarriageDate],		[AllowAccountAccess],		[IsResigned],		[ResignationDate],		[LastWorkingDate],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Inventory]
	WHERE  
	Id = @Id

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_LabReport_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_tbl_LabReport_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [LabReport]
	--WHERE
	--		[Id] = @Id

	Update 
		[LabReport]
	SET
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_LabReport_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_tbl_LabReport_Insert]
(
	@Id int = NULL OUTPUT,
	@LabDate varchar(10) = NULL,
	@VehicleId int = Null,
	@VehicleCode varchar(50) = NULL,
	@RouteId int = NULL,
	@ProductId int = NULL,
	@OT int = NULL,
	@Temp real = NULL,
	@Fat real = NULL,
	@SNF real = NULL,
	@Acidity real = NULL,
	@COB varchar(3) = NULL,
	@AlcoholNo varchar(50) = NULL,
	@Neutralizer varchar(3) = NULL,
	@Urea varchar(3) = NULL,
	@Salt varchar(3) = NULL,
	@Startch varchar(3) = NULL,
	@FPD varchar(50) = NULL,
	@Status int = NULL,
	@IsDeleted bit = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON

	INSERT INTO [LabReport]
	(
		[LabDate],
		[VehicleId],
		[VehicleCode],
		[RouteId],
		[ProductId],
		[OT],
		[Temp],
		[Fat],
		[SNF],
		[Acidity],
		[COB],
		[AlcoholNo],
		[Neutralizer],
		[Urea],
		[Salt],
		[Startch],
		[FPD],
		[Status],
		[IsDeleted],
		[CreatedBy],
		[CreatedDate]
	)
	VALUES
	(
		@LabDate,
		@VehicleId,
		@VehicleCode,
		@RouteId,
		@ProductId,
		@OT,
		@Temp,
		@Fat,
		@SNF,
		@Acidity,
		@COB,
		@AlcoholNo,
		@Neutralizer,
		@Urea,
		@Salt,
		@Startch,
		@FPD,
		@Status,
		0,
		@CreatedBy,
		@CreatedDate
	)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_LabReport_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [usp_tbl_LabReport_Select] 3
CREATE PROCEDURE [dbo].[usp_tbl_LabReport_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		LR.*,
		V.VehicleNumber,V.RouteNo--		[Id],		[LabDate],		[VehicleId],		[RouteId],		[ProductId],		[OT],		[Temp],		[Fat],		[SNF],		[Acidity],		[COB],		[AlcoholNo],		[Neutralizer],		[Urea],		[Salt],		[Startch],		[FPD],		[Status],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[LabReport] LR Inner Join Vehicle V on
			V.VehicleId = LR.VehicleId
	WHERE  
		[Id] = @Id
		and V.IsDeleted = 0
		and LR.IsDeleted = 0

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_LabReport_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_tbl_LabReport_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[LabDate],		[VehicleId],		[RouteId],		[ProductId],		[OT],		[Temp],		[Fat],		[SNF],		[Acidity],		[COB],		[AlcoholNo],		[Neutralizer],		[Urea],		[Salt],		[Startch],		[FPD],		[Status],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[LabReport]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_LabReport_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_tbl_LabReport_Update]
(
	@Id int,
	@LabDate varchar(10) = NULL,
	@VehicleId int = Null,
	@VehicleCode varchar(50) = NULL,
	@RouteId int = NULL,
	@ProductId int = NULL,
	@OT int = NULL,
	@Temp real = NULL,
	@Fat real = NULL,
	@SNF real = NULL,
	@Acidity real = NULL,
	@COB varchar(3) = NULL,
	@AlcoholNo varchar(50) = NULL,
	@Neutralizer varchar(3) = NULL,
	@Urea varchar(3) = NULL,
	@Salt varchar(3) = NULL,
	@Startch varchar(3) = NULL,
	@FPD varchar(50) = NULL,
	@Status int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	UPDATE 
		[LabReport]
	SET
		[LabDate] = @LabDate,
		[VehicleId] = @VehicleId,
		[VehicleCode] = @VehicleCode,
		[RouteId] = @RouteId,
		[ProductId] = @ProductId,
		[OT] = @OT,
		[Temp] = @Temp,
		[Fat] = @Fat,
		[SNF] = @SNF,
		[Acidity] = @Acidity,
		[COB] = @COB,
		[AlcoholNo] = @AlcoholNo,
		[Neutralizer] = @Neutralizer,
		[Urea] = @Urea,
		[Salt] = @Salt,
		[Startch] = @Startch,
		[FPD] = @FPD,
		[Status] = @Status,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		[Id] = @Id


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MassBalance_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_MassBalance_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Maintainance]
	--WHERE
	--

	Update 
		MassBalance
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id and 
		IsDeleted = 0




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MassBalance_Insert_Amul]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_tbl_MassBalance_Insert_Amul]
(
	@Id int = NULL OUTPUT,
	@Date datetime = NULL,
	@FAT varchar(50) = NULL,
	@SNF varchar(50) = NULL,
	@ProcessId decimal(20,0) = NULL
)
AS
	--SET NOCOUNT ON

	Update 
		MassBalanceAmul 
	Set
		Fat = @FAT,
		SNF = @SNF
	Where
		ID = @ProcessId
		and CONVERT(date, Date,103) =CONVERT(date, @Date,103)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MassBalance_Master_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_MassBalance_Master_Insert]
(
	@Id int = NULL OUTPUT,
	@Date date = NULL,
	@TotalTS float = NULL,
	@TotalTSKG float = NULL,
	@TotalQuantity float = NULL,
	@TSReverted float = NULL,
	@TSToDryer float = NULL,
	@PowderQuantity float = NULL,
	@TS float = NULL,
	@RecoveredPowder float = NULL,
	@TotalPowder float = NULL,
	@TotalTsPowder float = NULL,
	@DeltaTSKG float = NULL,
	@DeltaTS float = NULL,
	@IsDeleted int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON

If((Select count(*) from MassBalance where CONVERT(date, Date,103) =CONVERT(date, @Date,103)) = 0)
Begin
	INSERT INTO [MassBalance]
	(
		[Date],
		[TotalTS],
		[TotalTSKG],
		[TotalQuantity],
		[TSReverted],
		[TSToDryer],
		[PowderQuantity],
		[TS],
		[RecoveredPowder],
		[TotalPowder],
		[TotalTsPowder],
		[DeltaTSKG],
		[DeltaTS],
		[IsDeleted],
		[LastModifiedBy],
		[LastModifiedDate]
	)
	VALUES
	(
		@Date,
		@TotalTS,
		@TotalTSKG,
		@TotalQuantity,
		@TSReverted,
		@TSToDryer,
		@PowderQuantity,
		@TS,
		@RecoveredPowder,
		@TotalPowder,
		@TotalTsPowder,
		@DeltaTSKG,
		@DeltaTS,
		@IsDeleted,
		@LastModifiedBy,
		@LastModifiedDate
	)
End
Else
Begin
	UPDATE [MassBalance]
	SET
		[Date] = @Date,
		[TotalTS] = @TotalTS,
		[TotalTSKG] = @TotalTSKG,
		[TotalQuantity] = @TotalQuantity,
		[TSReverted] = @TSReverted,
		[TSToDryer] = @TSToDryer,
		[PowderQuantity] = @PowderQuantity,
		[TS] = @TS,
		[RecoveredPowder] = @RecoveredPowder,
		[TotalPowder] = @TotalPowder,
		[TotalTsPowder] = @TotalTsPowder,
		[DeltaTSKG] = @DeltaTSKG,
		[DeltaTS] = @DeltaTS,
		[IsDeleted] = @IsDeleted,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		CONVERT(date, Date,103) = CONVERT(date, @Date,103)

End

GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MassBalancePowderProduction_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_MassBalancePowderProduction_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[AvaPackQty],[Bosch1Qty],[Bosch2Qty],[Bosch3Qty],[Bosch4Qty],[Bosch5Qty],[Bosch6Qty],[Bosch7Qty],[HassiaQty]
	FROM   [MassBalancePowderProduction]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MassBalancePowderProduction_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_MassBalancePowderProduction_Update]
(
	@Id int,
	@AvaPackQty float = NULL,
	@Bosch1Qty float = NULL,
	@Bosch2Qty float = NULL,
	@Bosch3Qty float = NULL,
	@Bosch4Qty float = NULL,
	@Bosch5Qty float = NULL,
	@Bosch6Qty float = NULL,
	@Bosch7Qty float = NULL,
	@HassiaQty float = NULL,
	@IsDeleted int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	UPDATE [MassBalancePowderProduction]
	SET
		[AvaPackQty] = @AvaPackQty,
		[Bosch1Qty] = @Bosch1Qty,
		[Bosch2Qty] = @Bosch2Qty,
		[Bosch3Qty] = @Bosch3Qty,
		[Bosch4Qty] = @Bosch4Qty,
		[Bosch5Qty] = @Bosch5Qty,
		[Bosch6Qty] = @Bosch6Qty,
		[Bosch7Qty] = @Bosch7Qty,
		[HassiaQty] = @HassiaQty,
		[IsDeleted] = @IsDeleted,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		[Id] = @Id

	--RETURN @@Error


GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MilkAnalysis_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_MilkAnalysis_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
Begin

	update MilkAnalysis set 
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	where
		 Id = @Id

END
	
	



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MilkAnalysis_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_MilkAnalysis_Insert]
(
	@Id int = NULL OUTPUT,
	@Date date,
	@Time time = NULL,
	@SiloId int = NULL,
	@ProductType varchar(50) = NULL,
	@SampleId varchar(50) = NULL,
	@FAT float = NULL,
	@SNF float = NULL,
	@Sugar float = NULL,
	@TS float = NULL,
	@Acidity varchar(50) = NULL,
	@Temp Float = NULL,
	@OT varchar(50) = NULL,
	@UserId int = NULL,
	@Remarks varchar(MAX) = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime,
	@IsDeleted int = NULL
)
AS
	
	INSERT INTO [MilkAnalysis]
	(
	  [Date],
	  [Time],
	  [SiloId],
	  [ProductType],
      [SampleId],
      [FAT],
      [SNF],
      [Sugar],
      [TS],
      [Acidity],
      [Temp],
      [OT],
      [UserId],
      [Remark],
      [IsDeleted],
      [CreatedDate],
      [CreatedBy]
	)
	VALUES
	(
		convert(date,@Date,103),
		convert(time, @Time),
		@SiloId,
		@ProductType,
		@SampleId,
		@FAT,
		@SNF,
		@Sugar,
		@TS,
		@Acidity,
		@Temp,
		@OT,
		@UserId,
		@Remarks,
		@IsDeleted,
		@CreatedDate,
		@CreatedBy
	)

	--SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MilkAnalysis_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_MilkAnalysis_Select]
(
	@Id int
)
AS
Begin

	Select 
		MA.Id,
		row_number() over (order by MA.Id) SrNo,
		convert(varchar(10),[Date],103) Date,
		convert(varchar(5),[Time]) Time,
		[SiloId],
		[ProductType],
		[SampleId],
		CAST(ROUND([FAT], 2) AS NUMERIC(12,1)) FAT,
		CAST(ROUND([SNF], 2) AS NUMERIC(12,1)) SNF,
		CAST(ROUND([Sugar], 2) AS NUMERIC(12,1)) Sugar,
		CAST(ROUND([TS], 2) AS NUMERIC(12,1)) TS,
		[Acidity],
		CAST(ROUND([Temp], 2) AS NUMERIC(12,1)) Temp,
		[OT],
		Remark
	from 
		MilkAnalysis MA
	where
		IsDeleted =0
		and Id = @Id

END
	
	



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MilkAnalysis_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_MilkAnalysis_SelectAll]
AS
Begin

	Select 
		MA.Id,
		row_number() over (order by MA.Id) SrNo,
		convert(varchar(10),[Date],103) Date,
		convert(varchar(5),[Time]) Time,
		S.Name as 'SiloName',

		[ProductType],
		[SampleId],
		CAST(ROUND([FAT], 2) AS NUMERIC(12,1)) FAT,
		CAST(ROUND([SNF], 2) AS NUMERIC(12,1)) SNF,
		CAST(ROUND([Sugar], 2) AS NUMERIC(12,1)) Sugar,
		CAST(ROUND([TS], 2) AS NUMERIC(12,1)) TS,
		[Acidity],
		CAST(ROUND([Temp], 2) AS NUMERIC(12,1)) Temp,
		[OT],
		(Select Name from Employee E where E.Id = MA.CreatedBy and IsDeleted = 0) as 'Name',
		Remark
	from 
		MilkAnalysis MA inner join SILO S
			On S.SILOID = MA.SiloId
	where
		MA.IsDeleted =0
		and S.IsDeleted =0
END
	
	



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MilkAnalysis_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_MilkAnalysis_Update]
(
	@Id int,
	@Date date,
	@Time time = NULL,
	@SiloId int = NULL,
	@ProductType varchar(50) = NULL,
	@SampleId varchar(50) = NULL,
	@FAT float = NULL,
	@SNF float = NULL,
	@Sugar float = NULL,
	@TS float = NULL,
	@Acidity varchar(50) = NULL,
	@Temp Float = NULL,
	@OT varchar(50) = NULL,
	@UserId int = NULL,
	@Remarks varchar(MAX) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime
)
AS
	
	update [MilkAnalysis] set 

	  [Date] = convert(date,@Date,103),
	  [Time] =CONVERT(time, @Time),
	  [SiloId] = @SiloId,
	  [ProductType] = @ProductType,
      [SampleId] = @SampleId,
      [FAT] = @FAT,
      [SNF] = @SNF,
      [Sugar] = @Sugar,
      [TS] = @TS,
      [Acidity] = @Acidity,
      [Temp] = @Temp,
      [OT] = @OT,
      [UserId] = @UserId,
      [Remark] = @Remarks,
      [LastModifiedBy] = @LastModifiedBy,
      [LastModifiedDate] = @LastModifiedDate

	  where Id = @Id
    



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_MilkclosingReportAmul_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sohag	
-- Create date: 17-08-2017
-- Description:	Insert In MilkClosing
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_MilkclosingReportAmul_Insert]
	@FAT varchar(50),
	@SNF varchar(50)
AS

Insert Into 
			MilkClosingReport (FAT,SNF) 
Values 
			(@FAT,@SNF)

GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Organisation_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_tbl_Organisation_SelectAll]
AS


select * from [dbo].[Organisation]

GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingEntry_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PackingEntry_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		Id,
		Convert(varchar(10),Date,103) as Date,
		--Case when [ShiftId] = 1 then 'Shift - 1'
		--when [ShiftId] = 2 then 'Shift - 2'
		--when [ShiftId] = 3 then 'Shift - 3' end as 'Shift',
		[ShiftId] as 'Shift',
		[TotalQuantity],
		[TotalTs]
	FROM   
		PackingEntryMaster
	
	WHERE
		IsDeleted = 0
		and Id = @Id

	SELECT 
		[Id],
		[PlantMasterId],
		[SKU] as 'SKUName',
		[Type],
		[PackedQuantity],
		[TS]
  FROM 
	[PackingEntryTransation]
	where
		[PlantMasterId] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingEntry_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PackingEntry_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		Id,
		Convert(varchar(10),Date,103) as Date,
		Case when [ShiftId] = 1 then 'Shift - 1'
		when [ShiftId] = 2 then 'Shift - 2'
		when [ShiftId] = 3 then 'Shift - 3' end as 'Shift',
		[TotalQuantity],
		[TotalTs]
	FROM   
		PackingEntryMaster
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error







GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingEntryMaster_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingEntryMaster_Insert]
(
	@Id int = NULL OUTPUT,
	@Date date = NULL,
	@ShiftId int = NULL,
	@TotalQuantity float = NULL,
	@TotalTs float = NULL,
	@IsDeleted int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	if((Select COUNT(*) from [PackingEntryMaster] where Convert(date,Date,103) = Convert(date,@Date,103) and [ShiftId] = @ShiftId and IsDeleted = 0) = 0)
	Begin
	INSERT INTO [PackingEntryMaster]
	(
		[Date],
		[ShiftId],
		[TotalQuantity],
		[TotalTs],
		[IsDeleted],
		[CreatedBy],
		[CreatedDate]
	)
	VALUES
	(
		@Date,
		@ShiftId,
		@TotalQuantity,
		@TotalTs,
		@IsDeleted,
		@CreatedBy,
		@CreatedDate
	)

	select @@IDENTITY as Id

End
	--RETURN @@Error


GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingEntryMaster_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_tbl_PackingEntryMaster_Update]
(
	@Id int,
	@Date date = NULL,
	@ShiftId int = NULL,
	@TotalQuantity float = NULL,
	@TotalTs float = NULL,
	@IsDeleted int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	--if((Select COUNT(*) from [PackingEntryMaster] where Convert(date,Date,103) = Convert(date,@Date,103) and [ShiftId] = @ShiftId and IsDeleted = 0 and Id != @Id) = 0)
	Begin
	UPDATE [PackingEntryMaster]
	SET
		[Date] = @Date,
		[ShiftId] = @ShiftId,
		[TotalQuantity] = @TotalQuantity,
		[TotalTs] = @TotalTs,
		[IsDeleted] = @IsDeleted,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		[Id] = @Id

	--Select 1 as Status
	End
	--else 
	--Select 2 as Status
	--RETURN @@Error


GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingEntryTransation_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_tbl_PackingEntryTransation_Insert]
(
	@Id int = NULL OUTPUT,
	@PlantMasterId int = NULL,
	@SKU varchar(50) = NULL,
	@PackedQuantity varchar(50) = NULL,
	@Type varchar(50) = NULL,
	@TS varchar(50) = NULL,
	@IsDeleted int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON

	INSERT INTO [PackingEntryTransation]
	(
		[PlantMasterId],
		[SKU],
		[PackedQuantity],
		Type,
		[TS],
		[IsDeleted],
		[LastModifiedBy],
		[LastModifiedDate]
	)
	VALUES
	(
		@PlantMasterId,
		@SKU,
		@PackedQuantity,
		@Type,
		@TS,
		0,
		@LastModifiedBy,
		@LastModifiedDate
	)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error


GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingEntryTransation_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_tbl_PackingEntryTransation_Update]
(
	--@Id int,
	@PlantMasterId int = NULL,
	@SKU varchar(50) = NULL,
	@PackedQuantity varchar(50) = NULL,
	@Type varchar(50) = NULL,
	@TS varchar(50) = NULL,
	@IsDeleted int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	
	UPDATE [PackingEntryTransation]
	SET
		[PlantMasterId] = @PlantMasterId,
		[SKU] = @SKU,
		[PackedQuantity] = @PackedQuantity,
		
		[TS] = @TS,
		[IsDeleted] = 0,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		PlantMasterId = @PlantMasterId
		and [SKU] = @SKU

	--RETURN @@Error


GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingMachineTag_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingMachineTag_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [FaultTag]
	--WHERE
	--		[Id] = @Id

	Update 
		[dbo].[PackingMachineTag]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingMachineTag_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingMachineTag_Insert]
(
	@Id int = NULL OUTPUT,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @PackingMachineTagcount int
	Declare @status int
	set @PackingMachineTagcount = (Select COUNT(id) from PackingMachineTag where TagNo = @TagNo and IsDeleted = 0)
	
	if(@PackingMachineTagcount =0)
	begin
		INSERT INTO PackingMachineTag
		(
			[TagNo],
			[Description],
			[Type],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@TagNo,
			@Description,
			@Type,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingMachineTag_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingMachineTag_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[TagNo],		[Description],		[Type],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[dbo].[PackingMachineTag]
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingMachineTag_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingMachineTag_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],[TagNo],[Description],
		Case when [Type] = 1 then 'VFD' else Case when [Type] = 2 then 'Transmitter' else Case when [Type] = 3 then 'Valve' else Case when [Type] = 4 then 'Motor' else '' end end end end  as Type ,
		[IsDeleted],[CreatedBy],[CreatedDate],[LastModifiedBy],[LastModifiedDate]
	FROM   
		PackingMachineTag
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingMachineTag_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingMachineTag_Update]
(
	@Id int,
	@TagNo varchar(MAX) = NULL,
	@Description varchar(MAX) = NULL,
	@Type int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @PackingMachineTagcount int
	Declare @status int
	set @PackingMachineTagcount = (Select COUNT(id) from PackingMachineTag where TagNo = @TagNo and Id != @Id and IsDeleted = 0)
	
	if(@PackingMachineTagcount =0)
	begin
		UPDATE 
			[dbo].[PackingMachineTag]
		SET
			[TagNo] = @TagNo,
			[Description] = @Description,
			[Type] = @Type,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end



	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingSKU_Master_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingSKU_Master_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],SkuName
	FROM   
		PackingSKUMaster
	WHERE  
		[IsDeleted] = 0


	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingSKUMaster_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingSKUMaster_Delete]
(
	@Id int
)
AS
	
	Update 
		PackingSKUMaster
	SET
		IsDeleted = 1
	WHERE
		[Id] = @Id and 
		IsDeleted = 0

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingSKUMaster_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_tbl_Routes_Insert] 12,'',1,'',1,''
CREATE PROCEDURE [dbo].[usp_tbl_PackingSKUMaster_Insert]
(
	@SkuName nvarchar(500)
)
AS
	--SET NOCOUNT ON
	Declare @SKUcount int
	Declare @status int
	set @SKUcount = (Select COUNT(id) from PackingSKUMaster where SkuName = @SkuName and IsDeleted = 0)
	
	if(@SKUcount =0)
	begin
		INSERT INTO PackingSKUMaster
		(
			SkuName,
			[IsDeleted]
		)
		VALUES
		(
			@SkuName,
			0
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end
	

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingSKUMaster_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingSKUMaster_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		[Id],SkuName
	FROM   
		PackingSKUMaster
	WHERE  
		[Id] = @Id

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingSkuMaster_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PackingSkuMaster_SelectAll]
(
	@ShiftId int,
	@Date varchar(10)
)
AS
if((Select COUNT(*) from [PackingEntryMaster] where Convert(date,Date,103) = Convert(date,@Date,103) and [ShiftId] = @ShiftId and IsDeleted = 0) = 0)
Begin
	--SET NOCOUNT ON
	Select
		[ID],
		[SkuName],
		'0' as [PlantMasterId],
		'SMP' as [Type],
		'' as [PackedQuantity],
		'97.2' as [TS],
		0 as [TotalQuantity],
		0 as [TotalTs]
  FROM 
		[PackingSKUMaster]
End
Else
Begin
	--SELECT 
	--	Id,
	--	Convert(varchar(10),Date,103) as Date,
	--	[ShiftId] as 'Shift',
	--	[TotalQuantity],
	--	[TotalTs]
	--FROM   
	--	PackingEntryMaster
	
	--WHERE
	--	IsDeleted = 0
	--	and Convert(date,Date,103) = Convert(date,@Date,103)
	--	and [ShiftId] = @ShiftId


	SELECT 
		PM.[Id],
		[PlantMasterId],
		[SKU] as 'SKUName',
		[Type],
		[PackedQuantity],
		[TS],
		[TotalQuantity],
		[TotalTs]
  FROM 
	[PackingEntryTransation] PET inner join PackingEntryMaster PM
		On PM.Id = PET.[PlantMasterId]
	where
		 PM.IsDeleted = 0
		and PET.IsDeleted = 0
		and Convert(date,Date,103) = Convert(date,@Date,103)
		and [ShiftId] = @ShiftId
End
	--RETURN @@Error







GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PackingSKUMaster_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_PackingSKUMaster_Update]
(
	@Id int,
	@SkuName nvarchar(500)
)
AS
	--SET NOCOUNT ON
	
	Declare @SKUcount int
	Declare @status int
	set @SKUcount = (Select COUNT(id) from PackingSKUMaster where Id != @Id and SkuName = @SkuName and IsDeleted = 0)
	
	if(@SKUcount =0)
	begin
		UPDATE 
			PackingSKUMaster
		SET
			SkuName = @SkuName
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end


	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatus_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatus_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Circuit]
	--WHERE
	--		[Id] = @Id

	Update 
		DryerPlantStatus
	SET
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatus_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatus_Insert]
(
	@Id int = NULL OUTPUT,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@IsDeleted int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @ProgramCount int = (Select COUNT(*) from DryerPlantStatus where PLCValue = @PLCValue and IsDeleted = 0)
	Declare @Status int
	
	If(@ProgramCount = 0)
	Begin
		INSERT INTO DryerPlantStatus
		(
			[Name],
			PLCValue,
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@Name,
			@PLCValue,
			0,
			@CreatedBy,
			@CreatedDate
		)

		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End
--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatus_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatus_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		DryerPlantStatus
	WHERE  
		[Id] = @Id
		and IsDeleted = 0

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatus_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatus_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		DryerPlantStatus
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatus_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatus_Update]
(
	@Id int,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @ProgramCount int = (Select COUNT(*) from DryerPlantStatus where PLCValue = @PLCValue and IsDeleted = 0 and Id != @Id)
	Declare @Status int
	
	If(@ProgramCount = 0)
	Begin
		UPDATE 
			DryerPlantStatus
		SET
			[Name] = @Name,
			PLCValue = @PLCValue,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id

		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End

	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatusEvaporator_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatusEvaporator_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Circuit]
	--WHERE
	--		[Id] = @Id

	Update 
		[PlantStatusEvaporator]
	SET
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatusEvaporator_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatusEvaporator_Insert]
(
	@Id int = NULL OUTPUT,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@IsDeleted int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @PlantStatusEvaporatorCount int = (Select COUNT(*) from [PlantStatusEvaporator] where PLCValue = @PLCValue and IsDeleted = 0)
	Declare @Status int
	
	If(@PlantStatusEvaporatorCount = 0)
	Begin
		INSERT INTO [PlantStatusEvaporator]
		(
			[Name],
			[PLCValue],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@Name,
			@PLCValue,
			0,
			@CreatedBy,
			@CreatedDate
		)

		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End
--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatusEvaporator_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatusEvaporator_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		PlantStatusEvaporator
	WHERE  
		[Id] = @Id
		and IsDeleted = 0

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatusEvaporator_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatusEvaporator_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[Name],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		PlantStatusEvaporator
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PlantStatusEvaporator_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PlantStatusEvaporator_Update]
(
	@Id int,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @PlantStatusEvaporatorCount int = (Select COUNT(*) from PlantStatusEvaporator where PLCValue = @PLCValue and IsDeleted = 0 and Id != @Id)
	Declare @Status int
	
	If(@PlantStatusEvaporatorCount = 0)
	Begin
		UPDATE 
			PlantStatusEvaporator
		SET
			[Name] = @Name,
			[PLCValue] = @PLCValue,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id

		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PowderProduction_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PowderProduction_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
Begin

	update PowderProduction set 
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	where
		 Id = @Id

END
	
	



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PowderProduction_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PowderProduction_SelectAll]
AS
Begin

	Select 
		Id,
		ROW_NUMBER() over(partition by Id order by Id) SrNo,
 		convert(varchar(10),[Date],103) Date,
		convert(varchar(5),ProductType) ProductType,
		BatchNo,
		convert(varchar(5),ProductionTime) ProductionTime,
		PackQuantity,
		TypeOfpacking,
		NoOfUnit,
		QualityParameters
	from 
		PowderProduction
	where
		IsDeleted =0

END
	
	



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_PowderProduction_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_tbl_PowderProduction_Update]
(
	@Id int,
	@Date date,
	@ProductType time = NULL,
	@BatchNo varchar(50) = NULL,
	@ProductionTime time = NULL,
	@PackQuantity int = NULL,
	@TypeOfpacking varchar(50) = NULL,
	@NoOfUnits int = NULL,
	@QualityParameter Varchar(50) = NULL,
	@UserId int = NULL,
	@Remarks varchar(MAX) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime
)
AS
	
	update PowderProduction set 

	  [Date] = convert(date,@Date,103),
	  [ProductType] = CONVERT(time, @ProductType),
	  BatchNo = @BatchNo,
	  ProductionTime = CONVERT(time, @ProductionTime),
      PackQuantity = @PackQuantity,
	  [TypeOfpacking] = @TypeOfpacking,
	  [NoOfUnit] = @NoOfUnits,
	  [QualityParameters] = @QualityParameter,
      [UserId] = @UserId,
      [Remark] = @Remarks,
      [LastModifiedBy] = @LastModifiedBy,
      [LastModifiedDate] = @LastModifiedDate

	  where Id = @Id
    



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Reception_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Reception_Delete]
(
	@ReceptionId int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Reception]
	--WHERE
	--		[ReceptionId] = @ReceptionId

	Update 
		[Reception]
	SET
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	WHERE
		[ReceptionId] = @ReceptionId

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Reception_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Reception_Insert]
(
	@ReceptionId int = NULL OUTPUT,
	@Name nvarchar(50) = NULL,
	@Description nvarchar(MAX) = NULL,
	@PLCValue real = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @ReceptionCount int = (Select COUNT(ReceptionId) from Reception where Name = @Name and IsDeleted = 0)
	Declare @Status int 
	If(@ReceptionCount = 0)
	Begin
		INSERT INTO [Reception]
		(
			[Name],
			[Description],
			[PLCValue],
			[LineFor],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@Name,
			@Description,
			@PLCValue,
			1,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as Status
	End
--	SELECT @ReceptionId = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Reception_PLC_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_Reception_PLC_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		Distinct(Tanker_ID) as Tanker_ID--		[Id],		[DateTime],		[Ch_Temp],		[DEST],		[Line_No],		[Product_Type],		[SRC],		[Start_Trig],		[Tanker_ID],		[Transfer_Qty],		[WB_Qty]
	FROM   
		[Reception_PLC]
	
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Reception_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Reception_Select]
(
	@ReceptionId int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[ReceptionId],		[Name],		[Description],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Reception]
	WHERE  
		[ReceptionId] = @ReceptionId
		and [IsDeleted] = 0

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Reception_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_Reception_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*
	FROM   
		[Reception]
	WHERE
		IsDeleted = 0
		and LineFor = 1
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Reception_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Reception_Update]
(
	@ReceptionId int,
	@Name nvarchar(50) = NULL,
	@Description nvarchar(MAX) = NULL,
	@PLCValue real = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @ReceptionCount int = (Select COUNT(ReceptionId) from Reception where Name = @Name and IsDeleted = 0 and ReceptionId != @ReceptionId)
	Declare @Status int 
	If(@ReceptionCount = 0)
	Begin
		UPDATE 
			[Reception]
		SET
			[Name] = @Name,
			[Description] = @Description,
			[PLCValue] = @PLCValue,
			[IsDeleted] = 0,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[ReceptionId] = @ReceptionId
			
		Set @Status = 1
		Select @Status as Status
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as Status
	End


	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Role_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Role_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Role]
	--WHERE
	--		[RoleId] = @RoleId

	Update 
		[Role]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id

	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Role_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Role_Insert]
(
	@Name nvarchar(50) = NULL,
	@Description nvarchar(MAX) = NULL,
	@OrganisationId int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	Declare @RoleCount int
	set @RoleCount = (select count(ID) from Role where name = @name and IsDeleted = 0)
	if(@RoleCount = 0)
	INSERT INTO [Role]
	(
		[Name],
		[Description],
		[OrganisationId],
		[IsDeleted],
		[CreatedBy],
		[CreatedDate]
	)
	VALUES
	(
		@Name,
		@Description,
		@OrganisationId,
		0,
		@CreatedBy,
		@CreatedDate
	)


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Role_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Role_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[RoleId],		[Name],		[Description],		[OrganisationId],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Role]
	WHERE  
		[Id] = @Id

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Role_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Role_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[RoleId],		[Name],		[Description],		[OrganisationId],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Role]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Role_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Role_Update]
(
	@Id int,
	@Name nvarchar(50) = NULL,
	@Description nvarchar(MAX) = NULL,
	@OrganisationId int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	Declare @RoleCount int
	set @RoleCount = (select count(id) from Role where name=@name and Id!= @Id and IsDeleted = 0)
	if(@RoleCount = 0)
	UPDATE 
		[Role]
	SET
		[Name] = @Name,
		[Description] = @Description,
		[OrganisationId] = @OrganisationId,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
	WHERE 
		[Id] = @Id


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_RoleRights_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_RoleRights_Delete]
(
	@RoleId int,
	@Type int
)
AS
	--SET NOCOUNT ON

		DELETE
		FROM 
			[RoleRights] 
		WHERE
			[RoleId] = @RoleId and
			[ScreenId] in (select Id from [Screen] where  IsDeleted = 0 )


	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_RoleRights_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_RoleRights_Insert]
(
	@RoleRightsId int = NULL OUTPUT,
	@RoleId int = NULL,
	@ScreenId int = NULL
)
AS
	--SET NOCOUNT ON

	INSERT INTO [RoleRights]
	(
		[RoleId],
		[ScreenId]
	)
	VALUES
	(
		@RoleId,
		@ScreenId
	)

--	SELECT @RoleRightsId = SCOPE_IDENTITY();

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_RoleRights_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_tbl_RoleRights_Select] 2,1
CREATE PROCEDURE [dbo].[usp_tbl_RoleRights_Select]
(
	@RoleId int,
	@Type int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*
	FROM   
		[RoleRights]
	WHERE  
		[RoleId] = @RoleId and
		[ScreenId] in (Select Id from [Screen] where  IsDeleted = 0)

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_RoleRights_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_RoleRights_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[RoleRightsId],		[RoleId],		[ScreenId]
	FROM   
		[RoleRights]
	
	
	

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_RoleRights_SelectAll_ForAuthorization]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_tbl_RoleRights_SelectAll_ForAuthorization] 4
CREATE PROCEDURE [dbo].[usp_tbl_RoleRights_SelectAll_ForAuthorization]
(
	@RoleId int
)
AS
BEGIN

select  
	RT.RoleId,RSM.ScreenName,RSM.DisplayName
from 
	RoleRights RT,Screen RSM
where
	RSM.Id = RT.ScreenId and
	RT.RoleId = @RoleId and
	RSM.IsDeleted = 0 
END



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_RoleRights_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_RoleRights_Update]
(
	@RoleRightsId int,
	@RoleId int = NULL,
	@ScreenId int = NULL
)
AS
	--SET NOCOUNT ON
	UPDATE 
		[RoleRights]
	SET
		[RoleId] = @RoleId,
		[ScreenId] = @ScreenId
	WHERE 
		[RoleRightsId] = @RoleRightsId


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Route_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_Route_SelectAll]
AS

select RouteNo from CIPRoutes where IsDeleted=0;

GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Routes_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	
	Update 
		CIPRoutes
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id and 
		IsDeleted = 0

	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_tbl_Routes_Insert] 12,'',1,'',1,''
CREATE PROCEDURE [dbo].[usp_tbl_Routes_Insert]
(
	@RouteNo varchar(50),
	@RouteName nvarchar(500),
	@PLCValue real,
	@Description nvarchar(MAX) = NULL,
	@CreatedBy int,
	@CreatedDate datetime
)
AS
	--SET NOCOUNT ON
	Declare @Routescount int
	Declare @status int
	set @Routescount = (Select COUNT(id) from CIPRoutes where RouteNo = @RouteNo and IsDeleted = 0)
	
	if(@Routescount =0)
	begin
		INSERT INTO CIPRoutes
		(
			[RouteNo],
			[RouteName],
			[PLCValue],
			[Description],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@RouteNo,
			@RouteName,
			@PLCValue,
			@Description,
			0,
			@CreatedBy,
			@CreatedDate
		)
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin
		Set @Status = 0
		Select @Status as Status
	end
	

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Routes_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[RouteNo],		[RouteName],		[PLCValue],		[Description],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		CIPRoutes
	WHERE  
		[Id] = @Id

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Routes_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[RouteNo],		[RouteName],		[PLCValue],		[Description],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	Into
		#temp
	FROM   
		CIPRoutes
	WHERE  
		[IsDeleted] = 0


	select 
		* 
	from
	(
		select	* from #temp
		Union all
		select
			0,'','--Select--',0,'',0,0,'',0,''
	) t order by Id ASC


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_SelectAll_For_Dropdown]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_tbl_Routes_SelectAll_For_Dropdown]
	
AS


select PLCValue,RouteName from CIPRoutes where IsDeleted=0

GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_SelectAll_LabReport]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_tbl_Routes_SelectAll_LabReport]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[Id],		[RouteNo],		[RouteName],		[PLCValue],		[Description],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[Vehicle]
	WHERE
		IsDeleted = 0
		



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Routes_Update]
(
	@Id int,
	@RouteNo varchar(50),
	@RouteName nvarchar(500),
	@PLCValue real,
	@Description nvarchar(MAX) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	Declare @Routescount int
	Declare @status int
	set @Routescount = (Select COUNT(id) from CIPRoutes where Id != @Id and RouteNo = @RouteNo and IsDeleted = 0)
	
	if(@Routescount =0)
	begin
		UPDATE 
			CIPRoutes
		SET
			[RouteNo] = @RouteNo,
			[RouteName] = @RouteName,
			[PLCValue] = @PLCValue,
			[Description] = @Description,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[Id] = @Id
		Set @Status = 1
		Select @Status as Status
	end
	else
	begin 
		Set @Status = 0
		Select @Status as Status
	end


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Routes_ValidateName]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Routes_ValidateName]
(
	@RoutesId int,
	@Name varchar(MAX)
)
AS
	--SET NOCOUNT ON
	
	if(@RoutesId=-1)
	Begin
		Select 
			*
		From 
			CIPRoutes
		Where 
			RouteName = @Name And
			IsDeleted = 0
	End
	Else
	Begin
		Select 
			*
		From 
			CIPRoutes
		Where 
			RouteName = @Name And
			IsDeleted = 0 And
			[Id] = @RoutesId
	End

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Screen_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [usp_tbl_Screen_SelectAll] 2
CREATE PROCEDURE [dbo].[usp_tbl_Screen_SelectAll]
(
	@Type int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		Id,DisplayName
	FROM   
		[Screen]
	
	WHERE
		IsDeleted = 0 
	

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Shift_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Shift_Delete]
(
	@ShiftId int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Shift]
	--WHERE
	--		[ShiftId] = @ShiftId

	Update 
		[Shift]
	SET
		IsDeleted = 1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[ShiftId] = @ShiftId

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Shift_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Shift_Insert]
(
	@ShiftId int = NULL OUTPUT,
	@Name nvarchar(50) = NULL,
	@FromTime varchar(50) = NULL,
	@ToTime varchar(50) = NULL,
	@IsDeleted int = NULL,
	@CreatedDate datetime = NULL,
	@CreatedBy int = NULL
)
AS
	--SET NOCOUNT ON
	Declare @ShiftCount int = (Select COUNT(*) from Shift where Name = @Name and IsDeleted = 0)
	Declare @Status int
	
	If(@ShiftCount = 0)
	Begin
		INSERT INTO [Shift]
		(
			[Name],
			[FromTime],
			[ToTime],
			[IsDeleted],
			[CreatedDate],
			[CreatedBy]
		)
		VALUES
		(
			@Name,
			Convert(time, @FromTime),
			Convert(time, @ToTime),
			0,
			@CreatedDate,
			@CreatedBy
		)
		
		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End
--	SELECT @ShiftId = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Shift_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Shift_Select]
(
	@ShiftId int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[ShiftId],		[Name],		[FromTime],		[ToTime],		[IsDeleted],		[LastModifiedBy],		[LastModifiedDate],		[CreatedDate],		[CreatedBy]
	FROM   
		[Shift]
	WHERE  
		[ShiftId] = @ShiftId
		and IsDeleted = 0

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Shift_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_Shift_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[ShiftId],		[Name],		[FromTime],		[ToTime],		[PLCValue],		[IsDeleted],		[LastModifiedBy],		[LastModifiedDate],		[CreatedDate],		[CreatedBy]
	FROM   
		[Shift]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Shift_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Shift_Update]
(
	@ShiftId int,
	@Name nvarchar(50) = NULL,
	@FromTime varchar(50) = NULL,
	@ToTime varchar(50) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	Declare @ShiftCount int = (Select COUNT(*) from Shift where Name = @Name and IsDeleted = 0 and ShiftId != @ShiftId)
	Declare @Status int
	
	If(@ShiftCount = 0)
	Begin
		UPDATE 
			[Shift]
		SET
			[Name] = @Name,
			[FromTime] = Convert(time, @FromTime),
			[ToTime] =  Convert(time, @ToTime),
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[ShiftId] = @ShiftId
		
		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End


	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_SILO_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_SILO_Delete]
(
	@SILOID int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [SILO]
	--WHERE
	--		[SILOID] = @SILOID

	Update 
		[SILO]
	SET
		IsDeleted = 1,
		LastModifiedBy = @LastModifiedBy,
		LastModifiedDate = @LastModifiedDate
	WHERE
		[SILOID] = @SILOID

	
--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_SILO_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_SILO_Insert]
(
	@SILOID int = NULL OUTPUT,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@IsDeleted int = NULL,
	@CreatedBy int = NULL,
	@CreatedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @SILOCount int = (Select COUNT(*) from SILO where PLCValue = @PLCValue and IsDeleted = 0)
	Declare @Status int
	
	If(@SILOCount = 0)
	Begin
		INSERT INTO [SILO]
		(
			[Name],
			[PLCValue],
			[IsDeleted],
			[CreatedBy],
			[CreatedDate]
		)
		VALUES
		(
			@Name,
			@PLCValue,
			0,
			@CreatedBy,
			@CreatedDate
		)
		
		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End

--	SELECT @SILOID = SCOPE_IDENTITY();

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_SILO_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_SILO_Select]
(
	@SILOID int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[SILOID],		[Name],		[SILONo],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[SILO]
	WHERE  
		[SILOID] = @SILOID
		and IsDeleted = 0

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_SILO_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_SILO_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[SILOID],		[Name],		[SILONo],		[PLCValue],		[IsDeleted],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate]
	FROM   
		[SILO]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_SILO_SelectAll_MilkAnalysis]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_SILO_SelectAll_MilkAnalysis]

AS
	--SET NOCOUNT ON
	
	SELECT 
		[SILOID] as Id,		[Name]
	FROM   
		[SILO]
	
	WHERE
		IsDeleted = 0
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_SILO_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_SILO_Update]
(
	@SILOID int,
	@Name nvarchar(50) = NULL,
	@PLCValue real = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	Declare @SILOCount int = (Select COUNT(*) from SILO where PLCValue = @PLCValue and IsDeleted = 0 and SILOID != @SILOID)
	Declare @Status int
	
	If(@SILOCount = 0)
	Begin
		UPDATE 
			[SILO]
		SET
			[Name] = @Name,
			[PLCValue] = @PLCValue,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[SILOID] = @SILOID
	
		Set @Status = 1
		Select @Status as [Status]
	End
	Else
	Begin
		Set @Status = 0
		Select @Status as [Status]
	End


	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Supplier_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Supplier_Delete]
(
	@SupplierId int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Supplier]
	--WHERE
	--		[SupplierId] = @SupplierId

	Update 
		[Supplier]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[SupplierId] = @SupplierId

	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Supplier_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Supplier_Insert]
(
	@SupplierCode varchar(50) = NULL,
	@SupplierName varchar(100) = NULL,
	@Location varchar(50) = NULL,
	@Address varchar(500) = NULL,
	@City varchar(50) = NULL,
	@District varchar(50) = NULL,
	@State varchar(50) = NULL,
	@Country varchar(50) = NULL,
	@Phone varchar(50) = NULL,
	@Email varchar(50) = NULL,
	@Fax varchar(50) = NULL,
	@CSTNo varchar(50) = NULL,
	@SSTNo varchar(50) = NULL,
	@Date varchar(50) = null,
	@SSTDate varchar(50) = NULL,
	@AcNo varchar(50) = NULL,
	@Remarks varchar(MAX) = NULL,
	@ContactPerson1 varchar(50) = null,
	@ContactPerson2 varchar(50) = null,
	@CreatedBy int = NULL,
	@CreatedDate varchar(50) = NULL,
	@LastModifiedBy varchar(50) = NULL,
	@LastModifiedDate varchar(50) = NULL,
	@IsDeleted int = NULL
)
AS
	--SET NOCOUNT ON

	INSERT INTO [Supplier]
	(
	
		[SupplierCode],
		[SupplierName],
		[Location],
		[Address],
		[City],
		[District],
		[State],
		[Country],
		[Phone],
		[Email],
		[Fax],
		[CSTNo],
		[SSTNo],
		[Date],
		[SSTDate],
		[AcNo],
		[Remarks],
		[ContactPerson1],
		[ContactPerson2],
		[CreatedBy],
		[CreatedDate],
		[LastModifiedBy],
		[LastModifiedDate],
		[IsDeleted]
	)
	VALUES
	(
		
		@SupplierCode,
		@SupplierName,
		@Location,
		@Address,
		@City,
		@District,
		@State,
		@Country,
		@Phone,
		@Email,
		@Fax,
		@CSTNo,
		@SSTNo,
		@Date,
		@SSTDate,
		@AcNo,
		@Remarks,
		@ContactPerson1,
		@ContactPerson2,
		@CreatedBy,
		@CreatedDate,
		@LastModifiedBy,
		@LastModifiedDate,
		@IsDeleted
	)


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Supplier_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Supplier_Select]
(
	@SupplierId int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[SupplierId],		[SupplierCode],		[SupplierName],		[Address],		[City],		[District],		[State],		[Phone],		[Email],		[Fax],		[CSTNo],		[SSTNo],		[SSTDate],		[AcNo],		[Remarks],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate],		[IsDeleted]
	FROM   
		[Supplier]
	WHERE  
		[SupplierId] = @SupplierId

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Supplier_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Supplier_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
				[SupplierId],[SupplierName]+' - '+convert(Varchar(10),	[SupplierCode])	 as SupplierName,	[Location],	[Address],		[City],		[District],		[State],		[Phone],		[Email],		[Fax],		[CSTNo],		[SSTNo],	[Date]	,[SSTDate],		[AcNo],		[Remarks],[ContactPerson1] , [ContactPerson2],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate],		[IsDeleted]
	into
		#temp
	FROM   
		[Supplier]
	
	WHERE
		IsDeleted = 0
	Select 
		* 
	from 
	(
		Select * from #temp
		Union all
		select 
			0,'--Select--','','','','','','','','','','','','','','','','',0,'',0,'',0
	)t order by SupplierId ASC



	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Supplier_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Supplier_Update]
(
	@SupplierId int,
	@SupplierCode varchar(50) = NULL,
	@SupplierName varchar(100) = NULL,
	@Address varchar(500) = NULL,
	@City varchar(50) = NULL,
	@District varchar(50) = NULL,
	@State varchar(50) = NULL,
	@Phone varchar(50) = NULL,
	@Email varchar(50) = NULL,
	@Fax varchar(50) = NULL,
	@CSTNo varchar(50) = NULL,
	@SSTNo varchar(50) = NULL,
	@SSTDate varchar(50) = NULL,
	@AcNo varchar(50) = NULL,
	@Remarks varchar(MAX) = NULL,
	@CreatedBy int = NULL,
	@CreatedDate varchar(50) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL,
	@IsDeleted int = NULL,
	@ContactPerson1 varchar(50) = null,
	@ContactPerson2 varchar(50) = null,
	@Country varchar(50) = null,
	@Date varchar(50) = null,
	@Location varchar(50) = null

)
AS
	--SET NOCOUNT ON
	Declare @SupplierCount int
	set @SupplierCount = (select COUNT(SupplierCode) from Supplier where SupplierCode = @SupplierCode and SupplierId != @SupplierId)
	If(@SupplierCount = 0)

	Begin

	UPDATE 
		[Supplier]
	SET
		[SupplierCode] = @SupplierCode,
		[SupplierName] = @SupplierName,
		[Address] = @Address,
		[City] = @City,
		[District] = @District,
		[State] = @State,
		[Phone] = @Phone,
		[Email] = @Email,
		[Fax] = @Fax,
		[CSTNo] = @CSTNo,
		[SSTNo] = @SSTNo,
		[SSTDate] = @SSTDate,
		[AcNo] = @AcNo,
		[Remarks] = @Remarks,
		[CreatedBy] = @CreatedBy,
		[CreatedDate] = @CreatedDate,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate,
		[IsDeleted] = @IsDeleted,
		[ContactPerson1] = @ContactPerson1,
		[ContactPerson2] = @ContactPerson2,
		[Country] =@Country,
		[Date] = @Date,
		[Location] =@Location
	WHERE 
		[SupplierId] = @SupplierId

End
	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Supplier_ValidateName]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Supplier_ValidateName]
(
	@SupplierId int,
	@SupplierCode varchar(MAX)
)
AS
	--SET NOCOUNT ON
	
	if(@SupplierId=-1)
	Begin
		Select 
			*
		From 
			[Supplier]
		Where 
			SupplierCode = @SupplierCode And
			IsDeleted = 0
	End
	Else
	Begin
		Select 
			*
		From 
			[Supplier]
		Where 
			SupplierCode = @SupplierCode And
			IsDeleted = 0 And
			[SupplierId] = @SupplierId
	End

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Terminal_M_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Terminal_M_Select]
(
	@TerminalId int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[TerminalId],		[TerminalName],		[Inlet],		[Outlet]
	FROM   
		[Terminal_M]
	WHERE  
		[TerminalId] = @TerminalId

	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Terminal_M_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_Terminal_M_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		*--		[TerminalId],		[TerminalName],		[Inlet],		[Outlet]
		INTO
		#temp
	FROM   
		[Terminal_M]
	
	Select 
		* 
	from 
	(
		Select * from #temp
		Union all
		select 
			0,'--Select--','',''
	)t order by TerminalId ASC


	--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_Transfer_Dispatch_PLC_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_Transfer_Dispatch_PLC_SelectAll]

AS
	--SET NOCOUNT ON
	
	SELECT 
		Distinct(Tanker_ID) as Tanker_ID--		[Id],		[DateTime],		[Ch_Temp],		[DEST],		[Line_No],		[Product_Type],		[SRC],		[Start_Trig],		[Tanker_ID],		[Transfer_Qty],		[WB_Qty]
	FROM   
		[Transfer_Dispatch_PLC] 
	
	

	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_Delete]
(
	@WeighBridgeId int,
	@LastModifiedBy int,
	@LastModifiedDate varchar(50)
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [WeighBridge]
	--WHERE
	--		[WeighBridgeId] = @WeighBridgeId

	Update 
		[WeighBridge]
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[WeighBridgeId] = @WeighBridgeId

	
--RETURN @@Error



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [dbo].[usp_tbl_WeighBridge_Insert] 1,2,3
CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_Insert]
(
	@WeighBridgeId int = NULL OUTPUT,
	@TerminalId int = NULL,
	@VehicleId int = NULL,
	@ContractorId int = NULL,
	@ChallanNo varchar(50) = NULL,
	@Destination varchar(50) = NULL,
	@Purpose varchar(50) = NULL,
	@SupplierId int = NULL,
	@ProductGroupId int = NULL,
	@ProductId int = NULL,
	@RouteId int = NULL,
	@WeighMode varchar(20) = NULL,
	@TareWeight varchar(50) = NULL,
	@GrossWeight varchar(50) = NULL,
	@NetWeight varchar(50) = NULL,
	@TWTDate varchar(50) = NULL,
	@GWTDate varchar(50) = NULL,
	@TWTTime varchar(50) = NULL,
	@GWTTime varchar(50) = NULL,
	@CIPStatus varchar(50) = NULL,
	@CreatedBy int = NULL,
	@CreatedDate varchar(50) = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL,
	@IsDeleted int = NULL,
	@WeighType int = NULL,
	@Type int = NULL,
	@VehicleNumber varchar(50) = NULL,
	@DriverName varchar(50) = NULL,
	@ConductorName varchar(50) = NULL,
	@RouteNo varchar(20) = Null
)
AS
	--SET NOCOUNT ON
	
	If(@VehicleId=-1)
	Begin
		Insert INTO [Vehicle]
		(
			[VehicleNumber],
			[VehicleType],
			[ContractorCode],
			[DriverName],
			[ConductorName],
			[Compartments],
			[CreatedBy],
			[CreatedDate],
			[IsDeleted],
			[RouteNo]
		)
		Values
		(
			@VehicleNumber,
			'Tanker',
			0,
			@DriverName,
			@ConductorName,
			1,
			@CreatedBy,
			@CreatedDate,
			0,
			@RouteNo
		)
		set @VehicleId = (Select @@IDENTITY)
	End
	Else
	Begin
		Update
			[Vehicle]
		Set
			[DriverName] = @DriverName,
			[ConductorName] = @ConductorName,
			[LastModifiedBy] = @CreatedBy,
			[LastModifiedDate] = @CreatedDate
		Where
			[VehicleId] = @VehicleId
	End
	
	INSERT INTO [WeighBridge]
	(
		[TerminalId],
		[VehicleId],
		[ContractorId],
		[ChallanNo],
		[Destination],
		[Purpose],
		[SupplierId],
		[ProductGroupId],
		[ProductId],
		[RouteId],
		[WeighMode],
		[TareWeight],
		[GrossWeight],
		[NetWeight],
		[TWTDate],
		[GWTDate],
		[TWTTime],
		[GWTTime],
		[CIPStatus],
		[CreatedBy],
		[CreatedDate],
		[LastModifiedBy],
		[LastModifiedDate],
		[IsDeleted],
		[WeighType],
		[Type]
	)
	VALUES
	(
		@TerminalId,
		@VehicleId,
		@ContractorId,
		@ChallanNo,
		@Destination,
		@Purpose,
		@SupplierId,
		@ProductGroupId,
		@ProductId,
		@RouteId,
		@WeighMode,
		@TareWeight,
		@GrossWeight,
		@NetWeight,
		@TWTDate,
		@GWTDate,
		@TWTTime,
		@GWTTime,
		@CIPStatus,
		@CreatedBy,
		@CreatedDate,
		@LastModifiedBy,
		@LastModifiedDate,
		@IsDeleted,
		@WeighType,
		@Type
	)

Select @@Identity as WeighbridgeId

	--RETURN @WeighBridgeId






GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec [dbo].[usp_tbl_WeighBridge_Select] 5
CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_Select]
(
	@WeighBridgeId int
)
AS
	--SET NOCOUNT ON
	
	--SELECT 
	--	WB.*,VM.VehicleNumber ,RM.RouteName,SM.SupplierName ,CM.ContractorName,VM.DriverName,VM.ConductorName    --[WeighBridgeId],		[TerminalId],		[VehicleId],		[ContractorId],		[ChallanNo],		[Destination],		[Purpose],		[SupplierId],		[ProductGroupId],		[ProductId],		[RouteId],		[WeighMode],		[TareWeight],		[GrossWeight],		[NetWeight],		[TWTDate],		[GWTDate],		[TWTTime],		[GWTTime],		[CIPStatus],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate],		[IsDeleted]
	--FROM   
	--	[WeighBridge] WB
	--Inner Join [Vehicle] VM on VM.VehicleId = WB.VehicleId
	--Inner Join [Routes] RM on RM.Id=WB.RouteId
	--Inner JOin [Supplier] SM on SM.SupplierId=WB.SupplierId
	--Inner Join [Contractor] CM on CM.ContractorId=WB.ContractorId
	--WHERE  
	--	[WeighBridgeId] = @WeighBridgeId
	
	select 
		*
	From 
		[WeighBridge] WB Inner join [Vehicle] V
			on WB.VehicleId = V.VehicleId
	where
		WB.IsDeleted = 0 and
		V.IsDeleted = 0 and
		WB.WeighBridgeId = @WeighBridgeId

	--RETURN @@Error







GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_Select_ForPrint1]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec usp_tbl_WeighBridge_Select_ForPrint1  10,1

CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_Select_ForPrint1] 
(
	@WeighBridgeId int,
	@PrintType int
)
AS
	--SET NOCOUNT ON
	if(@PrintType = 1 or @PrintType = 2)

Begin

	SELECT 
		WB.VehicleId,
		WB.WeighMode,
		WB.Purpose,
		convert(varchar(20),WB.GWTDate) as GWTDate,
		convert(varchar(20),WB.GWTTime) as GWTTime,
		convert(varchar(20),WB.TWTDate) as TWTDate,
		convert(varchar(20),WB.TWTTime) as TWTTime,
		WB.GrossWeight,
		WB.TareWeight,
		WB.NetWeight,
		VM.VehicleNumber,
		VM.VehicleCode,
		RM.RouteName,
		'--' as SupplierName,
		'--' as ContractorName,
		VM.DriverName,
		VM.ConductorName,
		PM.ProductName ,
		VM.Capacity,
		convert(varchar(20),WB.GWTDate,103),
		round(((WB.NetWeight/VM.Capacity)*100),2) as Utilization  
	FROM   
			   [WeighBridge] WB
	Inner Join [Vehicle] VM on VM.VehicleId = WB.VehicleId
	Inner Join [Routes] RM on RM.Id=WB.RouteId
	--Inner JOin [Supplier] SM on SM.SupplierId=WB.SupplierId
	--Inner Join [Contractor] CM on CM.ContractorId=WB.ContractorId
	Inner Join [Product] PM on PM.ProductId = WB.ProductId
	WHERE  
		[WeighBridgeId] = @WeighBridgeId
End





GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_SelectAll]

AS
	--SET NOCOUNT ON
	
	--SELECT 
	--	*
	--FROM   
	--	[WeighBridge]
	
	--WHERE
	--	WeighType != 0 and
	--	IsDeleted = 0
	
	SELECT 
		WB.*,VM.VehicleNumber,RM.RouteName--		[WeighBridgeId],		[TerminalId],		[VehicleId],		[ContractorId],		[ChallanNo],		[Destination],		[Purpose],		[SupplierId],		[ProductGroupId],		[ProductId],		[RouteId],		[WeighMode],		[TareWeight],		[GrossWeight],		[NetWeight],		[TWTDate],		[GWTDate],		[TWTTime],		[GWTTime],		[CIPStatus],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate],		[IsDeleted]
	FROM   
		[WeighBridge] WB
	Inner Join [Vehicle] VM on VM.VehicleId = WB.VehicleId
	Inner Join [Routes] RM on RM.Id=WB.RouteId
	
	WHERE
		WB.WeighType != 0 and
		WB.IsDeleted = 0
	order by CreatedDate desc
	--RETURN @@Error







GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_SelectAll_ByDate]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_SelectAll_ByDate]
	
AS

	SELECT 
		WB.*,VM.VehicleNumber,RM.RouteName,SM.SupplierName--		[WeighBridgeId],		[TerminalId],		[VehicleId],		[ContractorId],		[ChallanNo],		[Destination],		[Purpose],		[SupplierId],		[ProductGroupId],		[ProductId],		[RouteId],		[WeighMode],		[TareWeight],		[GrossWeight],		[NetWeight],		[TWTDate],		[GWTDate],		[TWTTime],		[GWTTime],		[CIPStatus],		[CreatedBy],		[CreatedDate],		[LastModifiedBy],		[LastModifiedDate],		[IsDeleted]
	FROM   
		[WeighBridge] WB
	Inner Join [Vehicle] VM on VM.VehicleId = WB.VehicleId
	Inner Join [Routes] RM on RM.Id=WB.RouteId
	Inner JOin [Supplier] SM on SM.SupplierId=WB.SupplierId
	
	WHERE
		WB.IsDeleted = 0 And
		Convert(date,TWTDate,103) = CONVERT (date, GETDATE(),103)
	order by CreatedDate desc



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_SelectAll_For_TankerUtilization_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec usp_tbl_WeighBridge_SelectAll_For_TankerUtilization_Report 'GJ6CQ1991','Loading','21/12/2015','31/12/2015'

CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_SelectAll_For_TankerUtilization_Report]
	
	@VehicleNo varchar(50),
	@Purpose varchar(50),
	@FromDate varchar(50),
	@ToDate varchar(50)
AS
	--SET NOCOUNT ON;

    --Insert statements for procedure here
	SELECT 
		WB.*,
		VM.VehicleNumber,
		VM.VehicleCode,
		RM.RouteName,
		SM.SupplierName,
		--CM.ContractorName,
		VM.DriverName,
		VM.ConductorName,
		PM.ProductName ,
		VM.Capacity,
		convert(varchar(20),WB.GWTDate,103),
		(WB.NetWeight/VM.Capacity*100) as 'Utilization(%)'  
	FROM   
		 [WeighBridge] WB
	Inner Join [Vehicle] VM on VM.VehicleId = WB.VehicleId
	Inner Join [Routes] RM on RM.Id=WB.RouteId
	Inner Join [Supplier] SM on SM.SupplierId=WB.SupplierId
	--Inner Join [Contractor] CM on CM.ContractorId=WB.ContractorId
	Inner Join [Product] PM on PM.ProductId = WB.ProductId
	WHERE  
		VM.VehicleNumber = @VehicleNo And
		Wb.Purpose = @Purpose and
		--WB.NetWeight != null 
		WB.IsDeleted = 0 and
		VM.IsDeleted = 0 and
		RM.IsDeleted = 0 and
		SM.IsDeleted = 0 and
		PM.IsDeleted = 0 and
	convert(date,WB.GWTDate,103) Between convert(date,@FromDate,103) and convert(date,@ToDate,103)



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_SelectAll_For_WaitingTanker_Report]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
---- =============================================
-- exec usp_tbl_WeighBridge_SelectAll_For_WaitingTanker_Report 'Loading','BANAS-I'

CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_SelectAll_For_WaitingTanker_Report]
	-- Add the parameters for the stored procedure here
		@Purpose varchar(50),
		@Location varchar(50)
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare  @DateIn DateTime = null 
	 
	 --set @DateIn = select 

	SELECT 
		WB.Purpose,
		WB.GrossWeight,
		WB.TareWeight,
		VM.VehicleNumber,
		VM.VehicleCode,		
		VM.DriverName,
		VM.ConductorName,
	    case when @Purpose = 'Unloading' then WB.GWTDate +'  '+ WB.GWTTime else WB.TWTDate+'  '+WB.TWTTime End as DateIn
	FROM   
			   [WeighBridge] WB
	Inner Join [Vehicle] VM on VM.VehicleId = WB.VehicleId
	Inner Join [Routes] RM on RM.Id=WB.RouteId
	Inner Join [Supplier] SM on SM.SupplierId=WB.SupplierId
	Inner Join [Contractor] CM on CM.ContractorId=WB.ContractorId
	Inner Join [Product] PM on PM.ProductId = WB.ProductId
	WHERE  
		WB.Destination = @Location And
		Wb.Purpose = @Purpose



GO
/****** Object:  StoredProcedure [dbo].[usp_tbl_WeighBridge_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_tbl_WeighBridge_Update]
(
	@WeighBridgeId int,
	@TareWeight varchar(50) = NULL,
	@GrossWeight varchar(50) = NULL,
	@NetWeight varchar(50) = NULL,
	@TWTDate varchar(50) = NULL,
	@GWTDate varchar(50) = NULL,
	@TWTTime varchar(50) = NULL,
	@GWTTime varchar(50) = NULL,
	@WeighType int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate varchar(50) = NULL
)
AS
	--SET NOCOUNT ON
	if(@WeighType = 1)
	Begin
		UPDATE 
			[WeighBridge]
		SET
			[TWTDate] = @TWTDate,
			[TWTTime] = @TWTTime,
			[TareWeight] = @TareWeight,
			[NetWeight] = @NetWeight,
			[WeighType] = 0,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[WeighBridgeId] = @WeighBridgeId
	end
	else
	begin
		UPDATE 
			[WeighBridge]
		SET
			[GWTDate] = @GWTDate,
			[GWTTime] = @GWTTime,
			[GrossWeight] = @GrossWeight,
			[NetWeight] = @NetWeight,
			[WeighType] = 0,
			[LastModifiedBy] = @LastModifiedBy,
			[LastModifiedDate] = @LastModifiedDate
		WHERE 
			[WeighBridgeId] = @WeighBridgeId
	end


	--RETURN @@Error






GO
/****** Object:  StoredProcedure [dbo].[usp_Type_MaintainanceType_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Type_MaintainanceType_Select]
(
	@DepartMentId int
)
AS
	--SET NOCOUNT ON
	
	Select Id,Name from MaintenanceType where DepartMentId = @DepartMentId and IsDeleted = 0
	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_WheyAnalysis_Delete]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_WheyAnalysis_Delete]
(
	@Id int,
	@LastModifiedBy int,
	@LastModifiedDate datetime
)
AS
	--SET NOCOUNT ON

	--DELETE
	--FROM [Maintainance]
	--WHERE
	--

	Update 
		WheyAnalysis
	SET
		IsDeleted=1,
		LastModifiedBy=@LastModifiedBy,
		LastModifiedDate=@LastModifiedDate
	WHERE
		[Id] = @Id and 
		IsDeleted = 0




GO
/****** Object:  StoredProcedure [dbo].[usp_WheyAnalysis_Insert]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_WheyAnalysis_Insert]
(
	@Id int,
	@Date nvarchar(50) = NULL,
	@SampleName nvarchar(50) = NULL,
	@SampleNo nvarchar(50) = NULL,
	@ProductName nvarchar(50) = NULL,
	@OT nvarchar(50) = NULL,
	@Temp nvarchar(50) = NULL,
    @Fat nvarchar(50) = NULL,
	@SNF nvarchar(50) = NULL,
	@Acidity nvarchar(50) = NULL,
	@COB nvarchar(50) = NULL,
	@AlcholTest65 nvarchar(50) = NULL,
	@AlcholTest nvarchar(50) = NULL,
	@Blactumantibiotictest nvarchar(50) = NULL,
	@MineralOilTest nvarchar(50) = NULL,
	@AnyOtherTest01 nvarchar(50) = NULL,
	@AnyOtherTest02 nvarchar(50) = NULL,
	@AnyOtherTest03 nvarchar(50) = NULL,
	@AnyOtherTest04 nvarchar(50) = NULL,
	@Neutrilize nvarchar(50) = NULL,
	@Urea nvarchar(50) = NULL,
	@Salt nvarchar(50) = NULL,
	@Startch nvarchar(50) = NULL,
	@FPD nvarchar(50) = NULL,
	@Status nvarchar(50) = NULL,
	@Remarks nvarchar(max) = NULL,
	@CreatedBy int = NULL,
	@IsDeleted bit,
	@CreatedDate datetime = NULL

)
AS
	--SET NOCOUNT ON

	INSERT INTO [WheyAnalysis]
	(
		[DateTime],	
        SampleName,	
        SampleNo,	
        ProductName,	
        OT,	
       Temp,	
       Fat,	
       SNF,	
       Acidity,	
       COB,	
      AlcholTest65,	
      AlcholTest,	
      Blactumantibiotictest	,
      MineralOilTest,	
      AnyOtherTest01,	
      AnyOtherTest02,	
      AnyOtherTest03,	
      AnyOtherTest04,	
      Neutrilize	,
      Urea	,
      Salt	,
     Startch,	
     FPD	,
     Status	,
      Remarks,	
		[CreatedBy],
	    [IsDeleted],
		[CreatedDate]




	)
	VALUES
	(	
		@Date ,
	@SampleName, 
	@SampleNo, 
	@ProductName,
	@OT ,
	@Temp ,
    @Fat, 
	@SNF ,
	@Acidity ,
	@COB,
	@AlcholTest65, 
	@AlcholTest, 
	@Blactumantibiotictest ,
	@MineralOilTest, 
	@AnyOtherTest01, 
	@AnyOtherTest02, 
	@AnyOtherTest03, 
	@AnyOtherTest04 ,
	@Neutrilize ,
	@Urea ,
	@Salt ,
	@Startch, 
	@FPD, 
	@Status ,
	@Remarks,
	@CreatedBy,
	@IsDeleted, 
	@CreatedDate 
	)

--	SELECT @Id = SCOPE_IDENTITY();

	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_WheyAnalysis_Select]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_WheyAnalysis_Select]
(
	@Id int
)
AS
	--SET NOCOUNT ON
	
	SELECT 
	*
		FROM   
			WheyAnalysis M 
			where
	Id = @Id
	
	--RETURN @@Error





GO
/****** Object:  StoredProcedure [dbo].[usp_WheyAnalysis_SelectAll]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_WheyAnalysis_SelectAll]

AS
	--SET NOCOUNT ON
	
	select * from WheyAnalysis
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_WheyAnalysis_SelectAll_Details]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_WheyAnalysis_SelectAll_Details]
@FromDate datetime,
@ToDate datetime
AS
	--SET NOCOUNT ON
	
	select  
	ROW_NUMBER() over (order by [DateTime]) as 'SrNo',
	  convert(varchar(20),[DateTime],103)Date,
	convert(varchar(8),[DateTime],109) Time,
	SampleName,
	SampleNo,
	ProductName,
	OT,
	Temp,
	Fat,
	SNF,
	Acidity,
	COB,
	AlcholTest65,
	AlcholTest,
	Blactumantibiotictest,
	MineralOilTest,
	AnyOtherTest01,
	AnyOtherTest02,
	AnyOtherTest03,
	AnyOtherTest04,
	Neutrilize,
	Urea,
	Salt,
	Startch,
	FPD,
	Status,
	Remarks

	 from WheyAnalysis
	WHERE
		IsDeleted = 0
	--RETURN @@Error




GO
/****** Object:  StoredProcedure [dbo].[usp_WheyAnalysis_Update]    Script Date: 1/28/2022 11:05:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_WheyAnalysis_Update]
(
	@Id int,
	@Date nvarchar(50) = NULL,
	@SampleName nvarchar(50) = NULL,
	@SampleNo nvarchar(50) = NULL,
	@ProductName nvarchar(50) = NULL,
	@OT nvarchar(50) = NULL,
	@Temp nvarchar(50) = NULL,
    @Fat nvarchar(50) = NULL,
	@SNF nvarchar(50) = NULL,
	@Acidity nvarchar(50) = NULL,
	@COB nvarchar(50) = NULL,
	@AlcholTest65 nvarchar(50) = NULL,
	@AlcholTest nvarchar(50) = NULL,
	@Blactumantibiotictest nvarchar(50) = NULL,
	@MineralOilTest nvarchar(50) = NULL,
	@AnyOtherTest01 nvarchar(50) = NULL,
	@AnyOtherTest02 nvarchar(50) = NULL,
	@AnyOtherTest03 nvarchar(50) = NULL,
	@AnyOtherTest04 nvarchar(50) = NULL,
	@Neutrilize nvarchar(50) = NULL,
	@Urea nvarchar(50) = NULL,
	@Salt nvarchar(50) = NULL,
	@Startch nvarchar(50) = NULL,
	@FPD nvarchar(50) = NULL,
	@Status nvarchar(50) = NULL,
	@Remarks nvarchar(max) = NULL,
	@CreatedBy int = NULL,
	@LastModifiedBy int = NULL,
	@LastModifiedDate datetime = NULL
)
AS
	--SET NOCOUNT ON
	
	UPDATE [WheyAnalysis]
	SET


	
		[DateTime] = @Date,
		SampleName = @SampleName,
		SampleNo = @SampleNo,
		ProductName = @ProductName,
		OT = @OT,
		Temp = @Temp,
		Fat=@Fat ,
		SNF = @SNF,
		Acidity = @Acidity,
		COB = @COB,
		AlcholTest65 = @AlcholTest65,
		AlcholTest = @AlcholTest,
		Blactumantibiotictest = @Blactumantibiotictest,
		MineralOilTest = @MineralOilTest,
		AnyOtherTest01 = @AnyOtherTest01,
		AnyOtherTest02 = @AnyOtherTest02,
		AnyOtherTest03 = @AnyOtherTest03,
		AnyOtherTest04 = @AnyOtherTest04,
		Neutrilize = @Neutrilize,
		Urea = @Urea,
		Salt = @Salt,
		Startch = @Startch,
		FPD = @FPD,
		Status = @Status,
		Remarks = @Remarks,
		[LastModifiedBy] = @LastModifiedBy,
		[LastModifiedDate] = @LastModifiedDate
		
	WHERE 
		Id = @Id

	--RETURN @@Error





GO
USE [master]
GO
ALTER DATABASE [GEA-Britania] SET  READ_WRITE 
GO
