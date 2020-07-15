using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IWorkRepository
    {
         Task<Work> GetWorksByIdAsync(int id);
         Task<IReadOnlyList<Work>> GetWorksAsync();
         Task<IReadOnlyList<Work>> GetMonthWorksAsync();
         Task<IReadOnlyList<Work>> GetYearWorksAsync();
         Task<bool> AddWorkAsync(Work work);
         Task<bool> UpdateWorkAsync(Work work);
         Task<bool> DeleteWorkAsync(int id);

    }
}