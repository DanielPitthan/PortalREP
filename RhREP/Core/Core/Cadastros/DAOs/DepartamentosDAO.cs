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
    public class DepartamentosDAO : IDepartamentosDAO
    {
        private TOTVSContext _context;

        public DepartamentosDAO(TOTVSContext context)
        {
            this._context = context;
        }

        public IQueryable<Departamentos> All()
        {
            return this._context.SQB100;
        }
    }
}
