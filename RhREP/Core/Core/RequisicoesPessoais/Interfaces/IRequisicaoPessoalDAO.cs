using Models.RequisicoesPessoais.REP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.RequisicoesPessoais.Interfaces
{
    public interface IRequisicaoPessoalDAO
    {
        public IQueryable<RequisicaoPessoal> All();
        public Task<bool> MergeAsync(RequisicaoPessoal rep, string detalheDaVaga);
        public Task<bool> UpdateAsync(RequisicaoPessoal rep);
        public Task<bool> DeleteAsync(RequisicaoPessoal rep);
        public Task<string> GetDetalheDaVaga(RequisicaoPessoal rep);

    }
}
