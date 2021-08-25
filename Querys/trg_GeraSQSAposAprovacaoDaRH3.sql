Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE   TRIGGER trg_GeraSQSAposAprovacaoDaRH3
on RH3100
AFTER UPDATE
AS
	If (select TOP 1 1 from inserted AS I WITH(NOLOCK) 
		WHERE I.RH3_STATUS='2')=1
	BEGIN 
		
		Declare @Recno bigint 
		Declare @QS_VAGA		varchar	(6)
		Declare @CodVagaAtaul varchar(6)='        '
		SET @CodVagaAtaul = (Select MAX(QS_VAGA) from SQS100)
		EXEC SOMA1 @CodVagaAtaul,'N',@QS_VAGA OUT



		

		--iNCLUSÃO 
		If Not Exists (SELECT TOP 1 0 FROM SQS100 WHERE QS_VAGA=@QS_VAGA )
		Begin 

			set @Recno  = (Select MAX(R_E_C_N_O_)+1 from SQS100)

	

			--Insert da Vaga 
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
			,QS_XNOMESE) 
			
			SELECT 
			 QS_FILIAL
			,@QS_VAGA
			,QS_XFINALI
			,QS_XMOTIV
			,QS_XSUSBMO
			,QS_XDEMITI
			,ISNULL(RA.RA_NOME,'')
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
			,ISNULL(R6.R6_DESC,'')
			,QS_XJORNAD
			,QS_XMPONTO
			,QS_XBCOHS
			,QS_XRESPPO
			,Isnull(RAe.RA_NOME,'')
			,QS_XAPOPON
			,IsNull(RAa.RA_NOME,'') 
			,''		--@D_E_L_E_T_
			,@Recno
			,0		--@R_E_C_D_E_L_
			,QS_XSELECI
			,QS_XNOMESE
			FROM SQS100_PRECAD as p with(nolock)
				JOIN inserted as i with(nolock) on i.RH3_CODIGO=p.SQS_RH3COD 
				LEFT JOIN SRA100 AS RA WITH (NOLOCK) ON p.QS_XFILVAG =RA.RA_FILIAL  AND  RA.RA_MAT = p.QS_XDEMITI
				LEFT JOIN SRA100 AS RAe WITH (NOLOCK) ON p.QS_XFILVAG =RAe.RA_FILIAL  AND  RAe.RA_MAT = p.QS_XRESPPO
				LEFT JOIN SRA100 AS RAa WITH (NOLOCK) ON p.QS_XFILVAG =RAa.RA_FILIAL  AND  RAa.RA_MAT = p.QS_XAPOPON
				LEFT JOIN SR6100 AS R6 WITH(NOLOCK) ON p.QS_XTURNO = R6.R6_TURNO
			
			--update SQS100_PRECAD SET QS_VAGA = @QS_VAGA
			--FROM SQS100_PRECAD as p with(nolock)
			--	JOIN inserted as i with(nolock) on i.RH3_CODIGO=p.SQS_RH3COD 
		End
	END 


Completion time: 2021-06-21T08:36:13.9351352-03:00
