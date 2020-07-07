using System;
using System.ComponentModel.DataAnnotations;

namespace taskmanager.Models
{
    public class Work : BaseEntity
    {
        [Required]
        [StringLength(140)]
        public string Title { get; set; }
        [Required]
        [StringLength(1000)]
        public string Description { get; set; }
        public bool IsDone { get; set; } = false;
        
        [DataType(DataType.Date)]
        public DateTime GoalTime { get; set; }
    }
}