
namespace Minik.Server.Models
{
    public class Maintenance
    {
        public int Id { get; set; }
        public int TinyHouseId { get; set; }
        public string MaintenanceType { get; set; }
        public DateTime MaintenanceDate { get; set; }
        public string Status { get; set; }
    }
}
