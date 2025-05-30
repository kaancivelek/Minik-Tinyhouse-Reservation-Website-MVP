
using System.Text.Json.Serialization;

namespace Minik.Server.Models
{
    public class Maintenance
    {
        public int Id { get; set; }
        public int TinyHouseId { get; set; }
        public string MaintenanceType { get; set; }
        public DateTime MaintenanceDate { get; set; }
        [JsonConverter(typeof(JsonStringEnumConverter))]
        public MaintenanceStatus Status { get; set; }

    }
}
