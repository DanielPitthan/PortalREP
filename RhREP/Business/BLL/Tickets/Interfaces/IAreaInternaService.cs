using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface IAreaInternaService
    {
        public Task<IList<AreaInterna>> GetAllAsync();
        public IList<AreaInterna> GetAll();
        public Task<AreaInterna> GetByCodASync(string codigo);
    }
}
