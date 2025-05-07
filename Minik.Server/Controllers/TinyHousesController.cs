using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Minik.Server.Data;
using Minik.Server.Models;


namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinyHousesController : ControllerBase
    {
        private readonly string _connectionString;
        private readonly ApplicationDbContext _context;

        public TinyHousesController(IConfiguration configuration, ApplicationDbContext context)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            _context = context; // DbContext bağlanıyor
        }

        // GET: api/TinyHouses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TinyHouse>>> GetTinyHouses()
        {
            var houses = new List<TinyHouse>();

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(
                    "SELECT T.*, L.country, L.city FROM tiny_houses T, locations L WHERE T.location_id=L.id", conn);
                var reader = await cmd.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    houses.Add(new TinyHouse
                    {
                        Id = reader.GetInt32(0),
                        Name = reader.GetString(1),
                        Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                        LocationId = reader.GetInt32(3),
                        PricePerNight = reader.GetDecimal(4),
                        MaxGuests = reader.GetInt32(5),
                        property_owner_id = reader.GetInt32(6),
                        Amenities = reader.IsDBNull(7) ? null : reader.GetString(7),
                        // Bu iki satır location bilgisi alır
                        City = reader.GetString(8),
                        Country = reader.GetString(9),
                     
                    });
                }
            }

            return Ok(houses);
        }

        // GET: api/TinyHouses/
        [HttpGet("{id}")]
        public async Task<ActionResult<TinyHouse>> GetTinyHouse(int id)
        {
            TinyHouse? house = null;

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(@"
SELECT T.*, L.city,L.country, (SELECT CEILING(AVG(rating)) FROM reviews WHERE T.id=reviews.tiny_house_id)
FROM tiny_houses T, locations L
WHERE  T.location_id=L.id  AND T.id = @id", conn);

                cmd.Parameters.AddWithValue("@id", id);

                var reader = await cmd.ExecuteReaderAsync();

                if (await reader.ReadAsync())
                {
                    house = new TinyHouse
                    {
                        Id = reader.GetInt32(0),
                        Name = reader.GetString(1),
                        Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                        LocationId = reader.GetInt32(3),
                        PricePerNight = reader.GetDecimal(4),
                        MaxGuests = reader.GetInt32(5),
                        property_owner_id = reader.GetInt32(6),
                        Amenities = reader.IsDBNull(7) ? null : reader.GetString(7),
                        // Bu iki satır location bilgisi alır
                        City = reader.GetString(8),
                        Country = reader.GetString(9),
                        Rating = reader.IsDBNull(10) ? 0 : reader.GetInt32(10)

                    };
                }
            }

            return house == null ? NotFound() : Ok(house);
        }



        // GET: api/TinyHouses/
        [HttpGet("by-owner/{property_owner_id}")]
        public async Task<ActionResult<List<TinyHouse>>> GetTinyHouseByPropertyOwnerId(int property_owner_id)
        {
            var houses = new List<TinyHouse>();

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(@"
            SELECT T.*, L.country, L.city
            FROM tiny_houses T
            JOIN locations L ON T.location_id = L.id
            WHERE T.property_owner_id = @id", conn);

                cmd.Parameters.AddWithValue("@id", property_owner_id);

                var reader = await cmd.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    houses.Add(new TinyHouse
                    {
                        Id = reader.GetInt32(0),
                        Name = reader.GetString(1),
                        Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                        LocationId = reader.GetInt32(3),
                        PricePerNight = reader.GetDecimal(4),
                        MaxGuests = reader.GetInt32(5),
                        property_owner_id = reader.GetInt32(6),
                        Amenities = reader.IsDBNull(7) ? null : reader.GetString(7),
                        Country = reader.GetString(8),
                        City = reader.GetString(9)
                    });
                }
            }

            return houses.Count == 0 ? NotFound() : Ok(houses);
        }


    }
}
