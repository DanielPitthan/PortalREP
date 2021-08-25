using Business.BLL.Cadastros.Interfaces;
using Core.Cadastros.DAOs;
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
    public class CargoService : ICargoService
    {
        private readonly ICargoDAO cargoDAO;

        public CargoService(ICargoDAO _cargoDAO)
        {
            this.cargoDAO = _cargoDAO;
        }
        public async Task<IList<Cargo>> ListCargosAsync()
        {
            return await this.cargoDAO.All()
                .Where(x=> x.D_E_L_E_T_=="")
                .ToListAsync();
        }
    }
}
