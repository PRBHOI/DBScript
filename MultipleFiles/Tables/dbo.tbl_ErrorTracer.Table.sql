USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_ErrorTracer]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ErrorTracer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorLine] [int] NULL,
	[ErrorProc] [varchar](max) NULL,
	[ErrorMsg] [varchar](max) NULL,
	[UserName] [varchar](max) NULL,
	[HostName] [varchar](max) NULL,
	[ErrorDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tbl_ErrorTracer] ADD  DEFAULT (getdate()) FOR [ErrorDate]
GO
