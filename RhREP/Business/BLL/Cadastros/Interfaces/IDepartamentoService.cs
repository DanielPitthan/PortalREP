using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Interfaces
{
    public interface IDepartamentoService
    {
        bool AutorizadoFazerREP(string matricula);
        Task<Departamentos> GetDepartamentoByMatricula(string matricula);
    }
}
