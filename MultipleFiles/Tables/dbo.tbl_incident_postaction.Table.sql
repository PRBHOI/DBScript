USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_incident_postaction]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incident_postaction](
	[PostActionId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentId] [int] NOT NULL,
	[PostActionDate] [datetime] NULL,
	[PostActionTime] [datetime] NULL,
	[Action] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_incident_postaction] PRIMARY KEY CLUSTERED 
(
	[PostActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_incident_postaction]  WITH CHECK ADD  CONSTRAINT [FK_tbl_incident_postaction_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_incident_postaction] CHECK CONSTRAINT [FK_tbl_incident_postaction_tbl_incident]
GO
