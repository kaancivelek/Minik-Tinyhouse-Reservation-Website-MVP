using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Minik.Server.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.CodeAnalysis;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReservationsController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ReservationsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // GET api/reservations/5
        [HttpGet("{id}")]
        public IActionResult GetReservationById(int id)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");
            Reservation reservation = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM reservations WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            reservation = new Reservation
                            {
                                Id = (int)reader["id"],
                                UserId = (int)reader["user_id"],
                                TinyHouseId = (int)reader["tiny_house_id"],
                                TotalPrice = (decimal)reader["total_price"],
                                Status = reader["status"].ToString()
                            };
                        }
                    }
                }
            }

            if (reservation == null)
                return NotFound();

            return Ok(reservation);
        }

        // POST api/reservations
        [HttpPost]
        public IActionResult Post([FromBody] Reservation reservation)
        {
            string connectionString = "Server=localhost;Database=MinikDB;Trusted_Connection=True;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO reservations (user_id, tiny_house_id, total_price, status) " +
                               "VALUES (@UserId, @TinyHouseId, @TotalPrice, @Status)";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@UserId", reservation.UserId);
                command.Parameters.AddWithValue("@TinyHouseId", reservation.TinyHouseId);
                command.Parameters.AddWithValue("@TotalPrice", reservation.TotalPrice);
                command.Parameters.AddWithValue("@Status", reservation.Status);

                connection.Open();
                command.ExecuteNonQuery();
            }

            return Ok("Rezervasyon başarıyla eklendi.");
        }


    }
}
