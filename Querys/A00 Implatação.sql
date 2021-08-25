
create table ControleLogin(
	Id int identity not null primary key,
	RD0_CODIGO varchar(6),
	IsLogged bit,
	DataLastLogin Datetime,
	DataExpiracao DateTime
)
go 
create index Ix_ControleLogin_001 on ControleLogin (RD0_CODIGO) include (IsLogged)
go
CREATE TABLE [dbo].[ImagensTickets](
	[Id] [int] IDENTITY(1,1) NOT NULL primary key,
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
	ZC0_NUM varchar(10)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ImagensTickets] ADD  DEFAULT (getdate()) FOR [DataInclusao]
GO

ALTER TABLE [dbo].[ImagensTickets] ADD  DEFAULT ((1)) FOR [Ativo]
GO

sp_helptext InsertZC1
/*
** Data: 10/09/2020
** Autor: Daniel Pitthan Silveira - Exception Brasil
** Procedure para inserção na ZC1 - historico do ticket 
*/

create or alter   procedure InsertZC1
		(	@ZC1_FILIAL varchar(2),
           @ZC1_NUM varchar(10),
           @ZC1_DTINC varchar(8),
           @ZC1_HRINC varchar(4),
           @ZC1_TEXTO varchar(8000))
As
Declare @Recno bigint   
  
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
           ,[R_E_C_D_E_L_])
     VALUES
          (	@ZC1_FILIAL ,
           @ZC1_NUM		,
           @ZC1_DTINC	,
           @ZC1_HRINC	,
           cast(@ZC1_TEXTO	as varbinary),
           ''	,
           @Recno	,
           0)

  
 SELECT * FROM [ZC1100] WHERE [R_E_C_N_O_]=@Recno  
GO


/*
	Realiza o insert na ZC0
*/
CREATE     procedure InsertZC0
	  (   @ZC0_TEXTO       varchar(8000),
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
           @ZC0_VAL3		float,
		   @ZC0_ITENCT		VARCHAR(09))
As

Declare @Recno bigint 

/*Obtem o próximo Recno */
set @Recno = (select max(R_E_C_N_O_) from ZC0100)+1

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
		   [ZC0_ITENCT])
     VALUES
            (  
		   @ZC0_FILIAL ,
           @ZC0_NUM	   ,
           @ZC0_TITULO ,
           @ZC0_PRIO   ,
           @ZC0_STATUS ,
           @ZC0_CC	   ,
           @ZC0_DTINC  ,
           @ZC0_HRINC  ,
           @ZC0_DTENC  ,
           @ZC0_HRFECH	,
           @ZC0_UIDINC	,
           @ZC0_UIDENC	,
           @ZC0_MATI	,
           @ZC0_MATE	,
           @ZC0_EMAILD	,
           @ZC0_EMIALU	,
           @ZC0_TEL		,
           @ZC0_ANEXOS	,
           @ZC0_PROB	,
           @ZC0_UNID	,
           @ZC0_ASSUNT	,
           @ZC0_CODARE	,
           ''	,
           @Recno	,
           0,
           @ZC0_MAT		,
           @ZC0_DEPART	,
           @ZC0_ENV		,
           @ZC0_MAILEN	,
           @ZC0_CPO1	,
           @ZC0_CPO2	,
           @ZC0_CP3		,
           @ZC0_VAL1	,
           @ZC0_VAL2	,
           @ZC0_VAL3	,
		   cast(@ZC0_TEXTO	as varbinary),
		   @ZC0_ITENCT
		   )

	SELECT * FROM ZC0100 WHERE [R_E_C_N_O_]=@Recno




go

Create table WorkFlow_PortalDeChamados(
	Id int identity not null primary key,
	DataInclusao DateTime Default(GetDate()),
	EmailDestino Varchar(8000) not null,
	DataEnvio DateTime Null,
	EnvioOK Bit default(0),
	Assunto Varchar(517),
	CorpoEmail VArchar(8000),	
)
go
alter table ImagensTickets Add WorkflowId int
go
alter table ImagensTickets add constraint FK_ImagensTickets_WorkFlow_PortalDeChamados foreign key (WorkflowId) references WorkFlow_PortalDeChamados (Id)
GO
/*
** Incrementa o alfa numericos 
** Daniel Pitthan Silveira - ExceptionBrasil.com.br
** 31/08/2020

Exemplo : declare @OUT_RESULTADO VarChar(100) 
			EXEC SOMA1 '0000000004' ,'N', @OUT_RESULTADO 
			select @OUT_RESULTADO

*/

CREATE   PROCEDURE SOMA1
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
select @cRef = Substring(  @IN_SOMAR + '#' , 
@iTamStr , 1 )
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
go
create table ParametrosOnline (
	Id int identity not null primary key,
	Codigo varchar(20),
	Conteudo varchar(255),
	Descricao Varchar(717)
)
go 
create index Ix_ParametrosOnLine on ParametrosOnline (Codigo)
go
alter table WorkFlow add [Key] varchar(20)