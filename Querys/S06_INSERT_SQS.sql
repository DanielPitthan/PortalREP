Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
** Autor Daniel P Silveira 
** Data 01/04/2021
** Faz o insert na Tabela SQS - Cadastro de Vaga

*/

CREATE     procedure InsertSQS
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

,@QS_CC			varchar	(13 )
,@QS_XDPROJE	varchar	(90 )
,@QS_XITEM		varchar	(13 )
,@QS_XDESITE	varchar	(40 )
,@QS_XFILVAG	varchar	(2  )
,@QS_TIPO		varchar	(1  )
,@QS_TESTE		varchar	(3  )
,@QS_PONTOS		float	(8  )
--,@QS_AUTOM		varchar	(1  )
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

	declare  @chaveMemo varchar(6)  = (select MAX(QS_CODPERF) from SQS100_PRECAD)
	Exec SOMA1 @chaveMemo,'N',@QS_CODPERF out

	--SE FOR NOVA VAGA GERA O CÓDIGO DA VAGA 
	IF @QS_VAGA='' OR @QS_VAGA IS NULL 
	BEGIN 
		Declare @CodVagaAtaul varchar(6)='        '
		Declare @NovoCodVaga varchar(6) ='        '
		SET @CodVagaAtaul = (Select MAX(QS_VAGA) from SQS100_PRECAD)
		EXEC SOMA1 @CodVagaAtaul,'N',@NovoCodVaga OUT

		SET @QS_VAGA = @NovoCodVaga
	END 
	 


------------------------------------------------------------------------
-- GRAVA RDY
------------------------------------------------------------------------

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



	Declare @CODIGO  varchar(5)=(SELECT MAX(RH3_CODIGO) FROM RH3100)
	Declare @NOVO_CODIGO varchar(5) ='        '
	EXEC SOMA1 @CODIGO,'N',@NOVO_CODIGO OUT		



---------------------------------------------------------------------------------------------------
-- GRAVA RH3 E RH4 
---------------------------------------------------------------------------------------------------

Declare @RecnoRH3 bigint 

