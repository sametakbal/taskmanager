using System;

namespace Core.Entities
{
    public class Work : BaseEntity
    {
  
        public string Title { get; set; }
        public string Description { get; set; }
        public bool IsDone { get; set; } = false;
        public DateTime? GoalTime { get; set; }

    }
}