using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Minik.Server.Models;
using System.Data.SqlClient;

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
                var cmd = new SqlCommand("SELECT T.*, L.country FROM tiny_houses T,locations L WHERE T.location_id=L.id", conn);
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
                        Country = reader.GetString(1)
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
                var cmd = new SqlCommand("SELECT * FROM tiny_houses WHERE id = @id", conn);
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
                        Amenities = reader.IsDBNull(6) ? null : reader.GetString(6)
                    };
                }
            }

            return house == null ? NotFound() : Ok(house);
        }

        // POST: api/TinyHouses
        [HttpPost]
        public async Task<ActionResult> PostTinyHouse(TinyHouse house)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(@"
                    INSERT INTO tiny_houses 
                    (name, description, location_id, price_per_night, max_guests, amenities) 
                    VALUES (@name, @description, @location_id, @price_per_night, @max_guests, @amenities)", conn);

                cmd.Parameters.AddWithValue("@name", house.Name);
                cmd.Parameters.AddWithValue("@description", (object?)house.Description ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@location_id", house.LocationId);
                cmd.Parameters.AddWithValue("@price_per_night", house.PricePerNight);
                cmd.Parameters.AddWithValue("@max_guests", house.MaxGuests);
                cmd.Parameters.AddWithValue("@amenities", (object?)house.Amenities ?? DBNull.Value);

                await cmd.ExecuteNonQueryAsync();
            }

            return Ok();
        }

        // PUT: api/TinyHouses/5
        [HttpPut("{id}")]
        public async Task<ActionResult> PutTinyHouse(int id, TinyHouse house)
        {
            if (id != house.Id)
                return BadRequest();

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(@"
                    UPDATE tiny_houses SET
                        name = @name,
                        description = @description,
                        location_id = @location_id,
                        price_per_night = @price_per_night,
                        max_guests = @max_guests,
                        amenities = @amenities
                    WHERE id = @id", conn);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@name", house.Name);
                cmd.Parameters.AddWithValue("@description", (object?)house.Description ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@location_id", house.LocationId);
                cmd.Parameters.AddWithValue("@price_per_night", house.PricePerNight);
                cmd.Parameters.AddWithValue("@max_guests", house.MaxGuests);
                cmd.Parameters.AddWithValue("@amenities", (object?)house.Amenities ?? DBNull.Value);

                int rowsAffected = await cmd.ExecuteNonQueryAsync();
                return rowsAffected == 0 ? NotFound() : NoContent();
            }
        }

        // DELETE: api/TinyHouses/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteTinyHouse(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand("DELETE FROM tiny_houses WHERE id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);

                int rowsAffected = await cmd.ExecuteNonQueryAsync();
                return rowsAffected == 0 ? NotFound() : NoContent();
            }
        }
    }
}
