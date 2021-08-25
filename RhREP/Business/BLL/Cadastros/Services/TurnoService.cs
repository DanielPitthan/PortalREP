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
    public class TurnoService : ITurnoService
    {
        private readonly ITurnoDAO turnoDAO;

        public TurnoService(ITurnoDAO _turnoDAO)
        {
            this.turnoDAO = _turnoDAO;
        }

        public async Task<IList<Turno>> ListTurnosAsync()
        {
            return await this.turnoDAO.All()
                .Where(x => x.D_E_L_E_T_.Equals(""))
                .ToListAsync();
        }
    }
}
