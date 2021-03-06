USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_investigation]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation](
	[InvestigationId] [int] IDENTITY(1,1) NOT NULL,
	[InvestigationNo] [nvarchar](20) NOT NULL,
	[InvestigationLead] [int] NULL,
	[DocumentType] [int] NULL,
	[DocumentRefNo] [nvarchar](20) NULL,
	[DocumentRefId] [int] NULL,
	[Agency] [int] NULL,
	[CarriedOut] [int] NULL,
	[StartDate] [datetime] NULL,
	[StartTime] [time](7) NULL,
	[EndDate] [datetime] NULL,
	[EndTime] [time](7) NULL,
	[BriefDescription] [nvarchar](max) NULL,
	[RootCause] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_investigation] PRIMARY KEY CLUSTERED 
(
	[InvestigationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
