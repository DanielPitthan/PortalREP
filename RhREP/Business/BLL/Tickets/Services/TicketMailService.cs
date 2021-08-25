using Blazored.SessionStorage;
using Microsoft.EntityFrameworkCore;
using Business.BLL.Cadastros.Interfaces;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Admin.Interfaces;
using RHRep.Core.Infra.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Cadastros;
using Models.Infra;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.JSInterop;
using Microsoft.AspNetCore.Components;

namespace RHRep.BLL.Tickets.Services
{
    public class TicketMailService : ITicketMailService
    {
        
        IJSRuntime jsRuntime;
        private IWorkFlowDAO workFlowDAO;
        private IResponsabilidadeService responsavelService;
        private ITicketDAO ticketDAO;
        private IHistoricoService historicoService;
        private IFuncionarioService funcionarioService;
        private ICentroCustoService centroCustoService;
        private IAssuntoService assuntoService;
        private IProblemaService problemaService;
        private IUnidadeService unidadeService;
        private IAreaInternaService areaInternaService;
        private IStatusService statusService;

        public ISessionStorageService Session { get; }

        private IImagensTicketService imagensTicketService;
        private IParametrosOnline parametroDAO;

        public TicketMailService(IWorkFlowDAO wfDAO,
                                 IResponsabilidadeService _respService,
                                 ITicketDAO _ticketDAO,
                                 IHistoricoService _historicoService,
                                 IFuncionarioService _funcionarioService,
                                 ICentroCustoService _centroCustoService,
                                 IAssuntoService _assuntoService,
                                 IProblemaService _problemaService,
                                 IUnidadeService _unidadeService,
                                 IAreaInternaService _areaInternaService,
                                 IStatusService _statusService,
                                 ISessionStorageService sessionStorage,
                                 IImagensTicketService _imagensTicketService,
                                 IParametrosOnline _parametroDAO,
                                 IJSRuntime _jsRuntime)
        {
            this.workFlowDAO = wfDAO;
            this.responsavelService = _respService;

            this.ticketDAO = _ticketDAO;
            this.historicoService = _historicoService;
            this.funcionarioService = _funcionarioService;
            this.centroCustoService = _centroCustoService;
            this.assuntoService = _assuntoService;
            this.problemaService = _problemaService;
            this.unidadeService = _unidadeService;
            this.areaInternaService = _areaInternaService;
            this.statusService = _statusService;
            this.Session = sessionStorage;
            this.imagensTicketService = _imagensTicketService;
            this.parametroDAO = _parametroDAO;
            this.jsRuntime = _jsRuntime;
        }

        public async Task<bool> GravarWorkflow(Ticket ticket)
        {
            var responsavel = await responsavelService.Get(ticket.ZC0_ASSUNT, ticket.ZC0_CODARE, ticket.ZC0_PROB, ticket.ZC0_UNID);
            if (responsavel == null)
            {
                return false;
            }

            var body = await BodyBuilderHelper(ticket);
            WorkFlow wf = new WorkFlow();
            wf.Assunto = $"Nova interação no chamado {ticket.ZC0_NUM}";
            wf.CorpoEmail = body;
            wf.DataInclusao = DateTime.Now;
            wf.EmailDestino = $@"{responsavel.ZC7_MAILRE};{ticket.ZC0_EMIALU}";
            wf.Key = ticket.ZC0_NUM;
            wf.EmailCC = $"{responsavel.ZC7_MAILS};{responsavel.ZC7_MAILD}";

            //Grava o Workflow
            await workFlowDAO.AddSysnc(wf);
            WorkFlow wfGravado = await workFlowDAO.All()
                                .Where(x => x.Key == ticket.ZC0_NUM)
                                .OrderByDescending(x => x.DataInclusao)
                                .Take(1)
                                .FirstOrDefaultAsync();

            //Grava o Id do Workflow nos Anexos
            await imagensTicketService.SetWorkflowId(ticket.ZC0_NUM, wfGravado.Id);

            return true;
        }


