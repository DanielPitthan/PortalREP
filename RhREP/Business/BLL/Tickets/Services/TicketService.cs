using Microsoft.EntityFrameworkCore;
using Business.BLL.Cadastros.Interfaces;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Cryptography.X509Certificates;

namespace RHRep.BLL.Tickets.Services
{
    public class TicketService : ITicketService
    {
        private ITicketDAO ticketDAO;
        private IHistoricoService historicoService;
        private IFuncionarioService funcionarioService;
        private ICentroCustoService centroCustoService;
        private IAssuntoService assuntoService;
        private IProblemaService problemaService;
        private IUnidadeService unidadeService;
        private ITicketMailService mailService;

        public TicketService(ITicketDAO _ticketDAO,
                             IHistoricoService _historicoService,
                             IFuncionarioService _funcionarioService,
                             ICentroCustoService _centroCustoService,
                             IAssuntoService _assuntoService,
                             IProblemaService _problemaService,
                             IUnidadeService _unidadeService,
                             ITicketMailService _mailService)
        {
            this.ticketDAO = _ticketDAO;
            this.historicoService = _historicoService;
            this.funcionarioService = _funcionarioService;
            this.centroCustoService = _centroCustoService;
            this.assuntoService = _assuntoService;
            this.problemaService = _problemaService;
            this.unidadeService = _unidadeService;
            this.mailService = _mailService;
        }

        public async Task<string> Adcionar(Ticket ticket)
        {
            ticket.ZC0_STATUS = "0001";
            ticket.ZC0_HRINC = string.Concat(Convert.ToString(DateTime.Now.Hour).PadLeft(2, '0'), Convert.ToString(DateTime.Now.Minute).PadLeft(2, '0'));
            ticket.ZC0_DTINC = DateTime.Now.Date.ToString("yyyyMMdd");
            var numTicket = await this.ticketDAO.AddAsync(ticket);

            return numTicket;
        }

        public async Task<bool> Alterar(Ticket ticket)
        {
            return await this.ticketDAO.Atualiza(ticket);
        }

        public async Task<bool> EncerrarTicket(Ticket ticket)
        {
            try
            {
                ticket.ZC0_DTENC = DateTime.Now.Date.ToString("yyyyMMdd");
                ticket.ZC0_HRFECH = DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString();
                ticket.ZC0_STATUS = "0005";
                if (ticket.ZC0_TEXTO == null)
                    ticket.ZC0_TEXTO = new byte[] { };
                return await this.ticketDAO.Atualiza(ticket);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        public Task<bool> Excluir(Ticket ticket)
        {
            throw new NotImplementedException();
        }

        public async Task<IList<Ticket>> GetAll()
        {
            return await this.ticketDAO.All().ToListAsync();
        }

        public async Task<Ticket> GetByCodigo(string ticketNum)
        {
            Ticket ticket = await this.ticketDAO.All()
                                        .Where(t => t.ZC0_NUM == ticketNum)
                                        .Where(x => x.D_E_L_E_T_.Equals(""))
                                        .SingleOrDefaultAsync();
            return ticket;
        }

        public async Task<string> GetNextTicket()
        {
            var NumeroAtual = await this.ticketDAO.All()
                .MaxAsync(x => x.ZC0_NUM);
            if (string.IsNullOrWhiteSpace(NumeroAtual))
            {
                NumeroAtual = NumeroAtual.PadLeft(10, '0');
            }
            string ProximoNumero = await this.ticketDAO.Soma1(NumeroAtual);
            return ProximoNumero;
        }

        public async Task<IList<Ticket>> GetTicketByMatriculas(string matricula)
        {

            var meusTickets = await this.ticketDAO.All()
                 .Where(x => x.ZC0_MATI == matricula || x.ZC0_MAT == matricula ||
                 x.ZC0_MATE == matricula ||x.ZC0_ATEND2 == matricula|| x.ZC0_SUPER2 == matricula)
                 .Where(x => x.ZC0_STATUS != "0005" && x.D_E_L_E_T_ == "")
                 .OrderByDescending(x => x.ZC0_NUM)
                 .ToListAsync();
            return meusTickets;

        }

        public async Task<IList<Ticket>> GetTicketsFechados(string matricula)
        {
            var tickets = await this.ticketDAO.All()
                 .Where(x => x.D_E_L_E_T_.Equals(""))
                 .Where(x => x.ZC0_MATI == matricula || x.ZC0_MAT == matricula ||
                 x.ZC0_MATE == matricula || x.ZC0_ATEND2 == matricula || x.ZC0_SUPER2 == matricula)
                 .Where(x => !x.ZC0_DTENC.Equals(""))
                 .ToListAsync();
            return tickets;
        }

        public async Task<IList<Ticket>> GetTicketsFechados()
        {
            var tickets = await this.ticketDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .Where(x => !x.ZC0_DTENC.Equals(""))
                .ToListAsync();
            return tickets;
        }

        public async Task<IList<Ticket>> GetTicketsPendentes(string matricula = "")
        {

            if (!String.IsNullOrEmpty(matricula))
            {
                return await this.ticketDAO.All()
                .Where(x => x.ZC0_DTENC.Equals("") && x.D_E_L_E_T_ == "")
                .Where(x => x.ZC0_MATI == matricula || x.ZC0_MAT == matricula || x.ZC0_MATE == matricula)
                .OrderByDescending(x => x.ZC0_NUM)
                .ToListAsync();
            }
            else
            {
                return await this.ticketDAO.All()
                .Where(x => x.ZC0_DTENC.Equals("") && x.D_E_L_E_T_ == "")
                .OrderByDescending(x => x.ZC0_NUM)
                .ToListAsync();
            }


        }

        public async Task GetTicketsSemInteracaoAMaisde48Horas()
        {

            //Retorna os ticket com mais de 48 horas sem interação 
            var tickets = await ticketDAO.GetRawSQl(@"
                            SELECT  ZC0.* 
                            FROM ZC0100 AS ZC0 WITH(NOLOCK) 
                            LEFT JOIN ZC1100 AS ZC1 WITH(NOLOCK) ON ZC1.D_E_L_E_T_='' AND ZC0.ZC0_FILIAL=ZC1.ZC1_FILIAL AND ZC0.ZC0_NUM = ZC1.ZC1_NUM
                            WHERE 
	                            ZC1.ZC1_NUM IS NULL AND 
	                            CAST(ZC0.ZC0_DTINC AS DATE)<= CAST(DATEADD(HOUR,-48, GETDATE()) AS DATE)
	                            ").ToListAsync();

            foreach (var ticket in tickets)
            {
                await this.mailService.GravarWorkflow(ticket);
            }
        }
    }
}
