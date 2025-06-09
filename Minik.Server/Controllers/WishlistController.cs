
using Microsoft.AspNetCore.Mvc;
using Minik.Server.Models;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WishlistController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public WishlistController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        private SqlConnection GetConnection()
        {
            return new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }

        // GET: api/wishlist/{userId}
        [HttpGet("{userId}")]
        public IActionResult GetWishlist(int userId)
        {
            var wishlist = new List<int>();

            using (var conn = GetConnection())
            {
                conn.Open();
                var query = "SELECT tiny_house_id FROM wishlist WHERE user_id = @UserId";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    wishlist.Add((int)reader["tiny_house_id"]);
                }
            }

            return Ok(wishlist);
        }

        // POST: api/wishlist
        [HttpPost]
        public IActionResult AddToWishlist([FromBody] Wishlist item)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = @"INSERT INTO wishlist (user_id, tiny_house_id) VALUES (@UserId, @TinyHouseId)";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", item.UserId);
                cmd.Parameters.AddWithValue("@TinyHouseId", item.TinyHouseId);

                var result = cmd.ExecuteNonQuery();
                return result > 0 ? Ok("Favorilere eklendi.") : BadRequest("Eklenemedi.");
            }
        }

        // DELETE: api/wishlist
        [HttpDelete]
        public IActionResult RemoveFromWishlist([FromBody] Wishlist item)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = @"DELETE FROM wishlist WHERE user_id = @UserId AND tiny_house_id = @TinyHouseId";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", item.UserId);
                cmd.Parameters.AddWithValue("@TinyHouseId", item.TinyHouseId);

                var result = cmd.ExecuteNonQuery();
                return result > 0 ? Ok("Favoriden kaldırıldı.") : NotFound("Kayıt bulunamadı.");
            }
        }
    }
}
