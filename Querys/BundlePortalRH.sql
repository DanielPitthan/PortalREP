USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[UpdateZC0]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[UpdateZC0]
GO
/****** Object:  StoredProcedure [dbo].[SOMA1]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[SOMA1]
GO
/****** Object:  StoredProcedure [dbo].[InsertZC1]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[InsertZC1]
GO
/****** Object:  StoredProcedure [dbo].[InsertZC0]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[InsertZC0]
GO
/****** Object:  StoredProcedure [dbo].[InsertSQS]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[InsertSQS]
GO
/****** Object:  StoredProcedure [dbo].[GetWorkflows]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[GetWorkflows]
GO
/****** Object:  StoredProcedure [dbo].[GetAttachments]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[GetAttachments]
GO
/****** Object:  StoredProcedure [dbo].[DeleteSQS]    Script Date: 08/05/2021 16:25:13 ******/
DROP PROCEDURE IF EXISTS [dbo].[DeleteSQS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkFlow]') AND type in (N'U'))
ALTER TABLE [dbo].[WorkFlow] DROP CONSTRAINT IF EXISTS [DF__WorkFlow__EnvioO__20E1DCB5]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkFlow]') AND type in (N'U'))
ALTER TABLE [dbo].[WorkFlow] DROP CONSTRAINT IF EXISTS [DF__WorkFlow__DataIn__1FEDB87C]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLog]') AND type in (N'U'))
ALTER TABLE [dbo].[ServiceLog] DROP CONSTRAINT IF EXISTS [DF__ServiceLo__DataL__1387E197]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImagensTickets]') AND type in (N'U'))
ALTER TABLE [dbo].[ImagensTickets] DROP CONSTRAINT IF EXISTS [DF__ImagensTi__Ativo__0169315C]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImagensTickets]') AND type in (N'U'))
ALTER TABLE [dbo].[ImagensTickets] DROP CONSTRAINT IF EXISTS [DF__ImagensTi__DataI__00750D23]
GO
/****** Object:  Table [dbo].[WorkFlow]    Script Date: 08/05/2021 16:25:13 ******/
DROP TABLE IF EXISTS [dbo].[WorkFlow]
GO
/****** Object:  Table [dbo].[TicketsAvisadosSuperiro]    Script Date: 08/05/2021 16:25:13 ******/
DROP TABLE IF EXISTS [dbo].[TicketsAvisadosSuperiro]
GO
/****** Object:  Table [dbo].[ServiceLog]    Script Date: 08/05/2021 16:25:13 ******/
DROP TABLE IF EXISTS [dbo].[ServiceLog]
GO
/****** Object:  Table [dbo].[ParametrosOnline]    Script Date: 08/05/2021 16:25:13 ******/
DROP TABLE IF EXISTS [dbo].[ParametrosOnline]
GO
/****** Object:  Table [dbo].[ImagensTickets]    Script Date: 08/05/2021 16:25:13 ******/
DROP TABLE IF EXISTS [dbo].[ImagensTickets]
GO
/****** Object:  Table [dbo].[ControleLogin]    Script Date: 08/05/2021 16:25:13 ******/
DROP TABLE IF EXISTS [dbo].[ControleLogin]
GO
/****** Object:  Table [dbo].[ControleLogin]    Script Date: 08/05/2021 16:25:13 ******/
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
/****** Object:  Table [dbo].[ImagensTickets]    Script Date: 08/05/2021 16:25:14 ******/
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
/****** Object:  Table [dbo].[ParametrosOnline]    Script Date: 08/05/2021 16:25:14 ******/
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
/****** Object:  Table [dbo].[ServiceLog]    Script Date: 08/05/2021 16:25:14 ******/
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
/****** Object:  Table [dbo].[TicketsAvisadosSuperiro]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketsAvisadosSuperiro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Avisado] [bit] NULL,
	[Ticket] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkFlow]    Script Date: 08/05/2021 16:25:14 ******/
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
	[EmailCC] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[DeleteSQS]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
** Autor Daniel P Silveira 
** Data 01/04/2021
** Faz o DELET na Tabela SQS - Cadastro de Vaga

*/

create    procedure [dbo].[DeleteSQS]
(
 @QS_FILIAL		varchar	(2  )
,@QS_VAGA		varchar	(6  )
)
As

If  Exists (SELECT 0 FROM SQS100 WHERE QS_VAGA=@QS_VAGA )
Begin 
	update SQS100 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE 
	QS_FILIAL = @QS_FILIAL AND QS_VAGA=@QS_VAGA
End

 SELECT * FROM SQS100 WHERE 
	QS_FILIAL = @QS_FILIAL AND QS_VAGA=@QS_VAGA
