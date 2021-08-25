using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface IImagensTicketService
    {
        public Task<bool> Incluir(IList<ImagensTickets> imagem);
        public Task<bool> Excluir(IList<ImagensTickets> imagem);
        public Task<IList<ImagensTickets>> ListarImagensTicket(string ticket);
        public Task<bool> SetWorkflowId(string ticket,int workflowId);
    }
}
