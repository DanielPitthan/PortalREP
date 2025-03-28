USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[GetAttachments]    Script Date: 25/08/2021 14:23:12 ******/
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