GO
/****** Object:  StoredProcedure [dbo].[GetAttachments]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
** Autor: Daniel Pitthan Silveira
** Obtem os anexos pelo Id do Workflow
** 
** Exec GetAttachments 1
*/
create    procedure [dbo].[GetAttachments]
	( @WorkFlowId int)
as 
select  
		Id
		,Nome
		,Descricao
		,ImgBase64
		,ProdutoId
		,DataInclusao
		,Ativo
		,NomeOriginal
		,UsuarioId
		,PathServer
		,Extensao
		,Tamanho
		,RelativePath
		,IsCapa
		,ZC0_NUM
		,WorkflowId

from ImagensTickets
where WorkflowId= @WorkFlowId
and Ativo=1
GO
/****** Object:  StoredProcedure [dbo].[GetWorkflows]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
** Autor: Daniel Pitthan Silveira
** Obtem os anexos pelo Id do Workflow
** 
** Exec GetWorkflows 
*/

Create    procedure [dbo].[GetWorkflows]
As
select 
	w.Id,w.DataInclusao,
	w.EmailDestino,w.DataEnvio
	,w.EnvioOK,w.Assunto,w.CorpoEmail
from [WorkFlow] as w with(nolock)
where EnvioOK=0

GO
/****** Object:  StoredProcedure [dbo].[InsertSQS]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
** Autor Daniel P Silveira 
** Data 01/04/2021
** Faz o insert na Tabela SQS - Cadastro de Vaga

*/

create    procedure [dbo].[InsertSQS]
(
@QS_FILIAL		varchar	(2  )
,@QS_VAGA		varchar	(6  )
,@QS_XFINALI	varchar	(1  )
,@QS_XMOTIV		varchar	(90 )
,@QS_XSUSBMO	varchar	(30 )
,@QS_XDEMITI	varchar	(6  )
,@QS_XNOMDEM	varchar	(30 )
,@QS_XDATAMO	varchar	(8  )
,@QS_FUNCAO		varchar	(5  )
,@QS_XFUNCAO	varchar	(90 )
,@QS_DESCRIC	varchar	(50 )
,@QS_AREA		varchar	(3  )
,@QS_CC			varchar	(13 )
,@QS_XDPROJE	varchar	(90 )
,@QS_XITEM		varchar	(13 )
,@QS_XDESITE	varchar	(40 )
,@QS_XFILVAG	varchar	(2  )
,@QS_TIPO		varchar	(1  )
,@QS_TESTE		varchar	(3  )
,@QS_PONTOS		float	(8  )
,@QS_AUTOM		varchar	(1  )
,@QS_MSGAPV		varchar	(6  )
,@QS_MSGREP		varchar	(6  )
,@QS_REINSC		varchar	(1  )
,@QS_MATRESP	varchar	(6  )
,@QS_FILRESP	varchar	(2  )
,@QS_CODPERF	varchar	(6  )
,@QS_NRVAGA		float	(8  )
,@QS_PROCESS	varchar	(4  )
,@QS_SOLICIT	varchar	(30 )
,@QS_CLIENTE	varchar	(6  )
,@QS_PRAZO		float	(8  )
,@QS_DTABERT	varchar	(8  )
,@QS_XPREVFE	varchar	(8  )
,@QS_DTFECH		varchar	(8  )
,@QS_VAGAFEC	float	(8  )
,@QS_VCUSTO		float	(8  )
,@QS_XCIDADE	varchar	(40 )
,@QS_XBASE		varchar	(90 )
,@QS_XSALARI	float	(8  )
,@QS_POSTO		varchar	(9  )
,@QS_XPERICU	varchar	(3  )
,@QS_FILPOST	varchar	(2  )
,@QS_XTURNO		varchar	(3  )
,@QS_XDESCTU	varchar	(30 )
,@QS_XJORNAD	varchar	(1  )
,@QS_XMPONTO	varchar	(3  )
,@QS_XBCOHS		varchar	(3  )
,@QS_XRESPPO	varchar	(6  )
,@QS_XNPONTO	varchar	(30 )
,@QS_XAPOPON	varchar	(6  )
,@QS_XNAPOIO	varchar	(30 )
,@QS_XSELECI	varchar	(6  )
,@QS_XNOMESE	varchar	(90 )
,@DetalheDaVaga varchar(max)
)
As

Declare @Recno bigint 
Declare @RecnoRDY bigint 
Declare @Vaga varchar(6)

	declare  @chaveMemo varchar(6)  = (select MAX(QS_CODPERF) from SQS100)
	Exec SOMA1 @chaveMemo,'N',@QS_CODPERF out


