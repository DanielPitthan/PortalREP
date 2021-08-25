using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface IHistoricoService
    {
        public Task<bool> Adcionar(HistoricoTicket historico);
        public Task<IList<HistoricoTicket>> GetByTicket(Ticket ticket);
    }
}
