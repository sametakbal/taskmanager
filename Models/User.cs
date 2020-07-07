using System.ComponentModel.DataAnnotations;

namespace taskmanager.Models
{
    public class User : BaseEntity
    {
        [Required]
        [StringLength(55)]
        public string Name { get; set; }
        [Required]
        [StringLength(55)]
        public string Surname { get; set; }
        [Required]
        [StringLength(120)]
        public string Email{ get; set; }
        [Required]
        [StringLength(55)]
        public string Username{ get; set; }
        [Required]
        [StringLength(55)]
        public string Password{ get; set; }

    }
}