If Not Exists (SELECT 0 FROM SQS100 WHERE QS_VAGA=@QS_VAGA AND @QS_VAGA!='' )
Begin 

	set @Recno  = (Select MAX(R_E_C_N_O_)+1 from SQS100)

	Declare @CodVagaAtaul varchar(6)='        '
	Declare @NovoCodVaga varchar(6) ='        '
	SET @CodVagaAtaul = (Select MAX(QS_VAGA) from SQS100)
	EXEC SOMA1 @CodVagaAtaul,'N',@NovoCodVaga OUT
	 

	--Gera a Chave do campo Memo Virtual


	Insert into SQS100 (
	QS_FILIAL
	,QS_VAGA
	,QS_XFINALI
	,QS_XMOTIV
	,QS_XSUSBMO
	,QS_XDEMITI
	,QS_XNOMDEM
	,QS_XDATAMO
	,QS_FUNCAO
	,QS_XFUNCAO
	,QS_DESCRIC
	,QS_AREA
	,QS_CC
	,QS_XDPROJE
	,QS_XITEM
	,QS_XDESITE
	,QS_XFILVAG
	,QS_TIPO
	,QS_TESTE
	,QS_PONTOS
	,QS_AUTOM
	,QS_MSGAPV
	,QS_MSGREP
	,QS_REINSC
	,QS_MATRESP
	,QS_FILRESP
	,QS_CODPERF
	,QS_NRVAGA
	,QS_PROCESS
	,QS_SOLICIT
	,QS_CLIENTE
	,QS_PRAZO
	,QS_DTABERT
	,QS_XPREVFE
	,QS_DTFECH
	,QS_VAGAFEC
	,QS_VCUSTO
	,QS_XCIDADE
	,QS_XBASE
	,QS_XSALARI
	,QS_POSTO
	,QS_XPERICU
	,QS_FILPOST
	,QS_XTURNO
	,QS_XDESCTU
	,QS_XJORNAD
	,QS_XMPONTO
	,QS_XBCOHS
	,QS_XRESPPO
	,QS_XNPONTO
	,QS_XAPOPON
	,QS_XNAPOIO
	,D_E_L_E_T_
	,R_E_C_N_O_
	,R_E_C_D_E_L_
	,QS_XSELECI
	,QS_XNOMESE) values
	(
	@QS_FILIAL
	,@NovoCodVaga
	,@QS_XFINALI
	,@QS_XMOTIV
	,@QS_XSUSBMO
	,@QS_XDEMITI
	,@QS_XNOMDEM
	,@QS_XDATAMO
	,@QS_FUNCAO
	,@QS_XFUNCAO
	,@QS_DESCRIC
	,@QS_AREA
	,@QS_CC
	,@QS_XDPROJE
	,@QS_XITEM
	,@QS_XDESITE
	,@QS_XFILVAG
	,@QS_TIPO
	,@QS_TESTE
	,@QS_PONTOS
	,@QS_AUTOM
	,@QS_MSGAPV
	,@QS_MSGREP
	,@QS_REINSC
	,@QS_MATRESP
	,@QS_FILRESP
	,@QS_CODPERF
	,@QS_NRVAGA
	,@QS_PROCESS
	,@QS_SOLICIT
	,@QS_CLIENTE
	,@QS_PRAZO
	,@QS_DTABERT
	,@QS_XPREVFE
	,@QS_DTFECH
	,@QS_VAGAFEC
	,@QS_VCUSTO
	,@QS_XCIDADE
	,@QS_XBASE
	,@QS_XSALARI
	,@QS_POSTO
	,@QS_XPERICU
	,@QS_FILPOST
	,@QS_XTURNO
	,@QS_XDESCTU
	,@QS_XJORNAD
	,@QS_XMPONTO
	,@QS_XBCOHS
	,@QS_XRESPPO
	,@QS_XNPONTO
	,@QS_XAPOPON
	,@QS_XNAPOIO
	,''		--@D_E_L_E_T_
	,@Recno
	,0		--@R_E_C_D_E_L_
	,@QS_XSELECI
	,@QS_XNOMESE
	)	


	

End

