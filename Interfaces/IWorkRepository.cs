using System.Collections.Generic;
using System.Threading.Tasks;
using taskmanager.Models;

namespace taskmanager.Interfaces
{
    public interface IWorkRepository
    {
         Task<Work> GetWorkByIdAsync(int id);

         Task<IReadOnlyList<Work>> GetWorksAsync(int id);

        Task Create(Work work);

        Task Delete (int id);

        Task Update (Work work);
    }
}