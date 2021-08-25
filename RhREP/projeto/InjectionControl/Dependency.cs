using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Business.BLL.Cadastros.Interfaces;
using RHRep.BLL.Cadastros.Services;
using RHRep.BLL.Logins.Interfaces;
using RHRep.BLL.Logins.Services;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.BLL.Tickets.Services;
using RHRep.Contextos;
using RHRep.Core.Admin.DAO;
using RHRep.Core.Admin.Interfaces;
using RHRep.Core.Base.DAO;
using RHRep.Core.Base.Interfaces;
using RHRep.Core.Cadastros.DAOs;
using RHRep.Core.Cadastros.Interfaces;
using RHRep.Core.Infra.DAO;
using RHRep.Core.Infra.Interfaces;
using RHRep.Core.Logins.DAO;
using RHRep.Core.Logins.Interfaces;
using RHRep.Core.Tickets.DAO;
using RHRep.Core.Tickets.Interfaces;
using Core.RequisicoesPessoais.Interfaces;
using Business.BLL.RequisicoesPessoal.Interfaces;
using Business.BLL.RequisicoesPessoal.Services;
using Core.Cadastros.Interfaces;
using Core.Cadastros.DAOs;
using Business.BLL.Cadastros.Services;
using Core.RequisicoesPessoais.DAO;
using RHRep.Pages;

namespace RHRep.InjectionControl
{
    public static class Dependency
    {
        public static IServiceCollection AddDependencia(this IServiceCollection services, IConfiguration config)
        {
            services.AddTransient<IDepartamentosDAO, DepartamentosDAO>();
            services.AddTransient<IDepartamentoService, DepartamentoService>();

            services.AddTransient<ITabelaGenericaX5DAO, TabelaGenericaX5DAO>();
            services.AddTransient<ITabelaGenericaX5Service, TabelaGenericaX5Service>();

            services.AddTransient<IBaseDAO, BaseDAO>();
            services.AddTransient<IBaseService, BaseService>();

            services.AddTransient<ITurnoDAO, TurnoDAO>();
            services.AddTransient<ITurnoService, TurnoService>();

            services.AddTransient<ICargoDAO, CargoDAO>();
            services.AddTransient<ICargoService, CargoService>();


            services.AddTransient<IEmpresaDAO, EmpresaDAO>();
            services.AddTransient<IEmpresaService, EmpresaService>();

            services.AddTransient<IMunicipiosUFDAO, MunicipiosUFDAO>();
            services.AddTransient<IMunicipiosUFService, MunicipiosUFService>();

            services.AddTransient<IRequisicaoPessoalDAO, RequisicaoPessoalDAO>();
            services.AddTransient<IRequisicaoPessoalService, ResquisicaoPessoalService>();

            services.AddTransient<IParametrosOnline, ParametrosOnline>();

            services.AddTransient<IItemContabilDAO, ItemContabilDAO>();
            services.AddTransient<IItemContabilService, ItemContabilService>();

            services.AddTransient<ITicketMailService, TicketMailService>();
            services.AddTransient<IWorkFlowDAO, WorkFlowDAO>();
            services.AddTransient<IHistoricoDAO, HistricoDAO>();
            services.AddTransient<IProblemaDAO, ProblemaDAO>();
            services.AddTransient<IUnidadeDAO, UnidadeDAO>();
            services.AddTransient<IAssuntoDAO, AssuntoDAO>();

            services.AddTransient<IHistoricoService, HistoricoService>();
            services.AddTransient<IProblemaService, ProblemaService>();
            services.AddTransient<IUnidadeService, UnidadeService>();
            services.AddTransient<IAssuntoService, AssuntoService>();

            services.AddTransient<IResponsabilidadeDAO, ResponsabilidadeDAO>();
            services.AddTransient<IResponsabilidadeService, ResponsabilidadeService>();

            services.AddTransient<IImagensTicktsDAO, ImagensTicketDAO>();
            services.AddTransient<IImagensTicketService, ImagensTicketsService>();

            services.AddTransient<ICentroCustoDAO, CentroCustoDAO>();
            services.AddTransient<ICentroCustoService, CentroCustoService>();

            services.AddTransient<IfuncionarioDAO, FuncionarioDAO>();
            services.AddTransient<IFuncionarioService, FuncionarioService>();

            services.AddTransient<ILoginService, LoginService>();
            services.AddTransient<IControleLogin, ControleLoginDAO>();
            services.AddTransient<ILoginDAO, LoginDAO>();
            services.AddTransient<IDAOBase, DAOBase>();

            services.AddTransient<IAreaInternaDAO, AreaInternaDAO>();
            services.AddTransient<IAreaInternaService, AreaInternaService>();

            services.AddTransient<IStatusService, StatusService>();
            services.AddTransient<IStatusDAO, StatusDAO>();

            services.AddTransient<ITicketDAO, TicketDAO>();
            services.AddTransient<ITicketService, TicketService>();

            return services;
        }
    }
}
