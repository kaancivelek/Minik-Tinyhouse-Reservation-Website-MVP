﻿
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Minik.Server.Models;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewsController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ReviewsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // 1. GET: api/reviews
        // Kullanıcıya göre yorumları getir
        [HttpGet("user/{userId}")]
        public IActionResult GetReviewsByUser(int userId)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");
            List<Review> reviews = new List<Review>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM reviews WHERE user_id = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            reviews.Add(new Review
                            {
                                Id = (int)reader["id"],
                                UserId = (int)reader["user_id"],
                                TinyHouseId = (int)reader["tiny_house_id"],
                                Rating = (int)reader["rating"],
                                Comment = reader["comment"] == DBNull.Value ? null : reader["comment"].ToString(),
                                ReviewDate = (DateTime)reader["review_date"]
                            });
                        }
                    }
                }
            }

            return Ok(reviews);
        }

        // TinyHouseId'ye göre yorumları getir
        [HttpGet("tinyhouse/{tinyHouseId}")]
        public IActionResult GetReviewsByTinyHouse(int tinyHouseId)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");
            List<Review> reviews = new List<Review>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM reviews WHERE tiny_house_id = @TinyHouseId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TinyHouseId", tinyHouseId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            reviews.Add(new Review
                            {
                                Id = (int)reader["id"],
                                UserId = (int)reader["user_id"],
                                TinyHouseId = (int)reader["tiny_house_id"],
                                Rating = (int)reader["rating"],
                                Comment = reader["comment"] == DBNull.Value ? null : reader["comment"].ToString(),
                                ReviewDate = (DateTime)reader["review_date"]
                            });
                        }
                    }
                }
            }

            return Ok(reviews);
        }


        // 2. POST: api/reviews
        [HttpPost]
        public IActionResult AddReview([FromBody] Review review)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                    INSERT INTO reviews (user_id, tiny_house_id, rating, comment, review_date)
                    VALUES (@UserId, @TinyHouseId, @Rating, @Comment, @ReviewDate)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", review.UserId);
                    cmd.Parameters.AddWithValue("@TinyHouseId", review.TinyHouseId);
                    cmd.Parameters.AddWithValue("@Rating", review.Rating);
                    cmd.Parameters.AddWithValue("@Comment", (object?)review.Comment ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@ReviewDate", DateTime.Now);

                    cmd.ExecuteNonQuery();
                }
            }
            // test committ - doğru e-posta ile

            return Ok("Yorum başarıyla eklendi.");
        }

        // 3. DELETE: api/reviews/{id}
        [HttpDelete("{id}")]
        public IActionResult DeleteReview(int id)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM reviews WHERE id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    int affected = cmd.ExecuteNonQuery();

                    if (affected == 0)
                        return NotFound("Silinecek yorum bulunamadı.");
                }
            }

            return Ok("Yorum başarıyla silindi.");
        }

        // 4. PATCH: api/reviews/updateratingcomment/{id}
        [HttpPatch("updateratingcomment/{id}")]
        public IActionResult UpdateRatingAndComment(int id, [FromBody] Review updatedFields)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
                    UPDATE reviews 
                    SET 
                        rating = @Rating,
                        comment = @Comment
                    WHERE id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@Rating", updatedFields.Rating);
                    cmd.Parameters.AddWithValue("@Comment", (object?)updatedFields.Comment ?? DBNull.Value);

                    int affected = cmd.ExecuteNonQuery();
                    if (affected == 0)
                        return NotFound("Güncellenecek yorum bulunamadı.");
                }
            }

            return Ok("Yorum ve puan başarıyla güncellendi.");
        }
    }
}
