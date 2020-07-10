using System.Collections.Generic;
using System.Threading.Tasks;
using taskmanager.Models;

namespace taskmanager.Interfaces
{
    public interface IWorkRepository
    {
        Task<Work> GetWorkByIdAsync(int id);

        Task<IReadOnlyList<Work>> GetWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetMonthWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetYearWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetAllTimeWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetAllTimeDonedWorksAsync(int id);

        IEnumerable<FinishedWorks> GetStatistics(int id);

        Task Done(int id);

        Task Create(Work work);

        Task Delete(int id);

        Task Update(Work work);
    }
}