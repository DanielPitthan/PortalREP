using Models.RequisicoesPessoais.REP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.RequisicoesPessoal.Interfaces
{
    public interface IRequisicaoPessoalService
    {
        public Task<RequisicaoPessoal> GetRequisicao(string qsVaga);
        public Task<bool> AdcionarAsync(RequisicaoPessoal rep,string detalheDaVaga);
        public Task<bool> ExcluirAsync(RequisicaoPessoal rep);
        public Task<bool> AlterarAsync(RequisicaoPessoal rep, string detalheDaVaga);
        public Task<IList<RequisicaoPessoal>> ListByMatriculaAsync(string matricula);
        public IList<RequisicaoPessoal> ListByMatricula(string matricula);
        public Task<string> ObterDetalhesDaVaga(RequisicaoPessoal rep);
    }
}