        private async Task<string> BodyBuilderHelper(Ticket ticket)
        {

            //var Cadastro = await Session.GetItemAsync<CadastroModelView>("cadastro");
            var result = await jsRuntime.InvokeAsync<string>("getData", "session");
            var Cadastro = Newtonsoft.Json.JsonConvert.DeserializeObject<CadastroModelView>(result);

            var funcionario = Cadastro.Funcionario;
            var centroCusto = Cadastro.CentroCusto;
            var itemContabil = Cadastro.ItemContabil;

            var _assunto = await this.assuntoService.GetAllAsync();
            var _problema = await this.problemaService.GetAllAsync();
            var _unidade = await this.unidadeService.GetAllAsync();
            var _areaInternas = await this.areaInternaService.GetAllAsync();
            var _status = await this.statusService.GetAllAsync();

            var assunto = _assunto.Where(x => x.ZC4_COD == ticket.ZC0_ASSUNT).SingleOrDefault();
            var problema = _problema.Where(x => x.ZC5_COD == ticket.ZC0_PROB).SingleOrDefault();
            var unidade = _unidade.Where(x => x.ZC6_COD == ticket.ZC0_UNID).SingleOrDefault();
            var areaInterna = _areaInternas.Where(x => x.ZC3_COD == ticket.ZC0_CODARE).SingleOrDefault();
            var status = _status.Where(x => x.ZC2_COD == ticket.ZC0_STATUS).SingleOrDefault();

            var telefone = ticket.ZC0_TEL == null ? "" : ticket.ZC0_TEL;
            var email = ticket.ZC0_EMIALU == null ? "" : ticket.ZC0_EMIALU;


            string TextoTicket = "";
            if (ticket.ZC0_TEXTO != null)
            {
                TextoTicket = System.Text.Encoding.UTF8.GetString(ticket.ZC0_TEXTO);
            }

            StringBuilder html = new StringBuilder();
            html.Replace("\\r", " ");

            html.Append(@"<!DOCTYPE html>     
                    <html lang=""en"">    
                    <head>
                        <meta charset=""UTF-8"">
                        <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
                        <title>Document</title>
                        <link rel=""stylesheet"" href=""https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css"">
                        <style>
                            {
                                background-color: #f1f1f1;
                            }
                        </style>
                    </head>
    
                    <body>
                        <div class=""container"">
                            <section class=""hero"">
                                <div class=""hero-body"">
                                    <div class=""container"">
                                        <h1 class=""title"">
                                            Ticket # " + ticket.ZC0_NUM);
            html.Append(@"          </h1>
                                </div>
                            </div>
                        </section>
                        <hr>
                        <div class=""section"">
                            <div class=""row"">
                                <div class=""columns is-mobile"">
                                    <div class=""column""><b>Matricula</b></div>");
            html.Append($@" <div class=""column"">{ ticket.ZC0_MATI } - {funcionario.RA_NOME.Trim()} </div>

                      <div class=""column""><b>C.Custo</b></div>
                        <div class=""column"">  {ticket.ZC0_ITENCT} - {itemContabil.CTD_DESC01.Trim()}  </div>
    
                    </div>
                </div>
                <div class=""row"">
                    <div class=""columns is-mobile"">
                        <div class=""column""><b>Telefone</b></div>
                        <div class=""column"">  {telefone.Trim()}  </div>
                        <div class=""column""><b>E-Mail</b></div>
                        <div class=""column""> {email.Trim()}  </div>
                    </div>
                </div>
                <div class=""row"">
                    <div class=""columns is-mobile"">
                        <div class=""column""><b>Departamento Atend.</b></div>
                        <div class=""column"">  {ticket.ZC0_CODARE}  -  {areaInterna.ZC3_DESCRI.Trim()}  </div>
                        <div class=""column""><b>Unidade</b></div>
                        <div class=""column"">  {ticket.ZC0_UNID}  -  {unidade.ZC6_DESCRI.Trim()}  </div>
                    </div>
                </div>
                <hr>
                <div class=""row"">
                    <table class=""table"" style=""width: 100%;"">
                        <thead>
                            <tr>
                                <th>Status</th>
                                <th>Assunto</th>
                                <th>Problema</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>  {ticket.ZC0_STATUS}  -  {status.ZC2_DESCRI}  </td>
                                <td>  {ticket.ZC0_TITULO.Trim()}  </td>
                                <td>  {ticket.ZC0_PROB}  -  {problema.ZC5_DESCRI.Trim()}  </td>
                            </tr>
                        </tbody>
                    </table>
                    <table class=""table"" style=""width: 100%;"">
                        <thead>
                            <tr>
                                <th>Título</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>  {ticket.ZC0_TITULO} </td>
                            </tr>
                        </tbody>
                    </table>
                    <table class=""table"" style=""width: 100%;"">
                        <thead>
                            <tr>
                                <th>Assunto</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>  {TextoTicket} </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class=""row"">
                    <table class=""table"">
                        <thead>                       
                            <tr>
    
                                <th>Data</th>
                                <th>Hota</th>
                                <th>Interação</th>
                            </tr>
                        </thead>
                        <tbody>");

            var historico = await historicoService.GetByTicket(ticket);
            StringBuilder stBuilder = new StringBuilder();

            foreach (var h in historico)
            {

                stBuilder.Append("<tr>");
                stBuilder.Append("<td>" + FormatData(h.ZC1_DTINC) + "</td>");
                stBuilder.Append("<td>" + FormatHora(h.ZC1_HRINC) + "</td>");
                stBuilder.Append("<td>" + System.Text.Encoding.ASCII.GetString(h.ZC1_TEXTO).Replace("'", "\"") + "</td>");
                stBuilder.Append("</tr>");

            }

            var servidorDeResposta = await this.parametroDAO.All()
                                            .Where(x => x.Codigo == "ServidorResposta")
                                            .FirstOrDefaultAsync();

            //177.85.35.57:10300
            html.Append(stBuilder);
            html.Append($@"                    
                            </tbody>
                           </table>
                       </div>
                   </div>
                   <div class=""row"">
                       <a class=""button"" href=""{servidorDeResposta.Conteudo}/login?ticket={ticket.ZC0_NUM}"">Responder</a>
                   </div>
               </div>
           </body>
           </html>");
            var textoHtml = html.ToString().Replace("\r\n", string.Empty);
            return textoHtml;

        }



        private string FormatHora(string hora)
        {

            if (!string.IsNullOrWhiteSpace(hora))
            {
                var _hora = hora.PadRight(4, '0');
                return $" {_hora.Substring(0, 2)}:{_hora.Substring(2, 2)}";
            }
            else
            {
                return "";
            }
        }

        private string FormatData(string data)
        {
            if (!string.IsNullOrWhiteSpace(data))
            {
                return $"{ data.Substring(6, 2)}/{ data.Substring(4, 2)}/{ data.Substring(0, 4)}";
            }
            else
            {
                return "";
            }
        }
    }
}
