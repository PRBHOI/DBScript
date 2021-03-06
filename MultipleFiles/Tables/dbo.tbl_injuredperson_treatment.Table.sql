USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_injuredperson_treatment]    Script Date: 06/06/2021 23:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_injuredperson_treatment](
	[InjuredTreatmentId] [int] NOT NULL,
	[InjuredDetailId] [int] NULL,
	[PhysicanName] [nvarchar](100) NULL,
	[ImmediateResuscitation] [bit] NULL,
	[Unconscious] [bit] NULL,
	[InpatiengOvernight] [bit] NULL,
	[EmergencyRoom] [bit] NULL,
	[TreatmentBeyondFirstAid] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_injuredperson_treatment] PRIMARY KEY CLUSTERED 
(
	[InjuredTreatmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_injuredperson_treatment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_injuredperson_treatment_tbl_injuredperson_detail] FOREIGN KEY([InjuredDetailId])
REFERENCES [dbo].[tbl_injuredperson_detail] ([InjuredDetailId])
GO
ALTER TABLE [dbo].[tbl_injuredperson_treatment] CHECK CONSTRAINT [FK_tbl_injuredperson_treatment_tbl_injuredperson_detail]
GO