If Exists (SELECT 0 FROM SQS100 WHERE QS_VAGA=@QS_VAGA  AND @QS_VAGA!='')
Begin 
	
	update SQS100 
	SET 

	QS_XFINALI	=@QS_XFINALI
	,QS_XMOTIV	=@QS_XMOTIV
	,QS_XSUSBMO	=@QS_XSUSBMO
	,QS_XDEMITI	=@QS_XDEMITI
	,QS_XNOMDEM	=@QS_XNOMDEM
	,QS_XDATAMO	=@QS_XDATAMO
	,QS_FUNCAO	=@QS_FUNCAO
	,QS_XFUNCAO	=@QS_XFUNCAO
	,QS_DESCRIC	=@QS_DESCRIC
	,QS_AREA	=@QS_AREA
	,QS_CC		=@QS_CC
	,QS_XDPROJE	=@QS_XDPROJE
	,QS_XITEM	=@QS_XITEM
	,QS_XDESITE	=@QS_XDESITE
	,QS_XFILVAG	=@QS_XFILVAG
	,QS_TIPO	=@QS_TIPO
	,QS_TESTE	=@QS_TESTE
	,QS_PONTOS	=@QS_PONTOS
	,QS_AUTOM	=@QS_AUTOM
	,QS_MSGAPV	=@QS_MSGAPV
	,QS_MSGREP	=@QS_MSGREP
	,QS_REINSC	=@QS_REINSC
	,QS_MATRESP	=@QS_MATRESP
	,QS_FILRESP	=@QS_FILRESP
	,QS_CODPERF	=@QS_CODPERF
	,QS_NRVAGA	=@QS_NRVAGA
	,QS_PROCESS	=@QS_PROCESS
	,QS_SOLICIT	=@QS_SOLICIT
	,QS_CLIENTE	=@QS_CLIENTE
	,QS_PRAZO	=@QS_PRAZO
	,QS_DTABERT	=@QS_DTABERT
	,QS_XPREVFE	=@QS_XPREVFE
	,QS_DTFECH	=@QS_DTFECH
	,QS_VAGAFEC	=@QS_VAGAFEC
	,QS_VCUSTO	=@QS_VCUSTO
	,QS_XCIDADE	=@QS_XCIDADE
	,QS_XBASE	=@QS_XBASE
	,QS_XSALARI	=@QS_XSALARI
	,QS_POSTO	=@QS_POSTO
	,QS_XPERICU	=@QS_XPERICU
	,QS_FILPOST	=@QS_FILPOST
	,QS_XTURNO	=@QS_XTURNO
	,QS_XDESCTU	=@QS_XDESCTU
	,QS_XJORNAD	=@QS_XJORNAD
	,QS_XMPONTO	=@QS_XMPONTO
	,QS_XBCOHS	=@QS_XBCOHS
	,QS_XRESPPO	=@QS_XRESPPO
	,QS_XNPONTO	=@QS_XNPONTO
	,QS_XAPOPON	=@QS_XAPOPON
	,QS_XNAPOIO	=@QS_XNAPOIO
	,QS_XSELECI	=@QS_XSELECI
	,QS_XNOMESE	=@QS_XNOMESE

	WHERE QS_VAGA = @QS_VAGA AND QS_FILIAL=@QS_FILIAL

End


-- Gerar o RDY --> Memo virtual -- Com base na @QS_CODPERF
	-- Quebra da linha 80 caracteres
	Declare @TextoAGravar varchar(max)
	Declare @Seq varchar(03)='001'


	While Len(@DetalheDaVaga)>0
	Begin 
		
		Set @TextoAGravar = SUBSTRING(@DetalheDaVaga,1,80)
		set @RecnoRDY  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RDY100),0)

		if exists (SELECT 0 FROM RDY100 WHERE RDY_CHAVE=@QS_CODPERF)
		BEGIN 
			UPDATE RDY100 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE  RDY_CHAVE=@QS_CODPERF
		END 

		Insert into RDY100 (RDY_CHAVE,RDY_FILIAL,RDY_CAMPO,RDY_SEQ,RDY_TEXTO,RDY_FILTAB,R_E_C_N_O_)
		VALUES (@QS_CODPERF,'','QS_CODPERF',@Seq,@TextoAGravar,'01',@RecnoRDY)

	

		Set @DetalheDaVaga = RIGHT(@DetalheDaVaga,Case when len(@DetalheDaVaga)-80<0 then 0 else len(@DetalheDaVaga)-80 end )
		exec SOMA1 @Seq,'N',@Seq out
	End

---------------------------------------------------------------------------------------------------
-- GRAVA RH3 E RH4 
---------------------------------------------------------------------------------------------------

Declare @RecnoRH3 bigint 
Declare @RecnoRH4 bigint 

	set @RecnoRH3  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH3100),0)
	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)


