USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_incident_injuredperson]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incident_injuredperson](
	[InjuredId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentId] [int] NOT NULL,
	[InjuredType] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[UserId] [int] NULL,
	[UserDesignation] [int] NULL,
	[Age] [int] NULL,
	[Fatality] [int] NULL,
	[FatalityType] [int] NULL,
	[IsLostTimeInjury] [bit] NULL,
	[WorkDaysLost] [numeric](10, 2) NULL,
	[LossTimeInjury] [numeric](10, 2) NULL,
	[Statement] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_incident_injuredperson] PRIMARY KEY CLUSTERED 
(
	[InjuredId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_incident_injuredperson]  WITH CHECK ADD  CONSTRAINT [FK_tbl_incident_injuredperson_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_incident_injuredperson] CHECK CONSTRAINT [FK_tbl_incident_injuredperson_tbl_incident]
GO
