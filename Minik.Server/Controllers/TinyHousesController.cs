using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Minik.Server.Models;
using Microsoft.Data.SqlClient;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinyHousesController : ControllerBase
    {
        private readonly string _connectionString;

        public TinyHousesController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
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
                    "SELECT T.*, L.country, L.city FROM tiny_houses T,locations L WHERE T.location_id=L.id", conn);
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
                        Amenities = reader.IsDBNull(6) ? null : reader.GetString(6),
                        Country = reader.GetString(7),
                        City = reader.GetString(8)
                    });
                }
            }

            return Ok(houses);
        }

        // GET: api/TinyHouses/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TinyHouse>> GetTinyHouse(int id)
        {
            TinyHouse? house = null;

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(@"
    SELECT T.id, T.name, T.description, T.location_id, T.price_per_night, 
           T.max_guests, T.amenities, L.country, L.city 
    FROM tiny_houses T
    JOIN locations L ON T.location_id = L.id
    WHERE T.id = @id", conn);

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
                        Amenities = reader.IsDBNull(6) ? null : reader.GetString(6),
                        Country = reader.GetString(7),
                        City = reader.GetString(8)
                    };
                }
            }

            return house == null ? NotFound() : Ok(house);
        }

    }
}