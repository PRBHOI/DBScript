USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_safetyobservation]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_safetyobservation](
	[SafetyObservationId] [int] NOT NULL,
	[ObservationUserType] [int] NULL,
	[ObservationBy] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[ObservationDate] [datetime] NULL,
	[ObservationTime] [time](7) NULL,
	[CarriedOut] [int] NULL,
	[CompliancePercentage] [int] NULL,
	[ObservationType] [int] NULL,
	[PotentialServerity] [int] NULL,
	[Observation] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_safetyobservation] PRIMARY KEY CLUSTERED 
(
	[SafetyObservationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
