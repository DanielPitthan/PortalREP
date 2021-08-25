using Microsoft.EntityFrameworkCore;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Services
{
    public class AreaInternaService : IAreaInternaService
    {
        private IAreaInternaDAO departamentoDAO;

        public AreaInternaService(IAreaInternaDAO _departamentoDAO)
        {
            this.departamentoDAO = _departamentoDAO;
        }

        public IList<AreaInterna> GetAll()
        {
            return this.departamentoDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .AsNoTracking()
                .ToList();
        }

        public async Task<IList<AreaInterna>> GetAllAsync()
        {
            return await this.departamentoDAO.All()
                  .Where(x => x.D_E_L_E_T_.Equals(""))
                .AsNoTracking()
                .ToListAsync();
        }

        public async Task<AreaInterna> GetByCodASync(string codigo)
        {
            return await this.departamentoDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .Where(x => x.ZC3_COD == codigo)
                .AsNoTracking()
                .SingleOrDefaultAsync();

        }
    }
}
