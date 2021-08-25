using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Models.Tickets
{
    public class HistoricoTicket
    {
        public string ZC1_FILIAL { get; set; }

        public string ZC1_NUM { get; set; }

        public string ZC1_DTINC { get; set; }

        public string ZC1_HRINC { get; set; }

        public byte[] ZC1_TEXTO { get; set; }
        public string ZC1_TEXTO_String { get; set; }

        public string D_E_L_E_T_ { get; set; }

        public Int64 R_E_C_N_O_ { get; set; }

        //public long R_E_C_D_E_L_ { get; set; }
        public string ZC1_USERN { get; set; }
        public string ZC1_ATEND { get; set; }
    }
}
