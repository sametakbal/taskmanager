using System;

namespace Core.Dtos
{
    public class WorkDto
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public bool IsDone { get; set; } = false;
        public DateTime? GoalTime { get; set; }
        public int OwnerId { get; set; }
        public int? PersonId { get; set; }
    }
}