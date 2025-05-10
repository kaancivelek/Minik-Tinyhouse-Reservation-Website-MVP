namespace Minik.Server.Models
{

    public class TinyHousesDTO2
    {
        public string? Name { get; set; }
        public string? Description { get; set; }
        public int? LocationId { get; set; }
        public decimal? PricePerNight { get; set; }
        public int? MaxGuests { get; set; }
        public int? PropertyOwnerId { get; set; }
        public string? Amenities { get; set; }
    }
}