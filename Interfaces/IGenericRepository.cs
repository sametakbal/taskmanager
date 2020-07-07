using System.Collections.Generic;
using System.Threading.Tasks;
using taskmanager.Models;

namespace taskmanager.Interfaces
{
    public interface IGenericRepository<T> where T : BaseEntity
    {
        Task<T> GetByIdAsync(int id);
        Task<IReadOnlyList<T>> ListAllAsync();
        
    }
}