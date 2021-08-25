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
    public class ResponsabilidadeDAO : DAOBase, IResponsabilidadeDAO
    {
        public ResponsabilidadeDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<Responsabilidade> All()
        {
            return this.Contexto.ZC7100;
        }
    }
}
