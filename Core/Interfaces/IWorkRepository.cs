using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Dtos;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IWorkRepository
    {
        Task<Work> GetWorksByIdAsync(int id);
        Task<IReadOnlyList<Work>> GetWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetMonthWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetYearWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetDoneWorksAsync(int id);
        Task<IReadOnlyList<Work>> GetAssignedWorks(int id, int personId);
        Task<Work> GetAssignedWorkById(int ownerId, int personId);
        Task<bool> AddWorkAsync(Work work);
        Task<bool> UpdateWorkAsync(Work work);
        Task<bool> DeleteWorkAsync(int id);
        Task<bool> WorkDone(int id);
        Task<bool> AssignWork(int id, int personid);
        Task<bool> BackAssignWork(int id);

    }
}