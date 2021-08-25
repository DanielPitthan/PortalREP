using Business.BLL.RequisicoesPessoal.Interfaces;
using Core.RequisicoesPessoais.Interfaces;
using Microsoft.EntityFrameworkCore;
using Models.RequisicoesPessoais.REP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.RequisicoesPessoal.Services
{
    public class ResquisicaoPessoalService : IRequisicaoPessoalService
    {
        private readonly IRequisicaoPessoalDAO repDAO;

        public ResquisicaoPessoalService(IRequisicaoPessoalDAO _repDAO)
        {
            this.repDAO = _repDAO;
        }

        public async Task<bool> AdcionarAsync(RequisicaoPessoal rep,string detalheDaVaga)
        {
         

            try
            {
                var result = await repDAO.MergeAsync(rep, detalheDaVaga);
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception($"Erro ao tentar gravar: IRequisicaoPessoalService|AdcionarAsync { ex.Message }-{ex.InnerException}");
            }

        }

        public async Task<bool> AlterarAsync(RequisicaoPessoal rep, string detalheDaVaga)
        {
            try
            {
                var result = await repDAO.MergeAsync(rep, detalheDaVaga);
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception($"Erro ao tentar gravar: IRequisicaoPessoalService|AdcionarAsync { ex.Message }-{ex.InnerException}");
            }
        }

       

        public async Task<bool> ExcluirAsync(RequisicaoPessoal rep)
        {
            try
            {
                var result = await repDAO.DeleteAsync(rep);
                return result;

            }
            catch (Exception ex)
            {
                throw new Exception($"Erro ao tentar excluir: IRequisicaoPessoalService|ExcluirAsync { ex.Message }-{ex.InnerException}");
            }

        }

        public Task<RequisicaoPessoal> GetRequisicao(string qsVaga)
        {
            throw new NotImplementedException();
        }

        public IList<RequisicaoPessoal> ListByMatricula(string matricula)
        {
            IList<RequisicaoPessoal> requisicaoes = this.repDAO.All()
                                                  .Where(x => x.D_E_L_E_T_ == "" && x.QS_MATRESP == matricula)
                                                  .ToList();

            return requisicaoes;
        }

        public async Task<IList<RequisicaoPessoal>> ListByMatriculaAsync(string matricula)
        {
            IList<RequisicaoPessoal> requisicaoes = await this.repDAO.All()
                                                  .Where(x => x.D_E_L_E_T_ == "" && x.QS_MATRESP == matricula)
                                                  .ToListAsync();

            return requisicaoes;
        }

        public async Task<string> ObterDetalhesDaVaga(RequisicaoPessoal rep)
        {
            return await this.repDAO.GetDetalheDaVaga(rep);
        }
    }
}
