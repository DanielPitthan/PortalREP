using Microsoft.EntityFrameworkCore;
using Business.BLL.Cadastros.Interfaces;
using RHRep.Core.Cadastros.DAOs;
using RHRep.Core.Cadastros.Interfaces;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace RHRep.BLL.Cadastros.Services
{
    public class FuncionarioService : IFuncionarioService
    {
        private IfuncionarioDAO funcionarioDAO;

        public FuncionarioService(IfuncionarioDAO _funcionarioDAO)
        {
            this.funcionarioDAO = _funcionarioDAO;
        }

        public IQueryable<Funcionario> ListAllByEstado(string uf = "")
        {

            var funcionario = from func in this.funcionarioDAO.All()
                              where func.D_E_L_E_T_.Equals("")
                              && func.RA_DEMISSA.Equals("")
                              && func.RA_ESTADO == uf
                              select func;
            return funcionario;

        }

        public async Task<Funcionario> GetAsync(string cpf)
        {
            var funcionario = await this.funcionarioDAO.All()
                .Where(x => x.RA_CIC == cpf && x.D_E_L_E_T_.Equals(""))
                .Where(f => f.RA_DEMISSA == "")
                .AsNoTracking()
                .FirstOrDefaultAsync();

            return funcionario;
        }



        public async Task<Funcionario> GetByCPF(string cfp)
        {
            var funcionario = await this.funcionarioDAO.All()
              .Where(x => x.RA_CIC == cfp && x.D_E_L_E_T_.Equals(""))
              .AsNoTracking()
              .FirstOrDefaultAsync();

            return funcionario;
        }

       

        public IQueryable<Funcionario> ListAllByFilial(string filial)
        {
            var funcionario = from func in this.funcionarioDAO.All()
                              where func.D_E_L_E_T_.Equals("")
                              && func.RA_DEMISSA == ""
                              && func.RA_FILIAL == filial
                              select func;
            return funcionario;
        }
        public IQueryable<Funcionario> ListAllByFilialAll(string filial,string departamento)
        {
            var funcionario = from func in this.funcionarioDAO.All()
                              where func.D_E_L_E_T_.Equals("")
                             //  && func.RA_DEMISSA == ""
                               && func.RA_DEPTO==departamento.Trim()
                              && func.RA_FILIAL == filial
                              select func;
            //var x = funcionario.Where(x => x.RA_MAT == "044088");
            return funcionario;
        }


        public Funcionario GetByMatricula(string matricula)
        {
            var funcionario = this.funcionarioDAO.All()
               .Where(x => x.RA_MAT == matricula && x.D_E_L_E_T_.Equals(""))
               //.Where(x=> x.RA_FILIAL ==filial)
               .AsNoTracking()
               .First();

            return funcionario;
        }

        public async Task<Funcionario> GetByMatriculaAsync(string matricula, string filial)
        {
            var funcionario = await this.funcionarioDAO.All()
              .Where(x => x.RA_MAT == matricula && x.D_E_L_E_T_.Equals("") && x.RA_FILIAL == filial)
              .AsNoTracking()
              .FirstOrDefaultAsync();

            return funcionario;
        }

        public async Task<Funcionario> GetByMatriculaAsync(string matricula)
        {
            var funcionario = await this.funcionarioDAO.All()
               .Where(x => x.RA_MAT == matricula && x.D_E_L_E_T_.Equals(""))
               //.Where(x=> x.RA_FILIAL ==filial)
               .AsNoTracking()
               .FirstOrDefaultAsync();

            return funcionario;
        }

       

        public Funcionario GetByMatricula(string matricula, string filial)
        {
            var funcionario =  this.funcionarioDAO.All()
              .Where(x => x.RA_MAT == matricula && x.D_E_L_E_T_.Equals("") && x.RA_FILIAL == filial)
              .AsNoTracking()
              .First();

            return funcionario;
        }
    }
}
