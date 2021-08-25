using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.DAO
{
    public class UnidadeDAO : DAOBase,IUnidadeDAO
    {
        public UnidadeDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<Unidade> All()
        {
            return this.Contexto.ZC6100;
        }
    }
}
