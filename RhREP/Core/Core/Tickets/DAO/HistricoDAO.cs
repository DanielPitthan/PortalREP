using Microsoft.EntityFrameworkCore;
using RHRep.Contextos;
using RHRep.Core.Base.DAO;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Tickets.DAO
{
	public class HistricoDAO : DAOBase, IHistoricoDAO
	{
		public HistricoDAO(TOTVSContext _context) : base(_context)
		{
		}

		public async Task<bool> AddByProcAsync(HistoricoTicket item)
		{
			//insert na ZC1
			string query = @$" exec InsertZC1  '{item.ZC1_FILIAL}',
											   '{item.ZC1_NUM}',
											  '{item.ZC1_DTINC}',
											   '{item.ZC1_HRINC}',											 
											   '{item.ZC1_TEXTO_String}',
												'{item.ZC1_USERN}',
												'{item.ZC1_ATEND}'"; 

			var procedure = await this.Contexto.ZC1100.FromSqlRaw(query).ToListAsync();

			return procedure != null;
		}


        public IQueryable<HistoricoTicket> RawSqlRead()
        {
			var hist = base.Contexto.ZC1100.FromSqlRaw("select CAST(ZC1_TEXTO AS varchar(MAX)) as ZC1_TEXTO_String,* from ZC1100 where D_E_L_E_T_=''");
			return hist;

		}
    }
}
