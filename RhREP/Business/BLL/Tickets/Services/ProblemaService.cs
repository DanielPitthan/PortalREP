using Microsoft.EntityFrameworkCore;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Services
{
    public class ProblemaService : IProblemaService
    {
        private IProblemaDAO problemDAO;

        public ProblemaService(IProblemaDAO _problemaDAO)
        {
            this.problemDAO = _problemaDAO;
        }
        public async Task<IList<Problema>> GetAllAsync()
        {
            return await problemDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .ToListAsync();
        } 
        
        public  IList<Problema> GetAll()
        {
            return  problemDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .ToList();
        }
    }
}
