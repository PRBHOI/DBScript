USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_cm_code]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cm_code](
	[ComId] [int] IDENTITY(1,1) NOT NULL,
	[ShortDesc] [nvarchar](50) NOT NULL,
	[LongDesc] [nvarchar](500) NOT NULL,
	[Position] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_cm_code] PRIMARY KEY CLUSTERED 
(
	[ComId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
