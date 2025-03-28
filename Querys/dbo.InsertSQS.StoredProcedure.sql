USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[InsertSQS]    Script Date: 25/08/2021 14:23:12 ******/
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
,@DetalheDaVaga varchar(max)=''
)
As

	Declare @Recno bigint 
	Declare @RecnoRDY bigint 
	Declare @Vaga varchar(6)

	declare  @chaveMemo varchar(6)  = (select MAX(QS_CODPERF) from SQS100)
	Exec SOMA1 @chaveMemo,'N',@QS_CODPERF out

	--SE FOR NOVA VAGA GERA O CÓDIGO DA VAGA 
	IF @QS_VAGA='' OR @QS_VAGA IS NULL 
	BEGIN 
		Declare @CodVagaAtaul varchar(6)='        '
		Declare @NovoCodVaga varchar(6) ='        '
		SET @CodVagaAtaul = (Select MAX(QS_VAGA) from SQS100)
		EXEC SOMA1 @CodVagaAtaul,'N',@NovoCodVaga OUT

		SET @QS_VAGA = @NovoCodVaga
	END 
	 

--iNCLUSÃO 
If Not Exists (SELECT 0 FROM SQS100 WHERE QS_VAGA=@QS_VAGA )
Begin 

	set @Recno  = (Select MAX(R_E_C_N_O_)+1 from SQS100)

	

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


--ALTERAÇÃO 
If Exists (SELECT 0 FROM SQS100 WHERE QS_VAGA=@QS_VAGA )
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

		Declare @CODIGO  varchar(5)=(SELECT MAX(RH3_CODIGO) FROM RH3100)
		Declare @NOVO_CODIGO varchar(5) ='        '
		EXEC SOMA1 @CODIGO,'N',@NOVO_CODIGO OUT

		

	
	insert into RH3100
	(RH3_FILIAL,RH3_CODIGO,RH3_TIPO,RH3_ORIGEM,RH3_STATUS,RH3_DTSOLI,RH3_NVLINI,RH3_FILINI,RH3_MATINI ,RH3_NVLAPR,R_E_C_N_O_,D_E_L_E_T_,RH3_FLUIG,RH3_EMP,RH3_EMPINI,RH3_EMPAPR) VALUES
	(@QS_FILIAL,@NOVO_CODIGO  ,'5'     ,'PORTAL'  ,'4'      ,@QS_DTABERT,'0'       ,@QS_FILIAL,@QS_MATRESP,'99'      ,@RecnoRH3 ,''        ,0,'10','10','10')

	
	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)
	Insert into RH4100
	(RH4_FILIAL,	RH4_CODIGO,	RH4_ITEM,	RH4_CAMPO,	RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) VALUES
	(@QS_FILIAL,	@NOVO_CODIGO,	'1',		'TMP_VAGA',	'',			@QS_VAGA,	'',			@RecnoRH4)

	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)
	Insert into RH4100
	(RH4_FILIAL,	RH4_CODIGO,	RH4_ITEM,	RH4_CAMPO,	RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) VALUES
	(@QS_FILIAL,	@NOVO_CODIGO,	'2',		'TMP_DESC',	'',			@QS_DESCRIC,	'',			@RecnoRH4)

	set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)
	Insert into RH4100
	(RH4_FILIAL,	RH4_CODIGO,	RH4_ITEM,	RH4_CAMPO,	RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) VALUES
	(@QS_FILIAL,	@NOVO_CODIGO,	'3',		'TMP_SITUAC',	'',			'4',	'',			@RecnoRH4)

End


---------------------------------------------------------------------------------------------------
-- Retorna para a procedure 
---------------------------------------------------------------------------------------------------


 SELECT * FROM SQS100 WHERE [R_E_C_N_O_]=@Recno 

GO
