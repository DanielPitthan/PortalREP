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
    public class TabelaGenericaX5Service : ITabelaGenericaX5Service
    {
        private readonly ITabelaGenericaX5DAO tabelaGenericaX5DAO;

        public TabelaGenericaX5Service(ITabelaGenericaX5DAO _tabelaGenericaX5DAO)
        {
            this.tabelaGenericaX5DAO = _tabelaGenericaX5DAO;
        }
        public async Task<List<TabelaGenericaX5>> GetTabelaR1Async()
        {
            return await this.tabelaGenericaX5DAO.All()
                .Where(x => x.X5_TABELA == "R1" && x.D_E_L_E_T_.Equals(""))
                .ToListAsync();

                
                
        }
    }
}
