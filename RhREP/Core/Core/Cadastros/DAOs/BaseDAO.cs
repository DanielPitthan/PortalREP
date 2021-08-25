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
    public class BaseDAO : IBaseDAO
    {
        private TOTVSContext totvsContext;

        public BaseDAO(TOTVSContext _totvsContext)
        {
            this.totvsContext = _totvsContext;
        }

        public IQueryable<Base> All()
        {
            return totvsContext.RBS100;
        }
    }
}
