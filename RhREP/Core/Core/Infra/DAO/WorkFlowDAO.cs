using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Infra.Interfaces;
using Models.Infra;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Infra.DAO
{
    public class WorkFlowDAO : DAOBase,IWorkFlowDAO
    {
        public WorkFlowDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<WorkFlow> All()
        {
            return this.Contexto.WorkFlow;
        }
    }
}
