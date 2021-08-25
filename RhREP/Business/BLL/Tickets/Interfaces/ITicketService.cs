using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface ITicketService
    {
        /// <summary>
        /// Adiciona o Ticket na base
        /// </summary>
        /// <param name="ticket"></param>
        /// <returns>O número do Ticket gerado</returns>
        public Task<string> Adcionar(Ticket ticket);
        public Task<bool> Alterar(Ticket ticket);
        public Task<bool> Excluir(Ticket ticket);

        public Task<IList<Ticket>> GetTicketsPendentes(string matricula="");
        public Task<IList<Ticket>> GetTicketsFechados(string matricula);
        public Task<IList<Ticket>> GetTicketsFechados();
        public Task<IList<Ticket>> GetAll();
        public Task<IList<Ticket>> GetTicketByMatriculas(string matricula);

        public Task<string> GetNextTicket();
        public Task<bool> EncerrarTicket(Ticket ticket);

        public Task<Ticket> GetByCodigo(string ticketNum);
        public Task GetTicketsSemInteracaoAMaisde48Horas();
    }
}
