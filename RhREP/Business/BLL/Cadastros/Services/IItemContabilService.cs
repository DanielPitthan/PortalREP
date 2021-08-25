using Microsoft.EntityFrameworkCore;
using Business.BLL.Cadastros.Interfaces;
using RHRep.Core.Cadastros.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Cadastros.Services
{
    public class ItemContabilService : IItemContabilService
    {
        private IItemContabilDAO itemDAO;

        public ItemContabilService(IItemContabilDAO _itemDAO)
        {
            this.itemDAO = _itemDAO;
        }

        public async Task<ItemContabil> GetByCodigoAsync(string codigo)
        {
            return await this.itemDAO.All()
                            .Where(x => x.CTD_ITEM == codigo)
                            .Where(x=> x.D_E_L_E_T_.Equals(""))
                            .AsNoTracking()
                            .SingleOrDefaultAsync();
        }
    }
}

