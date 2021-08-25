
/*
** Autor: Daniel Pitthan Silveira
** Obtem os anexos pelo Id do Workflow
** 
** Exec GetAttachments 1
*/
create    procedure GetAttachments
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
