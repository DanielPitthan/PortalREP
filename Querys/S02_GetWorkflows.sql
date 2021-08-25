
/*
** Autor: Daniel Pitthan Silveira
** Obtem os anexos pelo Id do Workflow
** 
** Exec GetWorkflows 
*/

Create    procedure GetWorkflows
As
select 
	w.Id,w.DataInclusao,
	w.EmailDestino,w.DataEnvio
	,w.EnvioOK,w.Assunto,w.CorpoEmail
from [WorkFlow] as w with(nolock)
where EnvioOK=0