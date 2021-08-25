using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface IAssuntoService
    {
        Task<IList<Assunto>> GetAllAsync();
        IList<Assunto> GetAll();
    }
}
