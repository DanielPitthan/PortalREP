using Core.Cadastros.Interfaces;
using Models.Cadastros;
using RHRep.Contextos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Cadastros.DAOs
{
    public class EmpresaDAO : IEmpresaDAO
    {
        private TOTVSContext contexto;

        public EmpresaDAO(TOTVSContext _totvsContext)
        {
            this.contexto = _totvsContext;
        }

        public IQueryable<Empresa> All()
        {
            return this.contexto.SYS_COMPANY;
        }
    }
}
