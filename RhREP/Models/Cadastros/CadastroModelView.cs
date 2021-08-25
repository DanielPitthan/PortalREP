using Models.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Models.Cadastros
{
    public class CadastroModelView
    {
        public Funcionario Funcionario { get; set; }
        public Login Login { get; set; }
        public CentroCusto CentroCusto { get; set; }
        public ItemContabil ItemContabil { get; set; }
        public Departamentos Departamentos { get; set; }

    }
}
