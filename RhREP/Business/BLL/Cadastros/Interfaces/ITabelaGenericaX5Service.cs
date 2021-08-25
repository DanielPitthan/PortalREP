using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Interfaces
{
    public interface ITabelaGenericaX5Service
    {
        public Task<List<TabelaGenericaX5>> GetTabelaR1Async();
    }
}
