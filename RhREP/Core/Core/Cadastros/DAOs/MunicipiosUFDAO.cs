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
    public class MunicipiosUFDAO : IMunicipiosUFDAO
    {
        private readonly TOTVSContext totvsContext;

        public MunicipiosUFDAO(TOTVSContext _context)
        {
            this.totvsContext = _context;
        }

        public IQueryable<MunicipiosUF> All()
        {
            return this.totvsContext.CC2100;
        }
    }
}