Declare @RecnoRH4 bigint 


	set @RecnoRH3  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH3100),0)

	--Busca na SQB o responsável 
	declare @depsup varchar(19)
	DECLARE @MATAPR VARCHAR(6)
	DECLARE @FILAPR VARCHAR(2)
	DECLARE @KEYINI VARCHAR(60)
	DECLARE @DEPTO VARCHAR(19)
	DECLARE @QBDESCRIC VARCHAR(30)

	SELECT TOP 1 @depsup=QB_DEPSUP, @DEPTO=QB_DEPTO,@QBDESCRIC= QB_DESCRIC
	FROM SQB100 
	WHERE QB_MATRESP=@QS_MATRESP  AND
		--QB_FILRESP=@QS_XFILVAG and 
		   D_E_L_E_T_=''

		

	select top 1 @MATAPR = QB_MATRESP, @FILAPR = QB_FILRESP, @KEYINI = QB_KEYINI
	from SQB100
	WHERE QB_DEPTO = @depsup

	--BUSCA O POSTO 
	DECLARE @POSTO VARCHAR(9)=''

	SELECT @POSTO =ISNULL(RBU_POSTO,'Novo')
	FROM RBU100
	WHERE RBU_FILFUN=@QS_XFILVAG
		   AND RBU_MATFUN=@QS_XDEMITI

	DECLARE @DESC_CC VARCHAR(40)

	SELECT @DESC_CC=CTT_DESC01
	FROM CTT100
	WHERE CTT_CUSTO=@QS_CC

	--GRAVA RH3
	--insert into RH3100
	--(RH3_FILIAL,RH3_CODIGO    ,RH3_TIPO,RH3_ORIGEM,RH3_STATUS,RH3_DTSOLI ,RH3_NVLINI,RH3_FILINI  ,RH3_MATINI ,RH3_NVLAPR,R_E_C_N_O_,D_E_L_E_T_,RH3_FLUIG,RH3_EMP,RH3_EMPINI,RH3_EMPAPR,RH3_MAT,RH3_FILAPR,RH3_KEYINI,RH3_MATAPR,RH3_VISAO) VALUES
	--(@QS_XFILVAG,@NOVO_CODIGO  ,'5'     ,'PORTAL'  ,'1'      ,@QS_DTABERT,'2'      ,@QS_XFILVAG ,@QS_MATRESP ,'0'       ,@RecnoRH3 ,''        ,0,'10','10','10',@QS_MATRESP,@FILAPR,@KEYINI,@MATAPR,'000002')



	CREATE TABLE #_TMP
	(
	 RH4_FILIAL	  varchar	(2   )
	,RH4_CODIGO	  varchar		(5	 )
	,RH4_ITEM	  float		(8	 )
	,RH4_CAMPO	  varchar		(10	 )
	,RH4_VALANT	  varchar		(100 )
	,RH4_VALNOV	  varchar		(100 )
	,D_E_L_E_T_	  varchar		(1	 )	
	,R_E_C_D_E_L_ INT
	)

	--Obtem  o departamento 
	--INSERT INTO #_TMP
	--(RH4_FILIAL,	RH4_CODIGO  ,	RH4_ITEM,RH4_CAMPO ,RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_) VALUES
	
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'2'     ,'RB7_FILIAL',''        ,@QS_XFILVAG,''    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'3'     ,'RB7_MAT   ',''        ,@QS_MATRESP,''     ),	
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'7'     ,'RB7_TPALT ',''        ,'003'  ,''			),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'10'     ,'RB7_FUNCAO',''        ,@QS_FUNCAO  ,''    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'11'     ,'RB7_CARGO ',''        ,@QS_FUNCAO  ,''    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'14'     ,'RB7_PERCEN',''        ,'0'  ,''			),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'15'     ,'RB7_SALARI',''        ,'0'  ,''			),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'18'     ,'RB7_CATEG ',''        ,'M'  ,''           ),

	--(@QS_XFILVAG,	@NOVO_CODIGO,	'1'     ,'RBT_FILIAL',''        ,@QS_XFILVAG,''      ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'4'     ,'RBT_DEPTO ',''        ,ISNULL(@DEPTO ,'') ,''    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'8'     ,'RBT_CC    ',''        ,@QS_CC  ,''        ),	
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'12'     ,'RBT_FUNCAO',''        ,@QS_FUNCAO  ,''    ),	
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'16'     ,'RBT_CARGO ',''        ,@QS_FUNCAO  ,''    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'19'     ,'RBT_REMUNE',''        ,'100.00'  ,''         ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'20'     ,'RBT_TPOSTO',''        ,'1'  ,''		    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'21'     ,'RBT_TPCONT',''        ,'1'  ,''		    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'22'     ,'RBT_QTDMOV',''        ,'1'  ,''		    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'23'     ,'RBT_JUSTIF',''        ,'01'  ,''		    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'24'     ,'RBT_TIPOR ',''        ,'1'  ,''		    ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'25'     ,'RBT_CODPOS',''        ,@POSTO  ,''    ),
	
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'26'     ,'TMP_NOVACO',''        ,'1'  ,''           ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'6'     ,'TMP_NOME  ',''        ,''  ,''			),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'5'     ,'TMP_DDEPTO',''        ,@QS_DESCRIC  ,''   ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'9'     ,'TMP_DCC   ',''        ,@QS_XDESITE  ,''   ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'13'     ,'TMP_DFUNCA',''        ,@QS_XFUNCAO  ,''   ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'17'     ,'TMP_DCARGO',''        ,@QS_XFUNCAO  ,''   ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'17'     ,'TMP_TIPO  ',''        ,'2'  ,''   ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'17'     ,'TMP_FILIAL  ',''        ,@QS_XFILVAG  ,''   ),
	--(@QS_XFILVAG,	@NOVO_CODIGO,	'17'     ,'TMP_MAT     ',''        ,@QS_XDEMITI  ,''   )

	IF @QS_XFINALI ='2' --SUBSTITUIÇÃO
	BEGIN
		INSERT INTO #_TMP
		(RH4_FILIAL,	RH4_CODIGO  ,	RH4_ITEM,RH4_CAMPO ,RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_) VALUES
		(@QS_XFILVAG,	@NOVO_CODIGO,	'1'     ,'RBT_DEPTO ',''        ,ISNULL(@DEPTO ,'') ,''    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'2'     ,'RBT_CODPOS',''        ,@POSTO  ,''    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'3'     ,'TMP_TIPO  ',''        ,'2'  ,''   ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'4'     ,'TMP_FILIAL  ',''        ,@QS_XFILVAG  ,''   ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'5'     ,'TMP_MAT     ',''        ,@QS_XDEMITI  ,''   )

		--GRAVA RH3
		insert into RH3100
	(RH3_FILIAL,RH3_CODIGO    ,RH3_TIPO,RH3_ORIGEM,RH3_STATUS,RH3_DTSOLI ,RH3_NVLINI,RH3_FILINI  ,RH3_MATINI ,RH3_NVLAPR,R_E_C_N_O_,D_E_L_E_T_,RH3_FLUIG,RH3_EMP,RH3_EMPINI,RH3_EMPAPR,RH3_MAT,RH3_FILAPR,RH3_KEYINI,RH3_MATAPR,RH3_VISAO) VALUES
	(@QS_XFILVAG,@NOVO_CODIGO  ,'5'     ,'PORTAL'  ,'1'      ,@QS_DTABERT,'1'      ,@QS_XFILVAG ,@QS_MATRESP ,'0'       ,@RecnoRH3 ,''        ,0,'10','10','10',@QS_MATRESP,@FILAPR,'001001001           ',@MATAPR,'000002')

	END


	IF @QS_XFINALI ='1' --AUMENTO DE QUADRO
	BEGIN
		INSERT INTO #_TMP
		(RH4_FILIAL,	RH4_CODIGO  ,	RH4_ITEM,RH4_CAMPO ,RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_) VALUES
		(@QS_XFILVAG,	@NOVO_CODIGO,	'1'     ,'RBT_FILIAL',''        ,@QS_XFILVAG,''      ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'2'     ,'RBT_DEPTO ',''        ,ISNULL(@DEPTO ,'') ,''    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'3'     ,'TMP_DDEPTO',''        ,@QBDESCRIC  ,''   ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'4'     ,'RBT_CC    ',''        ,@QS_CC  ,''        ),	
		(@QS_XFILVAG,	@NOVO_CODIGO,	'5'     ,'TMP_DCC   ',''        ,@DESC_CC  ,''   ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'6'     ,'RBT_FUNCAO',''        ,@QS_FUNCAO  ,''    ),	
		(@QS_XFILVAG,	@NOVO_CODIGO,	'7'     ,'TMP_DFUNCA',''        ,@QS_XFUNCAO  ,''   ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'8'     ,'RBT_CARGO ',''        ,@QS_FUNCAO  ,''    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'9'     ,'TMP_DCARGO',''        ,@QS_XFUNCAO  ,''   ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'10'     ,'RBT_REMUNE',''        ,'0.00'  ,''         ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'11'     ,'RBT_TPOSTO',''        ,'1'  ,''		    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'12'     ,'RBT_TPCONT',''        ,'1'  ,''		    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'13'     ,'RBT_QTDMOV',''        ,'1'  ,''		    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'14'     ,'RBT_JUSTIF',''        ,'01'  ,''		    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'15'     ,'RBT_TIPOR ',''        ,'1'  ,''		    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'16'     ,'RBT_CODPOS',''        ,'Novo'  ,''    ),
		(@QS_XFILVAG,	@NOVO_CODIGO,	'17'     ,'TMP_NOVACO',''        ,'1'  ,''           )

		--GRAVA RH3
		insert into RH3100
		(RH3_FILIAL,RH3_CODIGO    ,RH3_TIPO,RH3_ORIGEM,RH3_STATUS,RH3_DTSOLI ,RH3_NVLINI,RH3_FILINI  ,RH3_MATINI ,RH3_NVLAPR,R_E_C_N_O_,D_E_L_E_T_,RH3_FLUIG,RH3_EMP,RH3_EMPINI,RH3_EMPAPR,RH3_MAT,RH3_FILAPR,RH3_KEYINI,RH3_MATAPR,RH3_VISAO) VALUES
		(@QS_XFILVAG,@NOVO_CODIGO  ,'3'     ,'PORTAL'  ,'1'      ,@QS_DTABERT,'1'      ,@QS_XFILVAG ,@QS_MATRESP ,'0'       ,@RecnoRH3 ,''        ,0,'10','10','10',@QS_MATRESP,@FILAPR,'001001              ',@MATAPR,'000002')

	END


	
	--GRAVA O RH4
	
	While EXISTS (SELECT 1 FROM #_TMP)
	Begin 

		set @RecnoRH4  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RH4100),0)

		Insert into RH4100
		(RH4_FILIAL,	RH4_CODIGO  ,	RH4_ITEM,RH4_CAMPO ,RH4_VALANT,	RH4_VALNOV,	D_E_L_E_T_,	R_E_C_N_O_) 
		SELECT TOP 1
			 RH4_FILIAL	 
			,RH4_CODIGO	 
			,RH4_ITEM	 
			,RH4_CAMPO	 
			,RH4_VALANT	 
			,RH4_VALNOV	 
			,D_E_L_E_T_	 
			,@RecnoRH4
		 FROM #_TMP

		 delete top(1) from #_TMP
	End


