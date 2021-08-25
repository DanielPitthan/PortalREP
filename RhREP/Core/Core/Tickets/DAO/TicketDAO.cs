using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.DAO
{
    public class TicketDAO : DAOBase, ITicketDAO
	{
		public TicketDAO(TOTVSContext _context) : base(_context)
		{
		}


		public IQueryable<Ticket> All()
		{
			return this.Contexto.ZC0100;
		}

		public async Task<string> AddAsync(Ticket item)
		{
			//item.ZC0_NUM = await Soma1(item.ZC0_NUM);
			//InsertZC0
			string query = @$" exec InsertZC0 
										'{System.Text.Encoding.UTF8.GetString(item.ZC0_TEXTO)}',
										'{item.ZC0_FILIAL}' , 
									   '{item.ZC0_NUM}'   ,
									   '{item.ZC0_TITULO}' ,
									   '{item.ZC0_PRIO}' ,
									   '{item.ZC0_STATUS}' ,
									   '{item.ZC0_CC}'   ,
									   '{item.ZC0_DTINC}' ,
									   '{item.ZC0_HRINC}' ,
									   '{item.ZC0_DTENC}' ,
									   '{item.ZC0_HRFECH}'	,
									   '{item.ZC0_UIDINC}'	,
									   '{item.ZC0_UIDENC}'	,
									   '{item.ZC0_MATI}',
									   '{item.ZC0_MATE}',
									   '{item.ZC0_EMAILD}'	,
									   '{item.ZC0_EMIALU}'	,
									   '{item.ZC0_TEL}'	,
									   '{item.ZC0_ANEXOS}'	,
									   '{item.ZC0_PROB}',
									   '{item.ZC0_UNID}',
									   '{item.ZC0_ASSUNT}'	,
									   '{item.ZC0_CODARE}'	,									  
									   '{item.ZC0_MAT}'		,
									   '{item.ZC0_DEPART}'	,
									   {item.ZC0_ENV}		,
									   '{item.ZC0_MAILEN}'	,
									   '{item.ZC0_CPO1}'	,
									   '{item.ZC0_CPO2}'	,
									   '{item.ZC0_CP3}'	,
									   {item.ZC0_VAL1}	,
									   {item.ZC0_VAL2}	,
									   {item.ZC0_VAL3},
									   '{item.ZC0_ITENCT}',
										'{item.ZC0_ATEND2}',
										'{item.ZC0_SUPER2}' ";

			var registroInserido =  await this.Contexto.ZC0100.FromSqlRaw(query).ToListAsync();

            if (registroInserido != null)
            {
				return (from num in registroInserido
						select num.ZC0_NUM).FirstOrDefault();
            }
			return string.Empty;
		}



	  

		public async Task<bool> Atualiza(Ticket item)
		{
			//Update ZC0
			string query = @$" exec UpdateZC0 
										{item.R_E_C_N_O_},
										'{System.Text.Encoding.UTF8.GetString(item.ZC0_TEXTO)}',
										'{item.ZC0_FILIAL}' , 
									   '{item.ZC0_NUM}'   ,
									   '{item.ZC0_TITULO}' ,
									   '{item.ZC0_PRIO}' ,
									   '{item.ZC0_STATUS}' ,
									   '{item.ZC0_CC}'   ,
									   '{item.ZC0_DTINC}' ,
									   '{item.ZC0_HRINC}' ,
									   '{item.ZC0_DTENC}' ,
									   '{item.ZC0_HRFECH}'	,
									   '{item.ZC0_UIDINC}'	,
									   '{item.ZC0_UIDENC}'	,
									   '{item.ZC0_MATI}',
									   '{item.ZC0_MATE}',
									   '{item.ZC0_EMAILD}'	,
									   '{item.ZC0_EMIALU}'	,
									   '{item.ZC0_TEL}'	,
									   '{item.ZC0_ANEXOS}'	,
									   '{item.ZC0_PROB}',
									   '{item.ZC0_UNID}',
									   '{item.ZC0_ASSUNT}'	,
									   '{item.ZC0_CODARE}'	,									  
									   '{item.ZC0_MAT}'		,
									   '{item.ZC0_DEPART}'	,
									   {item.ZC0_ENV}		,
									   '{item.ZC0_MAILEN}'	,
									   '{item.ZC0_CPO1}'	,
									   '{item.ZC0_CPO2}'	,
									   '{item.ZC0_CP3}'	,
									   {item.ZC0_VAL1}	,
									   {item.ZC0_VAL2}	,
									   {item.ZC0_VAL3}	";

			var procedure = this.Contexto.ZC0100.FromSqlRaw(query).ToList();

			return procedure != null;
		}

		public async Task<string> Soma1(string csoma)
		{
			var query = @$"EXEC SOMA1 '{csoma}' ,'N', @OUT_RESULTADO out";

			var parametros = new SqlParameter[]
			{
				new SqlParameter()
				{
					ParameterName = "@OUT_RESULTADO",
					SqlDbType = System.Data.SqlDbType.VarChar,
					Direction = System.Data.ParameterDirection.Output,
					Size=100,
					Value=""
				}
			};



			var procedure = this.Contexto.Database.ExecuteSqlRaw(query, parametros);
			var ProximoNumero = parametros[0].Value;

			return ProximoNumero.ToString();
		}

        public IQueryable<Ticket> GetRawSQl(string query)
        {
			return this.Contexto.ZC0100.FromSqlRaw(query);
        }
    }

}
