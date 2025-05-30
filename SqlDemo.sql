IF DB_ID('Demo') IS NULL
    CREATE DATABASE Demo;
GO
USE Demo
GO
/****** Object:  Table [dbo].[DemoData]    Script Date: 2025/4/19 下午 03:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DemoData](
	[出表日期] [int] NOT NULL,
	[資料年月] [int] NOT NULL,
	[公司代號] [int] NOT NULL,
	[公司名稱] [nvarchar](max) NOT NULL,
	[產業別] [nvarchar](100) NOT NULL,
	[營業收入_當月營收] [int] NULL,
	[營業收入_上月營收] [int] NULL,
	[營業收入_去年當月營收] [int] NULL,
	[營業收入_上月比較增減] [float] NULL,
	[營業收入_去年同月增減] [float] NULL,
	[累計營業收入_當月累計營收] [int] NULL,
	[累計營業收入_去年累計營收] [int] NULL,
	[累計營業收入_前期比較增減] [float] NULL,
	[備註] [nvarchar](100) NULL,
 CONSTRAINT [PK_DemoData_1] PRIMARY KEY CLUSTERED 
(
	[資料年月] ASC,
	[公司代號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertDemoData]    Script Date: 2025/4/19 下午 03:05:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_InsertDemoData]
    @出表日期 INT,
    @資料年月 INT,
    @公司代號 INT,
    @公司名稱 NVARCHAR(MAX),
    @產業別 NVARCHAR(100),
    @營業收入_當月營收 INT,
    @營業收入_上月營收 INT,
    @營業收入_去年當月營收 INT,
    @營業收入_上月比較增減 FLOAT,
    @營業收入_去年同月增減 INT,
    @累計營業收入_當月累計營收 INT,
    @累計營業收入_去年累計營收 INT,
    @累計營業收入_前期比較增減 FLOAT,
    @備註 NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM DemoData
        WHERE 公司代號 = @公司代號 AND 資料年月 = @資料年月
    )
    BEGIN
        RAISERROR('已有相同公司代號與資料年月的資料，請勿重複新增。', 16, 1);
        RETURN;
    END

    INSERT INTO DemoData (
        出表日期, 資料年月, 公司代號, 公司名稱, 產業別,
        營業收入_當月營收, 營業收入_上月營收, 營業收入_去年當月營收,
        營業收入_上月比較增減, 營業收入_去年同月增減,
        累計營業收入_當月累計營收, 累計營業收入_去年累計營收,
        累計營業收入_前期比較增減, 備註
    )
    VALUES (
        @出表日期, @資料年月, @公司代號, @公司名稱, @產業別,
        @營業收入_當月營收, @營業收入_上月營收, @營業收入_去年當月營收,
        @營業收入_上月比較增減, @營業收入_去年同月增減,
        @累計營業收入_當月累計營收, @累計營業收入_去年累計營收,
        @累計營業收入_前期比較增減, @備註
    )
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SelectByCompanyCode]    Script Date: 2025/4/19 下午 03:05:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_SelectByCompanyCode]
    @公司代號 INT
AS
BEGIN
    SELECT *
    FROM DemoData
    WHERE 公司代號 = @公司代號
END
GO
