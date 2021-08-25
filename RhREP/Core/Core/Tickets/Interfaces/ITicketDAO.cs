using RHRep.Core.Base.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.Interfaces
{
    public interface ITicketDAO:IDAOBase
    {
        public IQueryable<Ticket> All();
        Task<string> AddAsync(Ticket item);
        Task<bool> Atualiza(Ticket ticket);
        Task<string> Soma1(string csoma);

        IQueryable<Ticket> GetRawSQl(string query);
     
    }
}
