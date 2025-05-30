

using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Minik.Server.Models;
using System.Text.Json;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MaintenanceController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public MaintenanceController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // 1. GET: api/maintenance
        [HttpGet]
        public IActionResult GetAllMaintenance()
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");
            List<Maintenance> maintenances = new List<Maintenance>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM maintenance";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        maintenances.Add(new Maintenance
                        {
                            Id = (int)reader["id"],
                            TinyHouseId = (int)reader["tiny_house_id"],
                            MaintenanceType = reader["maintenance_type"].ToString(),
                            MaintenanceDate = (DateTime)reader["maintenance_date"],
                            Status = reader["status"].ToString()
                        });
                    }
                }
            }

            return Ok(maintenances);
        }

        // 2. GET: api/maintenance/{id}
        [HttpGet("{id}")]
        public IActionResult GetMaintenanceById(int id)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");
            Maintenance maintenance = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM maintenance WHERE id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            maintenance = new Maintenance
                            {
                                Id = (int)reader["id"],
                                TinyHouseId = (int)reader["tiny_house_id"],
                                MaintenanceType = reader["maintenance_type"].ToString(),
                                MaintenanceDate = (DateTime)reader["maintenance_date"],
                                Status = reader["status"].ToString()
                            };
                        }
                    }
                }
            }

            if (maintenance == null)
                return NotFound("Bakım kaydı bulunamadı.");

            return Ok(maintenance);
        }

        // 3. POST: api/maintenance
        [HttpPost]
        public IActionResult AddMaintenance([FromBody] Maintenance maintenance)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                    INSERT INTO maintenance (tiny_house_id, maintenance_type, maintenance_date, status)
                    VALUES (@TinyHouseId, @MaintenanceType, @MaintenanceDate, @Status)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TinyHouseId", maintenance.TinyHouseId);
                    cmd.Parameters.AddWithValue("@MaintenanceType", maintenance.MaintenanceType);
                    cmd.Parameters.AddWithValue("@MaintenanceDate", maintenance.MaintenanceDate);
                    cmd.Parameters.AddWithValue("@Status", maintenance.Status);

                    cmd.ExecuteNonQuery();
                }
            }

            return Ok("Yeni bakım kaydı başarıyla eklendi.");
        }

        // 4. DELETE: api/maintenance/{id}
        [HttpDelete("{id}")]
        public IActionResult DeleteMaintenance(int id)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM maintenance WHERE id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    int affected = cmd.ExecuteNonQuery();

                    if (affected == 0)
                        return NotFound("Silinecek bakım kaydı bulunamadı.");
                }
            }

            return Ok("Bakım kaydı başarıyla silindi.");
        }

        // 5. PATCH: api/maintenance/{id}
        [HttpPatch("{id}")]
        public IActionResult UpdateMaintenance(int id, [FromBody] JsonElement updatedFields)
        {
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string selectQuery = "SELECT * FROM maintenance WHERE id = @Id";
                Maintenance existing = null;

                using (SqlCommand selectCmd = new SqlCommand(selectQuery, conn))
                {
                    selectCmd.Parameters.AddWithValue("@Id", id);

                    using (var reader = selectCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            existing = new Maintenance
                            {
                                Id = id,
                                TinyHouseId = (int)reader["tiny_house_id"],
                                MaintenanceType = reader["maintenance_type"].ToString(),
                                MaintenanceDate = (DateTime)reader["maintenance_date"],
                                Status = reader["status"].ToString()
                            };
                        }
                        else
                        {
                            return NotFound("Bakım kaydı bulunamadı.");
                        }
                    }
                }

                string newType = existing.MaintenanceType;
                DateTime newDate = existing.MaintenanceDate;
                string newStatus = existing.Status;

                if (updatedFields.TryGetProperty("maintenance_type", out var typeProp))
                    newType = typeProp.GetString();

                if (updatedFields.TryGetProperty("maintenance_date", out var dateProp))
                    newDate = dateProp.GetDateTime();

                if (updatedFields.TryGetProperty("status", out var statusProp))
                    newStatus = statusProp.GetString();

                string updateQuery = @"
                    UPDATE maintenance
                    SET maintenance_type = @MaintenanceType,
                        maintenance_date = @MaintenanceDate,
                        status = @Status
                    WHERE id = @Id";

                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                {
                    updateCmd.Parameters.AddWithValue("@MaintenanceType", newType);
                    updateCmd.Parameters.AddWithValue("@MaintenanceDate", newDate);
                    updateCmd.Parameters.AddWithValue("@Status", newStatus);
                    updateCmd.Parameters.AddWithValue("@Id", id);

                    updateCmd.ExecuteNonQuery();
                }
            }

            return Ok("Bakım kaydı başarıyla güncellendi.");
        }
    }
}
