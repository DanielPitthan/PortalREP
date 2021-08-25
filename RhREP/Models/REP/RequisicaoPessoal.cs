using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.RequisicoesPessoais.REP
{
    public class RequisicaoPessoal
    {
        public string SQS_RH3COD { get; set; }
        public string QS_FILIAL { get; set; }

        public string QS_VAGA { get; set; }

        public string QS_XMOTIV { get; set; }

        public string QS_XSUSBMO { get; set; }

        public string QS_XDEMITI { get; set; }

        public string QS_XNOMDEM { get; set; }

        public string QS_XDATAMO { get; set; }

        public string QS_XFUNCAO { get; set; }

        //public string QS_AREA { get; set; }


        public string QS_XDPROJE { get; set; }

        public string QS_XITEM { get; set; }

        public string QS_XDESITE { get; set; }

        public string QS_XFILVAG { get; set; }

        public string QS_TIPO { get; set; }

        public string QS_TESTE { get; set; }

        public string QS_FILRESP { get; set; }

        public string QS_SOLICIT { get; set; }

        public string QS_CLIENTE { get; set; }

        public double QS_PRAZO { get; set; }

        public string QS_DTFECH { get; set; }

        public double QS_VCUSTO { get; set; }

        public double QS_XSALARI { get; set; }

        public string QS_POSTO { get; set; }

        public string QS_XPERICU { get; set; }

        public string QS_FILPOST { get; set; }

        public string QS_XDESCTU { get; set; }

        public string QS_XMPONTO { get; set; }

        public string QS_XNAPOIO { get; set; }

        public string D_E_L_E_T_ { get; set; }

        //public long R_E_C_N_O_ { get; set; }

        //public long R_E_C_D_E_L_ { get; set; }

        public string QS_XSELECI { get; set; }

        public string QS_XNOMESE { get; set; }

        [Required(ErrorMessage ="Campo Jornada não informado")]
        public string QS_XJORNAD { get; set; }

        [Required(ErrorMessage = "Campo Turno não informado")]
        public string QS_XTURNO { get; set; }

        [Required(ErrorMessage = "Campo Tipo de Vaga não informado")]
        public string QS_XFINALI { get; set; }

        [Required(ErrorMessage = "Campo Registro de Banco de Horas não informado")]
        public string QS_XBCOHS { get; set; }

        [Required(ErrorMessage = "Campo Responsável não informado")]
        public string QS_XRESPPO { get; set; }
   
        [Required(ErrorMessage = "Campo Município de Atuação não informado")]
        public string QS_XCIDADE { get; set; }

        [Required(ErrorMessage = "Campo Base não informada")]
        public string QS_XBASE { get; set; }     

        [Required(ErrorMessage = "Campo Data de Abertura não informado")]
        public string QS_DTABERT { get; set; }

        [Required(ErrorMessage = "Campo Número de vagas não informado")]
        public double QS_NRVAGA { get; set; }

        public string QS_XAPOPON { get; set; }

        public double QS_VAGAFEC { get; set; }

        public string QS_XPREVFE { get; set; }


        public string QS_CODPERF { get; set; }
        public string QS_XNPONTO { get; set; }

        public string QS_PROCESS { get; set; }
      
        public double QS_PONTOS { get; set; }

       
        //public string QS_AUTOM { get; set; }

       
        public string QS_MSGAPV { get; set; }

       
        public string QS_MSGREP { get; set; }

     
        public string QS_REINSC { get; set; }

        
        public string QS_MATRESP { get; set; }
        //[Required(ErrorMessage = "Campo Descrição da Vaga não infomado")]
        public string QS_DESCRIC { get; set; }


        [Required(ErrorMessage = "Campo Centro de Custo não informado")]
        public string QS_CC { get; set; }


        public string QS_FUNCAO { get; set; }

    }
}
