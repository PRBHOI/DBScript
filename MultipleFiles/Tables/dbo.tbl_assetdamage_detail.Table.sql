USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_assetdamage_detail]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_assetdamage_detail](
	[AssetDamagedDetailId] [int] IDENTITY(1,1) NOT NULL,
	[AssetDamagedId] [int] NULL,
	[DamagedType] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_assetdamage_detail] PRIMARY KEY CLUSTERED 
(
	[AssetDamagedDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_assetdamage_detail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_assetdamage_detail_tbl_incident_assetdamage] FOREIGN KEY([AssetDamagedId])
REFERENCES [dbo].[tbl_incident_assetdamage] ([AssetDamagedId])
GO
ALTER TABLE [dbo].[tbl_assetdamage_detail] CHECK CONSTRAINT [FK_tbl_assetdamage_detail_tbl_incident_assetdamage]
GO
