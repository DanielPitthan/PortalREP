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
    public class MunicipiosUFService : IMunicipiosUFService
    {
        private readonly IMunicipiosUFDAO municipiosUFDAO;

        public MunicipiosUFService(IMunicipiosUFDAO _municipiosUfDAO)
        {
            this.municipiosUFDAO = _municipiosUfDAO;
        }
        public async Task<MunicipiosUF> GetByCodigoIbgeUF(string codigoIBGE, string UF)
        {
            MunicipiosUF municipio = await this.municipiosUFDAO.All()
                                        .Where(x => x.CC2_CODMUN == codigoIBGE)
                                        .Where(x => x.CC2_EST == UF)
                                        .Where(x => x.D_E_L_E_T_.Equals(""))
                                        .FirstOrDefaultAsync();
            return municipio;
        }

        public async Task<MunicipiosUF> GetCodigoIbgeByCidade(string cidade)
        {
            MunicipiosUF municipio = await this.municipiosUFDAO.All()
                                        .Where(x => x.CC2_MUN == cidade)
                                        .Where(x => x.D_E_L_E_T_.Equals(""))
                                        .FirstOrDefaultAsync();
            return municipio;
        }



        public async Task<IList<Estado>> GetEstadosAsync()
        {
            IList<Estado> estados = await this.municipiosUFDAO.All()
                                            .Where(x => x.D_E_L_E_T_.Equals(""))
                                         .Select(x => new Estado { UF = x.CC2_EST })
                                         .Distinct()
                                         .OrderBy(e => e.UF)
                                         .ToListAsync();
            return estados;
        }

        public async Task<IList<MunicipiosUF>> ListMunicipiosByUF(string UF)
        {
            IList<MunicipiosUF> municipios = await this.municipiosUFDAO.All()
                                        .Where(x => x.D_E_L_E_T_.Equals(""))
                                        .Where(x => x.CC2_EST == UF)
                                        .ToListAsync();
            return municipios;
        }
    }
}
