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
    public class EmpresaService: IEmpresaService
    {
        private IEmpresaDAO empresaDAO;

        public EmpresaService(IEmpresaDAO _empresaDAO)
        {
            this.empresaDAO = _empresaDAO;
        }

        public async Task<IList<Empresa>> ListarAsync()
        {
            return await empresaDAO.All()
                .Where(e=> e.D_E_L_E_T_.Equals("") && e.M0_CODFIL!="01")
                 .ToListAsync();
        }
    }
}