---------------------------------------------------------------------------------------------------
-- GRAVA RGK
---------------------------------------------------------------------------------------------------
Declare @RecnoRGK bigint 
	set @RecnoRGK  =  Isnull((Select MAX(R_E_C_N_O_)+1 from RGK100),0)
	
	INSERT INTO RGK100 (RGK_FILIAL , RGK_MAT    ,RGK_CODIGO,RGK_SEQUEN   ,RGK_DATA   ,RGK_FILAPR       ,RGK_MATAPR    ,RGK_CODCON,RGK_OPERAC,RGK_EMP,R_E_C_N_O_,D_E_L_E_T_,R_E_C_D_E_L_) VALUES
	                   (@QS_XFILVAG, @QS_MATRESP,@NOVO_CODIGO,'000001'   ,@QS_DTABERT,@QS_XFILVAG      ,@QS_MATRESP   ,@QS_CODPERF  ,'1','10',@RecnoRGK,'',0)




---------------------------------------------------------------------------------------------------
-- GRAVA WF3100
---------------------------------------------------------------------------------------------------

DECLARE @WF3_IDATU VARCHAR(100 ) = (Select MAX(WF3_ID) from WF3100)
	DECLARE @WF3_ID VARCHAR(100)
	Exec MSSOMA1_EB @WF3_IDATU,'N',@WF3_ID out
	

