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
    public class TabelaGenericaX5DAO : ITabelaGenericaX5DAO
    {
        private readonly TOTVSContext totvsContext;

        public TabelaGenericaX5DAO(TOTVSContext _totvsContext)
        {
            this.totvsContext = _totvsContext;
        }
        public IQueryable<TabelaGenericaX5> All()
        {
            return this.totvsContext.SX5100;
        }
    }
}
