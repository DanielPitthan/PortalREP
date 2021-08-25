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
    public class ProblemaDAO : DAOBase,IProblemaDAO
    {
        public ProblemaDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<Problema> All()
        {
            return this.Contexto.ZC5100;
        }
    }
}
