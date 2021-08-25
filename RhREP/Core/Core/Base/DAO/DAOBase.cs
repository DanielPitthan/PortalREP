using Microsoft.EntityFrameworkCore;
using RHRep.Contextos;
using RHRep.Core.Base.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Base.DAO
{
    public class DAOBase : IDAOBase
    {
        public TOTVSContext Contexto { get; set; }

        public DAOBase(TOTVSContext _context)
        {
            this.Contexto = _context;
        }

        public virtual async Task<bool> AddSysnc<TSource>(TSource item)
        {
            this.Contexto.Entry(item).State = EntityState.Added;
            var rows = await this.Contexto.SaveChangesAsync().ConfigureAwait(false);
            return rows > 0;
            
        }

        public virtual async Task<bool> UpdateAsync<TSource>(TSource item)
        {
            this.Contexto.Entry(item).State = EntityState.Modified;
            var rows = await this.Contexto.SaveChangesAsync().ConfigureAwait(false);
            return rows > 0;
        }

        public virtual async Task<bool> DeleteAsync<TSource>(TSource item)
        {
            this.Contexto.Entry(item).State = EntityState.Deleted;
            var rows = await this.Contexto.SaveChangesAsync().ConfigureAwait(false);
            return rows > 0;
        }

        public virtual bool Add<TSource>(TSource item)
        {
            this.Contexto.Entry(item).State = EntityState.Added;
            var rows = this.Contexto.SaveChanges();
            return rows > 0;
        }

        public virtual bool Update<TSource>(TSource item)
        {
            this.Contexto.Entry(item).State = EntityState.Modified;
            var rows = this.Contexto.SaveChanges();
            return rows > 0;
        }

        public virtual bool Delete<TSource>(TSource item)
        {
            this.Contexto.Entry(item).State = EntityState.Deleted;
            var rows = this.Contexto.SaveChanges();
            return rows > 0;
        }
    }
}
