USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_investigation_flow]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_flow](
	[FlowId] [int] NOT NULL,
	[InvestigationId] [int] NULL,
	[StepNo] [int] NULL,
	[AssignTo] [int] NULL,
	[ExternalAgency] [nvarchar](100) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Commets] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_investigation_flow] PRIMARY KEY CLUSTERED 
(
	[FlowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_investigation_flow]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_flow_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_flow] CHECK CONSTRAINT [FK_tbl_investigation_flow_tbl_investigation]
GO
