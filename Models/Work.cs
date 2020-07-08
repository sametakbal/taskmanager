using System;
using System.ComponentModel.DataAnnotations;

namespace taskmanager.Models
{
    public class Work : BaseEntity
    {
        [Required(ErrorMessage="This field is required.")]
        [StringLength(140)]
        public string Title { get; set; }
        [Required(ErrorMessage="This field is required.")]
        [StringLength(1000)]
        public string Description { get; set; }
        public bool IsDone { get; set; } = false;
        [Required(ErrorMessage="This field is required.")]
        [DataType(DataType.Date)]
        public DateTime? GoalTime { get; set; }
    }
}