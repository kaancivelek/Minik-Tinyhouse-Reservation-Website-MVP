
using Microsoft.AspNetCore.Mvc;
using Minik.Server.Models;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DiscountsController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public DiscountsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        private SqlConnection GetConnection()
        {
            return new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }

        // GET: api/discounts
        [HttpGet]
        public IActionResult GetAllDiscounts()
        {
            var discounts = new List<Discount>();
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = "SELECT * FROM discounts";
                var cmd = new SqlCommand(query, conn);
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    discounts.Add(new Discount
                    {
                        Id = (int)reader["id"],
                        TinyHouseId = (int)reader["tiny_house_id"],
                        DiscountPercentage = (decimal)reader["discount_percentage"],
                        ValidFrom = (DateTime)reader["valid_from"],
                        ValidUntil = (DateTime)reader["valid_until"]
                    });
                }
            }

            return Ok(discounts);
        }

        // GET: api/discounts/5
        [HttpGet("{id}")]
        public IActionResult GetDiscountById(int id)
        {
            Discount discount = null;

            using (var conn = GetConnection())
            {
                conn.Open();
                var query = "SELECT * FROM discounts WHERE id = @Id";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    discount = new Discount
                    {
                        Id = (int)reader["id"],
                        TinyHouseId = (int)reader["tiny_house_id"],
                        DiscountPercentage = (decimal)reader["discount_percentage"],
                        ValidFrom = (DateTime)reader["valid_from"],
                        ValidUntil = (DateTime)reader["valid_until"]
                    };
                }
            }

            return discount != null ? Ok(discount) : NotFound("İndirim bulunamadı.");
        }

        // POST: api/discounts
        [HttpPost]
        public IActionResult AddDiscount([FromBody] Discount discount)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = @"INSERT INTO discounts (tiny_house_id, discount_percentage, valid_from, valid_until)
                              VALUES (@TinyHouseId, @DiscountPercentage, @ValidFrom, @ValidUntil)";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TinyHouseId", discount.TinyHouseId);
                cmd.Parameters.AddWithValue("@DiscountPercentage", discount.DiscountPercentage);
                cmd.Parameters.AddWithValue("@ValidFrom", discount.ValidFrom);
                cmd.Parameters.AddWithValue("@ValidUntil", discount.ValidUntil);

                var result = cmd.ExecuteNonQuery();
                return result > 0 ? Ok("İndirim başarıyla eklendi.") : BadRequest("Ekleme başarısız.");
            }
        }

        // PUT: api/discounts/5 (Tam güncelleme)
        [HttpPut("{id}")]
        public IActionResult UpdateDiscount(int id, [FromBody] Discount discount)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = @"UPDATE discounts SET
                              tiny_house_id = @TinyHouseId,
                              discount_percentage = @DiscountPercentage,
                              valid_from = @ValidFrom,
                              valid_until = @ValidUntil
                              WHERE id = @Id";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@TinyHouseId", discount.TinyHouseId);
                cmd.Parameters.AddWithValue("@DiscountPercentage", discount.DiscountPercentage);
                cmd.Parameters.AddWithValue("@ValidFrom", discount.ValidFrom);
                cmd.Parameters.AddWithValue("@ValidUntil", discount.ValidUntil);

                var result = cmd.ExecuteNonQuery();
                return result > 0 ? Ok("İndirim güncellendi.") : NotFound("İndirim bulunamadı.");
            }
        }

        // PATCH: api/discounts/5 (Sadece yüzde güncelle)
        [HttpPatch("{id}")]
        public IActionResult PatchDiscountPercentage(int id, [FromBody] decimal newPercentage)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = @"UPDATE discounts SET discount_percentage = @DiscountPercentage WHERE id = @Id";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@DiscountPercentage", newPercentage);

                var result = cmd.ExecuteNonQuery();
                return result > 0 ? Ok("İndirim oranı güncellendi.") : NotFound("İndirim bulunamadı.");
            }
        }

        // DELETE: api/discounts/5
        [HttpDelete("{id}")]
        public IActionResult DeleteDiscount(int id)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var query = "DELETE FROM discounts WHERE id = @Id";
                var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                var result = cmd.ExecuteNonQuery();
                return result > 0 ? Ok("İndirim silindi.") : NotFound("İndirim bulunamadı.");
            }
        }
    }
}
