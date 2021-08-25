using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Interfaces
{
    public interface ICentroCustoService
    {
        Task<CentroCusto> GetByCodigoAsync(string codigo);
        Task<IList<CentroCusto>> ListAsync();
    }
}
