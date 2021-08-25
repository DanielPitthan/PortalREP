using RHRep.Core.Base.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.Interfaces
{
    public interface IStatusDAO:IDAOBase
    {
        IQueryable<Status> All();
    }
}
