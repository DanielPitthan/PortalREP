using RHRep.Contextos;
using RHRep.Core.Admin.Interfaces;
using RHRep.Core.Base.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Admin.DAO
{
    public class ParametrosOnline : DAOBase, IParametrosOnline
    {
        public ParametrosOnline(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<Models.Admin.ParametrosOnline> All()
        {
            return this.Contexto.ParametrosOnline;
        }
    }
}
