USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[InsertZC1]    Script Date: 25/08/2021 14:23:12 ******/
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
