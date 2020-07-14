using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IWorkRepository
    {
         Task<Work> GetWorksByIdAsync(int id);
         Task<IReadOnlyList<Work>> GetWorkAsync();
         Task<bool> AddWorkAsync(Work work);
         Task<bool> UpdateWorkAsync(Work work);
         Task<bool> DeleteWorkAsync(int id);

    }
}