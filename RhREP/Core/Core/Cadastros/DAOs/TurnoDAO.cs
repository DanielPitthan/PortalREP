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
    public class TurnoDAO : ITurnoDAO
    {
        private readonly TOTVSContext contextoTotvs;

        public TurnoDAO(TOTVSContext _totvsContexto)
        {
            this.contextoTotvs = _totvsContexto;
        }

        public IQueryable<Turno> All()
        {
            return this.contextoTotvs.SR6100;
                        
        }
    }
}
