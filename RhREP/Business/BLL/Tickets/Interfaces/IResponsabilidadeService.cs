using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Interfaces
{
    public interface IResponsabilidadeService
    {
        public Task<Responsabilidade> Get(string assunto, string departamento, string problema, string unidade);
        public Task<IList<Assunto>> GetAssuntosByDepartamentos(string departamento);
        public Task<IList<Problema>> GetProblemasByAssunto(string area, string assunto);
        public Task<IList<Unidade>> GetUnidadeByProblema(string area, string assunto, string problema);
    }
}
