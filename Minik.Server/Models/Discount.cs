using System;

namespace Minik.Server.Models
{
    public class Discount
    {
        public int Id { get; set; }
        public int TinyHouseId { get; set; }
        public decimal DiscountPercentage { get; set; }
        public DateTime ValidFrom { get; set; }
        public DateTime ValidUntil { get; set; }
    }
}
