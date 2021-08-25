using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Business.BLL.Cadastros.Interfaces
{
    public interface IFuncionarioService
    {
        public Task<Funcionario> GetAsync(string cpf);
        public Task<Funcionario> GetByCPF(string cpf);
        public Task<Funcionario> GetByMatriculaAsync(string matricula);
        public Task<Funcionario> GetByMatriculaAsync(string matricula,string filial);
        
        public Funcionario GetByMatricula(string matricula);
        public Funcionario GetByMatricula(string matricula,string filial);

        public IQueryable<Funcionario> ListAllByEstado(string uf);
        public IQueryable<Funcionario> ListAllByFilial(string filial);
        public IQueryable<Funcionario> ListAllByFilialAll(string filial,string departamento);
    }
}
