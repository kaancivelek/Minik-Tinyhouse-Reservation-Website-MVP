using System.Data.SqlClient;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly string _connectionString;

        public LoginController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest loginRequest)
        {
            string storedHash = null;

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "SELECT password_hash FROM users WHERE email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", loginRequest.Email);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            storedHash = reader["password_hash"].ToString();
                        }
                        else
                        {
                            return Unauthorized("Kullanıcı bulunamadı.");
                        }
                    }
                }
            }

            bool isPasswordValid = BCrypt.Net.BCrypt.Verify(loginRequest.Password, storedHash);
            if (!isPasswordValid)
            {
                return Unauthorized("Şifre hatalı.");
            }

            return Ok("Giriş başarılı.");
        }
    }
}