if not exists (SELECT 0 FROM RH3100 WHERE RH3_CODIGO=@QS_VAGA)
Begin 
	insert into RH3100
	(RH3_FILIAL,RH3_CODIGO,RH3_TIPO,RH3_ORIGEM,RH3_STATUS,RH3_DTSOLI,RH3_NVLINI,RH3_FILINI,RH3_MATINI ,RH3_NVLAPR,R_E_C_N_O_,D_E_L_E_T_,RH3_FLUIG,RH3_EMP,RH3_EMPINI,RH3_EMPAPR) VALUES
	(@QS_FILIAL,@QS_VAGA  ,'5'     ,'PORTAL'  ,'4'      ,@QS_DTABERT,'0'       ,@QS_FILIAL,@QS_MATRESP,'99'      ,@RecnoRH3 ,''        ,0,'10','10','10')

	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)
	Insert into RH4100
	(RH4_FILIAL,	RH4_CODIGO,	RH4_ITEM,	RH4_CAMPO,	RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) VALUES
	(@QS_FILIAL,	@QS_VAGA,	'1',		'TMP_VAGA',	'',			@QS_VAGA,	'',			@RecnoRH4)

	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)
	Insert into RH4100
	(RH4_FILIAL,	RH4_CODIGO,	RH4_ITEM,	RH4_CAMPO,	RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) VALUES
	(@QS_FILIAL,	@QS_VAGA,	'1',		'TMP_DESC',	'',			@QS_DESCRIC,	'',			@RecnoRH4)

	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)
	Insert into RH4100
	(RH4_FILIAL,	RH4_CODIGO,	RH4_ITEM,	RH4_CAMPO,	RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) VALUES
	(@QS_FILIAL,	@QS_VAGA,	'1',		'TMP_SITUAC',	'',			'4',	'',			@RecnoRH4)

End


---------------------------------------------------------------------------------------------------
-- Retorna para a procedure 
---------------------------------------------------------------------------------------------------


 SELECT * FROM SQS100 WHERE [R_E_C_N_O_]=@Recno 

GO
/****** Object:  StoredProcedure [dbo].[InsertZC0]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*  
 criação: 20/11/2020  
 Autor : Daniel Pitthan Silveira   
  
 Realiza o insert na ZC0  
  
 manutenção 15/04/2021 - Correção do centro de custo   
*/  
 CREATE       procedure [dbo].[InsertZC0]  
   (   @ZC0_TEXTO       varchar(8000),  
    @ZC0_FILIAL  varchar(2),  
           @ZC0_NUM   varchar(10),  
           @ZC0_TITULO  varchar(80),  
           @ZC0_PRIO  varchar(1),  
           @ZC0_STATUS  varchar(4),  
           @ZC0_CC   varchar(13),  
           @ZC0_DTINC  varchar(8),  
           @ZC0_HRINC  varchar(4),  
           @ZC0_DTENC  varchar(8),  
           @ZC0_HRFECH  varchar(4),  
           @ZC0_UIDINC  varchar(6),  
           @ZC0_UIDENC  varchar(6),  
           @ZC0_MATI  varchar(6),  
           @ZC0_MATE  varchar(6),  
           @ZC0_EMAILD  varchar(254),  
           @ZC0_EMIALU  varchar(254),  
           @ZC0_TEL   varchar(20),  
           @ZC0_ANEXOS  varchar(6),  
           @ZC0_PROB  varchar(4),  
           @ZC0_UNID  varchar(4),  
           @ZC0_ASSUNT  varchar(4),  
           @ZC0_CODARE  varchar(4),  
           @ZC0_MAT   varchar(6),  
           @ZC0_DEPART  varchar(4),  
           @ZC0_ENV   float,  
           @ZC0_MAILEN  varchar(254),  
           @ZC0_CPO1  varchar(4),  
           @ZC0_CPO2  varchar(6),  
           @ZC0_CP3   varchar(80),  
           @ZC0_VAL1  float,  
           @ZC0_VAL2  float,  
           @ZC0_VAL3  float,  
     @ZC0_ITENCT  VARCHAR(09),
	 @ZC0_ATEND2 VARCHAR(6),
	 @ZC0_SUPER2 VARCHAR(6))  
As  
  
Declare @Recno bigint   
  
/*Obtem o próximo Recno */  
set @Recno = (select isnull(max(R_E_C_N_O_),0) from ZC0100)+1  

/*OBTEM O PRÓXIMO TICKET*/
declare  @TICKET varchar(10)  = (select ISNULL(MAX(ZC0_NUM),'') from [ZC0100])  
declare  @NEXT_TICKET varchar(10)


IF RTRIM(LTRIM(@TICKET))=''
BEGIN
	SET @TICKET='0000000000'
END

Exec SOMA1 @TICKET,'N',@NEXT_TICKET out  
  
