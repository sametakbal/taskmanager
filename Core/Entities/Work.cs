using System;

namespace Core.Entities
{
    public class Work : BaseEntity
    {

        public string Title { get; set; }
        public string Description { get; set; }
        public bool IsDone { get; set; } = false;
        public DateTime? GoalTime { get; set; }
        public User Owner { get; set; }
        public int OwnerId { get; set; }
        public User Person { get; set; }
        public int? PersonId { get; set; }
    }
}