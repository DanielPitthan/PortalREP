using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Models.Infra
{
    public class WorkFlow
    {
        public int Id { get; set; }
        public DateTime DataInclusao { get; set; }
        public string EmailDestino { get; set; }
        public DateTime? DataEnvio { get; set; }
        public bool EnvioOK { get; set; }
        public string Assunto { get; set; }
        public string CorpoEmail { get; set; }
        public string Key { get; set; }
        public string EmailCC { get; set; }
    }
}
