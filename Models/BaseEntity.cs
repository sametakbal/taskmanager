using System.ComponentModel.DataAnnotations;

namespace taskmanager.Models
{
    public class BaseEntity
    {
        [Key]
        public int Id { get; set; }
    }
}