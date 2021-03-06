USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_investigation_physicalcause]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_physicalcause](
	[PhysicalId] [int] NOT NULL,
	[InvestigationId] [int] NULL,
	[Physical] [int] NOT NULL,
	[IsTrue] [bit] NULL,
	[Comments] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_investigation_physicalcause] PRIMARY KEY CLUSTERED 
(
	[PhysicalId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_investigation_physicalcause]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_physicalcause_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_physicalcause] CHECK CONSTRAINT [FK_tbl_investigation_physicalcause_tbl_investigation]
GO
