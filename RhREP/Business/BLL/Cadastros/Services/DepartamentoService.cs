using Business.BLL.Cadastros.Interfaces;
using Core.Cadastros.Interfaces;
using Microsoft.EntityFrameworkCore;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Services
{
    public class DepartamentoService : IDepartamentoService
    {
        private IDepartamentosDAO departamentoDAO;

        public DepartamentoService(IDepartamentosDAO _departamentosDAO)
        {
            this.departamentoDAO = _departamentosDAO;
        }
        public  bool AutorizadoFazerREP(string matricula)
        {
            var matriculaAutorizada =  this.departamentoDAO.All()
                .Where(x=> x.D_E_L_E_T_.Equals(""))
                .Any(x => x.QB_MATRESP == matricula);
            return matriculaAutorizada;
        }

        public async Task<Departamentos> GetDepartamentoByMatricula(string matricula)
        {
            var depart = await this.departamentoDAO.All()
                    .Where(x => x.QB_MATRESP == matricula)
                     .Where(x => x.D_E_L_E_T_.Equals(""))
                     .FirstOrDefaultAsync();

            return depart;
        }
    }
}
