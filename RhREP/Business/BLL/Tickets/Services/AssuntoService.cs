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
    public class AssuntoService : IAssuntoService
    {
        private IAssuntoDAO assuntoDAO;

        public AssuntoService(IAssuntoDAO _assuntoDAO)
        {
            this.assuntoDAO = _assuntoDAO;
        }
        public async Task<IList<Assunto>> GetAllAsync()
        {
            return await this.assuntoDAO.All()

                  .Where(x => x.D_E_L_E_T_.Equals(""))
                 .ToListAsync();
        }
        public IList<Assunto> GetAll()
        {
            return this.assuntoDAO.All()
                  .Where(x => x.D_E_L_E_T_.Equals(""))
                 .ToList();
        }
    }
}
