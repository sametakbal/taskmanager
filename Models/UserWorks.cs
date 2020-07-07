namespace taskmanager.Models
{
    public class UserWorks : BaseEntity
    {
        public User User { get; set; }
        public int UserId { get; set; }
        public Work Work { get; set; }
        public int WorkId { get; set; }
    }
}