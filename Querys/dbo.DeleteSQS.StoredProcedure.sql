USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[DeleteSQS]    Script Date: 25/08/2021 14:23:12 ******/
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
