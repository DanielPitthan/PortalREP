USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[InsertZC0]    Script Date: 25/08/2021 14:23:12 ******/
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
