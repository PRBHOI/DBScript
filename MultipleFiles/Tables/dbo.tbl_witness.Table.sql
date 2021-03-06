USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_witness]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_witness](
	[WitnessId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentId] [int] NOT NULL,
	[WitnessType] [int] NULL,
	[UserId] [int] NULL,
	[UserDesignation] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[PhoneNo] [nchar](20) NULL,
	[Statement] [nvarchar](max) NULL,
	[WitnessDate] [date] NULL,
	[WitnessTime] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Witness] PRIMARY KEY CLUSTERED 
(
	[WitnessId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_witness]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Witness_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_witness] CHECK CONSTRAINT [FK_tbl_Witness_tbl_incident]
GO
