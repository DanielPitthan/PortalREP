using RHRep.Core.Base.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.Interfaces
{
    public interface IResponsabilidadeDAO:IDAOBase
    {
        public IQueryable<Responsabilidade> All();
    }
}
