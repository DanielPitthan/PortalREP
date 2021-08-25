
using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Tickets.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.DAO
{
    public class StatusDAO : DAOBase, IStatusDAO
    {
        public StatusDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<Status> All()
        {
            return this.Contexto.ZC2100;
        }
    }
}
