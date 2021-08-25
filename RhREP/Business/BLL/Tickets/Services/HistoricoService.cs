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
    public class HistoricoService:IHistoricoService
    {
        private IHistoricoDAO historicoDAO;

        public HistoricoService(IHistoricoDAO _historicoDAO)
        {
            this.historicoDAO = _historicoDAO;
        }

        public async Task<bool> Adcionar(HistoricoTicket historico)
        {

            return await this.historicoDAO.AddByProcAsync(historico);
        }

       

        public async Task<IList<HistoricoTicket>> GetByTicket(Ticket ticket)
        {
            
            return await this.historicoDAO.RawSqlRead()
                .Where(x => x.ZC1_NUM == ticket.ZC0_NUM)
                  .Where(x => x.D_E_L_E_T_.Equals(""))
                .AsNoTracking()
                .ToListAsync();
        }
    }
}
