using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Models.Cadastros
{
    public class Funcionario
    {
        [NotMapped]
        public string SituacaoFolha
        {
            get
            {
                if (RA_SITFOLH == "")
                    return "Normal";
                if (RA_SITFOLH == "D")
                    return "Demitido";
                if (RA_SITFOLH == "A")
                    return "Afastado";
                if (RA_SITFOLH == "F")
                    return "Férias";
                
                return "";
            }
        }

        [NotMapped]

        public string NomeFormatado
        {
            get
            {
                return $"{this.RA_MAT}-{this.RA_NOME}";
            }
        }

        public string RA_FILIAL { get; set; }

        public string RA_MAT { get; set; }

        public string RA_CC { get; set; }

        public string RA_NOME { get; set; }

        public string RA_CIC { get; set; }

        public string RA_PIS { get; set; }

        public string RA_RG { get; set; }

        public string RA_NUMCP { get; set; }

        public string RA_SERCP { get; set; }

        public string RA_UFCP { get; set; }

        public string RA_HABILIT { get; set; }

        public string RA_RESERVI { get; set; }

        public string RA_TITULOE { get; set; }

        public string RA_NOMECMP { get; set; }

        public string RA_ZONASEC { get; set; }

        public string RA_ENDEREC { get; set; }

        public string RA_COMPLEM { get; set; }

        public string RA_BAIRRO { get; set; }

        public string RA_MUNICIP { get; set; }

        public string RA_ESTADO { get; set; }

        public string RA_CEP { get; set; }

        public string RA_TELEFON { get; set; }

        public string RA_PAI { get; set; }

        public string RA_MAE { get; set; }

        public string RA_NATURAL { get; set; }

        public string RA_NACIONA { get; set; }

        public string RA_ANOCHEG { get; set; }

        public string RA_SEXO { get; set; }

        public string RA_ESTCIVI { get; set; }

        public string RA_DEPIR { get; set; }

        public string RA_DEPSF { get; set; }

        public string RA_NASC { get; set; }

        public string RA_ALTNASC { get; set; }

        public string RA_ADMISSA { get; set; }

        public string RA_OPCAO { get; set; }

        public string RA_DEMISSA { get; set; }

        public string RA_VCTOEXP { get; set; }

        public string RA_VCTEXP2 { get; set; }

        public string RA_EXAMEDI { get; set; }

        public string RA_BCDEPSA { get; set; }

        public string RA_CTDEPSA { get; set; }

        public string RA_BCDPFGT { get; set; }

        public string RA_CTDPFGT { get; set; }

        public string RA_SITFOLH { get; set; }

        public double RA_HRSMES { get; set; }

        public double RA_HRSEMAN { get; set; }

        public string RA_CHAPA { get; set; }

        public string RA_TNOTRAB { get; set; }

        public string RA_CODFUNC { get; set; }

        public string RA_CBO { get; set; }

        public string RA_PGCTSIN { get; set; }

        public string RA_SINDICA { get; set; }

        public string RA_ALTCBO { get; set; }

        public string RA_PROCES { get; set; }

        public string RA_ASMEDIC { get; set; }

        public string RA_DPASSME { get; set; }

        public string RA_ADTPOSE { get; set; }

        public string RA_CESTAB { get; set; }

        public string RA_VALEREF { get; set; }

        public string RA_SEGUROV { get; set; }

        public double RA_PENSALI { get; set; }

        public double RA_PERCADT { get; set; }

        public string RA_CATFUNC { get; set; }

        public string RA_TIPOPGT { get; set; }

        public double RA_SALARIO { get; set; }

        public double RA_ANTEAUM { get; set; }

        public double RA_PERICUL { get; set; }

        public double RA_INSMIN { get; set; }

        public double RA_INSMED { get; set; }

        public double RA_INSMAX { get; set; }

        public string RA_TIPOADM { get; set; }

        public string RA_AFASFGT { get; set; }

        public string RA_VIEMRAI { get; set; }

        public string RA_GRINRAI { get; set; }

        public string RA_RESCRAI { get; set; }

        public string RA_MESTRAB { get; set; }

        public double RA_MESESAN { get; set; }

        public string RA_ALTEND { get; set; }

        public string RA_ALTCP { get; set; }

        public string RA_ALTPIS { get; set; }

        public string RA_ALTADM { get; set; }

        public string RA_ALTOPC { get; set; }

        public string RA_ALTNOME { get; set; }

        public string RA_CODRET { get; set; }

        public string RA_CRACHA { get; set; }

        public string RA_REGRA { get; set; }

        public string RA_BITMAP { get; set; }

        public string RA_SENHA { get; set; }

        public string RA_CATEG { get; set; }

        public string RA_SEQTURN { get; set; }

        public string RA_REGISTR { get; set; }

        public string RA_NIVEL { get; set; }

        public string RA_APELIDO { get; set; }

        public string RA_FICHA { get; set; }

        public string RA_TPCONTR { get; set; }

        public string RA_TPRCBT { get; set; }

        public string RA_TCFMSG { get; set; }

        public string RA_OCORREN { get; set; }

        public string RA_INSSSC { get; set; }

        public string RA_CLASSEC { get; set; }

        public double RA_PERCSAT { get; set; }

        public string RA_DISTSN { get; set; }

        public string RA_RGORG { get; set; }

        public string RA_DEFIFIS { get; set; }

        public string RA_BHFOL { get; set; }

        public string RA_ACUMBH { get; set; }

        public string RA_BRPDH { get; set; }

        public string RA_RACACOR { get; set; }

        public string RA_OKTRANS { get; set; }

        public string RA_TABELA { get; set; }

        public string RA_TABNIVE { get; set; }

        public string RA_TABFAIX { get; set; }

        public string RA_RECMAIL { get; set; }

        public string RA_RECPFNC { get; set; }

        public string RA_EMAIL { get; set; }

        public double RA_PERFGTS { get; set; }

        public string RA_DTVTEST { get; set; }

        public string RA_CODIGO { get; set; }

        public string RA_TPMAIL { get; set; }

        public string RA_CARGO { get; set; }

        public string RA_MSBLQL { get; set; }

        public string RA_CODTIT { get; set; }

        public string RA_CHIDENT { get; set; }

        public string RA_POSTO { get; set; }

        public string RA_TIPAMED { get; set; }

        public string RA_ASSIST { get; set; }

        public string RA_RGEXP { get; set; }

        public string RA_RGUF { get; set; }

        public string RA_NUMINSC { get; set; }

        public string RA_SERVICO { get; set; }

        public string RA_CONFED { get; set; }

        public string RA_ORGEMRG { get; set; }

        public string RA_DEPTO { get; set; }

        public string RA_DTCPEXP { get; set; }

        public string RA_CODUNIC { get; set; }

        public string RA_REGIME { get; set; }

        public string RA_FWIDM { get; set; }

        public string RA_MENSIND { get; set; }

        public string RA_DTRGEXP { get; set; }

        public string RA_TPDEFFI { get; set; }

        public string RA_FECREI { get; set; }

        public string RA_DEMIANT { get; set; }

        public string D_E_L_E_T_ { get; set; }

        //public int R_E_C_N_O_ { get; set; }

        //public int R_E_C_D_E_L_ { get; set; }

        //public string RA_RESEXT { get; set; }

        //public string RA_TPASODO { get; set; }

        //public string RA_ASODONT { get; set; }

        //public string RA_HOPARC { get; set; }

        //public string RA_CLAURES { get; set; }

        //public string RA_DTFIMCT { get; set; }

        //public string RA_COMPSAB { get; set; }

        //public double RA_FTINSAL { get; set; }

        //public string RA_MOLEST { get; set; }

        //public string RA_INSSAUT { get; set; }

        public string RA_ITEM { get; set; }

        //public string RA_CLVL { get; set; }

        //public string RA_RHEXP { get; set; }

        //public string RA_MUNNASC { get; set; }

        //public double RA_ADCCONF { get; set; }

        //public double RA_ADCTRF { get; set; }

        //public string RA_TIPENDE { get; set; }

        //public string RA_COMPLRG { get; set; }

        //public string RA_SECAO { get; set; }

        //public string RA_DATCHEG { get; set; }

        //public string RA_NUMENDE { get; set; }

        //public string RA_CPOSTAL { get; set; }

        //public string RA_CEPCXPO { get; set; }

        //public string RA_DDDFONE { get; set; }

        //public string RA_DDDCELU { get; set; }

        //public string RA_NUMCELU { get; set; }

        //public string RA_CPAISOR { get; set; }

        //public string RA_BRNASEX { get; set; }

        //public string RA_TIPCERT { get; set; }

        //public string RA_EMICERT { get; set; }

        //public string RA_MATCERT { get; set; }

        //public string RA_LIVCERT { get; set; }
    }
}
