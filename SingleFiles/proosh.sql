USE [PROOSH]
GO
/****** Object:  Table [dbo].[tbl_investigation]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation](
	[InvestigationId] [int] IDENTITY(1,1) NOT NULL,
	[InvestigationNo] [nvarchar](20) NOT NULL,
	[InvestigationLead] [int] NULL,
	[DocumentType] [int] NULL,
	[DocumentRefNo] [nvarchar](20) NULL,
	[DocumentRefId] [int] NULL,
	[Agency] [int] NULL,
	[CarriedOut] [int] NULL,
	[StartDate] [datetime] NULL,
	[StartTime] [time](7) NULL,
	[EndDate] [datetime] NULL,
	[EndTime] [time](7) NULL,
	[BriefDescription] [nvarchar](max) NULL,
	[RootCause] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_investigation] PRIMARY KEY CLUSTERED 
(
	[InvestigationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_cm_code]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cm_code](
	[ComId] [int] NOT NULL,
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
/****** Object:  Table [dbo].[tbl_incident]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incident](
	[IncidentId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentNo] [nvarchar](20) NULL,
	[IncidentTitle] [nvarchar](100) NULL,
	[IncidentDate] [date] NULL,
	[IncidentTime] [datetime] NULL,
	[Location] [int] NULL,
	[InvestigationLevel] [int] NULL,
	[Sector] [int] NULL,
	[IncidentType] [int] NULL,
	[IncidentAt] [int] NULL,
	[Shift] [int] NOT NULL,
	[Activity] [int] NOT NULL,
	[Severity] [int] NOT NULL,
	[Department] [int] NOT NULL,
	[RecurrenceLikelihood] [int] NOT NULL,
	[EquipmentLoss] [numeric](18, 2) NOT NULL,
	[ExactLocation] [nvarchar](500) NOT NULL,
	[BriefDesc] [nvarchar](max) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_incident] PRIMARY KEY CLUSTERED 
(
	[IncidentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ErrorTracer]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_safetyobservation]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_witness]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_investigation_physicalcause]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_physicalcause](
	[PhysicalId] [int] NOT NULL,
	[InvestigationId] [int] NULL,
	[Physical] [int] NOT NULL,
	[IsTrue] [bit] NULL,
	[Comments] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_investigation_physicalcause] PRIMARY KEY CLUSTERED 
(
	[PhysicalId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_investigation_managementcause]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_managementcause](
	[ManagementId] [int] NOT NULL,
	[InvestigationId] [int] NULL,
	[Management] [int] NOT NULL,
	[IsTrue] [bit] NULL,
	[Comments] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_investigation_managementcause] PRIMARY KEY CLUSTERED 
(
	[ManagementId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_investigation_flow]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_flow](
	[FlowId] [int] NOT NULL,
	[InvestigationId] [int] NULL,
	[StepNo] [int] NULL,
	[AssignTo] [int] NULL,
	[ExternalAgency] [nvarchar](100) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Commets] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_investigation_flow] PRIMARY KEY CLUSTERED 
(
	[FlowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_investigation_behaviouralcause]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_investigation_behaviouralcause](
	[BehaviouralId] [int] IDENTITY(1,1) NOT NULL,
	[InvestigationId] [int] NULL,
	[Behavioural] [int] NOT NULL,
	[IsTrue] [bit] NULL,
	[Comments] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_investigation_behaviouralCause] PRIMARY KEY CLUSTERED 
(
	[BehaviouralId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_incident_postaction]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_incident_injuredperson]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_incident_assetdamage]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incident_assetdamage](
	[AssetDamagedId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentId] [int] NULL,
	[EquipmentId] [int] NULL,
	[EquipmentType] [int] NULL,
	[IsOperational] [bit] NULL,
	[IsCompanyOwned] [bit] NULL,
	[SerialNo] [nvarchar](100) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_incident_assetdamage] PRIMARY KEY CLUSTERED 
(
	[AssetDamagedId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_cm_code_detail]    Script Date: 06/06/2021 18:59:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cm_code_detail](
	[ComDetId] [int] NOT NULL,
	[ComId] [int] NULL,
	[ShortDesc] [nvarchar](50) NOT NULL,
	[LongDesc] [nvarchar](500) NOT NULL,
	[Position] [int] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_injuredperson_detail]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_assetdamage_detail]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Table [dbo].[tbl_injuredperson_treatment]    Script Date: 06/06/2021 18:59:21 ******/
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
/****** Object:  Default [DF__tbl_Error__Error__15502E78]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_ErrorTracer] ADD  DEFAULT (getdate()) FOR [ErrorDate]
GO
/****** Object:  ForeignKey [FK_tbl_assetdamage_detail_tbl_incident_assetdamage]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_assetdamage_detail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_assetdamage_detail_tbl_incident_assetdamage] FOREIGN KEY([AssetDamagedId])
REFERENCES [dbo].[tbl_incident_assetdamage] ([AssetDamagedId])
GO
ALTER TABLE [dbo].[tbl_assetdamage_detail] CHECK CONSTRAINT [FK_tbl_assetdamage_detail_tbl_incident_assetdamage]
GO
/****** Object:  ForeignKey [FK_tbl_cm_code_detail_tbl_cm_code]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_cm_code_detail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_cm_code_detail_tbl_cm_code] FOREIGN KEY([ComId])
REFERENCES [dbo].[tbl_cm_code] ([ComId])
GO
ALTER TABLE [dbo].[tbl_cm_code_detail] CHECK CONSTRAINT [FK_tbl_cm_code_detail_tbl_cm_code]
GO
/****** Object:  ForeignKey [FK_tbl_incident_assetdamage_tbl_incident]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_incident_assetdamage]  WITH CHECK ADD  CONSTRAINT [FK_tbl_incident_assetdamage_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_incident_assetdamage] CHECK CONSTRAINT [FK_tbl_incident_assetdamage_tbl_incident]
GO
/****** Object:  ForeignKey [FK_tbl_incident_injuredperson_tbl_incident]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_incident_injuredperson]  WITH CHECK ADD  CONSTRAINT [FK_tbl_incident_injuredperson_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_incident_injuredperson] CHECK CONSTRAINT [FK_tbl_incident_injuredperson_tbl_incident]
GO
/****** Object:  ForeignKey [FK_tbl_incident_postaction_tbl_incident]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_incident_postaction]  WITH CHECK ADD  CONSTRAINT [FK_tbl_incident_postaction_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_incident_postaction] CHECK CONSTRAINT [FK_tbl_incident_postaction_tbl_incident]
GO
/****** Object:  ForeignKey [FK_tbl_injuredperson_detail_tbl_incident_injuredperson1]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_injuredperson_detail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_injuredperson_detail_tbl_incident_injuredperson1] FOREIGN KEY([InjuredId])
REFERENCES [dbo].[tbl_incident_injuredperson] ([InjuredId])
GO
ALTER TABLE [dbo].[tbl_injuredperson_detail] CHECK CONSTRAINT [FK_tbl_injuredperson_detail_tbl_incident_injuredperson1]
GO
/****** Object:  ForeignKey [FK_tbl_injuredperson_treatment_tbl_injuredperson_detail]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_injuredperson_treatment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_injuredperson_treatment_tbl_injuredperson_detail] FOREIGN KEY([InjuredDetailId])
REFERENCES [dbo].[tbl_injuredperson_detail] ([InjuredDetailId])
GO
ALTER TABLE [dbo].[tbl_injuredperson_treatment] CHECK CONSTRAINT [FK_tbl_injuredperson_treatment_tbl_injuredperson_detail]
GO
/****** Object:  ForeignKey [FK_tbl_investigation_behaviouralCause_tbl_investigation]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_investigation_behaviouralcause]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_behaviouralCause_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_behaviouralcause] CHECK CONSTRAINT [FK_tbl_investigation_behaviouralCause_tbl_investigation]
GO
/****** Object:  ForeignKey [FK_tbl_investigation_flow_tbl_investigation]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_investigation_flow]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_flow_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_flow] CHECK CONSTRAINT [FK_tbl_investigation_flow_tbl_investigation]
GO
/****** Object:  ForeignKey [FK_tbl_investigation_managementcause_tbl_investigation]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_investigation_managementcause]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_managementcause_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_managementcause] CHECK CONSTRAINT [FK_tbl_investigation_managementcause_tbl_investigation]
GO
/****** Object:  ForeignKey [FK_tbl_investigation_physicalcause_tbl_investigation]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_investigation_physicalcause]  WITH CHECK ADD  CONSTRAINT [FK_tbl_investigation_physicalcause_tbl_investigation] FOREIGN KEY([InvestigationId])
REFERENCES [dbo].[tbl_investigation] ([InvestigationId])
GO
ALTER TABLE [dbo].[tbl_investigation_physicalcause] CHECK CONSTRAINT [FK_tbl_investigation_physicalcause_tbl_investigation]
GO
/****** Object:  ForeignKey [FK_tbl_Witness_tbl_incident]    Script Date: 06/06/2021 18:59:21 ******/
ALTER TABLE [dbo].[tbl_witness]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Witness_tbl_incident] FOREIGN KEY([IncidentId])
REFERENCES [dbo].[tbl_incident] ([IncidentId])
GO
ALTER TABLE [dbo].[tbl_witness] CHECK CONSTRAINT [FK_tbl_Witness_tbl_incident]
GO
