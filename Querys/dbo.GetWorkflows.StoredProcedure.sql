USE [PortalRH]
GO
/****** Object:  StoredProcedure [dbo].[GetWorkflows]    Script Date: 25/08/2021 14:23:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
** Autor: Daniel Pitthan Silveira
** Obtem os anexos pelo Id do Workflow
** 
** Exec GetWorkflows 
*/

Create    procedure [dbo].[GetWorkflows]
As
select 
	w.Id,w.DataInclusao,
	w.EmailDestino,w.DataEnvio
	,w.EnvioOK,w.Assunto,w.CorpoEmail
from [WorkFlow] as w with(nolock)
where EnvioOK=0

GO
