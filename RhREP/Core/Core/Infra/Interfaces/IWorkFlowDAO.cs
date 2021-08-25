using RHRep.Core.Base.Interfaces;
using Models.Infra;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Infra.Interfaces
{
    public interface IWorkFlowDAO:IDAOBase
    {
        IQueryable<WorkFlow> All();
    }
}
