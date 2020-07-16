using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IWorkRepository
    {
         Task<Work> GetWorksByIdAsync(int id);
         Task<IReadOnlyList<Work>> GetWorksAsync(int id);
         Task<IReadOnlyList<Work>> GetMonthWorksAsync(int id);
         Task<IReadOnlyList<Work>> GetYearWorksAsync(int id);
         Task<bool> AddWorkAsync(Work work);
         Task<bool> UpdateWorkAsync(Work work);
         Task<bool> DeleteWorkAsync(int id);

    }
}