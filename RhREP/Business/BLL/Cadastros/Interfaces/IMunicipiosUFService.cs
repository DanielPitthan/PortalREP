using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Interfaces
{
    public interface IMunicipiosUFService
    {
        public Task<IList<MunicipiosUF>> ListMunicipiosByUF(string UF);
        public Task<MunicipiosUF> GetByCodigoIbgeUF(string codigoIBGE, string UF);
        public Task<MunicipiosUF> GetCodigoIbgeByCidade(string cidade);
        public Task<IList<Estado>> GetEstadosAsync();
    }
}