INSERT INTO [dbo].[ZC0100]  
           ([ZC0_FILIAL]  
           ,[ZC0_NUM]  
           ,[ZC0_TITULO]  
           ,[ZC0_PRIO]  
           ,[ZC0_STATUS]  
           ,[ZC0_CC]  
           ,[ZC0_DTINC]  
           ,[ZC0_HRINC]  
           ,[ZC0_DTENC]  
           ,[ZC0_HRFECH]  
           ,[ZC0_UIDINC]  
           ,[ZC0_UIDENC]  
           ,[ZC0_MATI]  
           ,[ZC0_MATE]  
           ,[ZC0_EMAILD]  
           ,[ZC0_EMIALU]  
           ,[ZC0_TEL]  
           ,[ZC0_ANEXOS]  
           ,[ZC0_PROB]  
           ,[ZC0_UNID]  
           ,[ZC0_ASSUNT]  
           ,[ZC0_CODARE]  
           ,[D_E_L_E_T_]  
           ,[R_E_C_N_O_]  
           ,[R_E_C_D_E_L_]  
           ,[ZC0_MAT]  
           ,[ZC0_DEPART]  
           ,[ZC0_ENV]  
           ,[ZC0_MAILEN]  
           ,[ZC0_CPO1]  
           ,[ZC0_CPO2]  
           ,[ZC0_CP3]  
           ,[ZC0_VAL1]  
           ,[ZC0_VAL2]  
           ,[ZC0_VAL3],  
     [ZC0_TEXTO],  
     [ZC0_ITENCT],
	  [ZC0_ATEND2],
	  [ZC0_SUPER2])  
     VALUES  
            (    
     @ZC0_FILIAL ,  
           @NEXT_TICKET    ,  
           @ZC0_TITULO ,  
           @ZC0_PRIO   ,  
           @ZC0_STATUS ,  
           @ZC0_CC    ,  
           @ZC0_DTINC  ,  
           @ZC0_HRINC  ,  
           @ZC0_DTENC  ,  
           @ZC0_HRFECH ,  
           @ZC0_UIDINC ,  
           @ZC0_UIDENC ,  
           @ZC0_MATI ,  
           @ZC0_MATE ,  
           @ZC0_EMAILD ,  
           @ZC0_EMIALU ,  
           @ZC0_TEL  ,  
           @ZC0_ANEXOS ,  
           @ZC0_PROB ,  
           @ZC0_UNID ,  
           @ZC0_ASSUNT ,  
           @ZC0_CODARE ,  
           '' ,  
           @Recno ,  
           0,  
           @ZC0_MAT  ,  
           @ZC0_DEPART ,  
           @ZC0_ENV  ,  
           @ZC0_MAILEN ,  
           @ZC0_CPO1 ,  
           @ZC0_CPO2 ,  
           @ZC0_CP3  ,  
           @ZC0_VAL1 ,  
           @ZC0_VAL2 ,  
           @ZC0_VAL3 ,  
     cast(@ZC0_TEXTO as varbinary),  
     @ZC0_ITENCT  ,
	  @ZC0_ATEND2,
	  @ZC0_SUPER2
     )  
  
 SELECT * FROM ZC0100 WHERE [R_E_C_N_O_]=@Recno  
  
GO
/****** Object:  StoredProcedure [dbo].[InsertZC1]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
** Autor > DAniel Pitthan Silveira 
** Data  > 26/04/2021 
** 
** Faz o insert natabela ZC1

	EXEMPLO

	EXEC InsertZC1 '04','0000000001','20210426','1902','Em uma chuva de XUXA no meu colo cai Pelé, ou não!','GOKU','S'


*/

create       procedure [dbo].[InsertZC1]
		(	@ZC1_FILIAL varchar(2),
           @ZC1_NUM varchar(10),
           @ZC1_DTINC varchar(8),
           @ZC1_HRINC varchar(4),
           @ZC1_TEXTO varchar(MAX),
		   @ZC1_USERN VARCHAR(Max),
		   @ZC1_ATEND VARCHAR(1))
As
Declare @Recno bigint   
declare @Usuario varchar(50)

Set @Usuario = SUBSTRING(@ZC1_USERN,1,50)

/*Obtem o próximo Recno */  
set @Recno = (select isnull(max(R_E_C_N_O_),0) from [ZC1100])+1  

  
INSERT INTO [dbo].[ZC1100]
           ([ZC1_FILIAL]
           ,[ZC1_NUM]
           ,[ZC1_DTINC]
           ,[ZC1_HRINC]
           ,[ZC1_TEXTO]
           ,[D_E_L_E_T_]
           ,[R_E_C_N_O_]
           ,[R_E_C_D_E_L_]
		   ,ZC1_USERN
		   ,ZC1_ATEND)
     VALUES
          (	@ZC1_FILIAL ,
           @ZC1_NUM		,
           CAST(YEAR(GETDATE()) AS varchar(4))+RIGHT('00'+CAST(MONTH(GETDATE()) AS varchar(2)),2)+RIGHT('00'+CAST(DAY(GETDATE()) AS varchar(2)),2)	,
           @ZC1_HRINC	,
           cast(@ZC1_TEXTO	as varbinary(Max)),
           ''	,
           @Recno	,
           0,
		   @Usuario,
		   @ZC1_ATEND)



	--Atualiza o status do Ticket para o código Aguardando Procisa
	--UPDATE ZC0100 SET ZC0_STATUS='0003' 
	--WHERE ZC0_NUM = @ZC1_NUM AND ZC0_FILIAL=@ZC1_FILIAL
  
 SELECT CAST(ZC1_TEXTO AS varchar(MAX)) as ZC1_TEXTO_String,* FROM [ZC1100] WHERE [R_E_C_N_O_]=@Recno 

