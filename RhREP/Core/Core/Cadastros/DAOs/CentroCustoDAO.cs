using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Cadastros.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Cadastros.DAOs
{
    public class CentroCustoDAO :DAOBase, ICentroCustoDAO
    {
        public CentroCustoDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<CentroCusto> All()
        {
            return this.Contexto.CTT100;
        }
    }
}
