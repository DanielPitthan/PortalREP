using Core.RequisicoesPessoais.Interfaces;
using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using Models.RequisicoesPessoais.REP;
using RHRep.Contextos;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.RequisicoesPessoais.DAO
{
    public class RequisicaoPessoalDAO : IRequisicaoPessoalDAO
    {
        private readonly TOTVSContext totvsContext;

        public RequisicaoPessoalDAO(TOTVSContext _totvsContext)
        {
            this.totvsContext = _totvsContext;
        }

        public async Task<bool> MergeAsync(RequisicaoPessoal rep, string detalheDaVaga )
        {
            string query = @$" exec InsertSQS 
                                             '{rep.QS_FILIAL }'
                                            ,'{rep.QS_VAGA   }'
                                            ,'{rep.QS_XFINALI}'
                                            ,'{rep.QS_XMOTIV }'
                                            ,'{rep.QS_XSUSBMO}'
                                            ,'{rep.QS_XDEMITI}'
                                            ,'{rep.QS_XNOMDEM}'
                                            ,'{rep.QS_XDATAMO}'
                                            ,'{rep.QS_FUNCAO} '
                                            ,'{rep.QS_XFUNCAO}'
                                            ,'{rep.QS_DESCRIC}'
                                            
                                            ,'{rep.QS_CC	} '
                                            ,'{rep.QS_XDPROJE}'
                                            ,'{rep.QS_XITEM	} '
                                            ,'{rep.QS_XDESITE}'
                                            ,'{rep.QS_XFILVAG}'
                                            ,'{rep.QS_TIPO	} '
                                            ,'{rep.QS_TESTE	} '
                                            ,{rep.QS_PONTOS	}
                                        
                                            ,'{rep.QS_MSGAPV} '
                                            ,'{rep.QS_MSGREP} '
                                            ,'{rep.QS_REINSC} '
                                            ,'{rep.QS_MATRESP}'
                                            ,'{rep.QS_FILRESP}'
                                            ,'{rep.QS_CODPERF}'
                                            ,{rep.QS_NRVAGA	}
                                            ,'{rep.QS_PROCESS}'
                                            ,'{rep.QS_SOLICIT}'
                                            ,'{rep.QS_CLIENTE}'
                                            ,{rep.QS_PRAZO	}
                                            ,'{rep.QS_DTABERT}'
                                            ,'{rep.QS_XPREVFE}'
                                            ,'{rep.QS_DTFECH	}'
                                            ,{rep.QS_VAGAFEC}
                                            ,{rep.QS_VCUSTO	}
                                            ,'{rep.QS_XCIDADE}'
                                            ,'{rep.QS_XBASE	}'
                                            ,{rep.QS_XSALARI}
                                            ,'{rep.QS_POSTO	 }'
                                            ,'{rep.QS_XPERICU}'
                                            ,'{rep.QS_FILPOST}'
                                            ,'{rep.QS_XTURNO} '
                                            ,'{rep.QS_XDESCTU}'
                                            ,'{rep.QS_XJORNAD}'
                                            ,'{rep.QS_XMPONTO}'
                                            ,'{rep.QS_XBCOHS} '
                                            ,'{rep.QS_XRESPPO}'
                                            ,'{rep.QS_XNPONTO}'
                                            ,'{rep.QS_XAPOPON}'
                                            ,'{rep.QS_XNAPOIO}'
                                            ,'{rep.QS_XSELECI}'
                                            ,'{rep.QS_XNOMESE}'
                                            ,'{detalheDaVaga}'";

            try
            {
                var result = totvsContext.SQS100_PRECAD.FromSqlRaw(query).ToList();
                return result != null;
            }catch(SqlException ex)
            {
                throw new Exception($"AddAsync {ex.Message} - {ex.InnerException}");
            }
           
        }

        public IQueryable<RequisicaoPessoal> All()
        {
            return totvsContext.SQS100_PRECAD;
        }

        public async Task<bool> DeleteAsync(RequisicaoPessoal rep)
        {
            var query = @$" exec DeleteSQS '{rep.QS_FILIAL}','{rep.QS_VAGA}' ";
            try
            {
                var result = totvsContext.SQS100_PRECAD.FromSqlRaw(query).ToList();
                return result != null;
            }
            catch (SqlException ex)
            {
                throw new Exception($"AddAsync {ex.Message} - {ex.InnerException}");
            }
        }

      
        public Task<bool> UpdateAsync(RequisicaoPessoal rep)
        {
            throw new NotImplementedException();
        }

        public async Task<string> GetDetalheDaVaga(RequisicaoPessoal rep)
        {
            var builder = new ConfigurationBuilder()
                   .SetBasePath(Directory.GetCurrentDirectory())
                   .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                   .AddEnvironmentVariables();

            IConfiguration configuration = builder.Build();
            var conecxaoAtiva = configuration.GetSection("ConnectionString");
            var connectionstring = conecxaoAtiva.Value;

            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                connection.Open();
                var texto = await connection.QueryAsync<string>($@"SELECT RDY_TEXTO FROM RDY100
                                            where D_E_L_E_T_=''
                                            AND RDY_CAMPO='QS_CODPERF'
                                            AND RDY_CHAVE='{rep.QS_CODPERF}'
                                            ");
                return string.Concat(texto);
            }
        }
    }
}
