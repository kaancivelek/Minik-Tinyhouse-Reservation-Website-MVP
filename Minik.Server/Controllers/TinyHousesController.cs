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
                var cmd = new SqlCommand(@"
            SELECT T.*, 
                   L.country, 
                   L.city,
                   (SELECT AVG(CAST(rating AS FLOAT)) 
                    FROM reviews 
                    WHERE tiny_house_id = T.id) AS average_rating
            FROM tiny_houses T
            JOIN locations L ON T.location_id = L.id", conn);

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
                        City = reader.GetString(9),
                        Rating = reader.IsDBNull(10) ? 0 : Convert.ToInt32(reader[10])
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
                var cmd = new SqlCommand(@"SELECT T.*, L.city, L.country, 
       (SELECT CEILING(AVG(rating)) FROM reviews WHERE T.id = reviews.tiny_house_id) AS average_rating
FROM tiny_houses T
JOIN locations L ON T.location_id = L.id
WHERE T.id = @id
 ", conn);

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

        [HttpPost("add")]
        public IActionResult AddTinyHouse([FromBody] TinyHousesDTO dto)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                var query = @"
            INSERT INTO tiny_houses 
            (name, description, location_id, price_per_night, max_guests, property_owner_id, amenities)
            VALUES 
            (@name, @description, @location_id, @price_per_night, @max_guests, @owner_id, @amenities)";

                using (var cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@name", dto.Name);
                    cmd.Parameters.AddWithValue("@description", (object)dto.Description ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@location_id", dto.LocationId);
                    cmd.Parameters.AddWithValue("@price_per_night", dto.PricePerNight);
                    cmd.Parameters.AddWithValue("@max_guests", dto.MaxGuests);
                    cmd.Parameters.AddWithValue("@owner_id", dto.PropertyOwnerId);
                    cmd.Parameters.AddWithValue("@amenities", (object)dto.Amenities ?? DBNull.Value);

                    cmd.ExecuteNonQuery();
                }
            }

            return Ok("Tiny house başarıyla eklendi.");
        }

        [HttpDelete("delete/{id}")]
        public IActionResult DeleteTinyHouse(int id)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "DELETE FROM tiny_houses WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        return NotFound(new { Message = "Belirtilen ID ile eşleşen ev bulunamadı." });
                    }
                }
            }

            return Ok(new { Message = "Tiny house başarıyla silindi." });
        }


        [HttpPatch("update/{id}")]
        public IActionResult PatchTinyHouse(int id, [FromBody] TinyHousesDTO2 update)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                List<string> setClauses = new List<string>();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                // Güncellenebilecek alanları kontrol et
                if (update.Name != null)
                {
                    setClauses.Add("name = @name");
                    cmd.Parameters.AddWithValue("@name", update.Name);
                }
                if (update.Description != null)
                {
                    setClauses.Add("description = @description");
                    cmd.Parameters.AddWithValue("@description", update.Description);
                }
                if (update.LocationId.HasValue)
                {
                    setClauses.Add("location_id = @location_id");
                    cmd.Parameters.AddWithValue("@location_id", update.LocationId.Value);
                }
                if (update.PricePerNight.HasValue)
                {
                    setClauses.Add("price_per_night = @price_per_night");
                    cmd.Parameters.AddWithValue("@price_per_night", update.PricePerNight.Value);
                }
                if (update.MaxGuests.HasValue)
                {
                    setClauses.Add("max_guests = @max_guests");
                    cmd.Parameters.AddWithValue("@max_guests", update.MaxGuests.Value);
                }
                if (update.PropertyOwnerId.HasValue)
                {
                    setClauses.Add("property_owner_id = @property_owner_id");
                    cmd.Parameters.AddWithValue("@property_owner_id", update.PropertyOwnerId.Value);
                }
                if (update.Amenities != null)
                {
                    setClauses.Add("amenities = @amenities");
                    cmd.Parameters.AddWithValue("@amenities", update.Amenities);
                }

                // Eğer hiçbir alan belirtilmemişse hata dön
                if (!setClauses.Any())
                {
                    return BadRequest("Güncellenecek herhangi bir alan belirtilmedi.");
                }

                // SQL sorgusunu hazırla
                cmd.CommandText = $"UPDATE tiny_houses SET {string.Join(", ", setClauses)} WHERE id = @id";
                cmd.Parameters.AddWithValue("@id", id);

                // Veritabanında güncellemeyi yap
                int affected = cmd.ExecuteNonQuery();
                if (affected == 0)
                {
                    return NotFound("Belirtilen ID ile eşleşen tiny house bulunamadı.");
                }
            }

            return Ok(new { Message = "Tiny house başarıyla güncellendi." });
        }




    }
}
