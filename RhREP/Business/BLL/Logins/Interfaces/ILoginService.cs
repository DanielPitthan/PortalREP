using Models.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Logins.Interfaces
{
    public interface ILoginService
    {
        public Task<bool> EfetuarLogin(Login login);
        public Task<bool> IsLogged(ControleLogin controle);
        public Task<Login> Localizar(Login _login);
        public Task<Login> Localizar(string codigo);

    }
}
