﻿using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Interfaces
{
    public interface ICargoService
    {
        public Task<IList<Cargo>> ListCargosAsync();
    }
}
