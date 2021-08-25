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
    public class AreaInternaDAO : DAOBase,IAreaInternaDAO
    {
        public AreaInternaDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<AreaInterna> All()
        {
            return this.Contexto.ZC3100;
        }
    }
}
