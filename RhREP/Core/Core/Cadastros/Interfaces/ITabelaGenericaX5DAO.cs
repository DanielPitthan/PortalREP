using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Cadastros.Interfaces
{
    public interface ITabelaGenericaX5DAO
    {
        public IQueryable<TabelaGenericaX5> All();
    }
}
