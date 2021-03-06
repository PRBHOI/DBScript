USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_incident]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incident](
	[IncidentId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentNo] [nvarchar](20) NULL,
	[IncidentTitle] [nvarchar](100) NULL,
	[IncidentDate] [date] NULL,
	[IncidentTime] [datetime] NULL,
	[Location] [int] NULL,
	[InvestigationLevel] [int] NULL,
	[Sector] [int] NULL,
	[IncidentType] [int] NULL,
	[IncidentAt] [int] NULL,
	[Shift] [int] NOT NULL,
	[Activity] [int] NOT NULL,
	[Severity] [int] NOT NULL,
	[Department] [int] NOT NULL,
	[RecurrenceLikelihood] [int] NOT NULL,
	[EquipmentLoss] [numeric](18, 2) NOT NULL,
	[ExactLocation] [nvarchar](500) NOT NULL,
	[BriefDesc] [nvarchar](max) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_incident] PRIMARY KEY CLUSTERED 
(
	[IncidentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
