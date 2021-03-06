USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_cm_code_detail]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cm_code_detail](
	[ComDetId] [int] IDENTITY(1,1) NOT NULL,
	[ComId] [int] NULL,
	[ShortDesc] [nvarchar](50) NOT NULL,
	[LongDesc] [nvarchar](500) NOT NULL,
	[Position] [int] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_cm_code_detail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_cm_code_detail_tbl_cm_code] FOREIGN KEY([ComId])
REFERENCES [dbo].[tbl_cm_code] ([ComId])
GO
ALTER TABLE [dbo].[tbl_cm_code_detail] CHECK CONSTRAINT [FK_tbl_cm_code_detail_tbl_cm_code]
GO
