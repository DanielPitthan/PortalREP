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
    public class UnidadeService : IUnidadeService
    {
        private IUnidadeDAO unidadeDAO;

        public UnidadeService(IUnidadeDAO _unidadeDAO)
        {
            this.unidadeDAO = _unidadeDAO;
        }
        public  IList<Unidade> GetAll()
        {
            return  this.unidadeDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .ToList();
        } 
        public async Task<IList<Unidade>> GetAllAsync()
        {
            return await this.unidadeDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .ToListAsync();
        }
    }
}
