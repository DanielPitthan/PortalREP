using Models.Enums;
using Models.RequisicoesPessoais.REP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.REP
{
    public class RequisicaoPessoalCallBack
    {
        public RequisicaoPessoal Rep { get; set; }
        public Opcoes Opcao { get; set; }
        public bool? Success { get; set; }
        
        
        #nullable enable
        public string? Json { get; set; }
        public string[]? Erros { get; set; }
        public string? Mensagens { get; set; }
        #nullable disable

    }
}
