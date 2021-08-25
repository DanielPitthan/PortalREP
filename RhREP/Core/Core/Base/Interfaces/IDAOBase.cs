using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.Core.Base.Interfaces
{
    public interface IDAOBase
    {
        public Task<bool> AddSysnc<TSource>(TSource item);
        public Task<bool> UpdateAsync<TSource>(TSource item);
        public Task<bool> DeleteAsync<TSource>(TSource item);
        public bool Add<TSource>(TSource item);
        public bool Update<TSource>(TSource item);
        public bool Delete<TSource>(TSource item);

       
    }
}
