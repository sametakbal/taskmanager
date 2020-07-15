using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace Core.Entities
{
    public class User : IdentityUser<int>
    {
        [Required]
        [StringLength(55)]
        public string Name { get; set; }
        [Required]
        [StringLength(55)]
        public string Surname { get; set; }
    }
}