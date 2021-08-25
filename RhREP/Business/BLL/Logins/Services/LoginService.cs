using Microsoft.EntityFrameworkCore;
using RHRep.BLL.Logins.Interfaces;
using RHRep.Core.Logins.Interfaces;
using Models.Admin;
using System;
using System.Linq;
using System.Threading.Tasks;
using Blazored.SessionStorage;
using Business.BLL.Cadastros.Interfaces;
using Models.Cadastros;
using Microsoft.JSInterop;
using Microsoft.AspNetCore.Components;
using System.Globalization;

namespace RHRep.BLL.Logins.Services
{

    public class LoginService : ILoginService
    {
        private readonly ILoginDAO loginDAO;
        private readonly IControleLogin controleLoginDAO;
        private readonly ISessionStorageService sessionStorage;
        private readonly IFuncionarioService funcionarioService;
        private readonly ICentroCustoService centroCustoService;
        private readonly IItemContabilService itemService;


        private IJSRuntime jsRuntime;
        private IDepartamentoService departamentoService;

        public LoginService(ILoginDAO _loginDAO,
                            IControleLogin _controleLogin,
                           ISessionStorageService _sessionStorage,
                           IFuncionarioService _funcionarioService,
                           ICentroCustoService _centroCustoService,
                           IItemContabilService _itemService,
                           IJSRuntime _jsruntime,
                           IDepartamentoService _departamentoService)
        {
            this.loginDAO = _loginDAO;
            this.controleLoginDAO = _controleLogin;
            this.sessionStorage = _sessionStorage;
            this.funcionarioService = _funcionarioService;
            this.centroCustoService = _centroCustoService;
            this.itemService = _itemService;
            this.jsRuntime = _jsruntime;
            this.departamentoService = _departamentoService;
        }


        public async Task<bool> EfetuarLogin(Login login)
        {


            Login usuario = await Localizar(login);

            if (usuario == null)
                return false;



            //if (usuario != null && usuario.RD0_DTNASC != login.RD0_DTNASC)
            //    return false;

            ControleLogin conroleLogin = await this.controleLoginDAO.All()
                 .Where(x => x.RD0_CODIGO == usuario.RD0_CODIGO)
                 .SingleOrDefaultAsync();


            Funcionario funcionario = await funcionarioService.GetAsync(usuario.RD0_CIC);

            if (funcionario == null)
            {
                return false;
            }


            if (!string.IsNullOrWhiteSpace(funcionario.RA_DEMISSA))
                if (DateTime.ParseExact(funcionario.RA_DEMISSA,
                                      "yyyyMMdd",
                                       CultureInfo.InvariantCulture) < DateTime.Now.AddDays(-30))
                {
                    return false;
                }

            var session = new CadastroModelView()
            {
                Funcionario = funcionario,
                Login = usuario,
                CentroCusto = await centroCustoService.GetByCodigoAsync(funcionario.RA_CC),
                ItemContabil = await itemService.GetByCodigoAsync(funcionario.RA_ITEM),
                Departamentos = await departamentoService.GetDepartamentoByMatricula(funcionario.RA_MAT)
            };

            //Grava a session 
            await jsRuntime.InvokeAsync<string>("storeData", "session", Newtonsoft.Json.JsonConvert.SerializeObject(session));




            if (conroleLogin == null)
            {
                ControleLogin controle = new ControleLogin()
                {
                    DataExpiracao = DateTime.Now.AddDays(30),
                    DataLastLogin = DateTime.Now,
                    RD0_CODIGO = usuario.RD0_CODIGO,
                    IsLogged = true
                };
                return await controleLoginDAO.AddSysnc(controle);
            }
            else
            {
                conroleLogin.IsLogged = true;
                return await controleLoginDAO.UpdateAsync(conroleLogin);
            }
        }




        public async Task<bool> IsLogged(ControleLogin controle)
        {
            ControleLogin conroleLogin = await this.controleLoginDAO.All()
                .Where(x => x.RD0_CODIGO == controle.RD0_CODIGO)
                .SingleOrDefaultAsync();

            return conroleLogin.IsLogged;
        }




        public async Task<Login> Localizar(Login _login)
        {
            var login = await (from l in this.loginDAO.All()
                               where l.RD0_CIC == _login.RD0_CIC
                                        && l.D_E_L_E_T_ == ""
                               select l).SingleOrDefaultAsync();

            return login;

        }




        public async Task<Login> Localizar(string codigo)
        {
            var login = await (from l in this.loginDAO.All()
                               where l.RD0_CODIGO == codigo && l.D_E_L_E_T_ == ""
                               select l).SingleOrDefaultAsync();

            return login;
        }
    }
}