Declare @RecnoWF3 bigint 
	set @RecnoWF3  =  Isnull((Select MAX(R_E_C_N_O_)+1 from WF3100),0)

	
INSERT INTO dbo.WF3100(WF3_FILIAL  ,WF3_ID,WF3_PROC,WF3_STATUS,WF3_HORA  ,WF3_DATA   ,WF3_DESC,R_E_C_N_O_) 
VALUES                ( @QS_XFILVAG,@WF3_ID   ,'SOLICP','000001'  ,'00:00:00',@QS_DTABERT,'[ EV_NEWPROC      ] Processo iniciado                                                               ',@RecnoWF3)





--iNCLUSÃO 
If Not Exists (SELECT 0 FROM SQS100_PRECAD WHERE QS_VAGA=@QS_VAGA )
Begin 

	set @Recno  = (Select MAX(R_E_C_N_O_)+1 from SQS100_PRECAD)

	

	--Insert da Vaga 
	Insert into SQS100_PRECAD (
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
	,QS_CC
	,QS_XDPROJE
	,QS_XITEM
	,QS_XDESITE
	,QS_XFILVAG
	,QS_TIPO
	,QS_TESTE
	,QS_PONTOS	
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
	,QS_XNOMESE
	,SQS_RH3COD) values
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
	,@QS_CC
	,@QS_XDPROJE
	,@QS_XITEM
	,@QS_XDESITE
	,@QS_XFILVAG
	,@QS_TIPO
	,@QS_TESTE
	,@QS_PONTOS	
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
	,@NOVO_CODIGO)	


	

End


--ALTERAÇÃO 
If Exists (SELECT 0 FROM SQS100_PRECAD WHERE QS_VAGA=@QS_VAGA )
Begin 
	
	update SQS100_PRECAD 
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
	
	,QS_CC		=@QS_CC
	,QS_XDPROJE	=@QS_XDPROJE
	,QS_XITEM	=@QS_XITEM
	,QS_XDESITE	=@QS_XDESITE
	,QS_XFILVAG	=@QS_XFILVAG
	,QS_TIPO	=@QS_TIPO
	,QS_TESTE	=@QS_TESTE
	,QS_PONTOS	=@QS_PONTOS
	
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
	,SQS_RH3COD = @NOVO_CODIGO
	WHERE QS_VAGA = @QS_VAGA AND QS_FILIAL=@QS_FILIAL

End


---------------------------------------------------------------------------------------------------
-- Retorna para a procedure 
---------------------------------------------------------------------------------------------------


 SELECT * FROM SQS100_PRECAD WHERE [R_E_C_N_O_]=@Recno 



Completion time: 2021-06-21T08:36:32.5513260-03:00
