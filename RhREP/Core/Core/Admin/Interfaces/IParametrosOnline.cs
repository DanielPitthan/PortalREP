using RHRep.Core.Base.Interfaces;
using Models.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Admin.Interfaces
{
    public interface IParametrosOnline:IDAOBase
    {
        IQueryable<ParametrosOnline> All();
    }
}
