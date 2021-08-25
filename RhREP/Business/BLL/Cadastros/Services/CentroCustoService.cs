using Microsoft.EntityFrameworkCore;
using Business.BLL.Cadastros.Interfaces;
using RHRep.Core.Cadastros.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Cadastros.Services
{
    public class CentroCustoService:ICentroCustoService
    {
        private ICentroCustoDAO centroCustoDAO;

        public CentroCustoService(ICentroCustoDAO _centroCustoDAO)
        {
            this.centroCustoDAO = _centroCustoDAO;
        }

        public async Task<CentroCusto> GetByCodigoAsync(string codigo)
        {
            return await this.centroCustoDAO.All()
                            .Where(x => x.CTT_CUSTO == codigo)
                            .Where(x=> x.D_E_L_E_T_.Equals(""))
                            .AsNoTracking()
                            .SingleOrDefaultAsync();
        }

        public async Task<IList<CentroCusto>> ListAsync()
        {
            return await this.centroCustoDAO.All()
                .Where(x=> x.D_E_L_E_T_.Equals(""))
                .ToListAsync();
        }
    }
}
