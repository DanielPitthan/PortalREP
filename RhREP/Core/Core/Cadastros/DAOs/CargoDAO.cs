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
    public class CargoDAO : ICargoDAO
    {
        private readonly TOTVSContext contexto;

        public CargoDAO( TOTVSContext _totvsContext)
        {
            this.contexto = _totvsContext;
        }
        public IQueryable<Cargo> All()
        {
            return this.contexto.SQ3100;
        }
    }
}
