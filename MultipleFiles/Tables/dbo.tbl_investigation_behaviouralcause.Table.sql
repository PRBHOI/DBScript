USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_investigation_behaviouralcause]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_behaviouralcause](
	[BehaviouralId] [int] IDENTITY(1,1) NOT NULL,
	[InvestigationId] [int] NULL,
	[Behavioural] [int] NOT NULL,
	[IsTrue] [bit] NULL,
	[Comments] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_investigation_behaviouralCause] PRIMARY KEY CLUSTERED 
(
	[BehaviouralId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_investigation_behaviouralcause]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_behaviouralCause_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_behaviouralcause] CHECK CONSTRAINT [FK_tbl_investigation_behaviouralCause_tbl_investigation]
GO
