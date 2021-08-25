using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface IStatusService
    {
        public Task<IList<Status>> GetAllAsync();
        public Task<Status> GetByCodASync(string codigo);
        public Status GetByCod(string codigo);
    }
}
