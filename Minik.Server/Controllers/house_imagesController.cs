using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Minik.Server.Models;
using System.Data.SqlClient;

namespace Minik.Server.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class house_imagesController : Controller
    {
        private readonly string _connectionString;

        public house_imagesController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }


        // GET: api/house_images
        [HttpGet]
        public async Task<ActionResult<IEnumerable<house_images>>> Gethouse_images()
        {
            var images = new List<house_images>();

            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand("SELECT * FROM house_images", conn);
                var reader = await cmd.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    images.Add(new house_images
                    {
                      Id=reader.GetInt32(0),
                        Tiny_house_id = reader.GetInt32(1),
                        image_url = reader.IsDBNull(2) ? null : reader.GetString(2)
                    });
                }
            }

            return Ok(images);
        }




    }
}

