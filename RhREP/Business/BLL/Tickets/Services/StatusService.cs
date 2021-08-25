using Microsoft.EntityFrameworkCore;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Services
{
    public class StatusService : IStatusService
    {
        private IStatusDAO statusDAO;

        public StatusService( IStatusDAO _statusDAO)
        {
            this.statusDAO = _statusDAO;
        }

        public async Task<IList<Status>> GetAllAsync()
        {
            return await this.statusDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .ToListAsync();
        }

        public Status GetByCod(string codigo)
        {
            return  this.statusDAO.All()
                .Where(x => x.ZC2_COD == codigo)
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .SingleOrDefault();
        }

        public async Task<Status> GetByCodASync(string codigo)
        {
            return await this.statusDAO.All()
                .Where(x => x.ZC2_COD == codigo)
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .SingleOrDefaultAsync();
        }        
    }
}
