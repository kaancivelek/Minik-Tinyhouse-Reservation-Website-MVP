using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Minik.Server.Models;
using Microsoft.Data.SqlClient;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HouseImagesController : ControllerBase
    {
        private readonly string _connectionString;

        public HouseImagesController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        // GET: api/HouseImages
        [HttpGet]
        public async Task<ActionResult<IEnumerable<HouseImages>>> GetHouseImages()
        {
            var images = new List<HouseImages>();

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand("SELECT * FROM house_images", conn);
                var reader = await cmd.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    images.Add(new HouseImages
                    {
                        Id = reader.GetInt32(0),
                        Tiny_house_id = reader.GetInt32(1),
                        Image_url = reader.IsDBNull(2) ? null : reader.GetString(2)
                    });
                }
            }

            return Ok(images); // Response'da durum kodu 200 döndürülecek
        }

        // GET: api/HouseImages/tiny_house_id
        [HttpGet("{tiny_house_id}")]
        public async Task<ActionResult<IEnumerable<HouseImages>>> GetHouseImagesByTinyHouseId(int tiny_house_id)
        {
            var images = new List<HouseImages>();

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand("SELECT * FROM house_images WHERE tiny_house_id = @tiny_house_id", conn);
                cmd.Parameters.AddWithValue("@tiny_house_id", tiny_house_id);

                var reader = await cmd.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    images.Add(new HouseImages
                    {
                        Id = reader.GetInt32(0),
                        Tiny_house_id = reader.GetInt32(1),
                        Image_url = reader.IsDBNull(2) ? null : reader.GetString(2)
                    });
                }
            }

            if (images.Count == 0)
            {
                return NotFound(new { message = "No images found for this Tiny House." }); // 404 ve hata mesajı
            }

            return Ok(images); // 200 ile images listesi döndürülür
        }
    }
}
