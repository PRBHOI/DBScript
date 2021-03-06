USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_injuredperson_detail]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_injuredperson_detail](
	[InjuredDetailId] [int] IDENTITY(1,1) NOT NULL,
	[InjuredId] [int] NOT NULL,
	[Classification] [int] NULL,
	[InjuryType] [int] NULL,
	[InjuredBodyPart] [int] NULL,
	[InjuredBodySide] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_injuredperson_detail] PRIMARY KEY CLUSTERED 
(
	[InjuredDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_injuredperson_detail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_injuredperson_detail_tbl_incident_injuredperson1] FOREIGN KEY([InjuredId])
REFERENCES [dbo].[tbl_incident_injuredperson] ([InjuredId])
GO
ALTER TABLE [dbo].[tbl_injuredperson_detail] CHECK CONSTRAINT [FK_tbl_injuredperson_detail_tbl_incident_injuredperson1]
GO
