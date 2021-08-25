using Microsoft.EntityFrameworkCore;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Services
{
    public class ResponsabilidadeService : IResponsabilidadeService
    {
        private IResponsabilidadeDAO responsabilidadeDAO;
        private IAssuntoService assuntoService;
        private IProblemaService problemaService;
        private IUnidadeService unidadeService;
        private IUnidadeDAO unidadeDAO;
        private IProblemaDAO problemaDAO;

        public ResponsabilidadeService(IResponsabilidadeDAO _responsabilidadeDAO,
                                        IAssuntoService _assuntoService,
                                        IProblemaService _problemaService,
                                        IUnidadeService _uniadadeService,
                                        IUnidadeDAO _unidadeDAO,
                                        IProblemaDAO _problemaDAO)
        {
            this.responsabilidadeDAO = _responsabilidadeDAO;
            this.assuntoService = _assuntoService;
            this.problemaService = _problemaService;
            this.unidadeService = _uniadadeService;
            this.unidadeDAO = _unidadeDAO;
            this.problemaDAO = _problemaDAO;
        }

        public async Task<Responsabilidade> Get(string assunto, string areaInterna, string problema, string unidade)
        {
            
            var responsabilidade = await this.responsabilidadeDAO.All()
                 .Where(x => x.D_E_L_E_T_.Equals(""))
                 .Where(x => x.ZC7_ASSUNT == assunto && x.ZC7_CODARE == areaInterna && x.ZC7_PROB == problema && x.ZC7_UNID== unidade)
                 .SingleOrDefaultAsync();


            return responsabilidade;


        }

        public async Task<IList<Assunto>> GetAssuntosByDepartamentos(string departamento)
        {
            var matriz = await this.responsabilidadeDAO.All()
                                        .Where(x => x.ZC7_CODARE == departamento)
                                        .Where(x => x.D_E_L_E_T_.Equals(""))
                                        .ToListAsync();

            var assuntos = await this.assuntoService.GetAllAsync();
            var result = from m in matriz
                         join a in assuntos on m.ZC7_ASSUNT equals a.ZC4_COD
                         select a;


            return result.Distinct().ToList();
        }

        public async Task<IList<Problema>> GetProblemasByAssunto(string area, string assunto)
        {
            var query = this.responsabilidadeDAO.All()
                                      .Where(x => x.ZC7_ASSUNT == assunto && x.ZC7_CODARE == area)
                                      .Where(x => x.D_E_L_E_T_.Equals(""))
                                      .Select(x => new Problema()
                                      {
                                          ZC5_COD = x.ZC7_PROB
                                      })
                                      .Distinct();
            var listOfProblemas = await query.ToListAsync();

            foreach (var problema in listOfProblemas)
            {
                problema.ZC5_DESCRI = this.problemaDAO.All().Where(x => x.ZC5_COD == problema.ZC5_COD).Select(x => x.ZC5_DESCRI).FirstOrDefault();
            }

           


            return listOfProblemas;
        }

        public async Task<IList<Unidade>> GetUnidadeByProblema(string area, string assunto,string problema)
        {

            var query = this.responsabilidadeDAO.All()
                                     .Where(x => x.ZC7_PROB == problema && x.ZC7_ASSUNT==assunto && x.ZC7_CODARE==area)
                                     .Where(x => x.D_E_L_E_T_.Equals(""))
                                     .Select(x => new Unidade()
                                     {
                                         ZC6_COD = x.ZC7_UNID
                                     }).Distinct();


            var listOfUnidades = await query.ToListAsync();

            foreach (var unidade in listOfUnidades)
            {
                unidade.ZC6_DESCRI = this.unidadeDAO.All()
                    .Where(x => x.ZC6_COD == unidade.ZC6_COD).Select(x => x.ZC6_DESCRI)
                    .FirstOrDefault();
            }

            return  listOfUnidades; 
        }
    }
}