GO
/****** Object:  StoredProcedure [dbo].[SOMA1]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
** Incrementa o alfa numericos 
** Daniel Pitthan Silveira - ExceptionBrasil.com.br
** 31/08/2020

Exemplo : declare @OUT_RESULTADO VarChar(100) 
			EXEC SOMA1 '0000000004' ,'N', @OUT_RESULTADO 
			select @OUT_RESULTADO

*/

CREATE   PROCEDURE [dbo].[SOMA1]
(
@IN_SOMAR      VarChar(100),
@IN_SOMALOW    Char(01),
@OUT_RESULTADO VarChar(100) output
)
as

Declare @iAux     integer
Declare @iTamOri  integer
Declare @iNx      integer
Declare @cNext    Char(01)
Declare @cSpace   Char
(01)
Declare @cRef     VarChar(1)
Declare @cResult  VarChar(100)
Declare @iTamStr  integer

begin
select @iTamStr = ( Len( @IN_SOMAR + '#' ) - 1 )
select @iTamOri = ( Len( @IN_SOMAR + '#' ) - 1 )
select @iAux = 1
select @iNx  = 1
select @cRef = ' '
select

 @cNext   = '0'
select @cSpace  = '0'
select @cResult = ' '

 if @IN_SOMAR = Replicate( '*', @iTamOri) begin
select @OUT_RESULTADO = @IN_SOMAR
return @OUT_RESULTADO

end
else begin
While @iTamStr >= @iNx begin
select @cRef = Substring(  @IN_SOMAR + '#' , @iTamStr , 1 )
if @cRef = ' ' begin
select @cResult = ' ' + @cResult
select @cNext = '1'
select @cSpace = '1'
end
else if @IN_SOMAR = ( Replicate('z',  @iTamOri )) begin
select @cResult = ( Replicate('*',  @iTamOri ))
break
end
else if @cRef < '9' begin
select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1) ) + Char( Ascii( @cRef ) + 1 ) + @cResult
select @cNext = '0'
end
else if ( @cRef = '9' and @iTamStr > 1 ) begin
If
 ( Substring( @IN_SOMAR,  @iTamStr - 1 ,1 ) <= '9'  and  Substring( @IN_SOMAR, @iTamStr - 1 ,1 ) <> ' ') begin
select @cResult = '0' + @cResult
select @cNext = '1'
end
else if ( Substring( @IN_SOMAR, ( @iTamStr -1 ), 1 ) = ' ' ) begin
select @cResult = Substring( @IN_SOMAR,1,( @iTamStr - 2 ) ) + '10' + @cResult
select @cNext = '0'
end
else begin
select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 ) ) + 'A' + @cResult
select @cNext = '0'
end
end
else if @cRef = '9' and ( @iTamStr = 1 ) and ( @cSpace 

= '1' ) begin
select @cResult = '10' + Substring( @cResult, 1, ( Len( @cResult + '#' ) - 1) )
select @cNext = '0'
end
else if @cRef = '9' and @iTamStr = 1 and @cSpace = '0' begin
select @cResult = 'A' + @cResult
select @cNext ='0'
end
else if @cRef > '9' 

and @cRef < 'Z' begin
select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 ) ) + Char( ( Ascii( @cRef )+ 1 ) ) + @cResult
select @cNext = '0'
end
else if @cRef > 'Z' and @cRef < 'z' begin
select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 )) +

 Char((Ascii( @cRef ) + 1)) + @cResult
select @cNext = '0'
end
else if @cRef = 'Z' and @IN_SOMALOW = '1' begin
select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 )) + 'a' + @cResult
select @cNext = '0'
end
else if ( @cRef='z' or @cRef = 'Z') and @cSpace = '1' begin
select @cResult = Substring( @IN_SOMAR, 1, @iTamStr ) + '0' + Substring( @cResult, 1, ( Len( @cResult +'#' ) - 2 ))
select @cNext = '0'
end
else if @cRef = 'z' or @cRef = 'Z' begin
select @cResult = '0' + @cResult
select @cNext = '1'
end


