using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Minik.Server.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.CodeAnalysis;
using System.ComponentModel.Design;

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
        [HttpGet("user/{userId}")]
        public IActionResult GetReservationsByUserId(int userId)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");
            List<Reservation> reservations = new List<Reservation>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM reservations WHERE user_id = @userId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userId", userId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Reservation reservation = new Reservation
                            {
                              
                                UserId = (int)reader["user_id"],
                                TinyHouseId = (int)reader["tiny_house_id"],
                                TotalPrice = (decimal)reader["total_price"],
                                Status = reader["status"].ToString(),
                                CheckIn = (DateTime)reader["check_in"],
                                CheckOut = (DateTime)reader["check_out"]
                                
                            };

                            reservations.Add(reservation);
                        }
                    }
                }
            }

            if (reservations.Count == 0)
                return NotFound("Bu kullanıcıya ait rezervasyon bulunamadı.");

            return Ok(reservations);
        }


        // POST api/reservations
        [HttpPost]
        public IActionResult Post([FromBody] Reservation reservation)
        {
            string connectionString = "Server=localhost;Database=MinikDB;Trusted_Connection=True;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
    INSERT INTO reservations 
    (user_id, tiny_house_id, total_price, status, check_in, check_out)
    VALUES 
    (@UserId, @TinyHouseId, @TotalPrice, @Status, @CheckIn, @CheckOut)";


                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@UserId", reservation.UserId);
                command.Parameters.AddWithValue("@TinyHouseId", reservation.TinyHouseId);
                command.Parameters.AddWithValue("@TotalPrice", reservation.TotalPrice);
                command.Parameters.AddWithValue("@Status", reservation.Status);
                command.Parameters.AddWithValue("@CheckIn", reservation.CheckIn);
                command.Parameters.AddWithValue("@CheckOut", reservation.CheckOut);

                connection.Open();
                command.ExecuteNonQuery();
            }

            return Ok("Rezervasyon başarıyla eklendi.");
        }


        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            string connectionString = "Server=localhost;Database=MinikDB;Trusted_Connection=True;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    // 1. Invoice'ları sil
                    string deleteInvoices = @"
                DELETE FROM invoices 
                WHERE payment_id IN (
                    SELECT id FROM payments WHERE reservation_id = @Id
                )";
                    using (SqlCommand cmd1 = new SqlCommand(deleteInvoices, connection, transaction))
                    {
                        cmd1.Parameters.AddWithValue("@Id", id);
                        cmd1.ExecuteNonQuery();
                    }

                    // 2. Payment'leri sil
                    string deletePayments = "DELETE FROM payments WHERE reservation_id = @Id";
                    using (SqlCommand cmd2 = new SqlCommand(deletePayments, connection, transaction))
                    {
                        cmd2.Parameters.AddWithValue("@Id", id);
                        cmd2.ExecuteNonQuery();
                    }

                    // 3. Reservation'ı sil
                    string deleteReservation = "DELETE FROM reservations WHERE id = @Id";
                    using (SqlCommand cmd3 = new SqlCommand(deleteReservation, connection, transaction))
                    {
                        cmd3.Parameters.AddWithValue("@Id", id);
                        int affected = cmd3.ExecuteNonQuery();

                        if (affected == 0)
                        {
                            transaction.Rollback();
                            return NotFound("Rezervasyon bulunamadı.");
                        }
                    }

                    transaction.Commit();
                    return Ok("Tüm ilişkili kayıtlar başarıyla silindi.");
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return StatusCode(500, "Hata oluştu: " + ex.Message);
                }
            }
        }


        [HttpPut("{id}")]
        public IActionResult UpdateReservation(int id, [FromBody] Reservation updatedReservation)
        {
            string connectionString = "Server=localhost;Database=MinikDB;Trusted_Connection=True;";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = @"
            UPDATE reservations 
            SET  
                tiny_house_id = @TinyHouseId, 
                total_price = @TotalPrice, 
                status = @Status,
                check_in = @CheckIn,
                check_out = @CheckOut
            WHERE id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@UserId", updatedReservation.UserId);
                    cmd.Parameters.AddWithValue("@TinyHouseId", updatedReservation.TinyHouseId);
                    cmd.Parameters.AddWithValue("@TotalPrice", updatedReservation.TotalPrice);
                    cmd.Parameters.AddWithValue("@Status", updatedReservation.Status ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@CheckIn", updatedReservation.CheckIn);
                    cmd.Parameters.AddWithValue("@CheckOut", updatedReservation.CheckOut);
                    cmd.Parameters.AddWithValue("@Id", id);

                    int affectedRows = cmd.ExecuteNonQuery();
                    if (affectedRows == 0)
                        return NotFound("Rezervasyon bulunamadı.");
                }
            }

            return Ok("Rezervasyon başarıyla güncellendi.");
        }

        [HttpPatch("updatestatus/{id}")]
        public IActionResult UpdateStatus(int id, [FromBody] string newStatus)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "UPDATE reservations SET status = @status WHERE id = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@status", newStatus);
                    command.Parameters.AddWithValue("@id", id);

                    int affected = command.ExecuteNonQuery();

                    if (affected == 0)
                        return NotFound("Rezervasyon bulunamadı.");

                    return Ok("Rezervasyon durumu güncellendi.");
                }
            }
        }


    }
}

