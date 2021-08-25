using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Models.Admin
{
    public class ControleLogin
    {
        public int Id { get; set; }
        public string RD0_CODIGO { get; set; }
        public bool IsLogged { get; set; }
        public DateTime DataLastLogin { get; set; }
        public DateTime DataExpiracao { get; set; }

    }
}
