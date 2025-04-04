USE [PortalRH]
GO
/****** Object:  Table [dbo].[ControleLogin]    Script Date: 18/10/2020 20:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ControleLogin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RD0_CODIGO] [varchar](6) NULL,
	[IsLogged] [bit] NULL,
	[DataLastLogin] [datetime] NULL,
	[DataExpiracao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImagensTickets]    Script Date: 18/10/2020 20:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImagensTickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](150) NOT NULL,
	[Descricao] [varchar](max) NULL,
	[ImgBase64] [varchar](max) NULL,
	[ProdutoId] [int] NULL,
	[DataInclusao] [datetime2](7) NULL,
	[Ativo] [bit] NULL,
	[NomeOriginal] [varchar](max) NULL,
	[UsuarioId] [int] NULL,
	[PathServer] [varchar](max) NULL,
	[Extensao] [varchar](5) NULL,
	[Tamanho] [bigint] NULL,
	[RelativePath] [varchar](max) NULL,
	[IsCapa] [bit] NULL,
	[ZC0_NUM] [varchar](10) NULL,
	[WorkflowId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParametrosOnline]    Script Date: 18/10/2020 20:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametrosOnline](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NULL,
	[Conteudo] [varchar](255) NULL,
	[Descricao] [varchar](717) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceLog]    Script Date: 18/10/2020 20:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Process] [varchar](50) NULL,
	[DataLog] [datetime] NULL,
	[LogMessage] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkFlow]    Script Date: 18/10/2020 20:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkFlow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DataInclusao] [datetime] NULL,
	[EmailDestino] [varchar](8000) NOT NULL,
	[DataEnvio] [datetime] NULL,
	[EnvioOK] [bit] NULL,
	[Assunto] [varchar](517) NULL,
	[CorpoEmail] [varchar](8000) NULL,
	[Key] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImagensTickets] ADD  DEFAULT (getdate()) FOR [DataInclusao]
GO
ALTER TABLE [dbo].[ImagensTickets] ADD  DEFAULT ((1)) FOR [Ativo]
GO
ALTER TABLE [dbo].[ServiceLog] ADD  DEFAULT (getdate()) FOR [DataLog]
GO
ALTER TABLE [dbo].[WorkFlow] ADD  DEFAULT (getdate()) FOR [DataInclusao]
GO
ALTER TABLE [dbo].[WorkFlow] ADD  DEFAULT ((0)) FOR [EnvioOK]
GO
alter table WorkFlow add EmailCC varchar(Max)