using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Base.Interfaces;
using RHRep.Core.Logins.Interfaces;
using Models.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Logins.DAO
{
    public class LoginDAO : DAOBase, ILoginDAO
    {
        public LoginDAO(TOTVSContext _context) : base(_context)
        {
        }

        public IQueryable<Login> All()
        {
            return this.Contexto.RD0100;
        }
    }
}