if @cNext = '0' break
select @iTamStr = @iTamStr - 1
End
set @OUT_RESULTADO = @cResult
return @OUT_RESULTADO
end
end




GO
/****** Object:  StoredProcedure [dbo].[UpdateZC0]    Script Date: 08/05/2021 16:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
** Autor :Daniel Pitthan Silveira - exception Brasil
** Descri :Realiza o update na ZC0
**
*/
CREATE     procedure [dbo].[UpdateZC0]
	  (    @Recno bigint,
		   @ZC0_TEXTO       varchar(8000),
		   @ZC0_FILIAL		varchar(2),
           @ZC0_NUM			varchar(10),
           @ZC0_TITULO		varchar(80),
           @ZC0_PRIO		varchar(1),
           @ZC0_STATUS		varchar(4),
           @ZC0_CC			varchar(9),
           @ZC0_DTINC		varchar(8),
           @ZC0_HRINC		varchar(4),
           @ZC0_DTENC		varchar(8),
           @ZC0_HRFECH		varchar(4),
           @ZC0_UIDINC		varchar(6),
           @ZC0_UIDENC		varchar(6),
           @ZC0_MATI		varchar(6),
           @ZC0_MATE		varchar(6),
           @ZC0_EMAILD		varchar(254),
           @ZC0_EMIALU		varchar(254),
           @ZC0_TEL			varchar(20),
           @ZC0_ANEXOS		varchar(6),
           @ZC0_PROB		varchar(4),
           @ZC0_UNID		varchar(4),
           @ZC0_ASSUNT		varchar(4),
           @ZC0_CODARE		varchar(4),
           @ZC0_MAT			varchar(6),
           @ZC0_DEPART		varchar(4),
           @ZC0_ENV			float,
           @ZC0_MAILEN		varchar(254),
           @ZC0_CPO1		varchar(4),
           @ZC0_CPO2		varchar(6),
           @ZC0_CP3			varchar(80),
           @ZC0_VAL1		float,
           @ZC0_VAL2		float,
           @ZC0_VAL3		float)
As
update [dbo].[ZC0100] set 
            [ZC0_FILIAL]  = @ZC0_FILIAL    
           ,[ZC0_NUM]	  = @ZC0_NUM			
           ,[ZC0_TITULO]  = @ZC0_TITULO			
           ,[ZC0_PRIO]	  = @ZC0_PRIO		
           ,[ZC0_STATUS]  = @ZC0_STATUS		
           ,[ZC0_CC]	  = @ZC0_CC			
           ,[ZC0_DTINC]	  = @ZC0_DTINC		
           ,[ZC0_HRINC]	  = @ZC0_HRINC		
           ,[ZC0_DTENC]	  = @ZC0_DTENC		
           ,[ZC0_HRFECH]  = @ZC0_HRFECH		
           ,[ZC0_UIDINC]  = @ZC0_UIDINC		
           ,[ZC0_UIDENC]  = @ZC0_UIDENC		
           ,[ZC0_MATI]	  = @ZC0_MATI		
           ,[ZC0_MATE]	  = @ZC0_MATE		
           ,[ZC0_EMAILD]  = @ZC0_EMAILD		
           ,[ZC0_EMIALU]  = @ZC0_EMIALU		
           ,[ZC0_TEL]	  = @ZC0_TEL		
           ,[ZC0_ANEXOS]  = @ZC0_ANEXOS			
           ,[ZC0_PROB]	  = @ZC0_PROB		
           ,[ZC0_UNID]	  = @ZC0_UNID		
           ,[ZC0_ASSUNT]  = @ZC0_ASSUNT		
           ,[ZC0_CODARE]  = @ZC0_CODARE		          
           ,[ZC0_MAT]	  = @ZC0_MAT			
           ,[ZC0_DEPART]  = @ZC0_DEPART		
           ,[ZC0_ENV]	  = @ZC0_ENV		
           ,[ZC0_MAILEN]  = @ZC0_MAILEN		
           ,[ZC0_CPO1]	  = @ZC0_CPO1			
           ,[ZC0_CPO2]	  = @ZC0_CPO2		
           ,[ZC0_CP3]	  = @ZC0_CP3		
           ,[ZC0_VAL1]	  = @ZC0_VAL1		
           ,[ZC0_VAL2]	  =	@ZC0_VAL2	
           ,[ZC0_VAL3]	  =	@ZC0_VAL3	
		   ,[ZC0_TEXTO]	  =Cast(@ZC0_TEXTO as varbinary)
     where [R_E_C_N_O_]=@Recno

	SELECT * FROM ZC0100 WHERE [R_E_C_N_O_]=@Recno

GO
