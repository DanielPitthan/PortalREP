using Business.BLL.Cadastros.Interfaces;
using Core.Cadastros.Interfaces;
using Microsoft.EntityFrameworkCore;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Services
{
    public class BaseService:IBaseService
    {
        private readonly IBaseDAO baseDAO;

        public BaseService(IBaseDAO _baseDAO)
        {
            this.baseDAO = _baseDAO;
        }

        public async Task<IList<Base>> ListarAsync()
        {
            return await (from b in this.baseDAO.All()
                          where b.D_E_L_E_T_ == ""
                          select b).ToListAsync();
        }
    }
}
